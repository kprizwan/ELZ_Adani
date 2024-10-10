locals {
  private_dns_zone_name = flatten([for k, v in var.private_endpoint_variables :
    [for q in v.private_endpoint_private_dns_zone_group.private_dns_zone_names : {
      main_key = k, private_dns_zone_name = q, private_dns_zone_resource_group_name = v.private_endpoint_private_dns_zone_group.private_dns_zone_resource_group_name }
  ] if v.private_endpoint_private_dns_zone_group != null])
}

#DATA RESOURCE FOR SUBNET
data "azurerm_subnet" "subnet_id" {
  provider             = azurerm.private_endpoint_sub
  for_each             = var.private_endpoint_variables
  name                 = each.value.private_endpoint_subnet_name
  virtual_network_name = each.value.private_endpoint_virtual_network_name
  resource_group_name  = each.value.private_endpoint_virtual_network_resource_group_name
}

#DATA RESOURCE FOR PRIVATE DNS ZONE
data "azurerm_private_dns_zone" "private_dns_zone" {
  for_each            = { for j in local.private_dns_zone_name : "${j.main_key}:${j.private_dns_zone_name}" => j }
  name                = each.value.private_dns_zone_name
  resource_group_name = each.value.private_dns_zone_resource_group_name
}

#DATA RESOURCE FOR RESOURCES TO CONNECT PRIVATELY
data "azurerm_resources" "private_connection_resource" {
  provider            = azurerm.private_connection_sub
  for_each            = { for k, v in var.private_endpoint_variables : k => v.private_endpoint_private_service_connection }
  name                = each.value.private_connection_resource_name
  resource_group_name = each.value.private_connection_resource_resource_group_name
}

#PRIVATE ENDPOINT RESOURCE
resource "azurerm_private_endpoint" "private_endpoint" {
  for_each                      = var.private_endpoint_variables
  name                          = each.value.private_endpoint_name
  resource_group_name           = each.value.private_endpoint_resource_group_name
  location                      = each.value.private_endpoint_location
  subnet_id                     = data.azurerm_subnet.subnet_id[each.key].id
  custom_network_interface_name = each.value.custom_network_interface_name
  dynamic "private_dns_zone_group" {
    for_each = each.value.private_endpoint_private_dns_zone_group != null ? [each.value.private_endpoint_private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value.private_dns_zone_group_name
      private_dns_zone_ids = [for k, v in private_dns_zone_group.value.private_dns_zone_names : data.azurerm_private_dns_zone.private_dns_zone["${each.key}:${v}"].id]
    }
  }
  dynamic "private_service_connection" {
    for_each = [each.value.private_endpoint_private_service_connection]
    content {
      name                              = private_service_connection.value.private_service_connection_name
      is_manual_connection              = private_service_connection.value.private_service_connection_is_manual_connection
      private_connection_resource_id    = private_service_connection.value.private_connection_resource_alias == null && private_service_connection.value.private_connection_resource_name != null ? data.azurerm_resources.private_connection_resource[each.key].resources[0].id : null
      private_connection_resource_alias = private_service_connection.value.private_connection_resource_alias
      subresource_names                 = each.value.private_endpoint_private_service_connection.subresource_names
      request_message                   = private_service_connection.value.private_service_connection_is_manual_connection == true ? private_service_connection.value.private_service_connection_request_message : null
    }
  }
  dynamic "ip_configuration" {
    for_each = each.value.private_endpoint_ip_configuration != null ? each.value.private_endpoint_ip_configuration : {}
    content {
      name               = ip_configuration.value.ip_configuration_name
      private_ip_address = ip_configuration.value.ip_configuration_private_ip_address
      subresource_name   = ip_configuration.value.ip_configuration_subresource_name
      member_name        = ip_configuration.value.ip_configuration_member_name
    }
  }
  tags = merge(each.value.private_endpoint_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
