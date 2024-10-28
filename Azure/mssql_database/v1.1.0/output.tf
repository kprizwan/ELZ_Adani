output "mssql_database_ids" {
  value       = { for k, v in azurerm_mssql_database.mssql_database : k => v.id }
  description = "mssql database ids"
}