terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
<<<<<<<< HEAD:Azure/eventhub/v1.3.0/provider.tf
      version = "3.75.0"
========
      version = "=3.33.0"
>>>>>>>> feature04-connectivity:Azure/servicebus_namespace/recovery_services_vault/v1.2.0/provider.tf
    }
  }
}