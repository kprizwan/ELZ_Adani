### Connectivity Subscription ########

#RESOURCE GROUP
module "resource_group" {
  source = "../Azure/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  resource_group_variables = var.resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  source = "../Azure/virtual_network/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source = "../Azure/subnet/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

module "network_interface" {
  source                      = "../Azure/network_interface/v1.3.0"
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.resource_group, module.virtual_network, module.subnet, module.public_ip, module.lb]
}