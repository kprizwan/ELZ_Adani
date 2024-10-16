#VIRTUAL NETWORK PEERING SOURCE DESTINATION OUTPUT
output "virtual_network_peering_output" {
  value = { for k, v in azurerm_virtual_network_peering.virtual_network_peering : k => {
    id = v.id
    }
  }
  description = "Virtual Network Peering Source Destination Output Values"
}