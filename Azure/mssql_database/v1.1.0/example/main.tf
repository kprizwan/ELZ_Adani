# Resource Group
module "resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.mssql_server_sub
  }
  resource_group_variables = var.resource_group_variables
}

module "key_vault_resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}

module "storage_account_resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  resource_group_variables = var.storage_account_resource_group_variables
}

#Key Vault
module "key_vault" {
  source = "../../../key_vault/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on = [
    module.resource_group
  ]
}

#Key Vault Secret
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault]
}

# Storage Account
module "storage_account" {
  source = "../../../storage_account/v1.1.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group]
}

# MSSQL Server
module "mssql_server" {
  source = "../../../mssql_server/v1.1.0"
  providers = {
    azurerm.key_vault_sub     = azurerm.key_vault_sub
    azurerm.mssql_server_sub  = azurerm.mssql_server_sub
    azuread.azuread_tenant_id = azuread.azuread_tenant_id
  }
  mssql_server_variables = var.mssql_server_variables
  depends_on = [
    module.resource_group,
    module.key_vault,
    module.key_vault_secret
  ]
}

# MSSQL Database
module "mssql_database" {
  source = "../"
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.mssql_server_sub    = azurerm.mssql_server_sub
    azuread.azuread_tenant_id   = azuread.azuread_tenant_id
  }
  mssql_database_variables = var.mssql_database_variables
  depends_on = [
    module.resource_group,
    module.mssql_server,
    module.storage_account
  ]
}