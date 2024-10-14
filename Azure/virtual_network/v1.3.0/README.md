### Attributes: ###
- virtual_network_name = string #(Required) The name of the virtual network. Changing this forces a new resource to be created.
- virtual_network_resource_group_name = string #(Required) The name of the resource group in which to create the virtual network.
- virtual_network_address_space = list(string)   #(Required) The address space that is used the virtual network. You can supply more than one address space.
- virtual_network_location = string #(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created.
- virtual_network_dns_servers = list(string) #(Optional) list of IP addresses of DNS servers
- virtual_network_flow_timeout_in_minutes = number  #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
- virtual_network_bgp_community = string  #(Optional) the BGP community attribute in format <as-number>:<community-value>.
- virtual_network_ddos_protection_plan = object #(Optional) The ddos protection block. 
   - virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
   - virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
- virtual_network_edge_zone = string #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
- virtual_network_encryption_enforcement = string #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
- virtual_network_subnet = list(object) #(Optional) for the subnet block config. Set to null if not required
    - virtual_network_subnet_name = string #(Required) the subnet name to attach to vnet
    - virtual_network_subnet_address_prefix = string #(Required) the address prefix to use for the subnet.
    - virtual_network_subnet_network_security_group_name = string #(Optional) the Network Security Group Name to associate with the subnet.
    - virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
- virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
>### Notes: ###
>1. Terraform currently provides both a standalone Subnet resource, and allows for Subnets to be defined in-line within the Virtual Network resource. At this time you cannot use a Virtual Network with in-line Subnets in conjunction with any Subnet resources. Doing so will cause a conflict of Subnet configurations and will overwrite subnets.
>2. Terraform currently provides both a standalone virtual network DNS Servers resource, and allows for DNS servers to be defined in-line within the Virtual Network resource. At this time you cannot use a Virtual Network with in-line DNS servers in conjunction with any Virtual Network DNS Servers resources. Doing so will cause a conflict of Virtual Network DNS Servers configurations and will overwrite virtual networks DNS servers.
>3. The as-number segment is the Microsoft ASN, which is always 12076 for now.
>4. Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
>5. Since subnet can be configured both inline and via the separate azurerm_subnet resource, we have to explicitly set it to empty slice ([]) to remove it. 
>6. CIDR examples for virtual network- 10.0.0.0 - 10.255.255.255 (10/8 prefix),172.16.0.0 - 172.31.255.255 (172.16/12 prefix),192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
>7. Make sure the cidr ranges for the virtual network should not match with an exisiting virtual network in the portal.
>8. Subnet address should be within the virtual network address range

>Need to test:
>1. Virtual network with DDOS protection is not tested as  DDOS protection plan costs huge.
>2. DDOS plan is tested and commented the associated code, in case of using please uncomment and add DDOS label name in depends_on condition of virtual_network.