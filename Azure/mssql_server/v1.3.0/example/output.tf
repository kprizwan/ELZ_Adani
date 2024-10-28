#MSSQL SERVER OUTPUT
output "mssql_server_output" {
  value       = module.mssql_server.mssql_server_output
  description = "MSSQL Server Output Values"
}