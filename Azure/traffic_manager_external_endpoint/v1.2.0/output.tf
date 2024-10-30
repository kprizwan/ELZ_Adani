output "traffic_manager_external_endpoint_output" {
  value       = { for k, v in azurerm_traffic_manager_external_endpoint.traffic_manager_external_endpoint : k => { id = v.id } }
  description = "Traffic manager external endpoint output values"
}
