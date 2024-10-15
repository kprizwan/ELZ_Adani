#KEYVAULT
module "key_vault" {
  source = "../Azure/key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  key_vault_variables = var.key_vault_variables
}

#PRIVATE DNS ZONE
module "private_dns_zone" {
  source = "../Azure/private_dns_zone/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.key_vault]
}

#PRIVATE ENDPOINT
module "private_endpoint" {
  source = "../Azure/private_endpoint/v1.3.0"
  providers = {
    azurerm.private_connection_sub = azurerm.management
    azurerm.private_dns_zone_sub   = azurerm.management
    azurerm.private_endpoint_sub   = azurerm.management
  }
  private_endpoint_variables = var.private_endpoint_variables
  depends_on                 = [module.key_vault, module.private_dns_zone]
}

#CONTAINER REGISTRY
module "container_registry" {
  source = "../Azure/container_registry/v1.3.0"
  providers = {
    azurerm.key_vault_sub          = azurerm.management
    azurerm.container_registry_sub = azurerm.management
  }
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.private_endpoint]
}

#EVENTHUB NAMESPACE
module "eventhub_namespace" {
  source = "../Azure/eventhub_namespace/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  eventhub_namespace_variables = var.eventhub_namespace_variables
}

#EVENTHUB
module "eventhub" {
  source = "../Azure/eventhub/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  eventhub_variables = var.eventhub_variables
  depends_on         = [module.eventhub_namespace]
}

#AKS CLUSTER
module "kubernetes_cluster" {
  source = "../Azure/kubernetes_cluster/v1.3.0"
  providers = {
    azurerm.keyvault_sub                    = azurerm.management
    azurerm.log_analytics_oms_sub           = azurerm.management
    azurerm.log_analytics_defender_sub      = azurerm.management
    azurerm.kubernetes_cluster_sub          = azurerm.management
    azurerm.private_dns_zone_sub            = azurerm.management
    azurerm.user_assigned_identity_sub      = azurerm.management
    azurerm.ingress_application_gateway_sub = azurerm.management

  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on                   = [module.key_vault, module.container_registry]
}

