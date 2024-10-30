#Output
output "ddos_protection_plan_id" {
  value = { for k, v in azurerm_network_ddos_protection_plan.ddos_protection_plan : k => v.id }
}

output "ddos_protection_plan_name" {
  value = { for k, v in azurerm_network_ddos_protection_plan.ddos_protection_plan : k => v.id }
}