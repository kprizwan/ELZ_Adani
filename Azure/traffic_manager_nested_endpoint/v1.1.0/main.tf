data "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  for_each            = var.traffic_manager_nested_endpoint_variables
  name                = each.value.traffic_manager_nested_endpoint_traffic_manager_profile_profile_name
  resource_group_name = each.value.traffic_manager_nested_endpoint_traffic_manager_profile_resource_group_name
}

data "azurerm_traffic_manager_profile" "traffic_manager_nested_profile" {
  for_each            = var.traffic_manager_nested_endpoint_variables
  name                = each.value.traffic_manager_nested_endpoint_traffic_manager_nested_profile_name
  resource_group_name = each.value.traffic_manager_nested_endpoint_traffic_manager_nested_profile_resource_group_name
}

resource "azurerm_traffic_manager_nested_endpoint" "traffic_manager_nested_endpoint" {
  for_each                              = var.traffic_manager_nested_endpoint_variables
  name                                  = each.value.traffic_manager_nested_endpoint_name
  minimum_child_endpoints               = each.value.traffic_manager_nested_endpoint_minimum_child_endpoints
  profile_id                            = data.azurerm_traffic_manager_profile.traffic_manager_profile[each.key].id
  target_resource_id                    = data.azurerm_traffic_manager_profile.traffic_manager_nested_profile[each.key].id
  weight                                = each.value.traffic_manager_nested_endpoint_weight
  enabled                               = each.value.traffic_manager_nested_endpoint_enabled
  endpoint_location                     = each.value.traffic_manager_nested_endpoint_endpoint_location
  minimum_required_child_endpoints_ipv4 = each.value.traffic_manager_nested_endpoint_minimum_required_child_endpoints_ipv4
  minimum_required_child_endpoints_ipv6 = each.value.traffic_manager_nested_endpoint_minimum_required_child_endpoints_ipv6
  priority                              = each.value.traffic_manager_nested_endpoint_priority
  geo_mappings                          = each.value.traffic_manager_nested_endpoint_geo_mappings
  dynamic "custom_header" {
    for_each = each.value.traffic_manager_nested_endpoint_custom_header != null ? each.value.traffic_manager_nested_endpoint_custom_header : []
    content {
      name  = custom_header.value.custom_header_name
      value = custom_header.value.custom_header_value
    }
  }
  dynamic "subnet" {
    for_each = each.value.traffic_manager_nested_endpoint_subnet != null ? each.value.traffic_manager_nested_endpoint_subnet : []
    content {
      first = subnet.value.subnet_first
      last  = subnet.value.subnet_last
      scope = subnet.value.subnet_scope
    }
  }
}
