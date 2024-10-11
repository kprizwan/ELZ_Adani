#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}


# VNET FOR AKS
module "vnet" {
  source          = "../../../vnet/v1.0.0"
  vnets_variables = var.vnets_variables
  depends_on      = [module.resource_group]
}

#SUBNET FOR AKS
module "subnet" {
  source           = "../../../subnet/v1.0.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#Public IP
module "public_ip" {
  source             = "../../../public_ip/v1.0.0"
  public_ip_variable = var.public_ip_variable
  depends_on         = [module.resource_group]
}

# #APPLICATION GATEWAY FOR AKS
module "application_gateway" {
  source                        = "../../../application_gateways/v1.0.0"
  application_gateway_variables = var.application_gateway_variables
  depends_on = [module.vnet,
    module.subnet,
    module.public_ip,
  ]
}

#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  source                            = "../../../log_analytics_workspace/v1.0.0"
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.resource_group]
}

#AKS CLUSTER
module "aks" {
  source                = "../"
  aks_cluster_variables = var.aks_cluster_variables
  depends_on = [module.vnet,
    module.subnet,
    module.application_gateway,
    module.log_analytics_workspace
  ]
}
