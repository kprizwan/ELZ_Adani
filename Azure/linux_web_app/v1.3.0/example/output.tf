#LINUX WEB APP OUTPUT
output "linux_web_app_output" {
  value       = module.linux_web_app.linux_web_app_output
  description = "Linux Web App output"
  sensitive   = true
}