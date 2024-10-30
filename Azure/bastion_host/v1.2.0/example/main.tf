module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

module "virtual_network" {
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on = [
    module.resource_group
  ]
}

module "subnet" {
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on = [
    module.virtual_network
  ]
}

module "public_ip" {
  source              = "../../../public_ip/v1.2.0"
  public_ip_variables = var.public_ip_variables
  depends_on = [
    module.resource_group
  ]
}

module "bastion_host" {
  source                 = "../"
  bastion_host_variables = var.bastion_host_variables
  depends_on = [
    module.resource_group, module.subnet, module.public_ip
  ]
}