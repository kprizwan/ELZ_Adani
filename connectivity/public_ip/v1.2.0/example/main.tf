#RESOURCE GROUP for Linux VMs
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}
#DDOS protection plan
module "network_ddos_protection_plan" {
  source                                 = "../../../network_ddos_protection_plan/v1.2.0"
  network_ddos_protection_plan_variables = var.network_ddos_protection_plan_variables
  depends_on = [
    module.resource_group
  ]
}
#Public IP
module "public_ip" {
  source              = "../../../public_ip/v1.2.0"
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group, module.network_ddos_protection_plan]
}
