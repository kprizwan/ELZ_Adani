#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#TRAFFIC MANAGER PROFILE
traffic_manager_profile_variables = {
  "traffic_manager_profile_1" = {
    traffic_manager_profile_name                   = "ploceustmprofile000001" # (Required) The name of the resource group in which to create the Traffic Manager profile.
    traffic_manager_profile_resource_group_name    = "ploceusrg000001"        # (Required) The name of the Traffic Manager profile. Changing this forces a new resource to be created.
    traffic_manager_profile_traffic_routing_method = "Performance"            # (Required) Specifies the algorithm used to route traffic. Possible values are Geographic, Weighted, Performance, Priority, Subnet and MultiValue.
    traffic_manager_profile_traffic_view_enabled   = true                     # (Optional) Indicates whether Traffic View is enabled for the Traffic Manager profile.
    traffic_manager_profile_status                 = "Enabled"                # (Optional) The status of the profile, can be set to either Enabled or Disabled. Defaults to Enabled.
    traffic_manager_profile_max_return             = 2                        # (Optional) The amount of endpoints to return for DNS queries to this Profile. Possible values range from 1 to 8.
    traffic_manager_profile_dns_config = {                                    # (Required) This block specifies the DNS configuration of the Profile, it supports the fields documented below.
      dns_config_relative_name = "ploceustrafdns000001"                       # (Required) The relative domain name, this is combined with the domain name used by Traffic Manager to form the FQDN which is exported as documented below. Changing this forces a new resource to be created.
      dns_config_ttl           = 2                                            # (Required) The TTL value of the Profile used by Local DNS resolvers and clients.
    }
    traffic_manager_profile_monitor_config = {                             # (Required) This block specifies the Endpoint monitoring configuration for the Profile, it supports the fields documented below.
      monitor_config_protocol                     = "HTTPS"                # (Required) The protocol used by the monitoring checks, supported values are HTTP, HTTPS and TCP.
      monitor_config_port                         = 443                    # (Required) The port number used by the monitoring checks.
      monitor_config_path                         = "/"                    # (Optional) The path used by the monitoring checks. Required when protocol is set to HTTP or HTTPS - cannot be set when protocol is set to TCP.
      monitor_config_expected_status_code_ranges  = ["100-200", "300-400"] # (Optional) A list of status code ranges in the format of 100-101.
      monitor_config_interval_in_seconds          = 30                     # (Optional) The interval used to check the endpoint health from a Traffic Manager probing agent. You can specify two values here: 30 (normal probing) and 10 (fast probing). The default value is 30.
      monitor_config_timeout_in_seconds           = 10                     # (Optional) The amount of time the Traffic Manager probing agent should wait before considering that check a failure when a health check probe is sent to the endpoint. If interval_in_seconds is set to 30, then timeout_in_seconds can be between 5 and 10. The default value is 10. If interval_in_seconds is set to 10, then valid values are between 5 and 9 and timeout_in_seconds is required.
      monitor_config_tolerated_number_of_failures = 3                      # (Optional) The number of failures a Traffic Manager probing agent tolerates before marking that endpoint as unhealthy. Valid values are between 0 and 9. The default value is 3
      monitor_config_custom_header = [{                                    # (Optional) One or more custom_header blocks as defined below.
        monitor_config_custom_header_name  = "host"                        # (Required) The name of the custom header.
        monitor_config_custom_header_value = "www.contoso.com"             # (Required) The value of custom header. Applicable for HTTP and HTTPS protocol.
      }]
    }
    traffic_manager_profile_tags = { # (Optional) A mapping of tags to assign to the resource.
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
  }
}