#APPLICATION INSIGHTS OUTPUT
output "application_insights_output" {
  value       = module.application_insights.application_insights_output
  description = "Output of application insights"
}