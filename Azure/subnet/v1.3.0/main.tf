#SUBNET
resource "azurerm_subnet" "subnet" {
  for_each                                      = var.subnet_variables
  resource_group_name                           = each.value.subnet_resource_group_name
  name                                          = each.value.subnet_name
  virtual_network_name                          = each.value.subnet_virtual_network_name
  address_prefixes                              = each.value.subnet_address_prefixes
  private_link_service_network_policies_enabled = each.value.subnet_private_link_service_network_policies_enabled
  private_endpoint_network_policies_enabled     = each.value.subnet_private_endpoint_network_policies_enabled
  service_endpoints                             = each.value.subnet_service_endpoints
  service_endpoint_policy_ids                   = each.value.subnet_service_endpoint_policy_ids

  #SUBNET DELEGATION
  dynamic "delegation" {
    for_each = each.value.delegation != null ? each.value.delegation : []
    content {
      name = delegation.value.delegation_name
      service_delegation {
        name    = delegation.value.service_delegation_name
        actions = delegation.value.service_delegation_actions
      }
    }
  }
}