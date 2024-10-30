module "resource_group" {
  providers = {
    azurerm = azurerm.cosmos_db_account_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#RESOURCE GROUP KEY VAULT KEY VAULT 
module "resource_group_key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_key_vault_variables
}

module "vnet" {
  providers = {
    azurerm = azurerm.cosmos_db_account_sub
  }
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on = [
    module.resource_group
  ]
}

module "subnet" {
  providers = {
    azurerm = azurerm.cosmos_db_account_sub
  }
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on = [
    module.vnet
  ]
}

module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on = [
    module.resource_group_key_vault
  ]
}

module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on = [
    module.key_vault
  ]
}

module "key_vault_key" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                  = "../../../key_vault_key/v1.2.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on = [
    module.key_vault_access_policy
  ]
}

module "cosmosdb_account" {
  source = "../"
  providers = {
    azurerm.cosmos_db_account_sub = azurerm.cosmos_db_account_sub
    azurerm.key_vault_sub         = azurerm.key_vault_sub
  }
  cosmosdb_account_variables = var.cosmosdb_account_variables
  depends_on = [
    module.resource_group, module.key_vault_key, module.subnet
  ]
}