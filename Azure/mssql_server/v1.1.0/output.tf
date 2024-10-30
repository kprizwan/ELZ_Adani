output "mssql_server_ids" {
  value       = { for k, v in azurerm_mssql_server.mssql_server : k => v.id }
  description = "SQLServer ids"
}