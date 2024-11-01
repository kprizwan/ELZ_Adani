#RESOURCE GROUP
module "resource_group" {
  source = "../../Azure/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.dev_env
  }
  resource_group_variables = var.resource_group_variables
}

#CONTAINER REGISTRY
module "container_registry" {
  source = "../../Azure/container_registry/v1.3.0"
  providers = {
    azurerm.key_vault_sub          = azurerm.dev_env
    azurerm.container_registry_sub = azurerm.dev_env
  }
  container_registry_variables = var.container_registry_variables
}