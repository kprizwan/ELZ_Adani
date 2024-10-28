output "network_interface_output" {
  value = { for k, v in azurerm_network_interface.network_interface : k => {
    id = v.id
    }
  }
  description = "Network interface output"
}