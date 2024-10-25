#Recovery Vault
resource "azurerm_recovery_services_vault" "recovery_service_vault" {
  for_each                     = var.recovery_services_vault_variables
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  sku                          = each.value.sku
  soft_delete_enabled          = each.value.soft_delete_enabled
  tags                         = each.value.tags
  storage_mode_type            = each.value.storage_mode_type == null ? "GeoRedundant" : each.value.storage_mode_type
  cross_region_restore_enabled = each.value.cross_region_restore_enabled
  dynamic "identity" {
    for_each = each.value.identity == null ? [] : each.value.identity
    content {
      # At this time the only possible value is SystemAssigned.
      type = identity.value.type == null ? "SystemAssigned" : identity.value.type
    }
  }
  dynamic "encryption" {
    # Encryption block required with identity
    for_each = (each.value.encryption == null || each.value.identity == null) ? [] : [true]
    content {
      key_id = encryption.value.key_id
      # Once infrastructure_encryption_enabled has been set it's not possible to change it.
      infrastructure_encryption_enabled = encryption.value.infrastructure_encryption_enabled
      # this time the only possible value is true. Defaults to true
      use_system_assigned_identity = encryption.value.use_system_assigned_identity == null ? true : encryption.value.use_system_assigned_identity
    }
  }
}