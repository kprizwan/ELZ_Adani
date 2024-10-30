# APP SERVICE PLAN OUTPUT
output "app_service_plan_id" {
  description = "The ID of the Service Plan"
  value       = { for k, v in azurerm_service_plan.app_service_plan : k => v.id }
}