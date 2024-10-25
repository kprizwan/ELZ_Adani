#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#RESOURCE GROUP KEYVAULT
module "resource_group_key_vault" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables_key_vault
}

#RESOURCE GROUP STORAGE ACCOUNT
module "resource_group_storage_account" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables_storage_account
}

#KEY VAULT
module "key_vault" {
  source              = "../../../key_vault/v1.3.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm
    azurerm.key_vault_sub       = azurerm
  }
  source                    = "../../../storage_account/v1.3.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group_storage_account]
}

#POSTGRESQL SERVER
module "postgresql_server" {
  source = "../../../postgresql_server/v1.3.0"
  providers = {
    azurerm.postgresql_server_sub = azurerm
    azurerm.key_vault_sub         = azurerm
    azurerm.storage_account_sub   = azurerm
  }
  postgresql_server_variables = var.postgresql_server_variables
  depends_on                  = [module.resource_group, module.key_vault_access_policy]
}

#POSTGRESQL DATABASE
module "postgresql_database" {
  source                        = "../"
  postgresql_database_variables = var.postgresql_database_variables
  depends_on                    = [module.postgresql_server]
}