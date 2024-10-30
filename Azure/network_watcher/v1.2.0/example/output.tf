#NETWORK WATCHER OUTPUT
output "network_watcher_output" {
  value       = module.network_watcher.network_watcher_output
  description = "Network Watcher output values."
}