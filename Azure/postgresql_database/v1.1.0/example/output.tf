#Output PostgreSql_Database
output "postgresql_database_ids" {
  value       = module.postgresql_database.postgresql_database_ids
  description = "PostgreSql Database Output"
}
