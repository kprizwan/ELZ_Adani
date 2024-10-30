#NETWORK WATCHER OUTPUT
output "network_watcher" {
  value       = azurerm_network_watcher.network_watcher
  description = "Network Watcher outputs"
}
