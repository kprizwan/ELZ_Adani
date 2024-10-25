module "servicebus" {
  source                            = "../"
  resource_group_variables          = var.resource_group_variables
  servicebus_namespace_variables    = var.servicebus_namespace_variables
  servicebus_queue_variables        = var.servicebus_queue_variables
  servicebus_topic_variables        = var.servicebus_topic_variables
  servicebus_subscription_variables = var.servicebus_subscription_variables
}