#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#TRAFFIC MANAGER PROFILE
module "traffic_manager_profile" {
  source                            = "../../../traffic_manager_profile/v1.3.0"
  traffic_manager_profile_variables = var.traffic_manager_profile_variables
  depends_on                        = [module.resource_group]
}

#TRAFFIC MANAGER NESTED ENDPOINT
module "traffic_manager_nested_endpoint" {
  source                                    = "../"
  traffic_manager_nested_endpoint_variables = var.traffic_manager_nested_endpoint_variables
  depends_on                                = [module.traffic_manager_profile]
}