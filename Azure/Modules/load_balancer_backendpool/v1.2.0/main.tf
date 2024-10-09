data "azurerm_lb" "load_balancer" {
  for_each            = var.load_balancer_backendpool_variables
  name                = each.value.load_balancer_name
  resource_group_name = each.value.load_balancer_resource_group_name
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  for_each        = var.load_balancer_backendpool_variables
  name            = each.value.load_balancer_backendpool_name
  loadbalancer_id = data.azurerm_lb.load_balancer[each.key].id
  dynamic "tunnel_interface" {
    for_each = each.value.load_balancer_backendpool_tunnel_interface_required == true ? each.value.load_balancer_backendpool_tunnel_interface_variables : {}
    content { # optional block tunnel interface which works only with gateway LB please comment out these values or pass null incase of other LB SKu's 
      identifier = tunnel_interface.value.load_balancer_backendpool_tunnel_interface_identifier
      type       = tunnel_interface.value.load_balancer_backendpool_tunnel_interface_type
      protocol   = tunnel_interface.value.load_balancer_backendpool_tunnel_interface_protocol
      port       = tunnel_interface.value.load_balancer_backendpool_tunnel_interface_port
    }
  }
}
