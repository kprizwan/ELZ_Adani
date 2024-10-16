#ROUTE OUTPUT
output "route_output" {
  value = { for k, v in azurerm_route.route : k => {
    id = v.id
    }
  }
  description = "Routes Output values"
}