#Load Balancer Rule Output
output "load_balancer_rule_output" {
  description = "Load Balancer Rule Output Values"
  value = { for k, v in azurerm_lb_rule.load_balancer_rule : k => {
    id = v.id
    }
  }
}