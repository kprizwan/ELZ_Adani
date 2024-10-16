#NETWORK INTERFACE OUTPUT
output "network_interface_output" {
  value = { for k, v in azurerm_network_interface.network_interface : k => {
    id                          = v.id
    applied_dns_servers         = v.applied_dns_servers
    internal_domain_name_suffix = v.internal_domain_name_suffix
    mac_address                 = v.mac_address
    private_ip_address          = v.private_ip_address
    private_ip_addresses        = v.private_ip_addresses
    virtual_machine_id          = v.virtual_machine_id
    }
  }
  description = "Network interface output"
}