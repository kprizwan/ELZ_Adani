#NAT GATEWAY OUTPUT
output "nat_gateway_output" {
  value       = module.nat_gateway.nat_gateway_output
  description = "nat gateway output values"
}