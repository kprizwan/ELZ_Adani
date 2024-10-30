# APP SERVICE PLAN OUTPUT
output "app_service_plan_output" {
  description = "App Service Plan output values"
  value       = { for k, v in azurerm_service_plan.app_service_plan : k => { id = v.id } }
}