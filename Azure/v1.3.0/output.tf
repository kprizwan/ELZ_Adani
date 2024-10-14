#EVENTHUB OUTPUT
output "eventhub_output" {
  description = "eventhub output values"
  value = { for k, v in azurerm_eventhub.eventhub : k => {
    id            = v.id
    partition_ids = v.partition_ids
    }
  }
}