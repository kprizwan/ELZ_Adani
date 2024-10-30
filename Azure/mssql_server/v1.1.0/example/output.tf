output "mssql_server_ids" {
  value       = module.mssql_server.mssql_server_ids
  description = "SQLServer ids"
  sensitive   = true
}