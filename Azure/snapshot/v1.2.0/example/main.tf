#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.snapshot_sub
  }
  resource_group_variables = var.resource_group_variables

}

#MANAGED dISK
module "managed_disk" {
  source = "../../../managed_disk/v1.2.0"
  providers = {
    azurerm = azurerm.snapshot_sub
  }
  managed_disk_variables = var.managed_disk_variables
  depends_on             = [module.resource_group]
}

#SNAPSHOT
module "snapshot" {
  source = "../"
  providers = {
    azurerm.snapshot_sub        = azurerm.snapshot_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
    azurerm.storage_account_sub = azurerm.storage_account_sub
  }
  snapshot_variables = var.snapshot_variables
  depends_on = [
    module.managed_disk
  ]
}