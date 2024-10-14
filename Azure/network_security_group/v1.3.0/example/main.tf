#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#APPLICATION SECURITY GROUP
module "application_security_group" {
  source                               = "../../../application_security_group/v1.3.0"
  application_security_group_variables = var.application_security_group_variables
  depends_on                           = [module.resource_group]
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  source                           = "../"
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.application_security_group]
}
