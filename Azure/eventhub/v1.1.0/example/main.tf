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
}

#SUBNET
module "subnet" {
  source           = "../../../subnet/v1.1.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#STORAGE ACCOUNT
module "storage_account" {
  source                    = "../../../storage_account/v1.1.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group]
}
#STORAGE CONTAINER
module "storage_container" {
  source                      = "../../../storage_container/v1.1.0"
  storage_container_variables = var.storage_container_variables
  depends_on                  = [module.storage_account]
}

#Eventhub Namespace
module "eventhub_namespace" {
  source                       = "../../../eventhub_namespace/v1.1.0"
  eventhub_namespace_variables = var.eventhub_namespace_variables
  depends_on                   = [module.resource_group]
}

#Eventhub
module "eventhub" {
  source             = "../"
  eventhub_variables = var.eventhub_variables
  depends_on         = [module.eventhub_namespace, module.storage_container]
}