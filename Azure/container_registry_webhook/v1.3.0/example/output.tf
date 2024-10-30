#CONTAINER REGISTRY WEBHOOK OUTPUT
output "container_registry_webhook_output" {
  value       = module.container_registry_webhook.container_registry_webhook_output
  description = "container registry webhook output values"
}
