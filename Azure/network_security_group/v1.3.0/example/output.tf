# NETWORK SECURITY GROUP OUTPUT
output "network_security_group_output" {
  value       = module.network_security_group.network_security_group_output
  description = "Network Security Group output values."
}