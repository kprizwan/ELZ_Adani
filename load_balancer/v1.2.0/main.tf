locals {
  subnet_resource_ids = flatten([
    for k, v in var.load_balancers_variables : [
      for i, j in lookup(v, "load_balancer_frontend_ip_configuration", {}) :

      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j.frontend_ip_configuration_subnet)
  ]])
  public_ip_ids = flatten([
    for k, v in var.load_balancers_variables : [
      for i, j in lookup(v, "load_balancer_frontend_ip_configuration", {}) :
      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j.frontend_ip_configuration_public_ip_address_id)
  ]])
  public_ip_prefix_ids = flatten([
    for k, v in var.load_balancers_variables : [
      for i, j in lookup(v, "load_balancer_frontend_ip_configuration", {}) :
      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j.frontend_ip_configuration_public_ip_prefix_id)
  ]])

  gateway_load_balancer_ids = flatten([
    for k, v in var.load_balancers_variables : [
      for i, j in lookup(v, "load_balancer_frontend_ip_configuration", {}) :
      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j.frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id)
  ]])
}


data "azurerm_public_ip" "public_ip_ids" {
  for_each            = { for i in local.public_ip_ids : "${i.terraform_main_key},${i.terraform_nested_key}" => i if i.public_ip_name != null }
  name                = each.value.public_ip_name
  resource_group_name = each.value.public_ip_resource_group_name
}

data "azurerm_public_ip_prefix" "public_ip_prefix_ids" {
  for_each            = { for i in local.public_ip_prefix_ids : "${i.terraform_main_key},${i.terraform_nested_key}" => i if i.public_ip_prefix_name != null }
  name                = each.value.public_ip_prefix_name
  resource_group_name = each.value.public_ip_prefix_resource_group_name
}


data "azurerm_subnet" "subnet_ids" {
  for_each             = { for i in local.subnet_resource_ids : "${i.terraform_main_key},${i.terraform_nested_key}" => i if i.subnet_name != null }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.subnet_virtual_network_name
  resource_group_name  = each.value.virtual_network_resource_group
}


data "azurerm_lb" "gateway_load_balancer_ids" {
  for_each            = { for i in local.gateway_load_balancer_ids : "${i.terraform_main_key},${i.terraform_nested_key}" => i if i.gateway_load_balancer_name != null }
  name                = each.value.gateway_load_balancer_name
  resource_group_name = each.value.gateway_load_balancer_resource_group_name
}

data "azurerm_client_config" "current" {
}

resource "azurerm_lb" "load_balancers" {
  for_each            = var.load_balancers_variables
  name                = each.value.load_balancer_name
  resource_group_name = each.value.load_balancer_resource_group_name
  location            = each.value.load_balancer_location
  edge_zone           = each.value.load_balancer_edge_zone
  sku                 = each.value.load_balancer_sku
  sku_tier            = each.value.load_balancer_sku_tier

  dynamic "frontend_ip_configuration" {
    for_each = each.value.load_balancer_frontend_ip_configuration
    content {
      name                                               = frontend_ip_configuration.value.frontend_ip_configuration_name
      zones                                              = frontend_ip_configuration.value.frontend_ip_configuration_zones
      subnet_id                                          = frontend_ip_configuration.value.frontend_ip_configuration_subnet.subnet_name != null ? data.azurerm_subnet.subnet_ids["${each.key},${frontend_ip_configuration.key}"].id : null
      gateway_load_balancer_frontend_ip_configuration_id = frontend_ip_configuration.value.frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id.gateway_load_balancer_name != null ? data.azurerm_lb.gateway_load_balancer_ids["${each.key},${frontend_ip_configuration.key}"].id : null
      private_ip_address                                 = frontend_ip_configuration.value.frontend_ip_configuration_private_ip_address
      private_ip_address_allocation                      = frontend_ip_configuration.value.frontend_ip_configuration_private_ip_address_allocation
      private_ip_address_version                         = frontend_ip_configuration.value.frontend_ip_configuration_private_ip_address_version
      public_ip_address_id                               = frontend_ip_configuration.value.frontend_ip_configuration_public_ip_address_id.public_ip_name != null ? data.azurerm_public_ip.public_ip_ids["${each.key},${frontend_ip_configuration.key}"].id : null
      public_ip_prefix_id                                = frontend_ip_configuration.value.frontend_ip_configuration_public_ip_prefix_id.public_ip_prefix_name != null ? data.azurerm_public_ip_prefix.public_ip_prefix_ids["${each.key},${frontend_ip_configuration.key}"].id : null
    }
  }
  tags = merge(each.value.load_balancer_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}