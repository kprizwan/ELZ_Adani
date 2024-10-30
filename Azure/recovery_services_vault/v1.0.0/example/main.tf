#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

#Recovery Service Vault
module "recoveryservicevault" {
  source                          = "../"
  recovery_service_vault_variable = var.recovery_service_vault_variable
  depends_on                      = [module.resource_group]
}
