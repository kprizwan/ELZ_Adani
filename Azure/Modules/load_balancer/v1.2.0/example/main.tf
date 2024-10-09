#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#VNET
module "virtual_network" {
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.resource_group, module.virtual_network]
}

# Public IP
module "public_ip" {
  source              = "../../../public_ip/v1.2.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}

# Load Balancer
module "load_balancer" {
  source                   = "../"
  load_balancers_variables = var.load_balancers_variables
  depends_on               = [module.resource_group, module.virtual_network, module.subnet, module.public_ip]
}


