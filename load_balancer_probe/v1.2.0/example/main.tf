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

#LOAD BALANCER
module "load_balancer" {
  source                   = "../../../load_balancer/v1.2.0"
  load_balancers_variables = var.load_balancers_variables
  depends_on               = [module.resource_group, module.virtual_network, module.subnet]
}

#LOAD BALANCER PROBE
module "load_balancer_probe" {
  source                        = "../"
  load_balancer_probe_variables = var.load_balancer_probe_variables
  depends_on                    = [module.resource_group, module.load_balancer]
}
