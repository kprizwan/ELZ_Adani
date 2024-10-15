locals {
  ddos_protection_plan_enabled = { for k, v in var.public_ip_variables : k => v if lookup(v, "public_ip_is_ddos_protection_plan_enabled", false) == true }

}
#DDOS Protection Plan
data "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  for_each            = local.ddos_protection_plan_enabled
  name                = each.value.public_ip_ddos_protection_plan_name
  resource_group_name = each.value.public_ip_ddos_protection_plan_resource_group_name
}
#Public IP 
resource "azurerm_public_ip" "public_ip" {
  for_each                = var.public_ip_variables
  name                    = each.value.public_ip_name
  resource_group_name     = each.value.public_ip_resource_group_name
  location                = each.value.public_ip_location
  allocation_method       = each.value.public_ip_allocation_method
  sku                     = each.value.public_ip_sku
  sku_tier                = each.value.public_ip_sku_tier == null ? "Regional" : each.value.public_ip_sku_tier
  zones                   = each.value.public_ip_sku == "Standard" ? each.value.public_ip_zones : null
  ddos_protection_mode    = each.value.public_ip_ddos_protection_mode
  ddos_protection_plan_id = each.value.public_ip_is_ddos_protection_plan_enabled != false && each.value.public_ip_ddos_protection_mode == "Enabled" ? data.azurerm_network_ddos_protection_plan.ddos_protection_plan[each.key].id : null
  edge_zone               = each.value.public_ip_edge_zone
  domain_name_label       = each.value.public_ip_domain_name_label
  idle_timeout_in_minutes = each.value.public_ip_idle_timeout_in_minutes
  reverse_fqdn            = each.value.public_ip_reverse_fqdn
  public_ip_prefix_id     = each.value.public_ip_prefix_id
  ip_tags                 = each.value.public_ip_ip_tags
  ip_version              = each.value.public_ip_ip_version == null ? "IPv4" : each.value.public_ip_ip_version
  tags                    = merge(each.value.public_ip_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [zones, tags["Created_Time"]] }
}


