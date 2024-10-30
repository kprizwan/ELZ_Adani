#STORAGE ACCOUNT VARIABLES
variable "storage_account_variables" {
  type = map(object({
    name                      = string
    resource_group_name       = string
    location                  = string
    account_tier              = string
    account_replication_type  = string
    account_kind              = string
    access_tier               = string
    enable_https_traffic_only = bool
    min_tls_version           = string
    allow_blob_public_access  = bool
    large_file_share_enabled  = bool
    nfsv3_enabled             = bool
    is_hns_enabled            = bool
    storage_account_tags      = map(string)
    blob_properties = list(object({
      enable_versioning        = bool
      last_access_time_enabled = bool
      change_feed_enabled      = bool
      delete_retention_policy = object({
        blob_retention_policy = string
      })
      container_delete_retention_policy = object({
        container_delete_retention_policy = string
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))
    static_website = object({
      index_path      = string
      custom_404_path = string
    })
  }))
}