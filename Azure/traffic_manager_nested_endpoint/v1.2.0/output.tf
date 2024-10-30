output "traffic_manager_nested_endpoint_output" {
  value       = { for k, v in azurerm_traffic_manager_nested_endpoint.traffic_manager_nested_endpoint : k => { id = v.id } }
  description = "Traffic manager nested endpoint output values"
}

