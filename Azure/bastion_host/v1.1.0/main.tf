
data "azurerm_virtual_network" "virtual_network" {
  for_each            = var.azure_bastion_host_variables
  name                = each.value.bastion_host_virtual_network_name
  resource_group_name = each.value.bastion_host_virtual_network_resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each             = var.azure_bastion_host_variables
  name                 = each.value.bastion_host_subnet_name
  virtual_network_name = each.value.bastion_host_virtual_network_name
  resource_group_name  = each.value.bastion_host_subnet_resource_group_name
}

data "azurerm_public_ip" "public_ip" {
  for_each            = var.azure_bastion_host_variables
  name                = each.value.bastion_host_public_ip_name
  resource_group_name = each.value.bastion_host_public_ip_resource_group_name
}

resource "azurerm_bastion_host" "bastion_host" {
  for_each               = var.azure_bastion_host_variables
  name                   = each.value.bastion_host_name
  location               = each.value.bastion_host_location
  resource_group_name    = each.value.bastion_host_resource_group_name
  copy_paste_enabled     = each.value.bastion_host_copy_paste_enabled
  file_copy_enabled      = each.value.bastion_host_sku == "standard" ? each.value.bastion_host_file_copy_enabled : false
  sku                    = each.value.bastion_host_sku
  ip_connect_enabled     = each.value.bastion_host_sku == "standard" ? each.value.bastion_host_ip_connect_enabled : false
  scale_units            = each.value.bastion_host_scale_units
  shareable_link_enabled = each.value.bastion_host_sku == "standard" ? each.value.bastion_host_shareable_link_enabled : false
  tunneling_enabled      = each.value.bastion_host_sku == "standard" ? each.value.bastion_host_tunneling_enabled : false

  dynamic "ip_configuration" {
    for_each = each.value.bastion_host_ip_configuration
    content {
      name                 = each.value.bastion_host_ip_configuration.ip_configuration_name
      subnet_id            = data.azurerm_subnet.subnet[each.key].id
      public_ip_address_id = data.azurerm_public_ip.public_ip[each.key].id
    }
  }

  tags = merge(each.value.bastion_host_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}