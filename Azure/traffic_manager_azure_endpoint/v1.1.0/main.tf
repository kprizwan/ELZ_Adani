data "azurerm_client_config" "current" {
  provider = azurerm.traffic_manager_sub
}

data "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  provider            = azurerm.traffic_manager_sub
  for_each            = var.traffic_manager_azure_endpoint_variables
  name                = each.value.traffic_manager_azure_endpoint_traffic_manager_profile_profile_name
  resource_group_name = each.value.traffic_manager_azure_endpoint_traffic_manager_profile_profile_resource_group_name
}

data "azurerm_public_ip" "traffic_manager_public_ip" {
  provider            = azurerm.public_ip_sub
  for_each            = var.traffic_manager_azure_endpoint_variables
  name                = each.value.traffic_manager_azure_endpoint_traffic_manager_public_ip_name
  resource_group_name = each.value.traffic_manager_azure_endpoint_traffic_manager_public_ip_profile_resource_group_name
}

resource "azurerm_traffic_manager_azure_endpoint" "traffic_manager_azure_endpoint" {
  provider           = azurerm.traffic_manager_sub
  for_each           = var.traffic_manager_azure_endpoint_variables
  name               = each.value.traffic_manager_azure_endpoint_name
  profile_id         = data.azurerm_traffic_manager_profile.traffic_manager_profile[each.key].id
  target_resource_id = data.azurerm_public_ip.traffic_manager_public_ip[each.key].id
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
