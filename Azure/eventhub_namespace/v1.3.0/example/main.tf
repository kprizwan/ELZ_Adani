#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#EVENTHUB CLUSTER
module "eventhub_cluster" {
  source                     = "../../../eventhub_cluster/v1.3.0"
  eventhub_cluster_variables = var.eventhub_cluster_variables
  depends_on                 = [module.resource_group]
}

#EVENTHUB NAMESPACE
module "eventhub_namespace" {
  source                       = "../"
  eventhub_namespace_variables = var.eventhub_namespace_variables
  depends_on                   = [module.eventhub_cluster, module.subnet]
}