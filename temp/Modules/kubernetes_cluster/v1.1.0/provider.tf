terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.log_analytics_oms_sub, azurerm.log_analytics_defender_sub, azurerm.kubernetes_cluster_sub, azurerm.private_dns_zone_sub]
    }
  }
}
