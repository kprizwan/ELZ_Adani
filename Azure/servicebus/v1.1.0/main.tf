resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  for_each            = var.servicebus_variables
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  location            = each.value.location
  sku                 = each.value.sku
  capacity            = each.value.capacity
  local_auth_enabled  = each.value.local_auth_enabled
  zone_redundant      = each.value.zone_redundant
  tags                = merge(each.value.servicebus_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}

resource "azurerm_servicebus_queue" "servicebus_queue" {
  for_each     = var.servicebus_variables
  name         = each.value.queue_name
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace[each.value.namespace_name].id
}

resource "azurerm_servicebus_topic" "servicebus_topic" {
  for_each     = var.servicebus_variables
  name         = each.value.topic_name
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace[each.value.namespace_name].id
}

resource "azurerm_servicebus_subscription" "servicebus_subscription" {
  for_each           = var.servicebus_variables
  name               = each.value.subscription_name
  topic_id           = azurerm_servicebus_topic.servicebus_topic[each.value.topic_id].id
  max_delivery_count = each.value.max_delivery_count
}
