output "application_insights_id" {
  value = { for k, v in azurerm_application_insights.appinsight : k => v.id }
}

output "application_insights_app_id" {
  value = { for k, v in azurerm_application_insights.appinsight : k => v.app_id }
}

output "application_insights_instrumentation_key" {
  value     = { for k, v in azurerm_application_insights.appinsight : k => v.instrumentation_key }
  sensitive = true
}

output "application_insights_connection_string" {
  value     = { for k, v in azurerm_application_insights.appinsight : k => v.connection_string }
  sensitive = true
}
