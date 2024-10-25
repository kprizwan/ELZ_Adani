#resource_group_container_registry
module "resource_group_container_registry" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.container_registry_resource_group_variables
}

#resource_group_key_vault
module "resource_group_key_vault" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#virtual_network
module "virtual_network" {
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group_container_registry]
}

#subnet
module "subnet" {
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#user_assigned_identity
module "user_assigned_identity" {
  source                           = "../../../user_assigned_identity/v1.2.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group_key_vault]
}

#key_vault
module "key_vault" {
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.user_assigned_identity]
}

#key_vault_access_policy
module "key_vault_access_policy" {
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#key_vault_key
module "key_vault_key" {
  source                  = "../../../key_vault_key/v1.2.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#container_registry
module "container_registry" {
  source = "../../../container_registry/v1.2.0"
  providers = {
    azurerm.container_registry_sub = azurerm
    azurerm.key_vault_sub          = azurerm
  }
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.key_vault_key]
}

#container_registry_webhook
module "container_registry_webhook" {
  source                               = "../"
  container_registry_webhook_variables = var.container_registry_webhook_variables
  depends_on                           = [module.container_registry]
}
