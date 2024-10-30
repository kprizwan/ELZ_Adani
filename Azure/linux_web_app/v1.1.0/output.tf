output "linux_web_app_outputs" {
  value = {
    for k, v in azurerm_linux_web_app.linux_web_app :
    k => {
      web_app_id               = v.id
      default_hostname         = v.default_hostname
      kind                     = v.kind
      outbound_ip_address_list = v.outbound_ip_address_list
      outbound_ip_addresses    = v.outbound_ip_addresses
    }
  }
}
