#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#KEY VAULT
module "key_vault" {
  source              = "../../../key_vault/v1.2.0"
  key_vault_variables = var.key_vault_variables
  depends_on          = [module.resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  source                            = "../../../key_vault_access_policy/v1.2.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT KEY
module "key_vault_key" {
  source                  = "../../../key_vault_key/v1.2.0"
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy]
}

#RECOVERY SERVICE VAULT 
module "recovery_services_vault" {
  source                            = "../"
  recovery_services_vault_variables = var.recovery_services_vault_variables
  depends_on                        = [module.key_vault_key]
}