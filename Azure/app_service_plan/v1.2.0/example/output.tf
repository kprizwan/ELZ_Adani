# APP SERVICE PLAN OUTPUT
output "app_service_plan_output" {
  description = "App Service Plan output values"
  value       = module.app_service_plan.app_service_plan_output
}