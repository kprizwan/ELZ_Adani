output "eventhub_namespace_output" {
  description = "EventHub Namespace output values"
  value       = { for k, v in azurerm_eventhub_namespace.eventhub_namespace : k => { id = v.id } }
}