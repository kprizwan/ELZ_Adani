# azure azurerm_monitor_metric_alert

locals {
  resources_tomonitor = flatten([
    for k, v in var.monitor_metric_alert_variables : [
      for i, j in v.scopes :
      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j)
  ]])
}
data "azurerm_resources" "scopes" {
  for_each            = { for i in local.resources_tomonitor : "${i.terraform_main_key},${i.terraform_nested_key}" => i }
  provider            = azurerm.resource_tomonitor_sub
  name                = each.value.scope_name
  resource_group_name = each.value.scope_resource_group_name
}


resource "azurerm_monitor_metric_alert" "monitor_metric_alerts" {
  provider = azurerm.monitor_metric_alert_sub
  for_each = var.monitor_metric_alert_variables

  name                     = each.value.metric_alert_name
  resource_group_name      = each.value.metric_alert_resource_group_name
  scopes                   = [for k, v in each.value.scopes : data.azurerm_resources.scopes["${each.key},${k}"].resources[0].id] ###########
  enabled                  = each.value.enabled
  auto_mitigate            = each.value.auto_mitigate
  description              = each.value.description
  frequency                = each.value.frequency
  severity                 = each.value.severity
  target_resource_type     = each.value.target_resource_type
  target_resource_location = each.value.target_resource_location
  window_size              = each.value.window_size
  dynamic "action" {
    for_each = each.value.action
    content {
      action_group_id    = "/subscriptions/${action.value.action_group.action_group_subscription_id}/resourceGroups/${action.value.action_group.action_group_resource_group_name}/providers/Microsoft.Insights/actionGroups/${action.value.action_group.action_group_name}" #data.azurerm_monitor_action_group.action_groups["${each.key},${action.key}"].id
      webhook_properties = action.value.webhook_properties
    }
  }

  dynamic "criteria" {
    for_each = each.value.criteria == null ? {} : each.value.criteria
    content {
      metric_namespace       = criteria.value.metric_namespace
      metric_name            = criteria.value.metric_name
      aggregation            = criteria.value.aggregation
      operator               = criteria.value.operator
      threshold              = criteria.value.threshold
      skip_metric_validation = criteria.value.skip_metric_validation
      dynamic "dimension" {
        for_each = criteria.value.dimension
        content {
          name     = dimension.value.dimension_name
          operator = dimension.value.dimension_operator
          values   = dimension.value.dimension_values
        }
      }
    }
  }
  dynamic "dynamic_criteria" {
    for_each = each.value.dynamic_criteria == null ? [] : [1]
    content {
      metric_namespace         = each.value.dynamic_criteria.metric_namespace
      metric_name              = each.value.dynamic_criteria.metric_name
      aggregation              = each.value.dynamic_criteria.aggregation
      operator                 = each.value.dynamic_criteria.operator
      alert_sensitivity        = each.value.dynamic_criteria.alert_sensitivity
      evaluation_total_count   = each.value.dynamic_criteria.evaluation_total_count
      evaluation_failure_count = each.value.dynamic_criteria.evaluation_failure_count
      ignore_data_before       = each.value.dynamic_criteria.ignore_data_before
      skip_metric_validation   = each.value.dynamic_criteria.skip_metric_validation
      dynamic "dimension" {
        for_each = each.value.dynamic_criteria.dimension
        content {
          name     = dimension.value.dimension_name
          operator = dimension.value.dimension_operator
          values   = dimension.value.dimension_values
        }
      }
    }
  }

  dynamic "application_insights_web_test_location_availability_criteria" {
    for_each = each.value.application_insights_web_test_location_availability_criteria == null ? [] : [1]
    content {
      web_test_id           = each.value.application_insights_web_test_location_availability_criteria.web_test_id
      component_id          = each.value.application_insights_web_test_location_availability_criteria.component_id
      failed_location_count = each.value.application_insights_web_test_location_availability_criteria.failed_location_count
    }
  }
  tags = merge(each.value.tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
