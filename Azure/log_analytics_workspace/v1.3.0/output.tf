#LOG ANALYTICS WORKSPACE OUTPUT
output "log_analytics_workspace_output" {
  description = "Output and workspace output of log analytics workspace"
  value = { for k, v in azurerm_log_analytics_workspace.log_analytics_workspace : k => {
    id           = v.id           # The Log Analytics Workspace ID
    workspace_id = v.workspace_id # The Workspace (or Customer) ID for the Log Analytics Workspace
    }
  }
}
