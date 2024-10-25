data "azurerm_snapshot" "source_resource_id" {
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_create_option != "Copy" }
  name                = each.value.managed_disk_source_resource_name
  resource_group_name = each.value.managed_disk_source_resource_resource_group_name
}
data "azurerm_managed_disk" "managed_disk_source_uri" {
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_create_option == "Copy" }
  name                = each.value.snapshot_managed_disk_name
  resource_group_name = each.value.snapshot_managed_disk_resource_group_name
}
data "azurerm_storage_account" "storage_account_id" {
  for_each            = { for k, v in var.snapshot_variables : k => v if v.snapshot_source_uri_unmanaged_blobs_different_subscription == true }
  name                = each.value.snapshot_storage_account_name
  resource_group_name = each.value.snapshot_storage_resource_group_name
}
data "azurerm_storage_blob" "unmanaged_disk_source_uri" {
  for_each               = { for k, v in var.snapshot_variables : k => v if v.snapshot_source_manged_disk != true }
  name                   = each.value.snapshot_storage_blob_name
  storage_account_name   = each.value.snapshot_storage_account_name
  storage_container_name = each.value.snapshot_storage_container_name
}
resource "azurerm_snapshot" "snapshot" {
  for_each            = var.snapshot_variables
  name                = each.value.snapshot_name
  resource_group_name = each.value.snapshot_resource_group_name
  location            = each.value.snapshot_location
  create_option       = each.value.snapshot_create_option
  source_uri          = each.value.snapshot_create_option == "Import" ? null : each.value.snapshot_source_manged_disk == true ? data.azurerm_managed_disk.managed_disk_source_uri[each.key].id : data.azurerm_storage_blob.unmanaged_disk_source_uri[each.key].id
  source_resource_id  = each.value.snapshot_create_option == "Import" ? data.azurerm_snapshot.source_resource_id[each.key].id : null
  storage_account_id  = each.value.snapshot_source_uri_unmanaged_blobs_different_subscription == true ? data.azurerm_storage_account.storage_account_id[each.key].id : null
  disk_size_gb        = each.value.snapshot_disk_size_gb
  tags                = merge(each.value.snapshot_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}