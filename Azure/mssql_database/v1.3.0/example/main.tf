#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.mssql_server_sub
  }
  resource_group_variables = var.resource_group_variables
}

#KEYVAULT RESOURCE GROUP
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}

#STORAGE ACCOUNT RESOURCE GROUP
module "storage_account_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  resource_group_variables = var.storage_account_resource_group_variables
}

#KEYVAULT
module "key_vault" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#KEYVAULT ACCESS POLICY
module "key_vault_access_policy" {
  source = "../../../key_vault_access_policy/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEYVAULT KEY
module "key_vault_key" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                  = "../../../key_vault_key/v1.3.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#KEYVAULT SECRET
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                           = "../../../user_assigned_identity/v1.3.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.storage_account_resource_group]
}

#STORAGE ACCOUNT
module "storage_account" {
  source = "../../../storage_account/v1.3.0"
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.storage_account_resource_group, module.key_vault_key]
}

#MSSQL SERVER
module "mssql_server" {
  source = "../../../mssql_server/v1.3.0"
  providers = {
    azurerm.key_vault_sub     = azurerm.key_vault_sub
    azurerm.mssql_server_sub  = azurerm.mssql_server_sub
    azuread.azuread_tenant_id = azuread.azuread_tenant_id
  }
  mssql_server_variables = var.mssql_server_variables
  depends_on             = [module.resource_group, module.key_vault_secret]
}

#MSSQL DATABASE
module "mssql_database" {
  source = "../"
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.mssql_server_sub    = azurerm.mssql_server_sub
    azuread.azuread_tenant_id   = azuread.azuread_tenant_id
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  mssql_database_variables = var.mssql_database_variables
  depends_on               = [module.mssql_server, module.storage_account]
}