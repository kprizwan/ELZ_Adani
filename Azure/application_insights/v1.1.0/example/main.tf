#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  source                            = "../../../log_analytics_workspace/v1.1.0"
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.resource_group]
}

#APPINSIGHTS 
module "application_insights" {
  source                         = "../"
  application_insights_variables = var.application_insights_variables
  depends_on                     = [module.resource_group, module.log_analytics_workspace]
}
