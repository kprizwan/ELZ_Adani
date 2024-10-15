#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#PUBLIC IP
module "public_ip" {
  source              = "../../../public_ip/v1.3.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}
#NAT GATEWAY
module "nat_gateway" {
  source                = "../../../nat_gateway/v1.3.0"
  nat_gateway_variables = var.nat_gateway_variables
  depends_on            = [module.public_ip]
}
#NAT GATEWAY PUBLIC IP ASSOCIATION
module "nat_gateway_public_ip_association" {
  source                                      = "../"
  nat_gateway_public_ip_association_variables = var.nat_gateway_public_ip_association_variables
  depends_on                                  = [module.public_ip, module.nat_gateway]
}
