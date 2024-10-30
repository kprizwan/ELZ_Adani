#SERVICEBUS NAMESPACE OUTPUT
output "servicebus_namespace_output" {
  description = "Servciebus namespace output values"
  value       = module.servicebus_namespace.servicebus_namespace_output
}
