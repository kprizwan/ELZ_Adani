locals {
  is_ddos_needed = { for k, v in var.virtual_network_variables : k => v if lookup(v.virtual_network_ddos_protection_plan, "virtual_network_ddos_protection_enable", false) != false }

  subnet_map = flatten([
    for k, v in var.virtual_network_variables : [
      for i, j in v.virtual_network_subnet :
      merge(
        {
          main_key = k, network_security_group_name = j.virtual_network_subnet_network_security_group_name, resource_group_name = j.virtual_network_subnet_network_security_group_resource_group_name
        },
        j
      ) if j.virtual_network_subnet_network_security_group_name != null
    ] if v.virtual_network_subnet != null
  ])
}

# Fetch the data from ddos protection module when is_ddos_protection_enabled is set to true
data "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  for_each            = local.is_ddos_needed
  name                = each.value.virtual_network_ddos_protection_plan.virtual_network_ddos_protection_plan_name
  resource_group_name = each.value.virtual_network_resource_group_name
}

# Fetch the data from network_security_group module when needed
data "azurerm_network_security_group" "network_security_group" {
  for_each            = { for i in local.subnet_map : "${i.main_key}:${i.network_security_group_name}" => i }
  name                = each.value.network_security_group_name
  resource_group_name = each.value.resource_group_name
}

##VIRTUAL NETWORK
resource "azurerm_virtual_network" "virtual_network" {
  for_each                = var.virtual_network_variables
  name                    = each.value.virtual_network_name
  location                = each.value.virtual_network_location
  resource_group_name     = each.value.virtual_network_resource_group_name
  address_space           = each.value.virtual_network_address_space
  dns_servers             = each.value.virtual_network_dns_servers
  edge_zone               = each.value.virtual_network_edge_zone
  flow_timeout_in_minutes = each.value.virtual_network_flow_timeout_in_minutes
  bgp_community           = each.value.virtual_network_bgp_community
  dynamic "ddos_protection_plan" {
    for_each = each.value.virtual_network_ddos_protection_plan.virtual_network_ddos_protection_enable == true ? [1] : []
    content {
      id     = data.azurerm_network_ddos_protection_plan.ddos_protection_plan[each.key].id
      enable = each.value.virtual_network_ddos_protection_plan.virtual_network_ddos_protection_enable
    }
  }
  dynamic "encryption" {
    for_each = each.value.virtual_network_encryption != null ? toset(each.value.virtual_network_encryption) : []
    content {
      enforcement = encryption.value.virtual_network_encryption_enforcement
    }
  }
  dynamic "subnet" {
    for_each = each.value.virtual_network_subnet != null ? toset(each.value.virtual_network_subnet) : []
    content {
      name           = subnet.value.virtual_network_subnet_name
      address_prefix = subnet.value.virtual_network_subnet_address_prefix
      security_group = subnet.value.virtual_network_subnet_network_security_group_name != null ? data.azurerm_network_security_group.network_security_group["${each.key}:${subnet.value.virtual_network_subnet_network_security_group_name}"].id : null
    }
  }
  tags = merge(each.value.virtual_network_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}