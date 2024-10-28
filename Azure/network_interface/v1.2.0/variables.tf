#Network Interface variable
variable "network_interface_variables" {
  description = "Map of Network interface"
  type = map(object({
    network_interface_name                          = string       #(Required) The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = string       #(Required) The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = string       #(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_dns_servers                   = list(string) #(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. 
    network_interface_edge_zone                     = string       #(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created.
    network_interface_enable_ip_forwarding          = bool         #Optional)  Should IP Forwarding be enabled? Defaults to false
    network_interface_enable_accelerated_networking = bool         #(Optional) Should Accelerated Networking be enabled? Defaults to false
    network_interface_internal_dns_label            = string       #(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = map(object({              #(Required) One or more ip_configuration blocks
      ip_configuration_name                          = string      #(Required) A name used for this IP Configuration. Changing this forces a new resource to be created.
      ip_configuration_private_ip_address_allocation = string      #(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.
      ip_configuration_private_ip_address            = string      #(Optional) When private_ip_address_allocation is set to Static, The Static IP Address which should be used
      ip_configuration_private_ip_address_version    = string      #(Optional) The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
      ip_configuration_subnet = object({                           #(Required) When private_ip_address_version is set to IPv4,The ID of the Subnet where this Network Interface should be located in.
        subnet_virtual_network_name                = string        #(Required) When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID.
        subnet_name                                = string        #(Required) When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID.
        subnet_virtual_network_resource_group_name = string        #(Required) When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID.
      })
      ip_configuration_public_ip = object({    #(Optional) Reference to a Public IP Address to associate with this NIC
        public_ip_name                = string #(Optional) Reference to a Public IP Address Name to associate with this NIC
        public_ip_resource_group_name = string #(Optional) Reference to a Public IP Address Name Resource Group Name to associate with this NIC
      })
      ip_configuration_primary = bool              #(Optional) Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false
      ip_configuration_load_balancer = object({    #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        load_balancer_name                = string #(Optional) The Load Balancer name is required to fetch the Load Balancer ID.
        load_balancer_resource_group_name = string #(Optional) The Load Balancer Resource Group name is required to fetch the Load Balancer ID
      })
    }))
    network_interface_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}