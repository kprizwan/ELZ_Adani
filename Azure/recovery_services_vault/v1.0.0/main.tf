data "azurerm_resource_group" "resource_group_search" {
  for_each = var.recovery_service_vault_variable
  name     = each.value.resource_group_name
}

#Recovery Vault
resource "azurerm_recovery_services_vault" "recovery_service_vault" {
  for_each            = var.recovery_service_vault_variable
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = data.azurerm_resource_group.resource_group_search[each.key].location
  sku                 = each.value.sku
  soft_delete_enabled = each.value.soft_delete_enabled
  tags                = each.value.tags
  storage_mode_type   = each.value.storage_mode_type == null ? "GeoRedundant" : each.value.storage_mode_type
  dynamic "identity" {
    for_each = each.value.identity == null ? [] : [true]
    content {
      # At this time the only possible value is SystemAssigned.
      type = each.value.identity.type == null ? "SystemAssigned" : each.value.identity.type
    }
  }
  dynamic "encryption" {
    # Encryption block required with identity
    for_each = (each.value.encryption == null || each.value.identity == null) ? [] : [true]
    content {
      key_id = each.value.encryption.key_id
      # Once infrastructure_encryption_enabled has been set it's not possible to change it.
      infrastructure_encryption_enabled = each.value.encryption.infrastructure_encryption_enabled
      # t this time the only possible value is true. Defaults to true
      use_system_assigned_identity = each.value.encryption.use_system_assigned_identity == null ? true : each.value.encryption.use_system_assigned_identity
    }
  }
  depends_on = [data.azurerm_resource_group.resource_group_search]
}

resource "azurerm_management_lock" "recovery_service_vault_resource_lock" {
  for_each   = var.recovery_service_vault_variable
  name       = "resource_lock ${each.value.name}"
  scope      = azurerm_recovery_services_vault.recovery_service_vault[each.key].id
  lock_level = "CanNotDelete"
  notes      = "Locked by Neudesic"
}