#MSSQL SERVER OUTPUT
output "mssql_server_output" {
  value = { for k, v in azurerm_mssql_server.mssql_server : k => {
    id                              = v.id
    fully_qualified_domain_name     = v.fully_qualified_domain_name
    restorable_dropped_database_ids = v.restorable_dropped_database_ids
    }
  }
  description = "MSSQL Server Output Values"
}