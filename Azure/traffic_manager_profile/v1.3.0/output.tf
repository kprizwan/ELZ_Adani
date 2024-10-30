#TRAFFIC MANAGER PROFILE OUTPUT
output "traffic_manager_profile_output" {
  value = { for k, v in azurerm_traffic_manager_profile.traffic_manager_profile : k => {
    id   = v.id
    fqdn = v.fqdn
  } }
  description = "Traffic Manager Profile Output Values"
}