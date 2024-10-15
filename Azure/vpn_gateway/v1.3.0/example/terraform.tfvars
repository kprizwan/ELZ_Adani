#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}


#VIRTUAL WAN
virtual_wan_variables = {
  "virtual_wan_1" = {
    virtual_wan_name                              = "ploceuswan000001" #(Required) Specifies the name of the Virtual WAN. Changing this forces a new resource to be created.  
    virtual_wan_resource_group_name               = "ploceusrg000001"  #(Required) The name of the resource group in which to create the Virtual WAN. Changing this forces a new resource to be created.
    virtual_wan_location                          = "westus2"          #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    virtual_wan_disable_vpn_encryption            = null               #Optional; can be null which defaults to false
    virtual_wan_allow_branch_to_branch_traffic    = null               #Optional; can be null which defaults to true
    virtual_wan_type                              = "Standard"         #Optional; can be null which defaults to Standard
    virtual_wan_office365_local_breakout_category = "None"             #Optional; can be null which defaults to None
    virtual_wan_tags = {                                               #(Optional) A mapping of tags to assign to the Virtual WAN.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL HUB 
virtual_hub_variables = {
  "virtual_hub_1" = {
    virtual_hub_name                = "ploceushub000001" #(Required) The name of the Virtual Hub. Changing this forces a new resource to be created.
    virtual_hub_location            = "westus2"          #(Required) Specifies the supported Azure location where the Virtual Hub should exist(Should exist in the same location as Virtual WAN).
    virtual_hub_resource_group_name = "ploceusrg000001"  #(Required) Specifies the name of the Resource Group where the Virtual Hub should exist(Should be in the same Resource Group as Virtual WAN).
    virtual_hub_virtual_wan_name    = "ploceuswan000001" #(Required) Specify the name of an existing Virtual WAN.(Taken from Data source)
    virtual_hub_address_prefix      = "10.0.0.0/24"      #(Optional) The Address Prefix which should be used for this Virtual Hub. Changing this forces a new resource to be created. The address prefix subnet cannot be smaller than a /24. Azure recommends using a /23.
    virtual_hub_sku                 = "Standard"         #(Optional) The SKU of the Virtual Hub. Possible values are Basic and Standard. Changing this forces a new resource to be created.
    virtual_hub_routing_preference  = "VpnGateway"       #(Optional) The hub routing preference. Possible values are ExpressRoute, ASPath and VpnGateway. Defaults to ExpressRoute.
    virtual_hub_route               = null               #(Optional) One or more route blocks as defined below.
    virtual_hub_tags = {                                 #(Optional) A mapping of tags to assign to the Virtual Hub.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}


#VPN GATEWAY VARIABLES
vpn_gateway_variables = {
  "vpn_gateway_1" = {
    vpn_gateway_name                                  = "ploceusvpngw000001" #(Required) The Name which should be used for this VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_location                              = "westus2"            #(Required) The Azure location where this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_resource_group_name                   = "ploceusrg000001"    #(Required) The Name of the Resource Group in which this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_virtual_hub_name                      = "ploceushub000001"   # The Name of the virtual hub
    vpn_gateway_bgp_route_translation_for_nat_enabled = true                 #(Optional) Is BGP route translation for NAT on this VPN Gateway enabled? Defaults to false
    vpn_gateway_bgp_settings_enabled                  = true                 #(Optional) A bgp_settings block as defined below.
    vpn_gateway_bgp_settings = {
      vpn_gateway_bgp_settings_asn                                       = 65515 #(Required) The ASN of the BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_peer_weight                               = 1     #(Required) The weight added to Routes learned from this BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_instance_0_bgp_peering_address_custom_ips = []    #(Optional) An instance_bgp_peering_address block as defined below.
      vpn_gateway_bgp_settings_instance_1_bgp_peering_address_custom_ips = []    #(Optional) An instance_bgp_peering_address block as defined below.
    }
    vpn_gateway_scale_unit         = 1                   #(Optional) The Scale Unit for this VPN Gateway. Defaults to 1.                        
    vpn_gateway_routing_preference = "Microsoft Network" #(Optional) Azure routing preference lets you to choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network (default value, Microsoft Network), or via the ISP network (public internet, set to Internet). More context of the configuration can be found in the Microsoft Docs to create a VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_tags = {                                 #(Optional) A mapping of tags to assign to the VPN Gateway.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
