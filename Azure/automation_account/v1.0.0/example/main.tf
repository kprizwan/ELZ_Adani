#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

module "automation_account" {
  source                       = "../"
  automation_account_variables = var.automation_account_variables
  depends_on = [
    module.resource_group
  ]
}