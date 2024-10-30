#RESOURCE GROUP FOR WEB APP
module "windows_web_app_resource_group" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.windows_web_app_resource_group_variables
}

#RESOURCE GROUP FOR KEY VAULT 
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#RESOURCE GROUP FOR STORAGE ACCOUNT
module "storage_account_resource_group" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.storage_account_resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.windows_web_app_resource_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#KEY VAULT
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.3.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}
#KEY VAULT SECRET 
module "key_vault_secret" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                     = "../../../key_vault_secret/v1.3.0"
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy]
}

#STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.storage_account_sub
  }
  source                    = "../../../storage_account/v1.3.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.storage_account_resource_group, module.key_vault]
}

#USER ASSIGNED IDENTITY 
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.3.0"
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.windows_web_app_resource_group]
}

#SERVICE PLAN
module "service_plan" {
  source = "../../../service_plan/v1.3.0"
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  service_plan_variables = var.service_plan_variables
  depends_on             = [module.windows_web_app_resource_group]
}

#WINDOWS WEB APP
module "windows_web_app" {
  providers = {
    azurerm.key_vault_sub            = azurerm.key_vault_sub
    azurerm.storage_account_sub      = azurerm.storage_account_sub
    azurerm.application_insights_sub = azurerm.application_insights_sub
    azurerm.windows_web_app_sub      = azurerm.windows_web_app_sub
  }
  source                    = "../"
  windows_web_app_variables = var.windows_web_app_variables
  depends_on                = [module.service_plan, module.key_vault_secret, module.storage_account, module.user_assigned_identity]
}