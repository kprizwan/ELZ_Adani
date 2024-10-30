# RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#APP SERVICE PLAN
module "app_service_plan" {
  source                     = "../"
  app_service_plan_variables = var.app_service_plan_variables
  depends_on                 = [module.resource_group]
}
