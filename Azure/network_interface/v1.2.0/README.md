## Attributes: 
- network_interface_name                               = string (Required) The name of the Network Interface. Changing this forces a new resource to be created.(No Changes)                           

- network_interface_location                           = string (Required) The location where the Network Interface should exist. Changing this forces a new resource to be created.(No Changes)

- network_interface_resource_group_name               = string (Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.(No Changes)

- network_interface_dns_servers                        = list(string) (Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface.(No Changes)  

- network_interface_edge_zone                          = string (Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created.(No Changes)

- network_interface_enable_ip_forwarding               = bool (Optional) Should IP Forwarding be enabled? Defaults to false.(No Changes)

- network_interface_enable_accelerated_networking      = bool (Optional) Should Accelerated Networking be enabled? Defaults to false.(No Changes)

- network_interface_internal_dns_label                 = string (Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.(No Changes)

- network_interface_ip_configuration                   = map(object({})) (Required) One or more ip_configuration blocks.(No Changes)

- ip_configuration_name                                = string (Required) A name used for this IP Configuration. Changing this forces a new resource to be created.(No Changes)

- ip_configuration_private_ip_address_allocation       = string (Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.(No Changes)

- ip_configuration_private_ip_address                  = string (Optional) When private_ip_address_allocation is set to Static, The Static IP Address which should be used.(No Changes)

- ip_configuration_private_ip_address_version          = string (Optional) The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.(No Changes)

- ip_configuration_subnet                              = object (Required) When private_ip_address_version is set to IPv4,The ID of the Subnet where this Network Interface should be located in.(No Changes)

- virtual_network_name                                 = string (Required) When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID.(No Changes)

- subnet_name                                         = string (Required) When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID.(No Changes)

- virtual_network_resource_group_name                 = string (Required) When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID.(No Changes)

- ip_configuration_public_ip                          = string (Optional) Reference to a Public IP Address to associate with this NIC.(No Changes)

- public_ip_name                                      = string (Optional) Reference to a Public IP Address Name to associate with this NIC.(No Changes)
 
- public_ip_resource_group_name                       = string (Optional) Reference to a Public IP Address Name Resource Group Name to associate with this NIC.(No Changes)

- ip_configuration_primary                            = bool   (Optional) Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.(No Changes)
 
- ip_configuration_load_balancer                      = object() (Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.(No Changes)

- load_balancer_name                                  = string (Optional) The Load Balancer name is required to fetch the Load Balancer ID.(No Changes)

- load_balancer_resource_group_name                   = string (Optional) The Load Balancer Resource Group name is required to fetch the Load Balancer ID.(No Changes)

- network_interface_tags                               = map(string) (Optional) A mapping of tags to assign to the resource.(No Changes)




>### Notes: ###
> 1. Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network.(Optional)
> 2. Only certain Virtual Machine sizes are supported for Accelerated Networking.(Optional)
> 3. To use Accelerated Networking in an Availability Set, the Availability Set must be deployed onto an Accelerated Networking enabled cluster.(Optional)
> 4. This is required when private_ip_address_version is set to IPv4.(Optional)
> 5. Dynamic means "An IP is automatically assigned during creation of this Network Interface".(Required)
> 6. If a Dynamic allocation method is used Azure will allocate an IP Address on Network Interface creation.(Required)
