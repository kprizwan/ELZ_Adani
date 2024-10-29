#ROUTE TABLE OUTPUT
output "route_table_output" {
  value       = module.route_table.route_table_output
  description = "Route Tables Output values"
}