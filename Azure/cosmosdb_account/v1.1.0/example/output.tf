
#Output cosmos db account
output "cosmosdb_account_ids" {
  value       = module.cosmosdb_account.cosmosdb_account_ids
  description = "cosmosdb account output"
}


