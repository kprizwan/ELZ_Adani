output "logic_app_standard_ids" {
  description = "The ID of the logic app standard"
  value       = { for k, v in azurerm_logic_app_standard.logic_app_standard : k => v.id }
}