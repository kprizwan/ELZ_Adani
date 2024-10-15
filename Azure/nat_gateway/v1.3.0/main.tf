#NAT GATEWAY
resource "azurerm_nat_gateway" "nat_gateway" {
  for_each                = var.nat_gateway_variables
  name                    = each.value.nat_gateway_name
  location                = each.value.nat_gateway_location
  resource_group_name     = each.value.nat_gateway_resource_group_name
  sku_name                = each.value.nat_gateway_sku_name
  idle_timeout_in_minutes = each.value.nat_gateway_idle_timeout_in_minutes
  zones                   = each.value.nat_gateway_zones
  tags                    = merge(each.value.nat_gateway_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}