#NAT GATEWAY PUBLIC IP ASSOCIATION OUTPUT
output "nat_gateway_public_ip_association_output" {
  value       = module.nat_gateway_public_ip_association.nat_gateway_public_ip_association_output
  description = "nat gateway public ip association output values."
}
