#POSTGRESQL DATABASE OUTPUT
output "postgresql_database_output" {
  value = { for k, v in azurerm_postgresql_database.postgresql_database : k => {
    id = v.id
    }
  }
  description = "PostgreSql Database Output values"
}