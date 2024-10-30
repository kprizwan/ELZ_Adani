output "postgresql_database_ids" {
  value = { for k, v in azurerm_postgresql_database.postgresql_database : k => v.id }
}
