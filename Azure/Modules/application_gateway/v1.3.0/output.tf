#APPLICATION GATEWAY OUTPUT
output "application_gateway_output" {
  description = "application gateway output"
  value = { for k, v in azurerm_application_gateway.application_gateway : k =>
    {
      id = v.id
    }
  }
}

