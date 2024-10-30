#SERVICEBUS NAMESPACE OUTPUT
output "servicebus_namespace_output" {
  description = "Servciebus namespace output values"
  value = { for k, v in azurerm_servicebus_namespace.servicebus_namespace : k => {
    id       = v.id
    identity = v.identity
    }
  }
}

