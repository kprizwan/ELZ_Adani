variable "traffic_manager_external_endpoint_variables" {
  type = map(object({
    traffic_manager_external_endpoint_name              = string
    traffic_manager_external_endpoint_target            = string
    traffic_manager_external_endpoint_weight            = string
    traffic_manager_external_endpoint_enabled           = bool
    traffic_manager_external_endpoint_endpoint_location = string
    traffic_manager_external_endpoint_priority          = string
    traffic_manager_external_endpoint_geo_mappings      = list(string)
    traffic_manager_external_endpoint_custom_header = list(object({
      custom_header_name  = string
      custom_header_value = string
    }))
    traffic_manager_external_endpoint_subnet = list(object({
      subnet_first = string
      subnet_last  = string
      subnet_scope = string
    }))
    traffic_manager_external_endpoint_traffic_manager_profile_profile_name                = string
    traffic_manager_external_endpoint_traffic_manager_profile_profile_resource_group_name = string
  }))
}
