#PUBLIC IP OUTPUT
output "public_ip_output" {
  value       = module.public_ip.public_ip_output
  description = "Public IP Output values"
}