#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.private_endpoint_sub
  }
  resource_group_variables = var.resource_group_variables
}

#RESOURCE GROUP
module "private_dns_zone_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.private_dns_zone_sub
  }
  resource_group_variables = var.private_dns_zone_resource_group_variables
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  providers = {
    azurerm = azurerm.private_endpoint_sub
  }
  source                           = "../../../network_security_group/v1.3.0"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.resource_group]
}

#VIRTUAL NETWORK
module "virtual_network" {
  source = "../../../virtual_network/v1.3.0"
  providers = {
    azurerm = azurerm.private_endpoint_sub
  }
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.network_security_group]
}

#SUBNET
module "subnet" {
  source = "../../../subnet/v1.3.0"
  providers = {
    azurerm = azurerm.private_endpoint_sub
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#KEYVAULT
module "key_vault" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.private_connection_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.subnet]
}

#PRIVATE DNS ZONE
module "private_dns_zone" {
  source = "../../../private_dns_zone/v1.3.0"
  providers = {
    azurerm = azurerm.private_dns_zone_sub
  }
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.resource_group]
}

#PRIVATE ENDPOINT
module "private_endpoint" {
  source = "../"
  providers = {
    azurerm.private_endpoint_sub   = azurerm.private_endpoint_sub
    azurerm.private_connection_sub = azurerm.private_connection_sub
    azurerm.private_dns_zone_sub   = azurerm.private_dns_zone_sub
  }
  private_endpoint_variables = var.private_endpoint_variables
  depends_on                 = [module.key_vault, module.private_dns_zone]
}
