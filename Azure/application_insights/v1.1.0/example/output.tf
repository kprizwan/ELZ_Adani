output "application_insights_id" {
  value = module.application_insights.application_insights_id
}

output "application_insights_app_id" {
  value = module.application_insights.application_insights_app_id
}

output "application_insights_instrumentation_key" {
  value     = module.application_insights.application_insights_instrumentation_key
  sensitive = true
}

output "application_insights_connection_string" {
  value     = module.application_insights.application_insights_connection_string
  sensitive = true
}
