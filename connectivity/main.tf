### Connectivity Subscription ########

#RESOURCE GROUP
module "resource_group" {
  source = "../Azure/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  resource_group_variables = var.resource_group_variables
}
