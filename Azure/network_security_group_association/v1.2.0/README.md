  ### Attributes:
  - network_interface_security_group_association  # (Optional) The block for security group association with network interface
      - network_security_group_association_network_interface_name = string # (Required) The name of the network interface
      - network_security_group_association_network_security_group_name = string # (Required) The name of the network security group name to associate with network interface
      - network_security_group_association_network_interface_resource_group_name = string # (Required) The resource group name which contains network interface
      - network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name which contains security group
    
  - subnet_security_group_association  # (Optional) The block for security group association with subnet
      - network_security_group_association_virtual_network_name = string # (Required) The name of the virtual network where subnets are created
      - network_security_group_association_subnet_name  = string # (Required) The name subnet which needs to be associated with network security group
      - network_security_group_association_network_security_group_name  = string # (Required) The name of network_security_group_name
      - network_security_group_association_virtual_network_resource_group_name  = string # (Required) The resource group name of the virtual network
      - network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name of security group.
   