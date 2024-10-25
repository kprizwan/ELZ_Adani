resource "azurerm_postgresql_database" "postgresql_database" {
  for_each            = var.postgresql_database_variables
  name                = each.value.postgresql_database_name
  resource_group_name = each.value.postgresql_database_resource_group_name
  server_name         = each.value.postgresql_database_server_name
  charset             = each.value.postgresql_database_charset
  collation           = each.value.postgresql_database_collation
}