#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#WORKSPACE
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
  },

  "traffic_manager_profile_2" = {
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
    traffic_manager_profile_name                = "ploceustraf000002"
    traffic_manager_profile_relative_name       = "ploceustrafdns000002"
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
traffic_manager_nested_endpoint_variables = {
  "traffic_manager_nested_endpoint1" = {
    traffic_manager_nested_endpoint_name                                  = "ploceusnestedendpoint000001"
    traffic_manager_nested_endpoint_weight                                = "150"
    traffic_manager_nested_endpoint_enabled                               = true
    traffic_manager_nested_endpoint_geo_mappings                          = ["WORLD"]
    traffic_manager_nested_endpoint_priority                              = "100"
    traffic_manager_nested_endpoint_minimum_child_endpoints               = "3"
    traffic_manager_nested_endpoint_endpoint_location                     = "westus2"
    traffic_manager_nested_endpoint_minimum_required_child_endpoints_ipv4 = "1"
    traffic_manager_nested_endpoint_minimum_required_child_endpoints_ipv6 = "2"
    traffic_manager_nested_endpoint_custom_header = [{
      custom_header_name  = "ploeuscustomheader"
      custom_header_value = "ploceus.com"
    }]
    traffic_manager_nested_endpoint_subnet = [{
      subnet_first = "10.0.0.0"
      subnet_last  = "10.0.0.255"
      subnet_scope = "24"
    }]
    traffic_manager_nested_endpoint_traffic_manager_profile_profile_name               = "ploceustraf000001"
    traffic_manager_nested_endpoint_traffic_manager_profile_resource_group_name        = "ploceusrg000001"
    traffic_manager_nested_endpoint_traffic_manager_nested_profile_name                = "ploceustraf000002"
    traffic_manager_nested_endpoint_traffic_manager_nested_profile_resource_group_name = "ploceusrg000001"
  }
}


