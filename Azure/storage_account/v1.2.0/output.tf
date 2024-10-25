output "storage_account_output" {
  value = { for k, v in azurerm_storage_account.storage_account : k => {
    id                     = v.id
    primary_blob_endpoint  = v.primary_blob_endpoint
    primary_queue_endpoint = v.primary_queue_endpoint
    primary_table_endpoint = v.primary_table_endpoint
    primary_file_endpoint  = v.primary_file_endpoint
    primary_dfs_endpoint   = v.primary_dfs_endpoint
    primary_web_endpoint   = v.primary_web_endpoint
    }
  }
  description = "Storage account output values"
}