output "loadbalancer_backendpool_output" {
  value = { for k, v in azurerm_lb_backend_address_pool.backend_address_pool : k => {
    id = v.id
    }
  }
  description = "Loadbalancer backendpools output values"
}