output "application_insights_output" {
  description = "Output of application insights"
  value = { for k, v in azurerm_application_insights.application_insights : k => {
    id     = v.id     # The ID of the Application Insights component
    app_id = v.app_id # The App ID associated with this Application Insights component
    }
  }
}
