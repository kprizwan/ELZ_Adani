#EVENTHUB NAMESPACE OUTPUT
output "eventhub_namespace_output" {
  description = "eventhub namespace output values"
  value       = module.eventhub_namespace.eventhub_namespace_output
}