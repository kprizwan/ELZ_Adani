#Resource Group for AKS
module "resource_group" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_aks_variables
}

#GENERAL ASSIGNMENT
module "general_assignment" {
  source = "../../../general_role_assignment/v1.2.0"
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  general_role_assignment_variables = var.general_role_assignment_variables
  depends_on                        = [module.user_assigned_identity, module.private_dns_zone, module.virtual_network]
}

#Resource Group for Key Vault
module "resource_group_key_vault" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_key_vault_variables
}

#Resource Group for Log Analytics
module "resource_group_log_analytics" {
  providers = {
    azurerm = azurerm.log_analytics_oms_sub
  }
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_log_analytics_workspace_oms_variables
}

#virtual network
module "virtual_network" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source                    = "../../../virtual_network/v1.2.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source           = "../../../subnet/v1.2.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#user assigned identity
module "user_assigned_identity" {
  providers = {
    azurerm = azurerm.kubernetes_cluster_sub
  }
  source                           = "../../../user_assigned_identity/v1.2.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#KEY VAULT
module "key_vault" {
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault, module.user_assigned_identity]
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

#KEY VAULT SECRET
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.2.0"
  providers = {
    azurerm = azurerm.keyvault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault, module.key_vault_access_policy]
}

#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  providers = {
    azurerm.keyvault_sub      = azurerm.keyvault_sub
    azurerm.log_analytics_sub = azurerm.log_analytics_oms_sub
  }
  source                            = "../../../log_analytics_workspace/v1.2.0"
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.user_assigned_identity, module.resource_group_log_analytics, module.key_vault]
}

#Private DNS zone
module "private_dns_zone" {
  providers = {
    azurerm = azurerm.private_dns_zone_sub
  }
  source                    = "../../../private_dns_zone/v1.2.0"
  private_dns_zone_variable = var.private_dns_zone_variable
  depends_on                = [module.resource_group]
}

#AKS CLUSTER
module "kubernetes_cluster" {
  source = "../"
  providers = {
    azurerm.keyvault_sub               = azurerm.keyvault_sub
    azurerm.log_analytics_oms_sub      = azurerm.log_analytics_oms_sub
    azurerm.log_analytics_defender_sub = azurerm.log_analytics_defender_sub
    azurerm.kubernetes_cluster_sub     = azurerm.kubernetes_cluster_sub
    azurerm.private_dns_zone_sub       = azurerm.private_dns_zone_sub
  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on                   = [module.key_vault_secret, module.private_dns_zone, module.log_analytics_workspace]
}
