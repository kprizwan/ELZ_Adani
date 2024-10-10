#PRIVATE ENDPOINT OUTPUTS
output "private_endpoint_output" {
  value       = module.private_endpoint.private_endpoint_output
  description = "Private Endpoint Output values"
}