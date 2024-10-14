module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}


#VNET
module "vnet" {
  source          = "../../../vnet/v1.1.0"
  vnets_variables = var.vnets_variables
  depends_on      = [module.resource_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.1.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#Eventhub cluster
module "eventhub_cluster" {
  source                     = "../../../eventhub_cluster/v1.1.0"
  eventhub_cluster_variables = var.eventhub_cluster_variables
  depends_on                 = [module.subnet]
}

#eventhub_namespace
module "eventhub_namespace" {
  source                       = "../"
  eventhub_namespace_variables = var.eventhub_namespace_variables
  depends_on                   = [module.eventhub_cluster]
}
