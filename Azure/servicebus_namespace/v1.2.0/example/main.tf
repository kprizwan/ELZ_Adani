#RESOURCE GROUP
module "resource_group" {
  providers = {
    azurerm = azurerm.servicebus_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#Key vault resource group
module "key_vault_resource_group" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.key_vault_resource_group_variables
}

#KEY VAULT
module "key_vault" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT KEY
module "key_vault_key" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                  = "../../../key_vault_key/v1.2.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.servicebus_sub
  }
  source                           = "../../../user_assigned_identity/v1.2.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on = [
    module.resource_group
  ]
}

#Service namespace
module "servicebus_namespace" {
  providers = {
    azurerm.servicebus_sub = azurerm.servicebus_sub
    azurerm.keyvault_sub   = azurerm.keyvault_sub
  }
  source                         = "../"
  servicebus_namespace_variables = var.servicebus_namespace_variables
  depends_on = [
    module.resource_group, module.key_vault_key
  ]
}
