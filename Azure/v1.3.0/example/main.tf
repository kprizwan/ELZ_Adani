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
  depends_on       = [module.virtual_network, module.resource_group]
}

#STORAGE ACCOUNT
module "storage_account" {
  source = "../../../storage_account/v1.3.0"
  providers = {
    azurerm.storage_account_sub = azurerm
    azurerm.key_vault_sub       = azurerm
  }
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group]
}

#STORAGE CONTAINER
module "storage_container" {
  source                      = "../../../storage_container/v1.3.0"
  storage_container_variables = var.storage_container_variables
  depends_on                  = [module.storage_account]
}

#ROLE ASSIGNMENT
module "role_assignment" {
  source                    = "../../../role_assignment/v1.3.0"
  role_assignment_variables = var.role_assignment_variables
  depends_on                = [module.storage_account]
}

#EVENTHUB NAMESPACE
module "eventhub_namespace" {
  source                       = "../../../eventhub_namespace/v1.3.0"
  eventhub_namespace_variables = var.eventhub_namespace_variables
  depends_on                   = [module.subnet]
}

#EVENTHUB
module "eventhub" {
  source             = "../"
  eventhub_variables = var.eventhub_variables
  depends_on         = [module.eventhub_namespace, module.storage_container, module.role_assignment]
}