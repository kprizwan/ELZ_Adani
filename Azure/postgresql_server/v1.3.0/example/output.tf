#POSTGRESQL SERVER OUTPUT
output "postgresql_server_output" {
  value       = module.postgresql_server.postgresql_server_output
  description = "PostgreSql Server Output"
}