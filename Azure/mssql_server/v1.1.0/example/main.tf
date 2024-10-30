#ResourceGroup
module "resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.mssql_server_sub
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

#Key Vault
module "key_vault" {
  source = "../../../key_vault/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
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

#MSSQL Server
module "mssql_server" {
  source = "../"
  providers = {
    azurerm.key_vault_sub     = azurerm.key_vault_sub
    azurerm.mssql_server_sub  = azurerm.mssql_server_sub
    azuread.azuread_tenant_id = azuread.azuread_tenant_id
  }
  mssql_server_variables = var.mssql_server_variables
  depends_on             = [module.resource_group, module.key_vault, module.key_vault_secret]
}



