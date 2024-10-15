#SOURCE RESOURCE GROUP VARIABLES
variable "resource_group_variables_source" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#DESTINATION RESOURCE GROUP VARIABLES
variable "resource_group_variables_destination" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#SOURCE VNET VARIABLES
variable "virtual_network_variables_source" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = list(string) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = number       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = string       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = object({        #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
    })
    virtual_network_edge_zone = string                #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_encryption = list(object({        #(Optional) A encryption block as defined below.
      virtual_network_encryption_enforcement = string #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
    }))
    virtual_network_subnet = list(object({                                       #(Optional) for the subnet block config. Set to null if not required
      virtual_network_subnet_name                                       = string #(Required) the subnet name to attach to vnet
      virtual_network_subnet_address_prefix                             = string #(Required) the address prefix to use for the subnet.
      virtual_network_subnet_network_security_group_name                = string #(Optional) the Network Security Group Name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
    }))
    virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
  }))
  default = {}
}

#DESTINATION VNET VARIABLES
variable "virtual_network_variables_destination" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = list(string) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = number       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = string       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = object({        #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
    })
    virtual_network_edge_zone = string                #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_encryption = list(object({        #(Optional) A encryption block as defined below.
      virtual_network_encryption_enforcement = string #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
    }))
    virtual_network_subnet = list(object({                                       #(Optional) for the subnet block config. Set to null if not required
      virtual_network_subnet_name                                       = string #(Required) the subnet name to attach to vnet
      virtual_network_subnet_address_prefix                             = string #(Required) the address prefix to use for the subnet.
      virtual_network_subnet_network_security_group_name                = string #(Optional) the Network Security Group Name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
    }))
    virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
  }))
  default = {}
}

#DDOS PROTECTION PLAN VARIABLES
/* variable "network_ddos_protection_plan_variables" {
  type = map(object({
    network_ddos_protection_plan_name                = string      #(Required) Specifies the name of the Network DDoS Protection Plan. 
    network_ddos_protection_plan_resource_group_name = string      #(Required) The name of the resource group in which to create the resource.
    network_ddos_protection_plan_location            = string      #(Required) Specifies the supported Azure location where the resource exists.
    network_ddos_protection_plan_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
  }))
  description = "Map of Network DDOS Protection plan variables"
  default     = {}
} */

#VIRTUAL NETWORK PEEING VARIABLES
variable "source_virtual_network_peering_variables" {
  type = map(object({
    virtual_network_peering_name                             = string      # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = string      # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = string      # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = string      # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = string      # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = bool        # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = bool        # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = bool        #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = bool        # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = map(string) # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }))
  description = "Map of object of virtual network peering_variables"
  default     = {}
}

#VIRTUAL NETWORK PEEING VARIABLES
variable "destination_virtual_network_peering_variables" {
  type = map(object({
    virtual_network_peering_name                             = string      # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = string      # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = string      # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = string      # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = string      # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = bool        # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = bool        # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = bool        #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = bool        # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = map(string) # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }))
  description = "Map of object of virtual network peering_variables"
  default     = {}
}