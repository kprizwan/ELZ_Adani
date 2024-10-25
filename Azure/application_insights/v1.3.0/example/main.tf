#APPLICATION INSIGHTS RESOURCE GROUP
module "application_insights_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.application_insights_sub
  }
  resource_group_variables = var.resource_group_application_insights_variables
}

#LOG ANALYTICS WORKSPACE RESOURCE GROUP
module "log_analytics_workspace_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.log_analytics_sub
  }
  resource_group_variables = var.resource_group_log_analytics_workspace_variables
}

#KEY VAULT RESOURCE GROUP
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  resource_group_variables = var.resource_group_key_vault_variables
}

#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  source = "../../../log_analytics_workspace/v1.3.0"
  providers = {
    azurerm.keyvault_sub      = azurerm.keyvault_sub
    azurerm.log_analytics_sub = azurerm.log_analytics_sub
  }
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.log_analytics_workspace_resource_group, module.key_vault_access_policy]
}

#APPLICATION INSIGHTS 
module "application_insights" {
  source = "../"
  providers = {
    azurerm.keyvault_sub             = azurerm.keyvault_sub
    azurerm.application_insights_sub = azurerm.application_insights_sub
    azurerm.log_analytics_sub        = azurerm.log_analytics_sub
  }
  application_insights_variables = var.application_insights_variables
  depends_on                     = [module.application_insights_resource_group, module.log_analytics_workspace, module.key_vault_access_policy]
}