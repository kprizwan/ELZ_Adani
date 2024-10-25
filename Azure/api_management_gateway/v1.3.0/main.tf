data "azurerm_api_management" "api_management" {
  for_each            = var.api_management_gateway_variables
  name                = each.value.api_management_gateway_api_management_name
  resource_group_name = each.value.api_management_gateway_api_management_resource_group_name
}

resource "azurerm_api_management_gateway" "api_management_gateway" {
  for_each          = var.api_management_gateway_variables
  name              = each.value.api_management_gateway_name
  api_management_id = data.azurerm_api_management.api_management[each.key].id
  description       = each.value.api_management_gateway_description
  location_data {
    name     = each.value.api_management_gateway_name
    city     = each.value.api_management_gateway_city
    district = each.value.api_management_gateway_district
    region   = each.value.api_management_gateway_region
  }
}