#DATA BLOCK FOR VIRTUAL HUB
data "azurerm_virtual_hub" "virtual_hub" {
  for_each            = var.vpn_gateway_variables
  name                = each.value.vpn_gateway_virtual_hub_name
  resource_group_name = each.value.vpn_gateway_resource_group_name
}

#VPN GATEWAY
resource "azurerm_vpn_gateway" "vpn_gateway" {
  for_each                              = var.vpn_gateway_variables
  name                                  = each.value.vpn_gateway_name
  location                              = each.value.vpn_gateway_location
  resource_group_name                   = each.value.vpn_gateway_resource_group_name
  virtual_hub_id                        = data.azurerm_virtual_hub.virtual_hub[each.key].id
  bgp_route_translation_for_nat_enabled = each.value.vpn_gateway_bgp_route_translation_for_nat_enabled
  dynamic "bgp_settings" {
    for_each = each.value.vpn_gateway_bgp_settings_enabled == true ? [1] : []
    content {
      asn         = each.value.vpn_gateway_bgp_settings.vpn_gateway_bgp_settings_asn
      peer_weight = each.value.vpn_gateway_bgp_settings.vpn_gateway_bgp_settings_peer_weight
      dynamic "instance_0_bgp_peering_address" {
        for_each = each.value.vpn_gateway_bgp_settings.vpn_gateway_bgp_settings_instance_0_bgp_peering_address_custom_ips != null ? [1] : []
        content {
          custom_ips = each.value.vpn_gateway_bgp_settings.vpn_gateway_bgp_settings_instance_0_bgp_peering_address_custom_ips
        }
      }
      dynamic "instance_1_bgp_peering_address" {
        for_each = each.value.vpn_gateway_bgp_settings.vpn_gateway_bgp_settings_instance_1_bgp_peering_address_custom_ips != null ? [1] : []
        content {
          custom_ips = each.value.vpn_gateway_bgp_settings.vpn_gateway_bgp_settings_instance_1_bgp_peering_address_custom_ips
        }
      }
    }
  }
  routing_preference = each.value.vpn_gateway_routing_preference
  scale_unit         = each.value.vpn_gateway_scale_unit
  tags               = merge(each.value.vpn_gateway_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}