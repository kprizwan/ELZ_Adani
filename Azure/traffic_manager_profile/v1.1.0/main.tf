resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {

  for_each               = var.traffic_manager_profile_variables
  name                   = each.value.traffic_manager_profile_name
  resource_group_name    = each.value.traffic_manager_profile_resource_group_name
  traffic_routing_method = each.value.traffic_manager_profile_traffic_routing_method
  profile_status         = each.value.traffic_manager_profile_status
  traffic_view_enabled   = each.value.traffic_manager_profile_traffic_view_enabled

  max_return = each.value.traffic_manager_profile_max_return

  dns_config {
    relative_name = each.value.traffic_manager_profile_relative_name
    ttl           = each.value.traffic_manager_profile_dns_config_ttl
  }

  monitor_config {
    protocol                     = each.value.traffic_manager_profile_monitor_config.monitor_config_protocol
    port                         = each.value.traffic_manager_profile_monitor_config.monitor_config_port
    path                         = each.value.traffic_manager_profile_monitor_config.monitor_config_path
    interval_in_seconds          = each.value.traffic_manager_profile_monitor_config.monitor_config_interval_in_seconds
    timeout_in_seconds           = each.value.traffic_manager_profile_monitor_config.monitor_config_timeout_in_seconds
    tolerated_number_of_failures = each.value.traffic_manager_profile_monitor_config.monitor_config_tolerated_number_of_failures
    expected_status_code_ranges  = each.value.traffic_manager_profile_monitor_config.monitor_config_expected_status_code_ranges

    dynamic "custom_header" {
      for_each = each.value.traffic_manager_profile_monitor_config.monitor_config_custom_header != null ? each.value.traffic_manager_profile_monitor_config.monitor_config_custom_header : []
      content {
        name  = custom_header.value.monitor_config_custom_header_name
        value = custom_header.value.monitor_config_custom_header_value
      }
    }
  }

  tags = merge(each.value.traffic_manager_profile_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
