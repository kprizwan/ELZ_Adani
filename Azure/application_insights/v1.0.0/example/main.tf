#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

#APPINSIGHTS 
module "application_insights" {
  source                         = "../"
  application_insights_variables = var.application_insights_variables
}
