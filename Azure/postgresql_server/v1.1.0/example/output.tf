#Output PostgreSql_Server
output "postgresql_server_ids" {
  value       = module.postgresql_server.postgresql_server_ids
  description = "PostgreSql Server Output"
}