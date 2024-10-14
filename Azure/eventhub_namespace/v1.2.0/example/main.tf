#Resource Group
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#Virtual Network
module "virtual_network" {
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#Subnet
module "subnet" {
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network, module.resource_group]
}

#Eventhub cluster
module "eventhub_cluster" {
  source                     = "../../../eventhub_cluster/v1.2.0"
  eventhub_cluster_variables = var.eventhub_cluster_variables
  depends_on                 = [module.resource_group]
}

#eventhub_namespace
module "eventhub_namespace" {
  source                       = "../"
  eventhub_namespace_variables = var.eventhub_namespace_variables
  depends_on                   = [module.eventhub_cluster]
}