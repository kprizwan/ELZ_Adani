locals {
  generate_new_password = { for k, v in var.postgresql_server_variables : k => v if(lookup(v, "postgresql_server_generate_new_admin_password", false) == true) }
  use_existing_password = { for k, v in var.postgresql_server_variables : k => v if(lookup(v, "postgresql_server_generate_new_admin_password", true) == false) }
}

data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = { for k, v in var.postgresql_server_variables : k => v if v.postgresql_server_threat_detection_policy.postgresql_server_enable_threat_detection_policy == true }
  name                = each.value.postgresql_server_storage_account_name
  resource_group_name = each.value.postgresql_server_storage_account_resource_group
}

data "azurerm_key_vault" "key_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = var.postgresql_server_variables
  name                = each.value.postgresql_server_admin_password_key_vault_name
  resource_group_name = each.value.postgresql_server_key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "existing_password_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.use_existing_password
  name         = each.value.postgresql_server_admin_password_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

data "azurerm_postgresql_server" "postgresql_server_id" {
  provider            = azurerm.postgresql_server_sub
  for_each            = { for k, v in var.postgresql_server_variables : k => v if v.postgresql_server_creation_source_server_id != null }
  name                = each.value.postgresql_server_creation_source_server_id
  resource_group_name = each.value.postgresql_server_resource_group_name
}



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

#Add the newly created password as a secret to a key vault for admin login purpose
resource "azurerm_key_vault_secret" "key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.generate_new_password
  name         = each.value.postgresql_server_admin_password_key_vault_secret_name
  value        = random_password.password[each.key].result
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

resource "azurerm_postgresql_server" "postgresql_server" {
  provider            = azurerm.postgresql_server_sub
  for_each            = var.postgresql_server_variables
  name                = each.value.postgresql_server_name
  location            = each.value.postgresql_server_location
  resource_group_name = each.value.postgresql_server_resource_group_name

  administrator_login          = each.value.postgresql_server_administrator_login
  administrator_login_password = each.value.postgresql_server_generate_new_admin_password == false ? data.azurerm_key_vault_secret.existing_password_key_vault_secret[each.key].value : random_password.password[each.key].result
  sku_name                     = each.value.postgresql_server_sku_name
  version                      = each.value.postgresql_server_version
  storage_mb                   = each.value.postgresql_server_storage_mb

  backup_retention_days        = each.value.postgresql_server_backup_retention_days
  geo_redundant_backup_enabled = each.value.postgresql_server_geo_redundant_backup_enabled
  auto_grow_enabled            = each.value.postgresql_server_auto_grow_enabled

  public_network_access_enabled    = each.value.postgresql_server_public_network_access_enabled
  ssl_enforcement_enabled          = each.value.postgresql_server_ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = each.value.postgresql_server_ssl_minimal_tls_version_enforced

  create_mode                       = each.value.postgresql_server_create_mode
  creation_source_server_id         = each.value.postgresql_server_creation_source_server_id == null ? null : data.azurerm_postgresql_server.postgresql_server_id[each.key].id
  infrastructure_encryption_enabled = each.value.postgresql_server_infrastructure_encryption_enabled
  restore_point_in_time             = each.value.postgresql_server_restore_point_in_time


  dynamic "identity" {
    for_each = coalesce(each.value.postgresql_server_assign_identity, false) == false ? [] : tolist([coalesce(each.value.postgresql_server_assign_identity, false)])
    content {
      type = "SystemAssigned"
    }
  }

  dynamic "threat_detection_policy" {
    for_each = each.value.postgresql_server_threat_detection_policy.postgresql_server_enable_threat_detection_policy == false ? [] : [1]
    content {
      enabled                    = each.value.postgresql_server_threat_detection_policy.postgresql_server_enable_threat_detection_policy
      disabled_alerts            = each.value.postgresql_server_threat_detection_policy.postgresql_server_disabled_alerts
      email_account_admins       = each.value.postgresql_server_threat_detection_policy.postgresql_server_email_addresses_for_alerts != null ? true : false
      email_addresses            = each.value.postgresql_server_threat_detection_policy.postgresql_server_email_addresses_for_alerts
      retention_days             = each.value.postgresql_server_threat_detection_policy.postgresql_server_log_retention_days
      storage_account_access_key = data.azurerm_storage_account.storage_account[each.key].primary_access_key
      storage_endpoint           = data.azurerm_storage_account.storage_account[each.key].primary_blob_endpoint
    }
  }

  tags = merge(each.value.postgresql_server_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"], administrator_login_password] }
}
