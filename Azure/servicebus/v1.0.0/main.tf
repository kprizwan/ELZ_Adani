# locals {
#   is_resourcegroup_exists = { for k, v in var.servicebus_variables : k => v if lookup(v, "is_resource_group_required", false) == true }
# }

resource "azurerm_resource_group" "resource_group" {
  for_each = var.resource_group_variables #local.is_resourcegroup_exists
  name     = each.value.resource_group_name
  location = each.value.location
  tags     = merge(each.value.resource_group_tags)
}

resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  for_each            = var.servicebus_namespace_variables
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  location            = each.value.location
  sku                 = each.value.sku
  capacity            = each.value.capacity
  zone_redundant      = each.value.zone_redundant
  tags                = merge(each.value.servicebus_tags)
  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_servicebus_queue" "servicebus_queue" {
  for_each            = var.servicebus_queue_variables
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  namespace_name      = each.value.namespace_name
  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_servicebus_namespace.servicebus_namespace
  ]
}

resource "azurerm_servicebus_topic" "servicebus_topic" {
  for_each            = var.servicebus_topic_variables
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  namespace_name      = each.value.namespace_name
  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_servicebus_namespace.servicebus_namespace
  ]
}

resource "azurerm_servicebus_subscription" "servicebus_subscription" {
  for_each            = var.servicebus_subscription_variables
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  namespace_name      = each.value.namespace_name
  topic_name          = each.value.topic_name
  max_delivery_count  = each.value.max_delivery_count
  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_servicebus_namespace.servicebus_namespace,
    azurerm_servicebus_topic.servicebus_topic
  ]
}

# resource "azurerm_management_lock" "management_lock_servicebus_namespace" {
#   name                 = var.servicebus_namespace_lock_name
#   scope                = azurerm_servicebus_namespace.servicebus_namespace[each.key].id
#   lock_level           = var.servicebus_namespace_lock_level
#   notes                = var.servicebus_namespace_lock_notes
# }