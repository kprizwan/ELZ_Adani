#VIRTUAL NETWORK PEERING SOURCE DESTINATION OUTPUT
output "virtual_network_peering_source_destination_output" {
  value       = module.source_virtual_network_peering.virtual_network_peering_output
  description = "Virtual Network Peering Source Destination Output Values"
}

#VIRTUAL NETWORK PEERING DESTINATION SOURCE OUTPUT
output "virtual_network_peering_destination_source_output" {
  value       = module.destination_virtual_network_peering.virtual_network_peering_output
  description = "Virtual Network Peering Destination Source Output Values"
}