#Load Balancer Rule Output
output "load_balancer_rule_output" {
  description = "Load Balancer Rule Output Values"
  value       = module.load_balancer_rules.load_balancer_rule_output
}