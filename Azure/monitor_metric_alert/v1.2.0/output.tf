#MONITOR METRIC ALERTS OUTPUT
output "monitor_metric_alerts_output" {
  description = "Monitor Metric Alerts output"
  value = { for k, v in azurerm_monitor_metric_alert.monitor_metric_alerts : k => {
    id = v.id
    }
  }
}