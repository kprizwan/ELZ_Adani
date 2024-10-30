data "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  provider            = azurerm.traffic_manager_sub
  for_each            = var.traffic_manager_azure_endpoint_variables
  name                = each.value.traffic_manager_azure_endpoint_traffic_manager_profile_name
  resource_group_name = each.value.traffic_manager_azure_endpoint_traffic_manager_profile_resource_group_name
}

data "azurerm_resources" "target_resource_id" {
  provider            = azurerm.target_resource_sub
  for_each            = var.traffic_manager_azure_endpoint_variables
  name                = each.value.traffic_manager_azure_endpoint_target_resource_name
  resource_group_name = each.value.traffic_manager_azure_endpoint_target_resource_resource_group_name
}

resource "azurerm_traffic_manager_azure_endpoint" "traffic_manager_azure_endpoint" {
  provider           = azurerm.traffic_manager_sub
  for_each           = var.traffic_manager_azure_endpoint_variables
  name               = each.value.traffic_manager_azure_endpoint_name
  profile_id         = data.azurerm_traffic_manager_profile.traffic_manager_profile[each.key].id
  target_resource_id = each.value.traffic_manager_azure_endpoint_is_user_providing_target_resource_id == false ? data.azurerm_resources.target_resource_id[each.key].resources[0].id : each.value.traffic_manager_azure_endpoint_target_resource_id
  weight             = each.value.traffic_manager_azure_endpoint_weight
  enabled            = each.value.traffic_manager_azure_endpoint_enabled
  geo_mappings       = each.value.traffic_manager_azure_endpoint_geo_mappings
  priority           = each.value.traffic_manager_azure_endpoint_priority

  dynamic "custom_header" {
    for_each = each.value.traffic_manager_azure_endpoint_custom_header != null ? each.value.traffic_manager_azure_endpoint_custom_header : []
    content {
      name  = custom_header.value.custom_header_name
      value = custom_header.value.custom_header_value
    }
  }
  dynamic "subnet" {
    for_each = each.value.traffic_manager_azure_endpoint_subnet != null ? each.value.traffic_manager_azure_endpoint_subnet : []
    content {
      first = subnet.value.subnet_first
      last  = subnet.value.subnet_last
      scope = subnet.value.subnet_scope
    }
  }
}
