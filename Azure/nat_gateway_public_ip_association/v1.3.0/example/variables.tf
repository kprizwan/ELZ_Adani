#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}


#PUBLIC IP VARIABLES
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

#NAT GATEWAY VARIABLES
variable "nat_gateway_variables" {
  type = map(object({
    nat_gateway_name                    = string       #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_location                = string       #(Optional) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name     = string       #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_sku_name                = string       #(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. 
    nat_gateway_idle_timeout_in_minutes = string       #(Optional) The idle timeout which should be used in minutes. Defaults to 4.
    nat_gateway_zones                   = list(string) #(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created.
    nat_gateway_tags                    = map(string)  #(Optional) A mapping of tags to assign to the resource. Changing this forces a new resource to be created.
  }))
  default     = {}
  description = "Map of object of nat gateway variables"
}

#NAT GATEWAY PUBLIC IP ASSOCIATION VARIABLES
variable "nat_gateway_public_ip_association_variables" {
  description = "Map of object of nat gateway public ip associations"
  type = map(object({
    public_ip_name                  = string #(Required) Specifies the name of the Public IP.
    public_ip_resource_group_name   = string #(Required) The name of the Resource Group where this Public IP should exist.
    nat_gateway_name                = string #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name = string #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist.
  }))
  default = {}
}

