#Resource Group
module "resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.cosmos_db_account_sub
  }
  resource_group_variables = var.resource_group_variables
}
#Resource Group
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}

#VNET
module "vnet" {
  source = "../../../vnet/v1.1.0"
  providers = {
    azurerm = azurerm.cosmos_db_account_sub
  }
  vnets_variables = var.vnets_variables
  depends_on      = [module.resource_group]
}

#SUBNET
module "subnet" {
  source = "../../../subnet/v1.1.0"
  providers = {
    azurerm = azurerm.cosmos_db_account_sub
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group]
}

#KEY VAULT
module "key_vault_key" {
  source = "../../../Key_vault_key/v1.1.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault]
}

#cosmos db account
module "cosmosdb_account" {
  source = "../"
  providers = {
    azurerm.cosmos_db_account_sub = azurerm.cosmos_db_account_sub
    azurerm.key_vault_sub         = azurerm.key_vault_sub
  }
  cosmosdb_account_variables = var.cosmosdb_account_variables
  depends_on                 = [module.resource_group, module.vnet, module.subnet, module.key_vault, module.key_vault_key]
}
