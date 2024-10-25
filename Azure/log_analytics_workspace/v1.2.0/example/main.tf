#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.log_analytics_sub
  }
  resource_group_variables = var.resource_group_variables
}
#Key vault RESOURCE GROUP
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  resource_group_variables = var.resource_group_key_vault_variables
}
#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.2.0"
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
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}
#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  source = "../"
  providers = {
    azurerm.keyvault_sub      = azurerm.keyvault_sub
    azurerm.log_analytics_sub = azurerm.log_analytics_sub
  }
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.resource_group, module.key_vault_access_policy]
}