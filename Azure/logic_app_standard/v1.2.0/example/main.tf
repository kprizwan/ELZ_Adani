#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.logic_app_standard_sub
  }
  resource_group_variables = var.resource_group_variables
}
#KEY VAULT RESOURCE GROUP
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}
#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.logic_app_standard_sub
  }
  source                           = "../../../user_assigned_identity/v1.2.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}
#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}
#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source = "../../../key_vault_access_policy/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault_resource_group, module.key_vault]
}
#KEY VAULT SECRET
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault, module.key_vault_access_policy]
}
#KEY VAULT KEY
module "key_vault_key" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                  = "../../../key_vault_key/v1.2.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault, module.key_vault_resource_group, module.key_vault_access_policy]
}
#VIRTUAL NETWORK
module "virtual_network" {
  providers = {
    azurerm = azurerm.logic_app_standard_sub
  }
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}
#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.logic_app_standard_sub
  }
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.resource_group, module.virtual_network]
}
#STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.logic_app_standard_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  source                    = "../../../storage_account/v1.2.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group, module.virtual_network, module.subnet, module.user_assigned_identity, module.key_vault, module.key_vault_key]
}
#APP SERVICE PLAN
module "app_service_plan" {
  source = "../../../app_service_plan/v1.2.0"
  providers = {
    azurerm = azurerm.logic_app_standard_sub
  }
  app_service_plan_variables = var.app_service_plan_variables
  depends_on                 = [module.resource_group]
}
#LOGIC APP STANDARD
module "logic_app_standard" {
  source = "../"
  providers = {
    azurerm.logic_app_standard_sub = azurerm.logic_app_standard_sub
    azurerm.key_vault_sub          = azurerm.key_vault_sub
  }
  logic_app_standard_variables = var.logic_app_standard_variables
  depends_on                   = [module.resource_group, module.storage_account, module.app_service_plan, module.key_vault, module.virtual_network, module.subnet, module.user_assigned_identity]
}