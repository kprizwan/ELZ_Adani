#MSSQL DATABASE OUTPUT
output "mssql_database_output" {
  value = { for k, v in azurerm_mssql_database.mssql_database : k => {
    id = v.id
    }
  }
  description = "mssql database output values"
}