module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}
module "traffic_manager_profile" {
  source                            = "../../../traffic_manager_profile/v1.1.0"
  traffic_manager_profile_variables = var.traffic_manager_profile_variables
  depends_on                        = [module.resource_group]
}
module "traffic_manager_external_endpoint" {
  source                                      = "../"
  traffic_manager_external_endpoint_variables = var.traffic_manager_external_endpoint_variables
  depends_on                                  = [module.traffic_manager_profile]
}
