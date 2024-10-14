locals {
  is_dedicated_cluster_id = { for k, v in var.eventhub_namespace_variables : k => v if lookup(v, "eventhub_namespace_dedicated_cluster_id", false) == true }
}

data "azurerm_eventhub_cluster" "eventhub_cluster" {
  for_each            = { for k, v in var.eventhub_namespace_variables : k => v if lookup(v, "eventhub_cluster_name", null) != null && lookup(v, "eventhub_cluster_resource_group_name", null) != null }
  name                = each.value.eventhub_cluster_name
  resource_group_name = each.value.eventhub_cluster_resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each             = { for k, v in var.eventhub_namespace_variables : k => v if lookup(v, "eventhub_namespace_subnet_virtual_network_name", null) != null && lookup(v, "eventhub_namespace_subnet_name", null) != null && lookup(v, "eventhub_namespace_subnet_resource_group_name", null) != null }
  virtual_network_name = each.value.eventhub_namespace_subnet_virtual_network_name
  name                 = each.value.eventhub_namespace_subnet_name
  resource_group_name  = each.value.eventhub_namespace_subnet_resource_group_name
}

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  for_each                 = var.eventhub_namespace_variables
  name                     = each.value.eventhub_namespace_name
  location                 = each.value.eventhub_namespace_location
  resource_group_name      = each.value.eventhub_namespace_resource_group_name
  sku                      = each.value.eventhub_namespace_sku
  capacity                 = each.value.eventhub_namespace_capacity
  auto_inflate_enabled     = each.value.eventhub_namespace_auto_inflate_enabled
  dedicated_cluster_id     = each.value.eventhub_namespace_dedicated_cluster_id == null ? null : data.azurerm_eventhub_cluster.eventhub_cluster[each.key].id
  maximum_throughput_units = each.value.eventhub_namespace_maximum_throughput_units
  zone_redundant           = each.value.eventhub_namespace_zone_redundant
  tags                     = merge(each.value.eventhub_namespace_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }

  dynamic "identity" {
    for_each = each.value.eventhub_namespace_identity != null ? toset(each.value.eventhub_namespace_identity) : []

    content {
      type = identity.value.eventhub_namespace_identity_type
    }
  }

  dynamic "network_rulesets" {
    for_each = each.value.eventhub_namespace_network_rulesets != null ? toset(each.value.eventhub_namespace_network_rulesets) : []
    content {
      default_action                 = network_rulesets.value.network_rulesets_default_action
      trusted_service_access_enabled = network_rulesets.value.network_rulesets_trusted_service_access_enabled
      dynamic "virtual_network_rule" {
        for_each = network_rulesets.value.eventhub_namespace_virtual_network_rule == null ? null : toset(network_rulesets.value.eventhub_namespace_virtual_network_rule)
        content {
          subnet_id                                       = data.azurerm_subnet.subnet[each.key].id
          ignore_missing_virtual_network_service_endpoint = virtual_network_rule.value.virtual_network_rule_ignore_missing_virtual_network_service_endpoint
        }
      }
      dynamic "ip_rule" {
        for_each = network_rulesets.value.eventhub_namespace_ip_rule != [] ? toset(network_rulesets.value.eventhub_namespace_ip_rule) : []
        content {
          ip_mask = ip_rule.value.ip_rule_ip_mask
          action  = ip_rule.value.ip_rule_action
        }
      }
    }

  }
}