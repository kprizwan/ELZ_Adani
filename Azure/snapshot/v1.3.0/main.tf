data "azurerm_snapshot" "source_resource_id" {
  provider            = azurerm.snapshot_sub
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_create_option != "Copy" }
  name                = each.value.managed_disk_source_resource_name
  resource_group_name = each.value.managed_disk_source_resource_resource_group_name
}
data "azurerm_managed_disk" "managed_disk_source_uri" {
  provider            = azurerm.snapshot_sub
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_create_option == "Copy" }
  name                = each.value.snapshot_managed_disk_name
  resource_group_name = each.value.snapshot_managed_disk_resource_group_name
}
data "azurerm_storage_account" "storage_account_id" {
  provider            = azurerm.storage_account_sub
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_source_uri_unmanaged_blobs_different_subscription == true }
  name                = each.value.snapshot_storage_account_name
  resource_group_name = each.value.snapshot_storage_resource_group_name
}
data "azurerm_storage_blob" "unmanaged_disk_source_uri" {
  provider               = azurerm.snapshot_sub
  for_each               = { for k, v in var.snapshot_variables : k => v if v.snapshot_source_manged_disk != true }
  name                   = each.value.snapshot_storage_blob_name
  storage_account_name   = each.value.snapshot_storage_account_name
  storage_container_name = each.value.snapshot_storage_container_name
}
data "azurerm_key_vault" "source_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_encryption_settings_enabled == true }
  name                = each.value.snapshot_encryption_settings_key_vault_name
  resource_group_name = each.value.snapshot_encryption_settings_key_vault_resource_group_name
}
data "azurerm_key_vault_secret" "secret_url" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.snapshot_variables : k => v if v.snapshot_encryption_settings_key_vault_secret_name != null }
  name         = each.value.snapshot_encryption_settings_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.source_vault_id[each.key].id
}
data "azurerm_key_vault_key" "key_url" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.snapshot_variables : k => v if v.snapshot_encryption_settings_key_vault_key_name != null }
  name         = each.value.snapshot_encryption_settings_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.source_vault_id[each.key].id
}
resource "azurerm_snapshot" "snapshot" {
  provider            = azurerm.snapshot_sub
  for_each            = var.snapshot_variables
  name                = each.value.snapshot_name
  location            = each.value.snapshot_location
  resource_group_name = each.value.snapshot_resource_group_name
  create_option       = each.value.snapshot_create_option
  source_uri          = each.value.snapshot_create_option == "Import" ? null : each.value.snapshot_source_manged_disk == true ? data.azurerm_managed_disk.managed_disk_source_uri[each.key].id : data.azurerm_storage_blob.unmanaged_disk_source_uri[each.key].id
  source_resource_id  = each.value.snapshot_create_option == "Import" ? data.azurerm_snapshot.source_resource_id[each.key].id : null
  storage_account_id  = each.value.snapshot_source_uri_unmanaged_blobs_different_subscription == true ? data.azurerm_storage_account.storage_account_id[each.key].id : null
  disk_size_gb        = each.value.snapshot_disk_size_gb
  incremental_enabled = each.value.snapshot_incremental_enabled
  dynamic "encryption_settings" {
    for_each = each.value.snapshot_encryption_settings_enabled == true ? [each.value.snapshot_encryption_settings] : []
    content {
      dynamic "disk_encryption_key" {
        for_each = each.value.snapshot_encryption_settings_key_vault_secret_name != null ? [1] : []
        content {
          secret_url      = data.azurerm_key_vault_secret.secret_url[each.key].id
          source_vault_id = data.azurerm_key_vault.source_vault_id[each.key].id
        }
      }
      dynamic "key_encryption_key" {
        for_each = each.value.snapshot_encryption_settings_key_vault_key_name != null ? [1] : []
        content {
          key_url         = data.azurerm_key_vault_key.key_url[each.key].id
          source_vault_id = data.azurerm_key_vault.source_vault_id[each.key].id
        }
      }
    }
  }
  tags = merge(each.value.snapshot_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}