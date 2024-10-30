#RESOURCE GROUP
resource_group_variables = {
  "resource_group_5" = {
    resource_group_name = "ploceusrg000001"
    location            = "westus2"
    resource_group_tags = { Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SERVICEBUS
servicebus_namespace_variables = {
  "servicebus_2" = {
    resource_group_name = "ploceusrg000001"
    name                = "ploceussb000001"
    location            = "westus2"
    sku                 = "premium"
    capacity            = "4"
    zone_redundant      = true
    servicebus_tags = { Created_By = "Ploceus",
      Department = "CIS"
    }
    # servicebus_namespace_lock_name             = "Do_not_delete"
    # servicebus_namespace_lock_level            = "CanNotDelete"
    # servicebus_namespace_lock_notes            = "SE-Pattern"
  }
}

servicebus_queue_variables = {
  "servicebus_queue_1" = {
    resource_group_name = "ploceusrg000001"
    name                = "queue"
    namespace_name      = "ploceussb000001"
  }
}

servicebus_topic_variables = {
  "service_topic_1" = {
    resource_group_name = "ploceusrg000001"
    name                = "topic"
    namespace_name      = "ploceussb000001"
  }
}

servicebus_subscription_variables = {
  "service_subscription_1" = {
    resource_group_name = "ploceusrg000001"
    name                = "subscription"
    namespace_name      = "ploceussb000001"
    topic_name          = "topic"
    max_delivery_count  = "4"

  }
}

# # RESOURCE LOCK
# servicebus_namespace_lock_name             = "Delete_lock_for_namespace"
# # servicebus_namespace_lock_scope            = "azurerm_servicebus_namespace.namespace.id"
# servicebus_namespace_lock_level            = "CanNotDelete"
# servicebus_namespace_lock_notes            = "Neuron_test"
