#WINDOWS WEB APP OUTPUT
output "windows_web_app_output" {
  value = { for k, v in azurerm_windows_web_app.windows_web_app : k => {
    id                                = v.id
    hosting_environment_id            = v.hosting_environment_id
    default_hostname                  = v.default_hostname
    kind                              = v.kind
    outbound_ip_address_list          = v.outbound_ip_address_list
    outbound_ip_addresses             = v.outbound_ip_addresses
    possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
    possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
    identity                          = v.identity
    }
  }
  description = "Windows Web App Output Values"
}