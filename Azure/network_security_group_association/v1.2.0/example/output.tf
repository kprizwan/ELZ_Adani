output "network_interface_security_group_association_ids" {
  value       = module.network_security_group_association.network_interface_security_group_association_ids
  description = "azurerm_network_interface_security_group_association id's"
}

output "subnet_security_group_association_ids" {
  value       = module.network_security_group_association.subnet_security_group_association_ids
  description = "azurerm_subnet_network_security_group_association id's"
}

