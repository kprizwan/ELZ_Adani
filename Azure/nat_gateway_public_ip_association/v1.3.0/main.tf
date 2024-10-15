#PUBLIC IP
data "azurerm_public_ip" "public_ip" {
  for_each            = var.nat_gateway_public_ip_association_variables
  name                = each.value.public_ip_name
  resource_group_name = each.value.public_ip_resource_group_name
}

#NAT GATEWAY
data "azurerm_nat_gateway" "nat_gateway" {
  for_each            = var.nat_gateway_public_ip_association_variables
  name                = each.value.nat_gateway_name
  resource_group_name = each.value.nat_gateway_resource_group_name
}

#NAT GATEWAY PUBLIC IP ASSOCIATION
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  for_each             = var.nat_gateway_public_ip_association_variables
  nat_gateway_id       = data.azurerm_nat_gateway.nat_gateway[each.key].id
  public_ip_address_id = data.azurerm_public_ip.public_ip[each.key].id
}
