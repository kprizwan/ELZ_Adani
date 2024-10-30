#Resource Group
module "resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.postgresql_server_sub
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

#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
}

#Postgresql Server
module "postgresql_server" {
  source = "../"
  providers = {
    azurerm.postgresql_server_sub = azurerm.postgresql_server_sub
    azurerm.key_vault_sub         = azurerm.key_vault_sub
    azurerm.storage_account_sub   = azurerm.storage_account_sub
  }
  postgresql_server_variables = var.postgresql_server_variables
  depends_on                  = [module.resource_group, module.key_vault]
}