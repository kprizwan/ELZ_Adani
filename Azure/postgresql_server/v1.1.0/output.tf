output "postgresql_server_ids" {
  value = { for k, v in azurerm_postgresql_server.postgresql_server : k => v.id }
}