data "azurerm_storage_account" "storage_account_id" {
  for_each            = { for k, v in var.eventhub_variables : k => v if lookup(v, "eventhub_storage_blob_storage_account_name", null) != null && lookup(v, "eventhub_storage_blob_storage_account_resource_group_name", null) != null }
  name                = each.value.eventhub_storage_blob_storage_account_name
  resource_group_name = each.value.eventhub_storage_blob_storage_account_resource_group_name
}

resource "azurerm_eventhub" "eventhub" {
  for_each            = var.eventhub_variables
  name                = each.value.eventhub_name
  namespace_name      = each.value.eventhub_namespace_name
  resource_group_name = each.value.eventhub_resource_group_name
  partition_count     = each.value.eventhub_partition_count
  message_retention   = each.value.eventhub_message_retention
  status              = each.value.eventhub_status
  dynamic "capture_description" {
    for_each = each.value.eventhub_capture_description != null ? each.value.eventhub_capture_description : []
    content {
      enabled             = capture_description.value.capture_description_enabled
      encoding            = capture_description.value.capture_description_encoding
      interval_in_seconds = capture_description.value.capture_description_interval_in_seconds
      size_limit_in_bytes = capture_description.value.capture_description_size_limit_in_bytes
      skip_empty_archives = capture_description.value.capture_description_skip_empty_archives
      dynamic "destination" {
        for_each = capture_description.value.capture_description_destination
        content {
          name                = destination.value.capture_description_destination_name
          archive_name_format = destination.value.capture_description_destination_archive_name_format
          blob_container_name = destination.value.capture_description_destination_blob_container_name
          storage_account_id  = data.azurerm_storage_account.storage_account_id[each.key].id
        }
      }
    }
  }
}
