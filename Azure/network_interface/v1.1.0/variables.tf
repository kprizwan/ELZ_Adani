variable "network_interface_variables" {
  type = map(object({
    network_interface_name                          = string
    network_interface_location                      = string
    network_interface_resource_group_name           = string
    network_interface_dns_servers                   = list(string)
    network_interface_edge_zone                     = string
    network_interface_enable_ip_forwarding          = bool
    network_interface_enable_accelerated_networking = bool
    network_interface_internal_dns_label            = string
    network_interface_ip_config = map(object({
      ip_configuration_name                          = string
      ip_configuration_private_ip_address_allocation = string
      ip_configuration_private_ip_address            = string
      ip_configuration_private_ip_address_version    = string
      ip_configuration_subnet = object({
        virtual_network_name                = string
        subnet_name                         = string
        virtual_network_resource_group_name = string
      })
      ip_configuration_public_ip = object({
        public_ip_name                = string
        public_ip_resource_group_name = string
      })
      ip_configuration_primary = bool
      ip_configuration_load_balancer = object({
        load_balancer_name                = string
        load_balancer_resource_group_name = string
      })
    }))
    network_interface_tags = map(string)
  }))
}