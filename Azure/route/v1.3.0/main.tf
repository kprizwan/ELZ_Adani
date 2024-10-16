#ROUTE TABLE
resource "azurerm_route" "route" {
  for_each               = var.route_variables
  name                   = each.value.route_name
  resource_group_name    = each.value.route_resource_group_name
  route_table_name       = each.value.route_route_table_name
  address_prefix         = each.value.route_address_prefix
  next_hop_type          = each.value.route_next_hop_type
  next_hop_in_ip_address = each.value.route_next_hop_type == "VirtualAppliance" ? each.value.route_next_hop_in_ip_address : null
}