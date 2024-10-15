#VPN GATEWAY OUTPUT
output "VPN_Gateway_output" {
  value       = module.vpn_gateway.vpn_gateway_output
  description = "VPN Gateways Output values"
}
