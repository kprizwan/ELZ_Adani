#RESOURCE GROUP
module "resource_group" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#VNET
module "vnet" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source          = "../../../vnet/v1.1.0"
  vnets_variables = var.vnets_variables
  depends_on      = [module.resource_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source           = "../../../subnet/v1.1.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#APP SERVICE PLAN FOR FUNCTION APP
module "app_service_plan" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                     = "../../../app_service_plan/v1.1.0"
  app_service_plan_variables = var.app_service_plan_variables
  depends_on                 = [module.resource_group]
}

module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.1.0"
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

# Key Vault for Function App
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.1.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group]
}

# Key Vault Secret for function app
module "key_vault_secret" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                     = "../../../key_vault_secret/v1.1.0"
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault]
}

#STORAGE ACCOUNT FOR FUNCTION APP
module "storage_account" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                    = "../../../storage_account/v1.1.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group]
}

#FUNCTION APP
module "linux_web_app" {
  providers = {
    azurerm.linux_web_app_sub   = azurerm.linux_web_app_sub
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  source                  = "../"
  linux_web_app_variables = var.linux_web_app_variables
  depends_on              = [module.resource_group, module.storage_account, module.key_vault, module.key_vault_secret, module.app_service_plan]
}
