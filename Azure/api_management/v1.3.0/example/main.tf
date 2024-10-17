#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.api_management_sub
  }
  resource_group_variables = var.resource_group_variables
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.3.0"
  providers = {
    azurerm = azurerm.api_management_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  providers = {
    azurerm = azurerm.api_management_sub
  }
  source                           = "../../../network_security_group/v1.3.0"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.resource_group]
}

#VIRTUAL NETWORK
module "virtual_network" {
  providers = {
    azurerm = azurerm.api_management_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.network_security_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.api_management_sub
  }
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#KEYVAULT
module "key_vault" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source              = "../../../key_vault/v1.3.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.subnet]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault, module.user_assigned_identity]
}

#KEY VAULT SECRET
module "key_vault_secret" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                     = "../../../key_vault_secret/v1.3.0"
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy]
}

#KEY VAULT CERTIFICATE
module "key_vault_certificate" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                          = "../../../key_vault_certificate/v1.3.0"
  key_vault_certificate_variables = var.key_vault_certificate_variables
  depends_on                      = [module.key_vault_access_policy]
}

#PUBLIC IP
module "public_ip" {
  providers = {
    azurerm = azurerm.api_management_sub
  }
  source              = "../../../public_ip/v1.3.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}

#API MANAGEMENT
module "api_management" {
  source = "../"
  providers = {
    azurerm.api_management_sub = azurerm.api_management_sub
    azurerm.key_vault_sub      = azurerm.key_vault_sub
  }
  api_management_variables = var.api_management_variables
  depends_on               = [module.public_ip, module.user_assigned_identity, module.virtual_network, module.key_vault_certificate]
}


