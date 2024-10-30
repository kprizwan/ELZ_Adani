#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables

}

#MANAGED dISK
module "managed_disk" {
  source                 = "../../../managed_disk/v1.1.0"
  managed_disk_variables = var.managed_disk_variables
  depends_on             = [module.resource_group]
}

#SNAPSHOT
module "snapshot" {
  source             = "../"
  snapshot_variables = var.snapshot_variables
  depends_on = [
    module.managed_disk
  ]
}