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

#PRIVATE DNS ZONE
module "private_dns_zone" {
  source = "./Modules/private_dns_zone/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.key_vault]
}

#PRIVATE ENDPOINT
module "private_endpoint" {
  source = "./Modules/private_endpoint/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  private_endpoint_variables = var.private_endpoint_variables
  depends_on                 = [module.key_vault, module.private_dns_zone]
}
