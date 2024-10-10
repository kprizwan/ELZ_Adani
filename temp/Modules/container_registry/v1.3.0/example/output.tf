#CONTAINER REGISTRY OUTPUT
output "container_registry_output" {
  value       = module.container_registry.container_registry_output
  description = "Azure container registry output values"
}