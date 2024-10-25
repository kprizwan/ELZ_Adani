#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg00001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SERVICEBUS
servicebus_variables = {
  "servicebus" = {
    resource_group_name = "ploceusrg00001"
    name                = "ploceussbnamespace000001"
    location            = "westus2"
    sku                 = "Premium"
    capacity            = "4"
    zone_redundant      = true
    local_auth_enabled  = true # Defaults to true
    queue_name          = "ploceussbqueue000001"
    namespace_name      = "servicebus"
    topic_name          = "ploceussbtopic000001"
    topic_id            = "servicebus"
    subscription_name   = "ploceussbsubscription000001"
    max_delivery_count  = "4"
    servicebus_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
