#TRAFFIC MANAGER EXTERNAL ENDPOINT VARIABLES
variable "traffic_manager_external_endpoint_variables" {
  type = map(object({
    traffic_manager_external_endpoint_name              = string       # (Required) The name of the External Endpoint. Changing this forces a new resource to be created.
    traffic_manager_external_endpoint_target            = string       # (Required) The FQDN DNS name of the target.
    traffic_manager_external_endpoint_weight            = string       # (Optional) Specifies how much traffic should be distributed to this endpoint, this must be specified for Profiles using the Weighted traffic routing method. Valid values are between 1 and 1000.
    traffic_manager_external_endpoint_enabled           = bool         # (Optional) Is the endpoint enabled? Defaults to true.
    traffic_manager_external_endpoint_endpoint_location = string       # (Optional) Specifies the Azure location of the Endpoint, this must be specified for Profiles using the Performance routing method.
    traffic_manager_external_endpoint_priority          = string       # (Optional) Specifies the priority of this Endpoint, this must be specified for Profiles using the Priority traffic routing method. Supports values between 1 and 1000, with no Endpoints sharing the same value. If omitted the value will be computed in order of creation.
    traffic_manager_external_endpoint_geo_mappings      = list(string) # (Optional) A list of Geographic Regions used to distribute traffic, such as WORLD, UK or DE. The same location can't be specified in two endpoints.
    traffic_manager_external_endpoint_custom_header = list(object({    # (Optional) One or more custom_header blocks as defined below.
      custom_header_name  = string                                     # (Required) The name of the custom header.
      custom_header_value = string                                     # (Required) The value of custom header. Applicable for HTTP and HTTPS protocol.
    }))
    traffic_manager_external_endpoint_subnet = list(object({ # (Optional) One or more subnet blocks as defined below
      subnet_first = string                                  # (Required) The first IP Address in this subnet.
      subnet_last  = string                                  # (Optional) The last IP Address in this subnet.
      subnet_scope = string                                  # (Optional) The block size (number of leading bits in the subnet mask).
    }))
    traffic_manager_external_endpoint_traffic_manager_profile_name                = string # (Required) Name of the Traffic Manager Profile.
    traffic_manager_external_endpoint_traffic_manager_profile_resource_group_name = string # (Required) Resource Group Name of the Traffic Manager profile
  }))
  description = "Map of Traffic Manager External Endpoint"
  default     = {}
}