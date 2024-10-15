#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}


#VIRTUAL WAN
module "virtual_wan" {
  source                = "../../../virtual_wan/v1.3.0"
  virtual_wan_variables = var.virtual_wan_variables
  depends_on            = [module.resource_group]
}

#VIRTUAL HUB
module "virtual_hub" {
  source                = "../../../virtual_hub/v1.3.0"
  virtual_hub_variables = var.virtual_hub_variables
  depends_on            = [module.virtual_wan]
}

#VPN GATEWAY
module "vpn_gateway" {
  source                = "../"
  vpn_gateway_variables = var.vpn_gateway_variables
  depends_on            = [module.virtual_hub]
}