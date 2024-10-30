#POSTGRESQL DATABASE OUTPUT
output "postgresql_database_output" {
  value       = module.postgresql_database.postgresql_database_output
  description = "PostgreSql Database Output values"
}