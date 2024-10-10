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
  alias = "Managment"
  features {}
  use_msi         = true
  subscription_id = "d326a752-74a2-4442-8813-abc9087e7813"
  tenant_id       = "5ee36159-43e4-4b5d-a15b-076176333df1"
}
 
provider "azurerm" {
  alias = "connectivity"
  features {}
  use_msi         = true
  subscription_id = ""
  tenant_id       = "5ee36159-43e4-4b5d-a15b-076176333df1"
}
provider "azuread" {
  tenant_id = "5ee36159-43e4-4b5d-a15b-076176333df1"
}

#KEYVAULT
module "key_vault" {
  source              = "./Modules/key_vault"
  providers = {
    azurerm = azurerm.Managment
  }
  key_vault_variables = var.key_vault_variables
}
