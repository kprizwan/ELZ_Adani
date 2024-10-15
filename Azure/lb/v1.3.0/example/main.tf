#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.resource_group, module.virtual_network]
}

#PUBLIC IP
module "public_ip" {
  source              = "../../../public_ip/v1.3.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}

#LB
module "lb" {
  source       = "../"
  lb_variables = var.lb_variables
  depends_on   = [module.resource_group, module.virtual_network, module.subnet, module.public_ip]
}