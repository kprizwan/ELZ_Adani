#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

#VNET
module "vnet" {
  source          = "../../../vnet/v1.1.0"
  vnets_variables = var.vnets_variables
  depends_on      = [module.resource_group]
  #depends_on = [module.ddos_protection_plan]  #Uncomment if the ddos protection plan is required
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.1.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#Load Balancer
module "load_balancer" {
  source                   = "../../../load_balancer/v1.1.0"
  load_balancers_variables = var.load_balancers_variables
  depends_on               = [module.resource_group, module.vnet, module.subnet, module.public_ip]
}

#Public_IP
module "public_ip" {
  source              = "../../../public_ip/v1.1.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}

#NETWORK INTERFACE
module "network_interface" {
  source                      = "../"
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.resource_group, module.vnet, module.subnet, module.public_ip, module.load_balancer]
}