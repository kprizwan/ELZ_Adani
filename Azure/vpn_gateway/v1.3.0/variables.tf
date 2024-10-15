#VPN GATEWAY VARIABLES
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
    vpn_gateway_routing_preference = string      #(Optional) Azure routing preference lets you to choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network (default value, Microsoft Network), or via the ISP network (public internet, set to Internet). More context of the configuration can be found in the Microsoft Docs to create a VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_scale_unit         = number      #(Optional) The Scale Unit for this VPN Gateway. Defaults to 1.
    vpn_gateway_tags               = map(string) #(Optional) A mapping of tags to assign to the VPN Gateway.
  }))
  description = "Map of VPN Gateway object"
  default     = {}
}