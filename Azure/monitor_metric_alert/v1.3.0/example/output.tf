#MONITOR METRIC ALERTS OUTPUT
output "monitor_metric_alert_output" {
  value       = module.monitor_metric_alert.monitor_metric_alert_output
  description = "Monitor Metric alert output values"
}
