#APPLICATION GATEWAY OUTPUT
output "application_gateway_output" {
  description = "Application gateway Output"
  value       = module.application_gateway.application_gateway_output
}
