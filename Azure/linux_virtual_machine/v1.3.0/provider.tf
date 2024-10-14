terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.75.0"
      configuration_aliases = [azurerm.linux_vm_sub, azurerm.key_vault_sub, azurerm.gallery_sub]
    }
  }
}