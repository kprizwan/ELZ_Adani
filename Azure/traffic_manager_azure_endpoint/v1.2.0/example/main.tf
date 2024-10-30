module "resource_group" {
  providers = {
    azurerm = azurerm.traffic_manager_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

module "resource_group_public_ip" {
  providers = {
    azurerm = azurerm.target_resource_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_public_ip_variables
}

module "traffic_manager_profile" {
  providers = {
    azurerm = azurerm.traffic_manager_sub
  }
  source                            = "../../../traffic_manager_profile/v1.2.0"
  traffic_manager_profile_variables = var.traffic_manager_profile_variables
  depends_on                        = [module.resource_group]
}

#Public IP
module "public_ip" {
  providers = {
    azurerm = azurerm.target_resource_sub
  }
  source              = "../../../public_ip/v1.2.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group_public_ip]
}

module "traffic_manager_azure_endpoint" {
  providers = {
    azurerm.target_resource_sub = azurerm.target_resource_sub
    azurerm.traffic_manager_sub = azurerm.traffic_manager_sub
  }
  source                                   = "../"
  traffic_manager_azure_endpoint_variables = var.traffic_manager_azure_endpoint_variables
  depends_on                               = [module.traffic_manager_profile, module.public_ip]
}