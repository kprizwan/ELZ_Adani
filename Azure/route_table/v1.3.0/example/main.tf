#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#ROUTE TABLE
module "route_table" {
  source                = "../"
  route_table_variables = var.route_table_variables
  depends_on = [
    module.resource_group
  ]
}