#DATA BLOCK FOR VIRTUAL NETWORK
data "azurerm_virtual_network" "virtual_network" {
  provider            = azurerm.destination_virtual_network_sub
  for_each            = var.virtual_network_peering_variables
  name                = each.value.virtual_network_peering_destination_virtual_network_name
  resource_group_name = each.value.virtual_network_peering_destination_resource_group_name
}

#VIRTUAL NETWORK PEERING
resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  provider                     = azurerm.source_virtual_network_sub
  for_each                     = var.virtual_network_peering_variables
  name                         = each.value.virtual_network_peering_name
  resource_group_name          = each.value.virtual_network_peering_resource_group_name
  virtual_network_name         = each.value.virtual_network_peering_virtual_network_name
  remote_virtual_network_id    = data.azurerm_virtual_network.virtual_network[each.key].id
  allow_virtual_network_access = each.value.virtual_network_peering_allow_virtual_network_access
  allow_forwarded_traffic      = each.value.virtual_network_peering_allow_forwarded_traffic
  allow_gateway_transit        = each.value.virtual_network_peering_allow_gateway_transit
  use_remote_gateways          = each.value.virtual_network_peering_use_remote_gateways
  triggers                     = each.value.virtual_network_peering_triggers
}