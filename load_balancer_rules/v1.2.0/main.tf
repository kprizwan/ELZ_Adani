locals {
  backend_address_pool_list = flatten([for k, v in var.load_balancer_rule_variables : formatlist("%s#%s", k, v.load_balancer_rule_backend_pool_names)])
}

locals {
  backend_address_pool_ids_final = { for k, v in data.azurerm_lb_backend_address_pool.backend_address_pool : element(split("#", k), 0) => v.id... }
}

data "azurerm_lb" "load_balancer" {
  for_each            = var.load_balancer_rule_variables
  name                = each.value.load_balancer_rule_load_balancer_name
  resource_group_name = each.value.load_balancer_rule_load_balancer_resource_group_name
}

data "azurerm_lb_backend_address_pool" "backend_address_pool" {
  for_each        = { for v in local.backend_address_pool_list : v => element(split("#", v), 1)... }
  name            = each.value[0]
  loadbalancer_id = data.azurerm_lb.load_balancer[element(split("#", each.key), 0)].id
}


resource "azurerm_lb_rule" "load_balancer_rule" {
  for_each                       = var.load_balancer_rule_variables
  name                           = each.value.load_balancer_rule_name
  loadbalancer_id                = data.azurerm_lb.load_balancer[each.key].id
  protocol                       = each.value.load_balancer_rule_protocol == null ? "Tcp" : each.value.load_balancer_rule_protocol
  frontend_port                  = each.value.load_balancer_rule_frontend_port
  backend_port                   = each.value.load_balancer_rule_backend_port
  frontend_ip_configuration_name = each.value.load_balancer_rule_frontend_ip_configuration_name
  backend_address_pool_ids       = local.backend_address_pool_ids_final[each.key]
  probe_id                       = each.value.load_balancer_rule_probe_name == null ? null : "/subscriptions/${each.value.load_balancer_rule_load_balancer_subscription_id}/resourceGroups/${each.value.load_balancer_rule_load_balancer_resource_group_name}/providers/Microsoft.Network/loadBalancers/${each.value.load_balancer_rule_load_balancer_name}/probes/${each.value.load_balancer_rule_probe_name}"
  load_distribution              = each.value.load_balancer_rule_load_distribution
  idle_timeout_in_minutes        = each.value.load_balancer_rule_idle_timeout_in_minutes
  enable_floating_ip             = each.value.load_balancer_rule_enable_floating_ip
  disable_outbound_snat          = each.value.load_balancer_rule_disable_outbound_snat
  enable_tcp_reset               = each.value.load_balancer_rule_enable_tcp_reset
}

