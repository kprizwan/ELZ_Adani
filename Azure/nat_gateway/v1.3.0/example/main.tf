#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#NAT GATEWAY
module "nat_gateway" {
  source                = "../"
  nat_gateway_variables = var.nat_gateway_variables
  depends_on            = [module.resource_group]
}