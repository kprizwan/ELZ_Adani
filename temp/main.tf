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
  alias = "connectivity"
  features {}
  use_msi         = true
  skip_provider_registration = true
  subscription_id = "4d4b41f0-5e56-49da-9bc1-713a4a21ddf1" 
  
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
  source = "../"
  providers = {
    azurerm.management          = azurerm.management
  }
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.subnet, module.key_vault_key]
}




