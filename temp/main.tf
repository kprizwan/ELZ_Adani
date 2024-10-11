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

provider "azurerm" {
  alias = "management"
  features {}
  use_msi         = true
  skip_provider_registration = true
  subscription_id = "d326a752-74a2-4442-8813-abc9087e7813"
  
}

provider "azurerm" {
  alias = "container_registry_sub"
  features {}
  use_msi         = true
  skip_provider_registration = true
  subscription_id = "d326a752-74a2-4442-8813-abc9087e7813"
  
}
 
provider "azuread" {
  use_msi         = true
}


#KEYVAULT
module "key_vault" {
  source              = "./Modules/key_vault"
  providers = {
    azurerm = azurerm.management
  }
  key_vault_variables = var.key_vault_variables
}

#CONTAINER REGISTRY
module "container_registry" {
  source = "./Modules/container_registry/v1.3.0"
  providers = {
    azurerm.management          = azurerm.management
   azurerm.container_registry_sub = azurerm.container_registry_sub
  }
  container_registry_variables = var.container_registry_variables
  
}

#AKS CLUSTER
module "aks" {
  source                = "./Modules/aks/v1.3.0"
  aks_cluster_variables = var.aks_cluster_variables
}




