#Public IP output
output "public_ip_outputs" {
  value       = module.public_ip.public_ip_output
  description = "Public IP Output values"
}
