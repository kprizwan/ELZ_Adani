locals {
  generate_new_password   = { for k, v in var.mssql_server_variables : k => v if(lookup(v, "mssql_server_generate_new_admin_password", false) == true) }
  use_existing_password   = { for k, v in var.mssql_server_variables : k => v if(lookup(v, "mssql_server_generate_new_admin_password", true) == false) }
  use_existing_adminlogin = { for k, v in var.mssql_server_variables : k => v if(lookup(v, "mssql_server_use_existing_admin_login_username", false) == true) }

  identities_list = flatten([
    for k, v in var.mssql_server_variables : [
      for i, j in v.mssql_server_identity.mssql_server_user_assigned_identities : [
        merge(
          {
            main_key                     = k
            identity_name                = j.identity_name
            identity_resource_group_name = j.identity_resource_group_name

          },
          j
        )
      ]
    ] if v.mssql_server_identity.mssql_server_user_assigned_identities != null

  ])

  deploy_user_object_id = { for k, v in var.mssql_server_variables : k => length(data.azurerm_client_config.current.object_id) > 0 && v.mssql_server_access_container_agent_name == null ? data.azurerm_client_config.current.object_id : data.azuread_service_principal.agent_object_id[k].object_id }

}

data "azuread_service_principal" "agent_object_id" {
  provider     = azuread.azuread_tenant_id
  for_each     = { for k, v in var.mssql_server_variables : k => v if lookup(v, "mssql_server_access_container_agent_name", null) != null }
  display_name = each.value.mssql_server_access_container_agent_name
}

data "azurerm_client_config" "current" {
  provider = azurerm.mssql_server_sub
}

data "azurerm_key_vault" "key_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = var.mssql_server_variables
  name                = each.value.mssql_server_admin_credentials_key_vault_name
  resource_group_name = each.value.mssql_server_admin_credentials_key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "existing_adminlogin_username_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.use_existing_adminlogin
  name         = each.value.mssql_server_existing_admin_login_username_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

data "azurerm_key_vault_secret" "existing_password_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.use_existing_password
  name         = each.value.mssql_server_existing_admin_password_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

data "azurerm_user_assigned_identity" "user_assigned_identity" {
  provider            = azurerm.mssql_server_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

# primary_user_identity has issues with current version. so disabled.

/*data "azurerm_user_assigned_identity" "primary_user_assigned_identity" {
  provider            = azurerm.mssql_server_sub
  for_each            = var.mssql_server_variables
  name                = each.value.mssql_server_primary_user_assigned_identity_name
  resource_group_name = each.value.mssql_server_primary_user_assigned_identity_resource_group_name
}*/

#Generate random password
resource "random_password" "password" {
  for_each    = local.generate_new_password
  length      = 12
  special     = true
  lower       = true
  upper       = true
  numeric     = true
  min_lower   = 4
  min_upper   = 4
  min_numeric = 2
  min_special = 2
}

#Add the newly created login and password as a secret to a key vault for admin login purpose

resource "azurerm_key_vault_secret" "generated_password_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.generate_new_password
  name         = each.value.mssql_server_generated_admin_password_key_vault_secret_name
  value        = random_password.password[each.key].result
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

resource "azurerm_mssql_server" "mssql_server" {
  provider = azurerm.mssql_server_sub
  for_each = var.mssql_server_variables

  name                = each.value.mssql_server_name
  resource_group_name = each.value.mssql_server_resource_group_name
  location            = each.value.mssql_server_location
  version             = each.value.mssql_server_version

  dynamic "azuread_administrator" {
    for_each = each.value.mssql_server_azuread_administrator.azuread_administrator_login_email != null ? [1] : []
    content {
      login_username              = each.value.mssql_server_azuread_administrator.azuread_administrator_login_email
      tenant_id                   = data.azurerm_client_config.current.tenant_id
      object_id                   = local.deploy_user_object_id[each.key]
      azuread_authentication_only = each.value.mssql_server_azuread_administrator.azuread_administrator_azuread_authentication_only
    }
  }

  administrator_login          = each.value.mssql_server_azuread_administrator.azuread_administrator_azuread_authentication_only == true ? null : each.value.mssql_server_administrator_login == null ? data.azurerm_key_vault_secret.existing_adminlogin_username_key_vault_secret[each.key].value : each.value.mssql_server_administrator_login
  administrator_login_password = each.value.mssql_server_azuread_administrator.azuread_administrator_azuread_authentication_only == true ? null : each.value.mssql_server_generate_new_admin_password == false ? data.azurerm_key_vault_secret.existing_password_key_vault_secret[each.key].value : azurerm_key_vault_secret.generated_password_key_vault_secret[each.key].value

  dynamic "identity" {
    for_each = each.value.mssql_server_identity != null ? [1] : []
    content {
      type = each.value.mssql_server_identity.mssql_server_identity_type
      identity_ids = each.value.mssql_server_identity.mssql_server_identity_type != null ? each.value.mssql_server_identity.mssql_server_identity_type == "UserAssigned" ? [
        for k, v in each.value.mssql_server_identity.mssql_server_user_assigned_identities : data.azurerm_user_assigned_identity.user_assigned_identity["${each.key},${v.identity_name}"].id
      ] : null : null
    }
  }

  connection_policy                    = each.value.mssql_server_connection_policy
  minimum_tls_version                  = each.value.mssql_server_minimum_tls_version
  public_network_access_enabled        = each.value.mssql_server_public_network_access_enabled
  outbound_network_restriction_enabled = each.value.mssql_server_outbound_network_restriction_enabled

  //primary_user_assigned_identity_id = each.value.mssql_server_identity.mssql_server_identity_type != null ? each.value.mssql_server_identity.mssql_server_identity_type == "UserAssigned" ? data.azurerm_user_assigned_identity.primary_user_assigned_identity[each.key].id : null : null

  tags = merge(each.value.mssql_server_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}


