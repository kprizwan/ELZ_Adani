#DDOS protection plan
module "ddos_protection_plan" {
  source                         = "../"
  ddos_protection_plan_variables = var.ddos_protection_plan_variables
}