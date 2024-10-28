#MONITOR METRIC ALERTS OUTPUT
output "monitor_metric_alerts_output" {
  value       = module.metric_alerts.monitor_metric_alerts_output
  description = "Monitor Metric Alerts output"
}
