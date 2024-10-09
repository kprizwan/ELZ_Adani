output "load_balancer_output" {
  value       = { for k, v in azurerm_lb.load_balancers : k => { id = v.id } }
  description = "Load balancer output values"
}
