#NAT GATEWAY OUTPUT
output "nat_gateway_output" {
  description = "nat gateway output values"
  value = { for k, v in azurerm_nat_gateway.nat_gateway : k => {
    id            = v.id
    resource_guid = v.resource_guid
    }
  }
}