#RESOURCE GROUP
module "resource_group" {
  source = "../../Azure/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.dev_env
  }
  resource_group_variables = var.resource_group_variables
}

#CONTAINER REGISTRY
/*module "container_registry" {
  source = "../../Azure/container_registry/v1.3.0"
  providers = {
    azurerm.key_vault_sub          = azurerm.dev_env
    azurerm.container_registry_sub = azurerm.dev_env
  }
  container_registry_variables = var.container_registry_variables
}*/

#KEYVAULT
module "key_vault" {
  source = "../../Azure/key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.dev_env
  }
  key_vault_variables = var.key_vault_variables
}

# STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.dev_env
    azurerm.key_vault_sub       = azurerm.dev_env
  }
  source                    = "../../Azure/storage_account/v1.3.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.key_vault_key]
}
