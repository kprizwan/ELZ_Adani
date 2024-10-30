#RESOURCE GROUP

module "resource_group" {
  source                   = "../../../resource_group/v1.0.0"
  resource_group_variables = var.resource_group_variables
}

module "servicebus" {
  source               = "../"
  servicebus_variables = var.servicebus_variables
  depends_on = [
    module.resource_group
  ]
}
