#NETWORK WATCHER OUTPUT
output "network_watcher_output" {
  value = { for k, v in azurerm_network_watcher.network_watcher : k => {
    id = v.id
    }
  }
  description = "Network Watcher output values"
}