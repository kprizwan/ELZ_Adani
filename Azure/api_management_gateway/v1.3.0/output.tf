#API MANAGEMENT GATEWAY OUTPUT
output "api_management_gateway_output" {
  value = { for k, v in azurerm_api_management_gateway.api_management_gateway : k => {
    id = v.id
    }
  }
  description = "api management gateway output values"
}