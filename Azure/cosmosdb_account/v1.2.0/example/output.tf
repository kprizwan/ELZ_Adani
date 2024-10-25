#CosmosDB Account Output
output "cosmosdb_account_output" {
  value       = module.cosmosdb_account.cosmosdb_account_output
  description = "CosmosDB Account Output Values"
}