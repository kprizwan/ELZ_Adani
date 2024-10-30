# RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#Network Security Group
module "network_security_group" {
  source                           = "../../../network_security_group/v1.2.0"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.resource_group]
}

#VNET
module "virtual_network" {
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group, module.network_security_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#DDOS protection plan
module "network_ddos_protection_plan" {
  source                                 = "../../../network_ddos_protection_plan/v1.2.0"
  network_ddos_protection_plan_variables = var.network_ddos_protection_plan_variables
  depends_on                             = [module.resource_group]
}

#Public IP
module "public_ip" {
  source              = "../../../public_ip/v1.2.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group, module.network_ddos_protection_plan]
}

# Load Balancer
module "load_balancer" {
  source                   = "../../../load_balancer/v1.2.0"
  load_balancers_variables = var.load_balancers_variables
  depends_on               = [module.resource_group, module.virtual_network, module.subnet, module.public_ip]
}

#Network Interface
module "network_interface" {
  source                      = "../"
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.resource_group, module.virtual_network, module.subnet, module.public_ip, module.load_balancer]
}