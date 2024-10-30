#Resource Group
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

#KEY VAULT
module "key_vault" {
  source              = "../../../key_vault/v1.1.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group]
}

#Postgresql Server
module "postgresql_server" {
  source = "../../../postgresql_server/v1.1.0"
  providers = {
    azurerm.postgresql_server = azurerm
  }
  postgresql_server_variables = var.postgresql_server_variables
  depends_on                  = [module.resource_group, module.key_vault]
}

#Postgresql Database
module "postgresql_database" {
  source                        = "../"
  postgresql_database_variables = var.postgresql_database_variables
  depends_on                    = [module.resource_group, module.postgresql_server]
}