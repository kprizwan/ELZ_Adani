output "traffic_manager_azure_endpoint_ids" {
  value       = { for k, v in var.traffic_manager_azure_endpoint_variables : k => azurerm_traffic_manager_azure_endpoint.traffic_manager_azure_endpoint[k].id }
  description = "Traffic manager azure endpoint ids"
}
