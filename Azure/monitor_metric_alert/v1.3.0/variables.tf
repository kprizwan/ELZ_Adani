#MONITOR METRIC ALERT VARIABLES
variable "monitor_metric_alert_variables" {
  type = map(object({
    monitor_metric_alert_name                = string #(Required) The name of the Metric Alert. Changing this forces a new resource to be created.
    monitor_metric_alert_resource_group_name = string #(Required) The name of the resource group in which to create the Metric Alert instance.
    monitor_metric_alert_scopes = map(object({        #(Required) A set of strings of resource IDs at which the metric criteria should be applied.
      scopes_name                = string             #(Required) Scope name
      scopes_resource_group_name = string             #(Required) Scope resource group name
      }
    ))
    monitor_metric_alert_enabled                  = bool        #(Optional) Should this Metric Alert be enabled? Defaults to true
    monitor_metric_alert_auto_mitigate            = bool        #(Optional) Should the alerts in this Metric Alert be auto resolved? Defaults to true.
    monitor_metric_alert_description              = string      #(Optional) The description of this Metric Alert.
    monitor_metric_alert_frequency                = string      #(Optional) The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M.
    monitor_metric_alert_severity                 = number      #(Optional) The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.
    monitor_metric_alert_target_resource_type     = string      #(Optional) The resource type (e.g. Microsoft.Compute/virtualMachines) of the target resource.
    monitor_metric_alert_target_resource_location = string      #(Optional) The location of the target resource.
    monitor_metric_alert_window_size              = string      #(Optional) The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M.
    monitor_metric_alert_tags                     = map(string) #(Optional) A mapping of tags to assign to the resource.
    monitor_action_group_resource_group_name      = string
    monitor_action_group_name                     = string
    monitor_metric_alert_action = list(object({
      action_webhook_properties = map(string) #(Optional) The map of custom string properties to include with the post operation. These data are appended to the webhook payload.
    }))
    monitor_metric_alert_criteria = map(object({
      criteria_metric_namespace = string  #(Required) One of the metric namespaces to be monitored.
      criteria_metric_name      = string  #(Required) One of the metric names to be monitored.
      criteria_aggregation      = string  #(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
      criteria_operator         = string  # (Required) The criteria operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual.
      criteria_threshold        = number  #(Required) The criteria threshold value that activates the alert.
      criteria_dimension = map(object({   #(Optional) One or more dimension blocks as defined below.
        dimension_name     = string       #(Required) One of the dimension names.
        dimension_operator = string       #(Required) The dimension operator. Possible values are Include, Exclude and StartsWith.
        dimension_values   = list(string) #(Required) The list of dimension values.
      }))
      criteria_skip_metric_validation = bool #(Optional) Skip the metric validation to allow creating an alert rule on a custom metric that isn't yet emitted? Defaults to false.
    }))
    monitor_metric_alert_dynamic_criteria = object({ #(Optional) A dynamic_criteria block as defined below.
      dynamic_criteria_metric_namespace  = string    # (Required) One of the metric namespaces to be monitored.
      dynamic_criteria_metric_name       = string    #(Required) One of the metric names to be monitored.
      dynamic_criteria_aggregation       = string    #(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
      dynamic_criteria_operator          = string    #(Required) The criteria operator. Possible values are LessThan, GreaterThan and GreaterOrLessThan.
      dynamic_criteria_alert_sensitivity = string    #(Required) The extent of deviation required to trigger an alert. Possible values are Low, Medium and High.
      dynamic_criteria_dimension = map(object({      # (Optional) One or more dimension blocks as defined below.
        dimension_name     = string                  #(Required) One of the dimension names.
        dimension_operator = string                  #(Required) The dimension operator. Possible values are Include, Exclude and StartsWith.
        dimension_values   = list(string)            #(Required) The list of dimension values.
      }))
      dynamic_criteria_valuation_total_count    = number #(Optional) The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (window_size) and the selected number of aggregated points.
      dynamic_criteria_evaluation_failure_count = number #(Optional) The number of violations to trigger an alert. Should be smaller or equal to evaluation_total_count.
      dynamic_criteria_ignore_data_before       = string #(Optional) The ISO8601 date from which to start learning the metric historical data and calculate the dynamic thresholds.
      dynamic_criteria_skip_metric_validation   = bool   #(Optional) Skip the metric validation to allow creating an alert rule on a custom metric that isn't yet emitted? Defaults to false.
    })
    monitor_metric_alert_application_insights_web_test_location_availability_criteria = object({  #(Optional) A application_insights_web_test_location_availability_criteria block as defined below.
      application_insights_web_test_location_availability_criteria_web_test_id           = string # (Required) The ID of the Application Insights Web Test.
      application_insights_web_test_location_availability_criteria_component_id          = string #(Required) The ID of the Application Insights Resource.
      application_insights_web_test_location_availability_criteria_failed_location_count = string # (Required) The number of failed locations.
    })
  }))
  default     = {}
  description = "Map of Metric Alert Variables"
}
