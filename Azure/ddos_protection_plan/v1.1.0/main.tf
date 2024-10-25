#DDOS protection plan
resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  for_each            = var.ddos_protection_plan_variables
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}
