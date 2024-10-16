#NAT GATEWAY PUBLIC IP ASSOCIATION OUTPUT
output "nat_gateway_public_ip_association_output" {
  value = { for k, v in azurerm_nat_gateway_public_ip_association.nat_gateway_public_ip_association : k => {
    id = v.id
    }
  }
  description = "nat gateway public ip association output values."
}
