#MONITOR METRIC ALERTS OUTPUT
output "monitor_metric_alert_output" {
  description = "Monitor Metric Alert output"
  value = { for k, v in azurerm_monitor_metric_alert.monitor_metric_alert : k => {
    id = v.id
    }
  }
}