output "servicebus_namespace_id" {
  value = { for k, v in azurerm_servicebus_namespace.servicebus_namespace : k => v.id }
}

output "servicebus_queue_id" {
  value = { for k, v in azurerm_servicebus_queue.servicebus_queue : k => v.id }
}

output "servicebus_topic_id" {
  value = { for k, v in azurerm_servicebus_topic.servicebus_topic : k => v.id }
}
output "servicebus_subscription_id" {
  value = { for k, v in azurerm_servicebus_subscription.servicebus_subscription : k => v.id }
}
