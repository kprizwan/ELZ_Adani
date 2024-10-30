#Variable Definition for Metric Alerts
variable "monitor_metric_alert_variables" {
  type = map(object({
    metric_alert_name                = string
    metric_alert_resource_group_name = string
    scopes = map(object({
      scope_name                = string
      scope_resource_group_name = string
      }
    ))
    enabled                  = bool
    auto_mitigate            = bool
    description              = string
    frequency                = string
    severity                 = number
    target_resource_type     = string
    target_resource_location = string
    window_size              = string
    tags                     = map(string)
    action = map(object({
      action_group = object({
        action_group_name                = string
        action_group_resource_group_name = string
        action_group_subscription_id     = string
      })
      webhook_properties = map(string)
    }))
    criteria = map(object({
      metric_namespace = string
      metric_name      = string
      aggregation      = string
      operator         = string
      threshold        = string
      dimension = map(object({
        dimension_name     = string
        dimension_operator = string
        dimension_values   = list(string)
      }))
      skip_metric_validation = bool
    }))
    dynamic_criteria = object({
      metric_namespace  = string
      metric_name       = string
      aggregation       = string
      operator          = string
      alert_sensitivity = string
      dimension = map(object({
        dimension_name     = string
        dimension_operator = string
        dimension_values   = list(string)
      }))
      evaluation_total_count   = number
      evaluation_failure_count = number
      ignore_data_before       = string
      skip_metric_validation   = bool
    })
    application_insights_web_test_location_availability_criteria = object({
      web_test_id           = string
      component_id          = string
      failed_location_count = string
    })
  }))
  default     = {}
  description = "alert plans"
}