# RESOURCE GROUP MODULE
module "resource_group" {
  # Source now points to the Git repository path for the module
  source = "git::https://github.com/kprizwan/ELZ_Adani.git//Azure/resource_group/v1.3.0?ref=sd-branch-dev"
  
  providers = {
    azurerm = azurerm.dev_env
  }
  
  # Pass in the required variables for the resource group module
  resource_group_variables = var.resource_group_variables
}
