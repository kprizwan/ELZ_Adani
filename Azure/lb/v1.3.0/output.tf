#LB OUTPUT
output "lb_output" {
  value = { for k, v in azurerm_lb.lb : k => {
    id                        = v.id
    frontend_ip_configuration = v.frontend_ip_configuration
    private_ip_address        = v.private_ip_address
    private_ip_addresses      = v.private_ip_addresses
    }
  }
  description = "LB output values"
}