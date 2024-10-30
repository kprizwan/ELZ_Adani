#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.snapshot_sub
  }
  resource_group_variables = var.resource_group_variables
}

#KEY VAULT RESOURCE GROUP
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}

#STORAGE ACCOUNT RESOURCE GROUP
module "storage_account_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  resource_group_variables = var.storage_account_resource_group_variables
}

#KEY VAULT
module "key_vault" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.key_vault_resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source = "../../../key_vault_access_policy/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT SECRET
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy]
}

#KEY VAULT KEY
module "key_vault_key" {
  source = "../../../key_vault_key/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#STORAGE ACCOUNT
module "storage_account" {
  providers = {
    azurerm.storage_account_sub = azurerm.storage_account_sub
    azurerm.key_vault_sub       = azurerm.key_vault_sub
  }
  source                    = "../../../storage_account/v1.3.0"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.storage_account_resource_group]
}

#STORAGE CONTAINER
module "storage_container" {
  source = "../../../storage_container/v1.3.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  storage_container_variables = var.storage_container_variables
  depends_on                  = [module.storage_account]
}

#STORAGE BLOB
module "storage_blob" {
  source = "../../../storage_blob/v1.3.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  storage_blob_variables = var.storage_blob_variables
  depends_on             = [module.storage_container]
}

#MANAGED DISK
module "managed_disk" {
  source = "../../../managed_disk/v1.3.0"
  providers = {
    azurerm = azurerm.snapshot_sub
  }
  managed_disk_variables = var.managed_disk_variables
  depends_on             = [module.resource_group, module.key_vault_key, module.key_vault_secret, module.storage_blob]
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
  depends_on         = [module.managed_disk]
}
