#TRAFFIC MANAGER PROFILE VARIABLES
variable "traffic_manager_profile_variables" {
  type = map(object({
    traffic_manager_profile_resource_group_name    = string
    traffic_manager_profile_name                   = string
    traffic_manager_profile_relative_name          = string
    traffic_manager_profile_status                 = string
    traffic_manager_profile_traffic_routing_method = string # Possible values are Geographic, MultiValue, Performance, Priority, Subnet, Weighted
    traffic_manager_profile_traffic_view_enabled   = bool
    traffic_manager_profile_dns_config_ttl         = number
    traffic_manager_profile_max_return             = number # Possible values range from 1 to 8
    traffic_manager_profile_monitor_config = object({
      monitor_config_protocol                    = string # Possible values are HTTP, HTTPS, TCP
      monitor_config_port                        = number
      monitor_config_path                        = string
      monitor_config_expected_status_code_ranges = list(string)
      monitor_config_custom_header = list(object({
        monitor_config_custom_header_name  = string
        monitor_config_custom_header_value = string
      }))
      monitor_config_interval_in_seconds          = number
      monitor_config_timeout_in_seconds           = number
      monitor_config_tolerated_number_of_failures = number # Possible values are between 0 and 9
    })
    traffic_manager_profile_tags = map(string)
  }))
}

#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}
