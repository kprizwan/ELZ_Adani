resource "azurerm_network_watcher" "network_watcher" {
  for_each            = var.network_watcher_variables
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = merge(each.value.network_watcher_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
}