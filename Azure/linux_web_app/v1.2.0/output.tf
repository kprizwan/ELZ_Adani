#linux web app outputs
output "linux_web_app_output" {
  description = "Linux Web App output"
  value = { for k, v in azurerm_linux_web_app.linux_web_app : k => {
    id                                = v.id
    default_hostname                  = v.default_hostname
    kind                              = v.kind
    outbound_ip_address_list          = v.outbound_ip_address_list
    outbound_ip_addresses             = v.outbound_ip_addresses
    identity                          = v.identity
    possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
    possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
    }
  }
}
