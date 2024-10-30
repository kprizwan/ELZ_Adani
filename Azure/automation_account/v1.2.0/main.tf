locals {
  identities = { for k, v in var.automation_account_variables : k => lookup(v, "automation_account_identity", null) != null ? v.automation_account_identity.automation_account_identity_type != "SystemAssigned" ? v.automation_account_identity.automation_account_identity_ids : null : null }
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                     = k
        identity_name                = i.user_assigned_identity_name
        identity_resource_group_name = i.user_assigned_identity_resource_group_name
    }]] if v != null
  ])

}

data "azurerm_user_assigned_identity" "user_assigned_ids" {
  provider            = azurerm.user_assigned_identity_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

data "azurerm_user_assigned_identity" "user_assigned_identity_for_encryption" {
  provider = azurerm.user_assigned_identity_sub
  for_each = { for k, v in var.automation_account_variables : k => v if lookup(v, "automation_account_encryption") != null }

  name                = each.value.automation_account_uid_cmk_encryption_name
  resource_group_name = each.value.autommation_account_uid_cmk_encryption_resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in var.automation_account_variables : k => v if lookup(v, "automation_account_encryption") != null }
  name                = each.value.automation_account_key_vault_name
  resource_group_name = each.value.automation_account_key_vault_resource_group_name
}

data "azurerm_key_vault_key" "encryption_key" {
  provider = azurerm.key_vault_sub
  for_each = { for k, v in var.automation_account_variables : k => v if lookup(v, "automation_account_encryption") != null }

  name         = each.value.automation_account_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

# Automation account resource
resource "azurerm_automation_account" "automation_account" {
  provider                      = azurerm.automation_account_sub
  for_each                      = var.automation_account_variables
  name                          = each.value.automation_account_name
  public_network_access_enabled = each.value.automation_account_public_network_access_enabled
  location                      = each.value.automation_account_location
  resource_group_name           = each.value.automation_account_resource_group_name
  sku_name                      = each.value.automation_account_sku_name
  local_authentication_enabled  = each.value.automation_account_local_authentication_enabled

  dynamic "identity" {
    for_each = each.value.automation_account_identity == null ? [] : [1]
    content {
      type         = each.value.automation_account_identity.automation_account_identity_type
      identity_ids = each.value.automation_account_identity.automation_account_identity_ids == null ? [] : [for k, v in each.value.automation_account_identity.automation_account_identity_ids : data.azurerm_user_assigned_identity.user_assigned_ids["${each.key},${v.user_assigned_identity_name}"].id]
    }
  }

  dynamic "encryption" {
    for_each = each.value.automation_account_encryption != null ? [each.value.automation_account_encryption] : []
    content {
      user_assigned_identity_id = data.azurerm_user_assigned_identity.user_assigned_identity_for_encryption[each.key].id
      key_source                = encryption.value.encryption_key_source
      key_vault_key_id          = data.azurerm_key_vault_key.encryption_key[each.key].id
    }
  }

  tags = merge(each.value.automation_account_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
