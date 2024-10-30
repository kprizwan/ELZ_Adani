#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#GENERAL ASSUGNMENT
module "general_assignment" {
  source                            = "../"
  general_role_assignment_variables = var.general_role_assignment_variables
  depends_on                        = [module.resource_group]
}