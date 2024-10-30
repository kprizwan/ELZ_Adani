#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

module "user_assigned_identity" {
  source                           = "../../../user_assigned_identity/v1.1.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on = [
    module.resource_group
  ]
}


module "automation_account" {
  source                       = "../"
  automation_account_variables = var.automation_account_variables
  depends_on = [
    module.resource_group, module.user_assigned_identity
  ]
}