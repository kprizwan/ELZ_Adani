terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

# CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  alias = "keyvault_sub"
  features {}
  use_msi         = false
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}

provider "azurerm" {
  alias = "log_analytics_oms_sub"
  features {}
  use_msi         = false
  subscription_id = var.log_analytics_oms_subscription_id
  tenant_id       = var.log_analytics_oms_tenant_id
}

provider "azurerm" {
  alias = "log_analytics_defender_sub"
  features {}
  use_msi         = false
  subscription_id = var.log_analytics_defender_subscription_id
  tenant_id       = var.log_analytics_defender_tenant_id
}

provider "azurerm" {
  alias = "kubernetes_cluster_sub"
  features {}
  use_msi         = false
  subscription_id = var.kubernetes_cluster_subscription_id
  tenant_id       = var.kubernetes_cluster_tenant_id
}

provider "azurerm" {
  alias = "private_dns_zone_sub"
  features {}
  use_msi         = false
  subscription_id = var.private_dns_zone_subscription_id
  tenant_id       = var.private_dns_zone_tenant_id
}

provider "azurerm" {
  alias = "user_assigned_identity_sub"
  features {}
  use_msi         = false
  subscription_id = var.user_assigned_identity_subscription_id
  tenant_id       = var.user_assigned_identity_tenant_id
}
provider "azurerm" {
  alias = "ingress_application_gateway_sub"
  features {}
  use_msi         = false
  subscription_id = var.ingress_application_gateway_subscription_id
  tenant_id       = var.ingress_application_gateway_tenant_id
}