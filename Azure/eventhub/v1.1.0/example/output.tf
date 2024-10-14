#Eventhub ID's
output "eventhub_output" {
  value       = module.eventhub.eventhub_output
  description = "Outputs the following: ID of Eventhub, Eventhub partition ID's"
}