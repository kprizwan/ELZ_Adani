#Windows web app RESOURCE GROUP 
module "windows_web_app_resource_group" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.windows_web_app_resource_group_variables
}

#Key Vault RESOURCE GROUP 
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#APP SERVICE PLAN 
module "app_service_plan" {
  providers = {
    azurerm = azurerm.windows_web_app_sub
  }
  source                     = "../../../app_service_plan/v1.1.0"
  app_service_plan_variables = var.app_service_plan_variables
  depends_on                 = [module.windows_web_app_resource_group]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.user_assigned_identity_sub
  }
  source                           = "../../../user_assigned_identity/v1.1.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.windows_web_app_resource_group]
}

# API MANAGEMENT
module "api_management" {
  providers = {
    azurerm.api_management_sub = azurerm.api_management_sub
    azurerm.key_vault_sub      = azurerm.windows_web_app_sub
  }
  source                   = "../../../api_management/v1.1.0"
  api_management_variables = var.api_management_variables
  depends_on               = [module.windows_web_app_resource_group]
}

#API MANAGEMENT API
module "api_management_api" {
  providers = {
    azurerm = azurerm.api_management_sub
  }
  source                       = "../../../api_management_api/v1.1.0/"
  api_management_api_variables = var.api_management_api_variables
  depends_on                   = [module.api_management]
}

# Key Vault for Function App
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.1.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
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

#KEY VAULT KEY
module "key_vault_key" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                  = "../../../key_vault_key/v1.1.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault]
}

#STORAGE ACCOUNT FOR FUNCTION APP
module "storage_account" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                    = "../../../storage_account/v1.1.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.windows_web_app_resource_group]
}

# STORAGE CONTAINER FOR FUNACTION APP BACKUP
module "storage_container" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                      = "../../../storage_container/v1.1.0"
  storage_container_variables = var.storage_container_variables
  depends_on                  = [module.storage_account]
}

#VNET
module "vnet" {
  providers = {
    azurerm = azurerm.virtual_network_sub
  }
  source          = "../../../vnet/v1.1.0"
  vnets_variables = var.vnets_variables
  depends_on      = [module.windows_web_app_resource_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.virtual_network_sub
  }
  source           = "../../../subnet/v1.1.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#CONTAINER REGISTRY
module "container_registry" {
  providers = {
    azurerm.container_registry_sub = azurerm.windows_web_app_sub
    azurerm.key_vault_sub          = azurerm.windows_web_app_sub
  }
  source                       = "../../../container_registry/v1.1.0"
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.windows_web_app_resource_group, module.vnet, module.user_assigned_identity, module.key_vault_key]
}

#WINDOWS WEB APP
module "windows_web_app" {
  providers = {
    azurerm.windows_web_app_sub        = azurerm.windows_web_app_sub
    azurerm.user_assigned_identity_sub = azurerm.user_assigned_identity_sub
    azurerm.api_management_sub         = azurerm.api_management_sub
    azurerm.key_vault_sub              = azurerm.key_vault_sub
    azurerm.storage_account_sub        = azurerm.storage_account_sub
    azurerm.virtual_network_sub        = azurerm.virtual_network_sub
  }
  source                    = "../"
  windows_web_app_variables = var.windows_web_app_variables
  depends_on = [module.windows_web_app_resource_group, module.key_vault_resource_group, module.app_service_plan, module.user_assigned_identity, module.key_vault, module.key_vault_secret,
  module.api_management_api, module.storage_account, module.storage_container, module.container_registry, module.subnet]
}