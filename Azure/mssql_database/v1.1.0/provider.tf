terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.storage_account_sub, azurerm.mssql_server_sub]
    }
  }
}