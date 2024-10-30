output "loganalytics_workspace_ids" {
  value = module.log_analytics_workspace.loganalytics_workspace_ids
}

output "loganalytics_workspace_keys" {
  value     = module.log_analytics_workspace.loganalytics_workspace_keys
  sensitive = true
}
