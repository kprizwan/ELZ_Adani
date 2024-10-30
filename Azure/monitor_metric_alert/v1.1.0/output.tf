output "monitor_metric_alerts_id" {
  value       = { for k, v in azurerm_monitor_metric_alert.monitor_metric_alerts : k => v.id }
  description = "Monitor Metric Alerts ID"
}
