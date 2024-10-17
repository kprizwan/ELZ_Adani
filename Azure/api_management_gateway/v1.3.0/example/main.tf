#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#API MANAGEMENT
module "api_management" {
  providers = {
    azurerm.api_management_sub = azurerm
    azurerm.key_vault_sub      = azurerm
  }
  source                   = "../../../api_management/v1.3.0"
  api_management_variables = var.api_management_variables
  depends_on               = [module.resource_group]
}

#API MANAGEMENT GATEWAY
module "api_management_gateway" {
  source                           = "../"
  api_management_gateway_variables = var.api_management_gateway_variables
  depends_on                       = [module.api_management]
}