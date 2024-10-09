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

#LOAD BALNCER
module "load_balancer" {
  source                   = "../../../load_balancer/v1.2.0"
  load_balancers_variables = var.load_balancers_variables
  depends_on               = [module.resource_group, module.virtual_network, module.subnet]
}

#LOAD BALANCER PROBE
module "load_balancer_probe" {
  source                        = "../../../load_balancer_probe/v1.2.0"
  load_balancer_probe_variables = var.load_balancer_probe_variables
  depends_on                    = [module.load_balancer]
}

#LOAD BALANCER BACKENDPOOL
module "load_balancer_backendpool" {
  source                              = "../../../load_balancer_backendpool/v1.2.0"
  load_balancer_backendpool_variables = var.load_balancer_backendpool_variables
  depends_on                          = [module.load_balancer]
}

#LOAD BALANCER RULE
module "load_balancer_rules" {
  source                       = "../"
  load_balancer_rule_variables = var.load_balancer_rule_variables
  depends_on                   = [module.load_balancer, module.load_balancer_backendpool]
}
