output "snapshot_output" {
  value       = { for k, v in azurerm_snapshot.snapshot : k => { id = v.id } }
  description = "snapshot output values"
}