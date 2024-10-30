output "logic_app_standard_outputs" {
  description = "logic app standard outputs values"
  value       = module.logic_app_standard.logic_app_standard_outputs
  sensitive   = true
}