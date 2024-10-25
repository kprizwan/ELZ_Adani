#Output #MySql Database
output "snapshot_ids" {
  value       = module.snapshot.snapshot_ids
  description = "Snapshot ids"
}