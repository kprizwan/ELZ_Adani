output "bastion_host_ids" {
  value       = module.azure_bastion_host.bastion_host_ids
  description = "The bastion host ID"
}

output "bastion_host_fqdns" {
  value       = module.azure_bastion_host.bastion_host_fqdns
  description = "The FQDN of bastion host"
}