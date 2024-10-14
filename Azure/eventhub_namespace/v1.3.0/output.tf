#EVENTHUB NAMESPACE OUTPUT
output "eventhub_namespace_output" {
  description = "eventHub namespace output values"
  value       = { for k, v in azurerm_eventhub_namespace.eventhub_namespace : k => { id = v.id } }
}