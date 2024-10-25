#Web App Resource Group
module "windows_web_app_resource_group" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.windows_web_app_resource_group_variables
}

#Key Vault Resource Group 
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#Storage Account Resource Group
module "storage_account_resource_group" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.storage_account_resource_group_variables
}

#Virtual network 
module "virtual_network" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.windows_web_app_resource_group]
}

#Subnet
module "subnet" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#key Vault
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#key Vault Access Policy
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#Key Vault Secret 
module "key_vault_secret" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                     = "../../../key_vault_secret/v1.2.0"
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy]
}

#Storage Account
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.storage_account_sub
  }
  source                    = "../../../storage_account/v1.2.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.storage_account_resource_group]
}

#User Assigned Identity 
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.2.0"
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.windows_web_app_resource_group]
}

#App Service plan
module "app_service_plan" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                     = "../../../app_service_plan/v1.2.0"
  app_service_plan_variables = var.app_service_plan_variables
  depends_on                 = [module.windows_web_app_resource_group]
}

#Windows Web App
module "windows_web_app" {
  providers = {
    azurerm.key_vault_sub       = azurerm.key_vault_sub
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.windows_web_app_sub = azurerm.windows_web_app_sub
  }
  source                    = "../"
  windows_web_app_variables = var.windows_web_app_variables
  depends_on = [
    module.app_service_plan, module.key_vault_secret, module.storage_account, module.user_assigned_identity
  ]
}