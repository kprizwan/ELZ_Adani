output "load_balancer_probe_output" {
  description = "Load Balancer Probe output values"
  value = { for k, v in azurerm_lb_probe.load_balancer_probe : k => {
    id = v.id
    }
  }
}