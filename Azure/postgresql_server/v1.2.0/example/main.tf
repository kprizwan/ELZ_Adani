#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.postgresql_server_sub
  }
  resource_group_variables = var.resource_group_variables
}

#RESOURCE GROUP KEYVAULT
module "resource_group_key_vault" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.resource_group_variables_key_vault
}

# KEYVAULT
module "key_vault" {
  source = "../../../key_vault/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source = "../../../key_vault_access_policy/v1.2.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

# POSTGRESQL SERVER
module "postgresql_server" {
  source = "../"
  providers = {
    azurerm.postgresql_server_sub = azurerm.postgresql_server_sub
    azurerm.key_vault_sub         = azurerm.key_vault_sub
    azurerm.storage_account_sub   = azurerm.storage_account_sub
  }
  postgresql_server_variables = var.postgresql_server_variables
  depends_on                  = [module.resource_group, module.key_vault, module.key_vault_access_policy]
}