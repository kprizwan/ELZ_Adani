#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

#NETWORK WATCHER
module "network_watcher" {
  source                    = "../"
  network_watcher_variables = var.network_watcher_variables
  depends_on                = [module.resource_group]
}











