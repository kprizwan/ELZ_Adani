#TRAFFIC MANAGER AZURE ENDPOINT OUTPUT
output "traffic_manager_azure_endpoint_output" {
  value       = { for k, v in azurerm_traffic_manager_azure_endpoint.traffic_manager_azure_endpoint : k => { id = v.id } }
  description = "Traffic manager azure endpoint output values"
}