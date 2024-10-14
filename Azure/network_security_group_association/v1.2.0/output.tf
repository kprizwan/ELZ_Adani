output "network_interface_security_group_association_ids" {
  value       = { for k, v in local.network_interface_security_group_association : k => azurerm_network_interface_security_group_association.network_interface_security_group_association[k].id }
  description = "azurerm_network_interface_security_group_association id's"
}


output "subnet_security_group_association_ids" {
  value       = { for k, v in local.subnet_security_group_association : k => azurerm_subnet_network_security_group_association.subnet_network_security_group_association[k].id }
  description = "azurerm_subnet_network_security_group_association id's"
}