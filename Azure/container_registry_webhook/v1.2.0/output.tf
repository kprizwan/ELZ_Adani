#container_registry_webhook_output
output "container_registry_webhook_output" {
  value = { for k, v in azurerm_container_registry_webhook.container_registry_webhook : k => {
    id = v.id
    }
  }
  description = "container registry webhook output values"
}
