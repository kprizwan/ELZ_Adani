#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "eastus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#TRAFFIC MANAGER PROFILE
traffic_manager_profile_variables = {
  "traffic_manager_profile_1" = {
    traffic_manager_profile_dns_config_ttl = 2
    traffic_manager_profile_max_return     = 2 # Possible values range from 1 to 8
    traffic_manager_profile_monitor_config = {
      monitor_config_protocol                     = "HTTPS" # Possible values are HTTP, HTTPS, TCP
      monitor_config_port                         = 443
      monitor_config_path                         = "/"
      monitor_config_interval_in_seconds          = 30
      monitor_config_timeout_in_seconds           = 10
      monitor_config_tolerated_number_of_failures = 3 # Possible values are between 0 and 9
      monitor_config_expected_status_code_ranges  = ["100-200", "300-400"]
      monitor_config_custom_header = [
        {
          monitor_config_custom_header_name  = "host"
          monitor_config_custom_header_value = "www.contoso.com"
        }
      ]
    }
    traffic_manager_profile_name                = "ploceustraf000001"
    traffic_manager_profile_relative_name       = "ploceustrafdns000001"
    traffic_manager_profile_status              = "Enabled"
    traffic_manager_profile_resource_group_name = "ploceusrg000001"
    traffic_manager_profile_tags = {
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
    traffic_manager_profile_traffic_routing_method = "Performance" # Possible values are Geographic, MultiValue, Performance, Priority, Subnet, Weighted
    traffic_manager_profile_traffic_view_enabled   = true
  }
}
