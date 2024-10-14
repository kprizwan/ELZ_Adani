# eventhub resource Group
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

# virtual Network
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

# strotage account
module "storage_account" {
  source = "../../../storage_account/v1.2.0"
  providers = {
    azurerm.storage_account_sub = azurerm
    azurerm.key_vault_sub       = azurerm
  }
  storage_account_variables = var.storage_account_variables
  depends_on = [
    module.resource_group
  ]
}

# storage container
module "storage_container" {
  source                      = "../../../storage_container/v1.2.0"
  storage_container_variables = var.storage_container_variables
  depends_on = [
    module.storage_account
  ]
}

# eventhub cluster
module "eventhub_cluster" {
  source                     = "../../../eventhub_cluster/v1.2.0"
  eventhub_cluster_variables = var.eventhub_cluster_variables
  depends_on = [
    module.resource_group
  ]
}

# eventhub_namespace
module "eventhub_namespace" {
  source                       = "../../../eventhub_namespace/v1.2.0"
  eventhub_namespace_variables = var.eventhub_namespace_variables
  depends_on                   = [module.eventhub_cluster, module.subnet]
}

# eventhub
module "eventhub" {
  source             = "../"
  eventhub_variables = var.eventhub_variables
  depends_on = [
    module.eventhub_namespace, module.storage_account
  ]
}