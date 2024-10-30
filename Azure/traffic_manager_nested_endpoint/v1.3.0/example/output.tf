#TRAFFIC MANAGER NESTED ENDPOINT OUTPUT
output "traffic_manager_nested_endpoint_output" {
  value       = module.traffic_manager_nested_endpoint.traffic_manager_nested_endpoint_output
  description = "Traffic manager nested endpoint output values"
}