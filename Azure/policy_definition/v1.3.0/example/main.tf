#MANAGEMENT GROUP
module "management_group" {
  source                     = "../../../management_group/v1.3.0"
  management_group_variables = var.management_group_variables
}

#POLICY DEFINITON 
module "policy_definition" {
  source                      = "../"
  policy_definition_variables = var.policy_definition_variables
  depends_on                  = [module.management_group]
}
