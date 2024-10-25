#SNAPSHOT OUTPUT VALUES
output "snapshot_output" {
  value = { for k, v in azurerm_snapshot.snapshot : k => {
    id                     = v.id
    disk_size_gb           = v.disk_size_gb
    trusted_launch_enabled = v.trusted_launch_enabled
  } }
  description = "snapshot output values"
}