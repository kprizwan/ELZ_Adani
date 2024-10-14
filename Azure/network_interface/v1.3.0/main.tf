locals {
  subnet = flatten([
    for k, v in var.network_interface_variables : [
      for i, j in v.network_interface_ip_configuration : [
        merge({
          main_key = k, nested_key = i
        }, j.ip_configuration_subnet)
      ] if j.ip_configuration_subnet != null
    ] if v.network_interface_ip_configuration != null
  ])
  public_ip = flatten([
    for k, v in var.network_interface_variables : [
      for i, j in v.network_interface_ip_configuration : [
        merge({
          main_key = k, nested_key = i
        }, j.ip_configuration_public_ip)
      ] if j.ip_configuration_public_ip != null
    ] if v.network_interface_ip_configuration != null
  ])
  load_balancer = flatten([
    for k, v in var.network_interface_variables : [
      for i, j in v.network_interface_ip_configuration : [
        merge({
          main_key = k, nested_key = i
        }, j.ip_configuration_load_balancer)
      ] if j.ip_configuration_load_balancer != null
    ] if v.network_interface_ip_configuration != null
  ])
}

data "azurerm_subnet" "subnet" {
  for_each             = { for v in local.subnet : "${v.main_key},${v.nested_key}" => v }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.subnet_virtual_network_name
  resource_group_name  = each.value.subnet_virtual_network_resource_group_name
}

data "azurerm_public_ip" "public_ip" {
  for_each            = { for v in local.public_ip : "${v.main_key},${v.nested_key}" => v }
  name                = each.value.public_ip_name
  resource_group_name = each.value.public_ip_resource_group_name
}

data "azurerm_lb" "load_balancer" {
  for_each            = { for v in local.load_balancer : "${v.main_key},${v.nested_key}" => v }
  name                = each.value.load_balancer_name
  resource_group_name = each.value.load_balancer_resource_group_name
}

#NETWORK INTERFACE
resource "azurerm_network_interface" "network_interface" {
  for_each                      = var.network_interface_variables
  name                          = each.value.network_interface_name
  location                      = each.value.network_interface_location
  resource_group_name           = each.value.network_interface_resource_group_name
  auxiliary_mode                = each.value.network_interface_auxiliary_mode
  auxiliary_sku                 = each.value.network_interface_auxiliary_sku
  dns_servers                   = each.value.network_interface_dns_servers
  edge_zone                     = each.value.network_interface_edge_zone
  enable_ip_forwarding          = each.value.network_interface_enable_ip_forwarding
  enable_accelerated_networking = each.value.network_interface_enable_accelerated_networking
  internal_dns_name_label       = each.value.network_interface_internal_dns_label
  dynamic "ip_configuration" {
    for_each = each.value.network_interface_ip_configuration
    content {
      name                                               = ip_configuration.value.ip_configuration_name
      private_ip_address_allocation                      = ip_configuration.value.ip_configuration_private_ip_address_allocation
      private_ip_address                                 = ip_configuration.value.ip_configuration_private_ip_address_allocation != "Static" ? null : ip_configuration.value.ip_configuration_private_ip_address
      private_ip_address_version                         = ip_configuration.value.ip_configuration_private_ip_address_version
      subnet_id                                          = ip_configuration.value.ip_configuration_private_ip_address_version != "IPv4" ? null : (ip_configuration.value.ip_configuration_subnet.subnet_name != null ? data.azurerm_subnet.subnet["${each.key},${ip_configuration.key}"].id : null)
      public_ip_address_id                               = ip_configuration.value.ip_configuration_public_ip != null ? data.azurerm_public_ip.public_ip["${each.key},${ip_configuration.key}"].id : null
      primary                                            = ip_configuration.value.ip_configuration_primary
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.ip_configuration_load_balancer != null ? data.azurerm_lb.load_balancer["${each.key},${ip_configuration.key}"].frontend_ip_configuration[0].id : null
    }
  }
  tags = merge(each.value.network_interface_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}