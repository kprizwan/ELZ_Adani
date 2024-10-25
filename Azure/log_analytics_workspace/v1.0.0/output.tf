output "loganalytics_workspace_ids" {
  description = "Loganalytics workspace outputs"
  value = [
    for k, v in azurerm_log_analytics_workspace.log_analytics_workspace :
    {
      name         = k
      id           = v.id
      workspace_id = v.workspace_id
    }
  ]
}

output "loganalytics_workspace_keys" {
  description = "Loganalytics workspace outputs"
  sensitive   = true
  value = [
    for k, v in azurerm_log_analytics_workspace.log_analytics_workspace :
    {
      name                 = k
      primary_shared_key   = v.primary_shared_key
      secondary_shared_key = v.secondary_shared_key
    }
  ]
}

