#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

#Recovery Service Vault
module "recovery_services_vault" {
  source                            = "../"
  recovery_services_vault_variables = var.recovery_services_vault_variables
  depends_on                        = [module.resource_group]
}
