#output "storage_account_id" {
# value = { for k, v in azurerm_storage_account.storage_account : k => v.id }
#}

output "storage_account_outputs" {
  value = [
    for k, v in var.storage_account_variables :
    {
      id                    = azurerm_storage_account.storage_account[k].id
      resource_group_name   = azurerm_storage_account.storage_account[k].resource_group_name
      primary_blob_endpoint = azurerm_storage_account.storage_account[k].primary_blob_endpoint
      location              = azurerm_storage_account.storage_account[k].location
      account_kind          = azurerm_storage_account.storage_account[k].account_kind

    }
  ]
  description = "Storage account output values"
}
