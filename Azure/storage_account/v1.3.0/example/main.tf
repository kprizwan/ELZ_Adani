#RESOURCE GROUP
module "resource_group" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#KEY VAULT RESOURCE GROUP
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#KEY VAULT
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.3.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group, module.virtual_network]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT KEY
module "key_vault_key" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                  = "../../../key_vault_key/v1.3.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  source                           = "../../../user_assigned_identity/v1.3.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  providers = {
    azurerm = azurerm.virtual_network_sub
  }
  source                           = "../../../network_security_group/v1.3.0"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.resource_group]
}

#VNET
module "virtual_network" {
  providers = {
    azurerm = azurerm.virtual_network_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.network_security_group]
}

# SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.virtual_network_sub
  }
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

# STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  source                    = "../"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.subnet, module.user_assigned_identity, module.key_vault_key]
}