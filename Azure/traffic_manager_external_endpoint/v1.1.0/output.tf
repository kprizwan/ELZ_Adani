output "traffic_external_endpoint_ids" {
  value       = { for k, v in var.traffic_manager_external_endpoint_variables : k => azurerm_traffic_manager_external_endpoint.traffic_manager_external_endpoint[k].id }
  description = "Traffic manager nested endpoint ids"
}