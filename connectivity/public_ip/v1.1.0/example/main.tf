#RESOURCE GROUP for Linux VMs
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

#Public IP
module "public_ip" {
  source              = "../"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}
