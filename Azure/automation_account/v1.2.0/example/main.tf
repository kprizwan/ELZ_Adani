# Resource group
module "resource_group" {
  providers = {
    azurerm = azurerm.automation_account_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_automation_account_variables
}

module "resource_group_key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_key_vault_variables
}

# User assigned identity
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.user_assigned_identity_sub
  }
  source                           = "../../../user_assigned_identity/v1.2.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

# Key Vault
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
}

# Key Vault Key
module "key_vault_key" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                  = "../../../key_vault_key/v1.2.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

# Key Vault Access Policy
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

# Automation Account
module "automation_account" {
  providers = {
    azurerm.key_vault_sub              = azurerm.key_vault_sub
    azurerm.automation_account_sub     = azurerm.automation_account_sub
    azurerm.user_assigned_identity_sub = azurerm.user_assigned_identity_sub
  }
  source                       = "../"
  automation_account_variables = var.automation_account_variables
  depends_on                   = [module.resource_group, module.user_assigned_identity, module.key_vault_key]
}
