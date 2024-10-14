#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

# VNET
module "virtual_network" {
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}


#Network Security Group
module "network_security_group" {
  source                           = "../../../network_security_group/v1.2.0"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.resource_group]
}

#networ_interface
#Network Interface
module "network_interface" {
  source                      = "../../../network_interface/v1.2.0"
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.resource_group, module.virtual_network, module.subnet]
}

#Network Security Group Association
module "network_security_group_association" {
  source                                       = "../"
  network_security_group_association_variables = var.network_security_group_association_variables
  depends_on                                   = [module.network_security_group, module.subnet, module.network_interface]
}
