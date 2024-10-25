#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

module "management_groups" {
  source                     = "../../../management_group/v1.1.0"
  management_group_variables = var.management_group_variables
}


module "general_assignment" {
  source                            = "../"
  general_role_assignment_variables = var.general_role_assignment_variables
  depends_on                        = [module.resource_group]

}

