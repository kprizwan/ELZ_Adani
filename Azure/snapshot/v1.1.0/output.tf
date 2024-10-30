output "snapshot_ids" {
  value       = { for k, v in azurerm_snapshot.snapshot : k => v.id }
  description = "snapshot ids"
}