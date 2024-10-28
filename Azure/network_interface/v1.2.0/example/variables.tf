#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    resource_group_name     = string
    resource_group_location = string
    resource_group_tags     = map(string)
  }))
  default = {}
}

# NETWORK SECURITY GROUP VARIABLES
variable "network_security_group_variables" {
  type = map(object({
    network_security_group_name                = string
    network_security_group_resource_group_name = string
    network_security_group_location            = string
    network_security_group_security_rule = map(object({
      security_rule_name                                           = string
      security_rule_application_security_group_resource_group_name = string
      security_rule_description                                    = string
      security_rule_protocol                                       = string
      security_rule_source_port_range                              = string
      security_rule_source_port_ranges                             = list(string)
      security_rule_destination_port_range                         = string
      security_rule_destination_port_ranges                        = list(string)
      security_rule_source_address_prefix                          = string
      security_rule_source_address_prefixes                        = list(string)
      security_rule_source_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))
      security_rule_destination_address_prefix   = string
      security_rule_destination_address_prefixes = list(string)
      security_rule_destination_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))
      security_rule_access    = string
      security_rule_priority  = string
      security_rule_direction = string
    }))
    network_security_group_tags = map(string)
  }))
  description = "Map of object for network security group details"
  default     = {}
}

#DDOS protection plan variable
variable "network_ddos_protection_plan_variables" {
  type = map(object({
    network_ddos_protection_plan_name                = string      #(Required) Specifies the name of the Network DDoS Protection Plan. 
    network_ddos_protection_plan_resource_group_name = string      #(Required) The name of the resource group in which to create the resource.
    network_ddos_protection_plan_location            = string      #(Required) Specifies the supported Azure location where the resource exists.
    network_ddos_protection_plan_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
  }))
  description = "Map of Network DDOS Protection plan variables"
  default     = {}
}

#VNET variable
variable "virtual_network_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    virtual_network_name                    = string
    virtual_network_location                = string
    virtual_network_resource_group_name     = string
    virtual_network_address_space           = list(string)
    virtual_network_dns_servers             = list(string)
    virtual_network_flow_timeout_in_minutes = number
    virtual_network_bgp_community           = string
    virtual_network_ddos_protection_plan = object({
      virtual_network_ddos_protection_enable    = bool
      virtual_network_ddos_protection_plan_name = string
    })
    virtual_network_edge_zone = string
    virtual_network_subnet = list(object({
      virtual_network_subnet_name                                       = string
      virtual_network_subnet_address_prefix                             = string
      virtual_network_subnet_network_security_group_name                = string
      virtual_network_subnet_network_security_group_resource_group_name = string
    }))
    virtual_network_tags = map(string)
  }))
  default = {}
}


#Subnet Variables
variable "subnet_variables" {
  description = "Map of Subnet"
  type = map(object({
    subnet_name                                           = string
    subnet_resource_group_name                            = string
    subnet_virtual_network_name                           = string
    subnet_address_prefixes                               = list(string)
    subnet_private_link_service_network_policies_enabled  = bool
    subnet_private_endpoint_network_policies_enabled      = bool
    subnet_service_endpoints                              = list(string)
    subnet_enforce_private_link_endpoint_network_policies = bool
    subnet_enforce_private_link_service_network_policies  = bool
    subnet_service_endpoint_policy_ids                    = list(string)
    delegation = list(object({
      delegation_name            = string
      service_delegation_name    = string
      service_delegation_actions = list(string)
    }))
  }))
  default = {}
}

#Public IP variables
variable "public_ip_variables" {
  type = map(object({
    public_ip_name                                     = string       # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = string       # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = string       # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = string       # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = string       # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = string       # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = string       # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_zones                                    = list(string) # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = string       # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_domain_name_label                        = string       # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_idle_timeout_in_minutes                  = string       # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_reverse_fqdn                             = string       # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_prefix_id                                = string       # (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_ip_tags                                  = map(string)  # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = bool         # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = string       # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = string       # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = string       # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags                                     = map(string)  # (Optional) Public IP tags
  }))
  description = "Map of object of Pubic IP variables"
  default     = {}
}

#Load Balancer variable
variable "load_balancers_variables" {
  type = map(object({
    load_balancer_name                = string #(Required) Specifies the name of the Load Balancer.
    load_balancer_resource_group_name = string # (Required) The name of the Resource Group in which to create the Load Balancer.
    load_balancer_location            = string ## (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    load_balancer_edge_zone           = string #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    load_balancer_frontend_ip_configuration = map(object({
      frontend_ip_configuration_name  = string #(Required) Specifies the name of the frontend IP configuration.
      frontend_ip_configuration_zones = list(string)
      frontend_ip_configuration_subnet = object({
        subnet_name                    = string # Subnet name
        subnet_virtual_network_name    = string # virtual network name where subnet resides.
        virtual_network_resource_group = string # Resource group name where the virtual network resides.
      })
      frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id = object({ #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        gateway_load_balancer_name                = string                                    # gateway load balancer name
        gateway_load_balancer_resource_group_name = string                                    # gateway load balancer resource group name
      })
      frontend_ip_configuration_private_ip_address            = string # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
      frontend_ip_configuration_private_ip_address_allocation = string #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
      frontend_ip_configuration_private_ip_address_version    = string #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
      frontend_ip_configuration_public_ip_address_id = object({
        public_ip_name                = string # public ip  name
        public_ip_resource_group_name = string # public ip resource group name
      })
      frontend_ip_configuration_public_ip_prefix_id = object({
        public_ip_prefix_name                = string # public ip prefix name
        public_ip_prefix_resource_group_name = string # public ip prefix resource group name            
      })
    }))
    load_balancer_sku      = string      #(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    load_balancer_sku_tier = string      #(Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    load_balancer_tags     = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of object of Load Balancer variables"
  default     = {}
}

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