output "eventhub_namespace_ids" {
  value = { for k, v in azurerm_eventhub_namespace.eventhub_namespace : k => v.id }
}

