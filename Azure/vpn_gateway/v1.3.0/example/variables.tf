#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#VIRTUAL WAN VARIABLES
variable "virtual_wan_variables" {
  type = map(object({
    virtual_wan_name                              = string      #(Required) Specifies the name of the Virtual WAN. Changing this forces a new resource to be created.
    virtual_wan_resource_group_name               = string      #(Required) The name of the resource group in which to create the Virtual WAN. Changing this forces a new resource to be created.
    virtual_wan_disable_vpn_encryption            = bool        #(Optional) Boolean flag to specify whether VPN encryption is disabled. Defaults to false.
    virtual_wan_allow_branch_to_branch_traffic    = bool        #(Optional) Boolean flag to specify whether branch to branch traffic is allowed. Defaults to true
    virtual_wan_location                          = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    virtual_wan_type                              = string      #(Optional) Specifies the Virtual WAN type. Possible Values include: Basic and Standard. Defaults to Standard.
    virtual_wan_office365_local_breakout_category = string      #(Optional) Specifies the Office365 local breakout category. Possible values include: Optimize, OptimizeAndAllow, All, None. Defaults to None.
    virtual_wan_tags                              = map(string) #(Optional) A mapping of tags to assign to the Virtual WAN.
  }))
  description = "Map of Virtual WANs"
  default     = {}
}

#VIRTUAL HUB VARIABLES
variable "virtual_hub_variables" {
  type = map(object({
    virtual_hub_name                = string      #(Required) The name of the Virtual Hub. Changing this forces a new resource to be created.
    virtual_hub_location            = string      #(Required) Specifies the supported Azure location where the Virtual Hub should exist(Should exist in the same location as Virtual WAN).
    virtual_hub_resource_group_name = string      #(Required) Specifies the name of the Resource Group where the Virtual Hub should exist(Should exist in the same Resource Group as Virtual WAN).
    virtual_hub_virtual_wan_name    = string      #(Required) Specifies the name of the Resource Group where the Virtual Hub should exist. Changing this forces a new resource to be created.
    virtual_hub_address_prefix      = string      #(Optional) The Address Prefix which should be used for this Virtual Hub. Changing this forces a new resource to be created. The address prefix subnet cannot be smaller than a /24. Azure recommends using a /23.
    virtual_hub_tags                = map(string) #(Optional) A mapping of tags to assign to the Virtual Hub.
    virtual_hub_routing_preference  = string      #(Optional) The hub routing preference. Possible values are ExpressRoute, ASPath and VpnGateway. Defaults to ExpressRoute.
    virtual_hub_sku                 = string      #(Optional) The SKU of the Virtual Hub. Possible values are Basic and Standard. Changing this forces a new resource to be created.
    virtual_hub_route = list(object({             #(Optional) One or more route details.
      route_address_prefixes    = list(string)    #(Required) A list of Address Prefixes.
      route_next_hop_ip_address = string          #(Required) The IP Address that Packets should be forwarded to as the Next Hop.
    }))
  }))
  description = "Map of Virtual hub"
  default     = {}
}

#VPN GATEWAYS VARIABLES
variable "vpn_gateway_variables" {
  type = map(object({
    vpn_gateway_name                                  = string #(Required) The Name which should be used for this VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_location                              = string #(Required) The Azure location where this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_resource_group_name                   = string #(Required) The Name of the Resource Group in which this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_virtual_hub_name                      = string # The Name of the virtual hub
    vpn_gateway_bgp_route_translation_for_nat_enabled = bool   #(Optional) Is BGP route translation for NAT on this VPN Gateway enabled? Defaults to false
    vpn_gateway_bgp_settings_enabled                  = bool   #(Optional) A bgp_settings block as defined below.
    vpn_gateway_bgp_settings = object({
      vpn_gateway_bgp_settings_asn                                       = number       #(Required) The ASN of the BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_peer_weight                               = number       #(Required) The weight added to Routes learned from this BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_instance_0_bgp_peering_address_custom_ips = list(string) #(Optional) An instance_bgp_peering_address block as defined below.
      vpn_gateway_bgp_settings_instance_1_bgp_peering_address_custom_ips = list(string) #(Optional) An instance_bgp_peering_address block as defined below.
    })
    vpn_gateway_scale_unit         = number      #(Optional) The Scale Unit for this VPN Gateway. Defaults to 1.
    vpn_gateway_routing_preference = string      #(Optional) Azure routing preference lets you to choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network (default value, Microsoft Network), or via the ISP network (public internet, set to Internet). More context of the configuration can be found in the Microsoft Docs to create a VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_tags               = map(string) #(Optional) A mapping of tags to assign to the VPN Gateway.
  }))
  description = "Map of VPN Gateway object"
  default     = {}
}