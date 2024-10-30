#MSSQL Server Output
output "mssql_server_output" {
  value = { for k, v in azurerm_mssql_server.mssql_server : k => {
    id = v.id
    }
  }
  description = "MSSQL Server Output Values"
}