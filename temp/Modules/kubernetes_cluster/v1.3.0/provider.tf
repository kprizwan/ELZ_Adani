terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.75.0"
      configuration_aliases = [azurerm.keyvault_sub, azurerm.log_analytics_oms_sub, azurerm.log_analytics_defender_sub, azurerm.kubernetes_cluster_sub, azurerm.private_dns_zone_sub, azurerm.user_assigned_identity_sub, azurerm.ingress_application_gateway_sub]
    }
  }
}
