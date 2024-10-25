#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  source                           = "../../../user_assigned_identity/v1.3.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#KEY VAULT
module "key_vault" {
  source              = "../../../key_vault/v1.3.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT KEY
module "key_vault_key" {
  source                  = "../../../key_vault_key/v1.3.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
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

#SERVICEBUS NAMESPACE
module "servicebus_namespace" {
  providers = {
    azurerm.servicebus_sub = azurerm
    azurerm.keyvault_sub   = azurerm
  }
  source                         = "../"
  servicebus_namespace_variables = var.servicebus_namespace_variables
  depends_on                     = [module.key_vault_key, module.subnet]
}
