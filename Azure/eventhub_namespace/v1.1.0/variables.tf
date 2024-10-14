variable "eventhub_namespace_variables" {
  description = "eventhub namespace variables"
  type = map(object({
    eventhub_namespace_name                        = string
    eventhub_namespace_location                    = string
    eventhub_namespace_resource_group_name         = string
    eventhub_namespace_tags                        = map(string)
    eventhub_namespace_sku                         = string
    eventhub_namespace_capacity                    = number
    eventhub_namespace_auto_inflate_enabled        = string
    eventhub_namespace_dedicated_cluster_id        = string
    eventhub_namespace_identity                    = string
    eventhub_namespace_maximum_throughput_units    = number
    eventhub_namespace_zone_redundant              = string
    eventhub_cluster_name                          = string
    eventhub_cluster_resource_group_name           = string
    eventhub_namespace_subnet_name                 = string
    eventhub_namespace_subnet_resource_group_name  = string
    eventhub_namespace_subnet_virtual_network_name = string

    eventhub_namespace_identity = list(object({
      eventhub_namespace_identity_type = string
    }))
    eventhub_namespace_network_rulesets = list(object({
      eventhub_namespace_default_action = string
      trusted_service_access_enabled    = bool

    }))
    eventhub_namespace_virtual_network_rule = list(object({
      eventhub_namespace_subnet_id                    = string
      ignore_missing_virtual_network_service_endpoint = string
    }))
    eventhub_namespace_ip_rule = list(object({
      ip_rule_ip_mask = string
      ip_rule_action  = string
    }))

  }))
}