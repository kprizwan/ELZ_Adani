#ROUTE TABLE OUTPUT
output "route_table_output" {
  value = { for k, v in azurerm_route_table.route_table : k => {
    id = v.id
    }
  }
  description = "Route Tables Output values"
}