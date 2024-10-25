data "azurerm_key_vault" "encryption_key_vault" {
  for_each            = { for k, v in var.recovery_services_vault_variables : k => v if lookup(v, "recovery_services_vault_encryption") != null }
  name                = each.value.recovery_services_vault_encryption.encryption_key_vault_name
  resource_group_name = each.value.recovery_services_vault_encryption.encryption_key_vault_resource_group_name
}

data "azurerm_key_vault_key" "encryption_key" {
  for_each     = { for k, v in var.recovery_services_vault_variables : k => v if lookup(v, "recovery_services_vault_encryption") != null }
  name         = each.value.recovery_services_vault_encryption.encryption_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.encryption_key_vault[each.key].id
}

#RECOVERY SERVICE VAULT RESOURCE
resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  for_each                     = var.recovery_services_vault_variables
  name                         = each.value.recovery_services_vault_name
  resource_group_name          = each.value.recovery_services_vault_resource_group_name
  location                     = each.value.recovery_services_vault_location
  sku                          = each.value.recovery_services_vault_sku
  storage_mode_type            = each.value.recovery_services_vault_storage_mode_type
  cross_region_restore_enabled = each.value.recovery_services_vault_storage_mode_type == "GeoRedundant" ? true : false
  soft_delete_enabled          = each.value.recovery_services_vault_soft_delete_enabled
  dynamic "identity" {
    for_each = each.value.recovery_services_vault_identity == null ? [] : [each.value.recovery_services_vault_identity]
    content {
      type = identity.value.recovery_services_vault_identity_type
    }
  }
  dynamic "encryption" {
    for_each = each.value.recovery_services_vault_identity != null && each.value.recovery_services_vault_encryption != null ? [each.value.recovery_services_vault_encryption] : []
    content {
      key_id                            = data.azurerm_key_vault_key.encryption_key[each.key].id
      infrastructure_encryption_enabled = encryption.value.encryption_infrastructure_encryption_enabled
      use_system_assigned_identity      = encryption.value.encryption_use_system_assigned_identity
    }
  }
  tags = merge(each.value.recovery_services_vault_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}