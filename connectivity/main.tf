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
  providers = {
    azurerm = azurerm.connectivity
  }
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.resource_group, module.virtual_network, module.subnet]
}


#APPLICATION GATEWAY
module "application_gateway" {
  source                        = "../Azure/application_gateway/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  application_gateway_variables = var.application_gateway_variables
  depends_on                    = [module.subnet]
}

#LINUX VM
module "linux_virtual_machine" {
  source = "../Azure/linux_virtual_machine/v1.3.0"
  providers = {
    azurerm.linux_vm_sub  = azurerm.connectivity
    azurerm.key_vault_sub = azurerm.connectivity
    azurerm.gallery_sub   = azurerm.connectivity
  }
  linux_virtual_machine_variables = var.linux_virtual_machine_variables
  depends_on                      = [module.subnet]
}

