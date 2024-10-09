#RESOURCE GROUP FOR CONTAINER REGISTRY
module "resource_group_container_registry" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.container_registry_sub
  }
  resource_group_variables = var.Container_registry_resource_group_variables
}

#RESOURCE GROUP FOR KEY VAULT
module "resource_group_key_vault" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  source = "../../../virtual_network/v1.3.0"
  providers = {
    azurerm = azurerm.container_registry_sub
  }
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group_container_registry]
}

#SUBNET
module "subnet" {
  source = "../../../subnet/v1.3.0"
  providers = {
    azurerm = azurerm.container_registry_sub
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group_key_vault]
}

#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
}

#KEY VAULT KEY
module "key_vault_key" {
  source = "../../../key_vault_key/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source = "../../../key_vault_access_policy/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault, module.user_assigned_identity]
}

#CONTAINER REGISTRY
module "container_registry" {
  source = "../"
  providers = {
    azurerm.container_registry_sub = azurerm.container_registry_sub
    azurerm.key_vault_sub          = azurerm.key_vault_sub
  }
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.subnet, module.key_vault_key]
}