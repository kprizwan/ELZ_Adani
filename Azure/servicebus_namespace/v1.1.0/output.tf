output "servicebus_namespace_output" {
  description = "Servciebus namespace output values"
  value = [
    for k, v in azurerm_servicebus_namespace.servicebus_namespace :
    {
      id       = azurerm_servicebus_namespace.servicebus_namespace[k].id
      identity = azurerm_servicebus_namespace.servicebus_namespace[k].identity
    }
  ]
}