#Output Eventhub
output "eventhub_output" {
  description = "Outputs the following: ID of Eventhub, Eventhub partition ID's"
  value = { for k, v in azurerm_eventhub.eventhub : k => {
    id            = v.id
    partition_ids = v.partition_ids
    }
  }
}
