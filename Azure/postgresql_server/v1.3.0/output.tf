#POSTGRESQL SERVER OUTPUT
output "postgresql_server_output" {
  description = "PostgreSql Server Output"
  value = { for k, v in azurerm_postgresql_server.postgresql_server : k => {
    id = v.id
    }
  }
}