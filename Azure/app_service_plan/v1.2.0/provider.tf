<<<<<<<< HEAD:Azure/key_vault/v1.3.0/provider.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}
========
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.33.0"
    }
  }
}
>>>>>>>> feature04-connectivity:Azure/app_service_plan/v1.2.0/provider.tf
