# eventhub output
output "eventhub_output" {
  description = "Eventhub output values"
  value = { for k, v in azurerm_eventhub.eventhub : k => {
    id            = v.id
    partition_ids = v.partition_ids
    }
  }
}