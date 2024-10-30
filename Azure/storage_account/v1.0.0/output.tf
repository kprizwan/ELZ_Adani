#output "storage_account_id" {
# value = { for k, v in azurerm_storage_account.storage_account : k => v.id }
#}


output "storage_account_outputs" {
  value = [
    for k, v in var.storage_account_variables :
    {
      id                    = azurerm_storage_account.storage_account[k].id
      primary_blob_endpoint = azurerm_storage_account.storage_account[k].primary_blob_endpoint
    }
  ]
  description = "Storage account output values"
}