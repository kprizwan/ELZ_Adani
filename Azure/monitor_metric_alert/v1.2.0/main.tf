locals {
  resources_tomonitor = flatten([
    for k, v in var.monitor_metric_alert_variables : [
      for i, j in v.monitor_metric_alert_scopes :
      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j)
  ]])
}

data "azurerm_resources" "scopes" {
  for_each            = { for i in local.resources_tomonitor : "${i.terraform_main_key},${i.terraform_nested_key}" => i }
  provider            = azurerm.resource_tomonitor_sub
  name                = each.value.scopes_name
  resource_group_name = each.value.scopes_resource_group_name
}

resource "azurerm_monitor_metric_alert" "monitor_metric_alerts" {
  provider                 = azurerm.monitor_metric_alert_sub
  for_each                 = var.monitor_metric_alert_variables
  name                     = each.value.monitor_metric_alert_name
  resource_group_name      = each.value.monitor_metric_alert_resource_group_name
  scopes                   = [for k, v in each.value.monitor_metric_alert_scopes : data.azurerm_resources.scopes["${each.key},${k}"].resources[0].id]
  enabled                  = each.value.monitor_metric_alert_enabled
  auto_mitigate            = each.value.monitor_metric_alert_auto_mitigate
  description              = each.value.monitor_metric_alert_description
  frequency                = each.value.monitor_metric_alert_frequency
  severity                 = each.value.monitor_metric_alert_severity
  target_resource_type     = each.value.monitor_metric_alert_target_resource_type
  target_resource_location = each.value.monitor_metric_alert_target_resource_location
  window_size              = each.value.monitor_metric_alert_window_size
  dynamic "action" {
    for_each = each.value.monitor_metric_alert_action == null ? {} : each.value.monitor_metric_alert_action
    content {
      action_group_id    = "/subscriptions/${action.value.action_group.action_group_subscription_id}/resourceGroups/${action.value.action_group.action_group_resource_group_name}/providers/Microsoft.Insights/actionGroups/${action.value.action_group.action_group_name}" #data.azurerm_monitor_action_group.action_groups["${each.key},${action.key}"].id
      webhook_properties = action.value.action_webhook_properties
    }
  }
  dynamic "criteria" {
    for_each = each.value.monitor_metric_alert_criteria == null ? {} : each.value.monitor_metric_alert_criteria
    content {
      metric_namespace       = criteria.value.criteria_metric_namespace
      metric_name            = criteria.value.criteria_metric_name
      aggregation            = criteria.value.criteria_aggregation
      operator               = criteria.value.criteria_operator
      threshold              = criteria.value.criteria_threshold
      skip_metric_validation = criteria.value.criteria_skip_metric_validation
      dynamic "dimension" {
        for_each = criteria.value.criteria_dimension == null ? {} : criteria.value.criteria_dimension
        content {
          name     = dimension.value.dimension_name
          operator = dimension.value.dimension_operator
          values   = dimension.value.dimension_values
        }
      }
    }
  }
  dynamic "dynamic_criteria" {
    for_each = toset(each.value.monitor_metric_alert_dynamic_criteria == null ? [] : [1])
    content {
      metric_namespace         = each.value.dynamic_criteria.dynamic_criteria_metric_namespace
      metric_name              = each.value.dynamic_criteria.dynamic_criteria_metric_name
      aggregation              = each.value.dynamic_criteria.dynamic_criteria_aggregation
      operator                 = each.value.dynamic_criteria.dynamic_criteria_operator
      alert_sensitivity        = each.value.dynamic_criteria.dynamic_criteria_alert_sensitivity
      evaluation_total_count   = each.value.dynamic_criteria.dynamic_criteria_valuation_total_count
      evaluation_failure_count = each.value.dynamic_criteria.dynamic_criteria_evaluation_failure_count
      ignore_data_before       = each.value.dynamic_criteria.dynamic_criteria_ignore_data_before
      skip_metric_validation   = each.value.dynamic_criteria.dynamic_criteria_skip_metric_validation
      dynamic "dimension" {
        for_each = each.value.dynamic_criteria.dynamic_criteria_dimension
        content {
          name     = dimension.value.dimension_name
          operator = dimension.value.dimension_operator
          values   = dimension.value.dimension_values
        }
      }
    }
  }
  dynamic "application_insights_web_test_location_availability_criteria" {
    for_each = toset(each.value.monitor_metric_alert_application_insights_web_test_location_availability_criteria == null ? [] : [1])
    content {
      web_test_id           = each.value.application_insights_web_test_location_availability_criteria.application_insights_web_test_location_availability_criteria_web_test_id
      component_id          = each.value.application_insights_web_test_location_availability_criteria.application_insights_web_test_location_availability_criteria_component_id
      failed_location_count = each.value.application_insights_web_test_location_availability_criteria.application_insights_web_test_location_availability_criteria_failed_location_count
    }
  }
  tags = merge(each.value.monitor_metric_alert_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
