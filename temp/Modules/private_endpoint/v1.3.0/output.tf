#PRIVATE ENDPOINT OUTPUT
output "private_endpoint_output" {
  value = { for k, v in azurerm_private_endpoint.private_endpoint : k => {
    id = v.id
    }
  }
  description = "Private Endpoint Output values"
}