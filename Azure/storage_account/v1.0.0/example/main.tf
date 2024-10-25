#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

#STORAGE ACCOUNT FOR ML
module "storage_account" {
  source                    = "../"
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.resource_group]
}
