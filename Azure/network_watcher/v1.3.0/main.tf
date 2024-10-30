#NETWORK WATCHER
resource "azurerm_network_watcher" "network_watcher" {
  for_each            = var.network_watcher_variables
  name                = each.value.network_watcher_name
  location            = each.value.network_watcher_location
  resource_group_name = each.value.network_watcher_resource_group_name
  tags                = merge(each.value.network_watcher_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}