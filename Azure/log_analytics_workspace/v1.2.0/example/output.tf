output "log_analytics_workspace_output" {
  value       = module.log_analytics_workspace.log_analytics_workspace_output
  description = "Id and workspace id of log analytics workspace"
}