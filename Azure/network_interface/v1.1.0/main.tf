locals {
  subnet = flatten([
    for k, v in var.network_interface_variables : [
      for i, j in v.network_interface_ip_config : [
        merge({
          main_key = k, nested_key = i
        }, j.ip_configuration_subnet)
      ]
  ]])
  public_ip = flatten([
    for k, v in var.network_interface_variables : [
      for i, j in v.network_interface_ip_config : [
        merge({
          main_key = k, nested_key = i
        }, j.ip_configuration_public_ip)
      ]
  ]])
  load_balancer = flatten([
    for k, v in var.network_interface_variables : [
      for i, j in v.network_interface_ip_config : [
        merge({
          main_key = k, nested_key = i
        }, j.ip_configuration_load_balancer)
      ]
  ]])
}

data "azurerm_subnet" "subnet" {
  for_each             = { for v in local.subnet : "${v.main_key},${v.nested_key}" => v if v.subnet_name != null }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_resource_group_name
}

data "azurerm_public_ip" "public_ip" {
  for_each            = { for v in local.public_ip : "${v.main_key},${v.nested_key}" => v if v.public_ip_name != null }
  name                = each.value.public_ip_name
  resource_group_name = each.value.public_ip_resource_group_name
}

data "azurerm_lb" "load_balancer" {
  for_each            = { for v in local.load_balancer : "${v.main_key},${v.nested_key}" => v if v.load_balancer_name != null }
  name                = each.value.load_balancer_name
  resource_group_name = each.value.load_balancer_resource_group_name
}

# Network Interface
resource "azurerm_network_interface" "network_interface" {
  for_each                      = var.network_interface_variables
  name                          = each.value.network_interface_name
  location                      = each.value.network_interface_location
  resource_group_name           = each.value.network_interface_resource_group_name
  dns_servers                   = each.value.network_interface_dns_servers
  edge_zone                     = each.value.network_interface_edge_zone
  enable_ip_forwarding          = each.value.network_interface_enable_ip_forwarding
  enable_accelerated_networking = each.value.network_interface_enable_accelerated_networking
  internal_dns_name_label       = each.value.network_interface_internal_dns_label
  dynamic "ip_configuration" {
    for_each = each.value.network_interface_ip_config
    content {
      name                                               = ip_configuration.value.ip_configuration_name
      private_ip_address_allocation                      = ip_configuration.value.ip_configuration_private_ip_address_allocation
      private_ip_address                                 = ip_configuration.value.ip_configuration_private_ip_address
      private_ip_address_version                         = ip_configuration.value.ip_configuration_private_ip_address_version
      subnet_id                                          = ip_configuration.value.ip_configuration_subnet.subnet_name != null ? data.azurerm_subnet.subnet["${each.key},${ip_configuration.key}"].id : null
      public_ip_address_id                               = ip_configuration.value.ip_configuration_public_ip.public_ip_name != null ? data.azurerm_public_ip.public_ip["${each.key},${ip_configuration.key}"].id : null
      primary                                            = ip_configuration.value.ip_configuration_primary
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.ip_configuration_load_balancer.load_balancer_name != null ? data.azurerm_lb.load_balancer["${each.key},${ip_configuration.key}"].frontend_ip_configuration[0].id : null
    }
  }
  tags = merge(each.value.network_interface_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}