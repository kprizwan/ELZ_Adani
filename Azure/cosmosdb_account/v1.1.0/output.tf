#Output cosmos db account
output "cosmosdb_account_ids" {
  value = { for k, v in azurerm_cosmosdb_account.cosmosdb_account : k => v.id }
}

