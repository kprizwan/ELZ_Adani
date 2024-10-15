#VPN GATEWAY OUTPUT
output "vpn_gateway_output" {
  description = "VPN Gateways Output values"
  value = { for k, v in azurerm_vpn_gateway.vpn_gateway : k => {
    id           = v.id
    bgp_settings = v.bgp_settings
    }
  }
}
