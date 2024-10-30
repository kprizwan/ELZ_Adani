data "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  for_each            = var.traffic_manager_external_endpoint_variables
  name                = each.value.traffic_manager_external_endpoint_traffic_manager_profile_name
  resource_group_name = each.value.traffic_manager_external_endpoint_traffic_manager_profile_resource_group_name
}
resource "azurerm_traffic_manager_external_endpoint" "traffic_manager_external_endpoint" {
  for_each          = var.traffic_manager_external_endpoint_variables
  name              = each.value.traffic_manager_external_endpoint_name
  profile_id        = data.azurerm_traffic_manager_profile.traffic_manager_profile[each.key].id
  target            = each.value.traffic_manager_external_endpoint_target
  weight            = each.value.traffic_manager_external_endpoint_weight
  enabled           = each.value.traffic_manager_external_endpoint_enabled
  endpoint_location = each.value.traffic_manager_external_endpoint_endpoint_location
  priority          = each.value.traffic_manager_external_endpoint_priority
  geo_mappings      = each.value.traffic_manager_external_endpoint_geo_mappings
  dynamic "custom_header" {
    for_each = each.value.traffic_manager_external_endpoint_custom_header != null ? each.value.traffic_manager_external_endpoint_custom_header : []
    content {
      name  = custom_header.value.custom_header_name
      value = custom_header.value.custom_header_value
    }
  }
  dynamic "subnet" {
    for_each = each.value.traffic_manager_external_endpoint_subnet != null ? each.value.traffic_manager_external_endpoint_subnet : []
    content {
      first = subnet.value.subnet_first
      last  = subnet.value.subnet_last
      scope = subnet.value.subnet_scope
    }
  }
}
