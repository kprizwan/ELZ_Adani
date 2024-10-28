terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.75.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.mssql_server_sub]
    }
    azuread = {
      source                = "hashicorp/azuread"
      version               = "2.29.0"
      configuration_aliases = [azuread.azuread_tenant_id]
    }
  }
}