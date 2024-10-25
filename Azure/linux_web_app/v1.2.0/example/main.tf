#resource group 
module "resource_group" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#key valut resource group 
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#virtual network 
module "virtual_network" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#subnet
module "subnet" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#apps Service plan
module "app_service_plan" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                     = "../../../app_service_plan/v1.2.0"
  app_service_plan_variables = var.app_service_plan_variables
  depends_on                 = [module.resource_group]
}

# key vault key
module "key_vault_key" {
  source = "../../../key_vault_key/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_resource_group, module.key_vault, module.key_vault_access_policy]
}

#key vault access policy
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#user assigned identity 
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.2.0"
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#key vault
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#key vault secret 
module "key_vault_secret" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                     = "../../../key_vault_secret/v1.2.0"
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault, module.key_vault_access_policy]
}

# storage account
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.storage_account_sub
  }
  source                    = "../../../storage_account/v1.2.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group, module.key_vault]
}

#linux web app
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
