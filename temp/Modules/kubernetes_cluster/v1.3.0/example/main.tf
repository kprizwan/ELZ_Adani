#RESOURCE GROUP FOR AKS
module "resource_group" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_aks_variables
}

#ROLE ASSIGNMENT
module "role_assignment" {
  source = "../../../role_assignment/v1.3.0"
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  role_assignment_variables = var.role_assignment_variables
  depends_on                = [module.user_assigned_identity, module.private_dns_zone, module.virtual_network]
}

#RESOURCE GROUP FOR KEY VAULT
module "resource_group_key_vault" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_key_vault_variables
}

#RESOURCE GROUP FOR LOG ANALYTICS
module "resource_group_log_analytics" {
  providers = {
    azurerm = azurerm.log_analytics_oms_sub
  }
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_log_analytics_workspace_oms_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source           = "../../../subnet/v1.3.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source                           = "../../../user_assigned_identity/v1.3.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#KEY VAULT
module "key_vault" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source              = "../../../key_vault/v1.3.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault, module.user_assigned_identity]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT KEY
module "key_vault_key" {
  source = "../../../key_vault_key/v1.3.0"
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#KEY VAULT SECRET
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.3.0"
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy]
}

#KEY VAULT CERTIFICATE
module "key_vault_certificate" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                          = "../../../key_vault_certificate/v1.3.0"
  key_vault_certificate_variables = var.key_vault_certificate_variables
  depends_on                      = [module.key_vault_access_policy]
}

#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  providers = {
    azurerm.keyvault_sub      = azurerm.keyvault_sub
    azurerm.log_analytics_sub = azurerm.log_analytics_oms_sub
  }
  source                            = "../../../log_analytics_workspace/v1.3.0"
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.user_assigned_identity, module.resource_group_log_analytics, module.key_vault]
}

#PRIVATE DNS ZONE
module "private_dns_zone" {
  providers = {
    azurerm = azurerm.private_dns_zone_sub
  }
  source                     = "../../../private_dns_zone/v1.3.0"
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.resource_group]
}

#AKS CLUSTER
module "kubernetes_cluster" {
  source = "../"
  providers = {
    azurerm.keyvault_sub                   = azurerm.keyvault_sub
    azurerm.log_analytics_oms_sub          = azurerm.log_analytics_oms_sub
    azurerm.log_analytics_defender_sub     = azurerm.log_analytics_defender_sub
    azurerm.kubernetes_cluster_sub         = azurerm.kubernetes_cluster_sub
    azurerm.private_dns_zone_sub           = azurerm.private_dns_zone_sub
    azurerm.user_assigned_identity_sub     = azurerm.kubernetes_cluster_sub
    azurem.ingress_application_gateway_sub = azurem.ingress_application_gateway_sub
  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on                   = [module.key_vault_secret, module.key_vault_key, module.private_dns_zone, module.log_analytics_workspace, module.subnet, module.key_vault_certificate]
}
