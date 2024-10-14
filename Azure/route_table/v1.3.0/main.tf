#ROUTE TABLE
resource "azurerm_route_table" "route_table" {
  for_each                      = var.route_table_variables
  name                          = each.value.route_table_name
  location                      = each.value.route_table_location
  resource_group_name           = each.value.route_table_resource_group_name
  disable_bgp_route_propagation = each.value.route_table_disable_bgp_route_propagation
  dynamic "route" {
    for_each = each.value.route_table_route != null ? toset(each.value.route_table_route) : []
    content {
      name                   = route.value.route_name
      address_prefix         = route.value.route_address_prefix
      next_hop_type          = route.value.route_next_hop_type
      next_hop_in_ip_address = route.value.route_next_hop_type == "VirtualAppliance" ? route.value.route_next_hop_in_ip_address : null
    }
  }
  tags = merge(each.value.route_table_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}