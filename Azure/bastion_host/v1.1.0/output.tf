output "bastion_host_ids" {
  value       = { for k, v in azurerm_bastion_host.bastion_host : k => v.id }
  description = "The ID of the Bastion Host."
}

output "bastion_host_fqdns" {
  value       = { for k, v in azurerm_bastion_host.bastion_host : k => v.dns_name }
  description = "The FQDN for bastion host"
}