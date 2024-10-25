# APP SERVICE PLAN OUTPUT
output "app_service_plan_id" {
  description = "The ID of the Service Plan"
  value       = module.app_service_plan.app_service_plan_id
}