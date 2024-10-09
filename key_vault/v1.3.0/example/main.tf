#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  source                           = "../../../network_security_group/v1.3.0"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.resource_group]
}

#VNET
module "virtual_network" {
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group, module.network_security_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#KEYVAULT
module "key_vault" {
  source              = "../"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group, module.virtual_network, module.subnet]
}
