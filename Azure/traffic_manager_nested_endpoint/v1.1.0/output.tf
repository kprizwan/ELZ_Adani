output "traffic_nested_endpoint_ids" {
  value       = { for k, v in var.traffic_manager_nested_endpoint_variables : k => azurerm_traffic_manager_nested_endpoint.traffic_manager_nested_endpoint[k].id }
  description = "Traffic manager nested endpoint ids"
}

