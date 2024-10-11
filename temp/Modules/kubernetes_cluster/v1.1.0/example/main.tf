#Resource Group for AKS
module "resource_group" {
  providers = {
  azurerm = azurerm.kubernetes_cluster_sub }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_aks_variables
}

#Resource Group for Key Vault
module "resource_group_key_vault" {
  providers = {
  azurerm = azurerm.key_vault_sub }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_key_vault_variables
}

#VNET
module "vnet" {
  providers = {
  azurerm = azurerm.kubernetes_cluster_sub }
  source          = "../../../vnet/v1.1.0"
  vnets_variables = var.vnets_variables
  depends_on      = [module.resource_group]
}
module "user_assigned_identity" {
  providers = {
  azurerm = azurerm.kubernetes_cluster_sub }
  source                           = "../../../user_assigned_identity/v1.1.0"
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on = [
    module.resource_group
  ]
}
#SUBNET
module "subnet" {
  providers = {
  azurerm = azurerm.kubernetes_cluster_sub }
  source           = "../../../subnet/v1.1.0"
  subnet_variables = var.subnet_variables
  depends_on       = [module.vnet]
}

#Resource Group for Log Analytics
module "resource_group_log_analytics" {
  providers = {
  azurerm = azurerm.log_analytics_oms_sub }
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_log_analytics_workspace_oms_variables
}

#KEY VAULT
module "key_vault" {
  providers = {
  azurerm = azurerm.key_vault_sub }
  source              = "../../../key_vault/v1.1.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group_key_vault]
}

#LOG ANALYTICS WORKSPACE
module "log_analytics_workspace" {
  providers = {
  azurerm = azurerm.log_analytics_oms_sub }
  source                            = "../../../log_analytics_workspace/v1.1.0"
  log_analytics_workspace_variables = var.log_analytics_workspace_variables
  depends_on                        = [module.resource_group_log_analytics]
}
module "private_dns_zone" {
  providers = {
    azurerm = azurerm.private_dns_zone_sub
  }
  source                    = "../../../private_dns_zone/v1.1.0"
  private_dns_zone_variable = var.private_dns_zone_variable
  depends_on = [
    module.resource_group
  ]
}

#AKS CLUSTER
module "kubernetes_cluster" {
  source = "../"
  providers = {
    azurerm.key_vault_sub              = azurerm.key_vault_sub
    azurerm.log_analytics_oms_sub      = azurerm.log_analytics_oms_sub
    azurerm.log_analytics_defender_sub = azurerm.log_analytics_defender_sub
    azurerm.kubernetes_cluster_sub     = azurerm.kubernetes_cluster_sub
    azurerm.private_dns_zone_sub       = azurerm.private_dns_zone_sub
  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on = [module.resource_group, module.resource_group_key_vault, module.resource_group_log_analytics,
    module.key_vault,
    module.log_analytics_workspace, module.user_assigned_identity, module.private_dns_zone, module.vnet, module.subnet
  ]
}
