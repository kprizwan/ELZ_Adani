#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

#APP SERVICE PLAN FOR FUNCTION APP
module "app_service_plan" {
  source                     = "../../../app_service_plan/v1.0.0"
  app_service_plan_variables = var.app_service_plan_variables
}

#STORAGE ACCOUNT FOR FUNCTION APP
module "storage_account" {
  source                    = "../../../storage_account/v1.0.0"
  storage_account_variables = var.storage_account_variables
}

#FUNCTION APP
module "function_app" {
  source                 = "../"
  function_app_variables = var.function_app_variables
  depends_on = [module.app_service_plan,
    module.storage_account
  ]
}
