terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.75.0"
    }
     azuread = {
      source  = "hashicorp/azuread"
      version = "2.29.0"
    }
}
}
# subscription 1 - Management
provider "azurerm" {
  alias = "management"
  features {}
  use_msi         = true
  skip_provider_registration = true
  subscription_id = "d326a752-74a2-4442-8813-abc9087e7813"
  
}
# subscription 2 - Connectivity
provider "azurerm" {
  alias = "connectivity"
  features {}
  use_msi         = true
  skip_provider_registration = true
  subscription_id = "4d4b41f0-5e56-49da-9bc1-713a4a21ddf1"  
}

provider "azuread" {
  use_msi         = true
}

terraform {
  backend "azurerm" {
    use_msi = true
 
  }
}

#KEYVAULT
/*module "key_vault" {
  source              = "./Modules/key_vault"
  providers = {
    azurerm = azurerm.management
  }
  key_vault_variables = var.key_vault_variables
}*/

#PRIVATE DNS ZONE
/*module "private_dns_zone" {
  source = "./Modules/private_dns_zone/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.key_vault]
}*/

#PRIVATE ENDPOINT
/*module "private_endpoint" {
  source = "./Modules/private_endpoint/v1.3.0"
  providers = {
    azurerm.private_connection_sub = azurerm.management
    azurerm.private_dns_zone_sub = azurerm.management
    azurerm.private_endpoint_sub = azurerm.management  
  }
  private_endpoint_variables = var.private_endpoint_variables
  depends_on                 = [module.key_vault, module.private_dns_zone]
}*/

#CONTAINER REGISTRY
/*module "container_registry" {
  source = "./Modules/container_registry/v1.3.0"
  providers = {
    azurerm.key_vault_sub          = azurerm.management
    azurerm.container_registry_sub = azurerm.management
  }
  container_registry_variables = var.container_registry_variables
  depends_on                 = [module.private_endpoint]
}

#AKS CLUSTER
module "kubernetes_cluster"  {
  source                = "./Modules/kubernetes_cluster/v1.3.0"
  providers = {
    azurerm.keyvault_sub = azurerm.management
    azurerm.log_analytics_oms_sub = azurerm.management
    azurerm.log_analytics_defender_sub = azurerm.management
    azurerm.kubernetes_cluster_sub = azurerm.management
    azurerm.private_dns_zone_sub = azurerm.management
    azurerm.user_assigned_identity_sub = azurerm.management
    azurerm.ingress_application_gateway_sub = azurerm.management
    
  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on                 = [module.private_endpoint]
}*/

### Connectivity Subscription ########

#RESOURCE GROUP
module "resource_group" {
  source                   = "./Modules/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  resource_group_variables = var.resource_group_variables
}

