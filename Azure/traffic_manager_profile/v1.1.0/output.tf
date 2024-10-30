output "traffic_manager_profile_ids" {
  value       = { for k, v in azurerm_traffic_manager_profile.traffic_manager_profile : k => v.id }
  description = "Created azure traffic manager profile(s) output id(s)"
}
