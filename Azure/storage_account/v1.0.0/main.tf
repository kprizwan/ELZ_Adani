#Storage Account module
resource "azurerm_storage_account" "storage_account" {
  for_each                  = var.storage_account_variables
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  location                  = each.value.location
  account_tier              = each.value.account_tier
  account_replication_type  = each.value.account_replication_type
  account_kind              = each.value.account_kind
  access_tier               = each.value.access_tier
  enable_https_traffic_only = each.value.enable_https_traffic_only
  min_tls_version           = each.value.min_tls_version
  allow_blob_public_access  = each.value.allow_blob_public_access
  large_file_share_enabled  = each.value.large_file_share_enabled
  is_hns_enabled            = each.value.is_hns_enabled


  dynamic "blob_properties" {
    for_each = each.value.blob_properties != null ? each.value.blob_properties : []
    content {
      versioning_enabled       = blob_properties.value.enable_versioning
      last_access_time_enabled = blob_properties.value.last_access_time_enabled
      change_feed_enabled      = blob_properties.value.change_feed_enabled

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy != null ? [blob_properties.value.delete_retention_policy] : []
        content {
          days = delete_retention_policy.value.blob_retention_policy
        }
      }
      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy != null ? [blob_properties.value.container_delete_retention_policy] : []
        content {
          days = container_delete_retention_policy.value.container_delete_retention_policy
        }
      }
      dynamic "cors_rule" {
        for_each = coalesce(lookup(blob_properties.value, "cors_rule"), [])
        content {
          allowed_origins    = cors_rule.value.allowed_origins
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_headers    = cors_rule.value.allowed_headers
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = each.value["static_website"] != null ? [each.value["static_website"]] : []
    content {
      index_document     = static_website.value.index_path
      error_404_document = static_website.value.custom_404_path
    }
  }

  tags = merge(each.value.storage_account_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
