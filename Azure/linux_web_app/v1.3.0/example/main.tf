#RESOURCE GROUP 
module "resource_group" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#KEY VAULT RESOURCE GROUP 
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#VIRTUAL NETWORK 
module "virtual_network" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#SERVICE PLAN
module "service_plan" {
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  source                 = "../../../service_plan/v1.3.0"
  service_plan_variables = var.service_plan_variables
  depends_on             = [module.resource_group]
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

#KEY VAULT KEY
module "key_vault_key" {
  source = "../../../key_vault_key/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#USER ASSIGNED IDENTITY 
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.3.0"
  providers = {
    azurerm = azurerm.linux_web_app_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  source                    = "../../../storage_account/v1.3.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.user_assigned_identity, module.key_vault_key]
}

#CONTAINER REGISTRY
module "container_registry" {
  source = "../../../container_registry/v1.3.0"
  providers = {
    azurerm.container_registry_sub = azurerm.linux_web_app_sub
    azurerm.key_vault_sub          = azurerm.key_vault_sub
  }
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.virtual_network, module.user_assigned_identity, module.key_vault_key]
}

#LINUX WEB APP
module "linux_web_app" {
  providers = {
    azurerm.linux_web_app_sub   = azurerm.linux_web_app_sub
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  source                  = "../"
  linux_web_app_variables = var.linux_web_app_variables
  depends_on              = [module.storage_account, module.key_vault_secret, module.service_plan, module.container_registry]
}
