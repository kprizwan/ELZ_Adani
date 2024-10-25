
#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}


#STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_1" = {
    name                      = "ploceussa000001a"
    resource_group_name       = "ploceusrg000001"
    location                  = "westus2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    account_kind              = "StorageV2"
    access_tier               = "Hot"
    enable_https_traffic_only = true
    min_tls_version           = "TLS1_2"
    allow_blob_public_access  = true
    large_file_share_enabled  = false
    nfsv3_enabled             = false
    is_hns_enabled            = false #This can only be true when account_tier is Standard or Premium and account_kind is BlockBlobStorage
    blob_properties = [{
      enable_versioning        = true
      last_access_time_enabled = false
      change_feed_enabled      = false
      delete_retention_policy = {
        blob_retention_policy = "1"
      }
      container_delete_retention_policy = {
        container_delete_retention_policy = "1"
      }
      cors_rule = [{
        allowed_origins    = ["*"]
        allowed_methods    = ["GET", "DELETE"]
        allowed_headers    = ["*"]
        exposed_headers    = ["*"]
        max_age_in_seconds = 5
      }]
    }]
    static_website = {
      index_path      = "index.html"
      custom_404_path = "404.html"
    }
    storage_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },

  "storage_account_2" = {
    name                      = "ploceussa000001b"
    resource_group_name       = "ploceusrg000001"
    location                  = "westus2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    account_kind              = "StorageV2"
    access_tier               = "Hot"
    enable_https_traffic_only = true
    min_tls_version           = "TLS1_2"
    allow_blob_public_access  = true
    large_file_share_enabled  = false
    nfsv3_enabled             = false
    is_hns_enabled            = false #This can only be true when account_tier is Standard or Premium and account_kind is BlockBlobStorage
    blob_properties           = null
    static_website            = null
    storage_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
