terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
<<<<<<<< HEAD:Azure/traffic_manager_profile/v1.3.0/example/provider.tf
      version = "=3.75.0"
========
      version = "=3.33.0"
>>>>>>>> feature04-connectivity:Azure/traffic_manager_nested_endpoint/v1.2.0/example/provider.tf
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
<<<<<<<< HEAD:Azure/traffic_manager_profile/v1.3.0/example/provider.tf
}
========
}
>>>>>>>> feature04-connectivity:Azure/traffic_manager_nested_endpoint/v1.2.0/example/provider.tf
