#API MANAGEMENT OUTPUT
output "api_management_output" {
  description = "API Management Output"
  value = { for k, v in azurerm_api_management.api_management : k => {
    id                   = v.id
    gateway_url          = v.gateway_url
    public_ip_addresses  = v.public_ip_addresses
    private_ip_addresses = v.private_ip_addresses
    }
  }
}
