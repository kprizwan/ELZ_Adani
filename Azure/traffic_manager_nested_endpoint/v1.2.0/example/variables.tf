#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#TRAFFIC MANAGER PROFILE VARIABLES
variable "traffic_manager_profile_variables" {
  type = map(object({
    traffic_manager_profile_resource_group_name    = string # (Required) The name of the Traffic Manager profile. Changing this forces a new resource to be created.
    traffic_manager_profile_name                   = string # (Required) The name of the resource group in which to create the Traffic Manager profile.
    traffic_manager_profile_traffic_routing_method = string # (Required) Specifies the algorithm used to route traffic. Possible values are Geographic, Weighted, Performance, Priority, Subnet and MultiValue.
    traffic_manager_profile_traffic_view_enabled   = bool   # (Optional) Indicates whether Traffic View is enabled for the Traffic Manager profile.
    traffic_manager_profile_status                 = string # (Optional) The status of the profile, can be set to either Enabled or Disabled. Defaults to Enabled.
    traffic_manager_profile_max_return             = number # (Optional) The amount of endpoints to return for DNS queries to this Profile. Possible values range from 1 to 8.
    traffic_manager_profile_dns_config = object({           # (Required) This block specifies the DNS configuration of the Profile, it supports the fields documented below.
      dns_config_relative_name = string                     # (Required) The relative domain name, this is combined with the domain name used by Traffic Manager to form the FQDN which is exported as documented below. Changing this forces a new resource to be created.
      dns_config_ttl           = number                     # (Required) The TTL value of the Profile used by Local DNS resolvers and clients.
    })
    traffic_manager_profile_monitor_config = object({            # (Required) This block specifies the Endpoint monitoring configuration for the Profile, it supports the fields documented below.
      monitor_config_protocol                     = string       # (Required) The protocol used by the monitoring checks, supported values are HTTP, HTTPS and TCP.
      monitor_config_port                         = number       # (Required) The port number used by the monitoring checks.
      monitor_config_path                         = string       # (Optional) The path used by the monitoring checks. Required when protocol is set to HTTP or HTTPS - cannot be set when protocol is set to TCP.
      monitor_config_expected_status_code_ranges  = list(string) # (Optional) A list of status code ranges in the format of 100-101.
      monitor_config_interval_in_seconds          = number       # (Optional) The interval used to check the endpoint health from a Traffic Manager probing agent. You can specify two values here: 30 (normal probing) and 10 (fast probing). The default value is 30.
      monitor_config_timeout_in_seconds           = number       # (Optional) The amount of time the Traffic Manager probing agent should wait before considering that check a failure when a health check probe is sent to the endpoint. If interval_in_seconds is set to 30, then timeout_in_seconds can be between 5 and 10. The default value is 10. If interval_in_seconds is set to 10, then valid values are between 5 and 9 and timeout_in_seconds is required.
      monitor_config_tolerated_number_of_failures = number       # (Optional) The number of failures a Traffic Manager probing agent tolerates before marking that endpoint as unhealthy. Valid values are between 0 and 9. The default value is 3
      monitor_config_custom_header = list(object({               # (Optional) One or more custom_header blocks as defined below.
        monitor_config_custom_header_name  = string              # (Required) The name of the custom header.
        monitor_config_custom_header_value = string              # (Required) The value of custom header. Applicable for HTTP and HTTPS protocol.
      }))

    })
    traffic_manager_profile_tags = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of Traffic Manager Profile Objects"
  default     = {}
}

# TRAFFIC MANAGER NESTED ENDPOINT
variable "traffic_manager_nested_endpoint_variables" {
  type = map(object({
    traffic_manager_nested_endpoint_name                                  = string       # (Required) The name of the External Endpoint. Changing this forces a new resource to be created.
    traffic_manager_nested_endpoint_minimum_child_endpoints               = string       # (Required) This argument specifies the minimum number of endpoints that must be ‘online’ in the child profile in order for the parent profile to direct traffic to any of the endpoints in that child profile. This value must be larger than 0. If min_child_endpoints is less than either minimum_required_child_endpoints_ipv4 or minimum_required_child_endpoints_ipv6, then it won't have any effect.
    traffic_manager_nested_endpoint_weight                                = string       # (Optional) Specifies how much traffic should be distributed to this endpoint, this must be specified for Profiles using the Weighted traffic routing method. Valid values are between 1 and 1000.
    traffic_manager_nested_endpoint_enabled                               = bool         # (Optional) Is the endpoint enabled? Defaults to true.
    traffic_manager_nested_endpoint_endpoint_location                     = string       # (Optional) Specifies the Azure location of the Endpoint, this must be specified for Profiles using the Performance routing method.
    traffic_manager_nested_endpoint_minimum_required_child_endpoints_ipv4 = string       # (Optional) This argument specifies the minimum number of IPv4 (DNS record type A) endpoints that must be ‘online’ in the child profile in order for the parent profile to direct traffic to any of the endpoints in that child profile. This argument only applies to Endpoints of type nestedEndpoints and defaults to 1.
    traffic_manager_nested_endpoint_minimum_required_child_endpoints_ipv6 = string       # (Optional) This argument specifies the minimum number of IPv6 (DNS record type AAAA) endpoints that must be ‘online’ in the child profile in order for the parent profile to direct traffic to any of the endpoints in that child profile. This argument only applies to Endpoints of type nestedEndpoints and defaults to 1.
    traffic_manager_nested_endpoint_priority                              = string       # (Optional) Specifies the priority of this Endpoint, this must be specified for Profiles using the Priority traffic routing method. Supports values between 1 and 1000, with no Endpoints sharing the same value. If omitted the value will be computed in order of creation.
    traffic_manager_nested_endpoint_geo_mappings                          = list(string) # (Optional) A list of Geographic Regions used to distribute traffic, such as WORLD, UK or DE. The same location can't be specified in two endpoints.
    traffic_manager_nested_endpoint_custom_header = list(object({                        # (Optional) One or more custom_header blocks as defined below.
      custom_header_name  = string                                                       # (Required) The name of the custom header.
      custom_header_value = string                                                       # (Required) The value of custom header. Applicable for HTTP and HTTPS protocol.
    }))
    traffic_manager_nested_endpoint_subnet = list(object({ # (Optional) One or more subnet blocks as defined below
      subnet_first = string                                # (Required) The first IP Address in this subnet.
      subnet_last  = string                                # (Optional) The last IP Address in this subnet.
      subnet_scope = string                                # (Optional) The block size (number of leading bits in the subnet mask).
    }))
    traffic_manager_nested_endpoint_traffic_manager_profile_name                       = string # (Required) Name of the Traffic manager profile
    traffic_manager_nested_endpoint_traffic_manager_profile_resource_group_name        = string # (Required) Resource Group Name Name of the Traffic manager profile
    traffic_manager_nested_endpoint_traffic_manager_nested_profile_name                = string # (Required) Name of the Nested Traffic manager profile
    traffic_manager_nested_endpoint_traffic_manager_nested_profile_resource_group_name = string # (Required) Resource Group Name of the Nested Traffic manager profile
  }))
  description = "Map of Traffic Manager Nested Endpoint Objects"
  default     = {}
}
