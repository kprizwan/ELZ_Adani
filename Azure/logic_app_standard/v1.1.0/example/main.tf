#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.logic_app_standard_sub
  }
  resource_group_variables = var.resource_group_variables
}

module "resource_group_key_vault" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.resource_group_variables_key_vault
}

# Key Vault for Logic App Standard
module "key_vault" {
  source = "../../../key_vault/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group]
}

# Key Vault Secret for Logic App Standard
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault]
}

module "resource_group_storage_account" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  resource_group_variables = var.resource_group_variables_storage_account
}

#STORAGE ACCOUNT
module "storage_account" {
  source = "../../../storage_account/v1.1.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group]
}

#APP SERVICE PLAN
module "app_service_plan" {
  source = "../../../app_service_plan/v1.1.0"
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
    azurerm.storage_account_sub    = azurerm.storage_account_sub
    azurerm.key_vault_sub          = azurerm.key_vault_sub
  }
  logic_app_standard_variables = var.logic_app_standard_variables
  depends_on                   = [module.resource_group, module.storage_account, module.app_service_plan]
}

