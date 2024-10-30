output "application_insights_id" {
  value = { for k, v in azurerm_application_insights.appinsight : k => v.id }
}