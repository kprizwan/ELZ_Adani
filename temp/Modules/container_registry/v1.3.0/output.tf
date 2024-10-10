# CONTAINER REGISTRY OUTPUT
output "container_registry_output" {
  value = { for k, v in azurerm_container_registry.container_registry : k => {
    id = v.id
    }
  }
  description = "Azure container registry output values"
}