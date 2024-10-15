output "az_public_ip_address" {
  description = "The address of the newly created Public IP"
  value       = zipmap(values(azurerm_public_ip.public_ip)[*].ip_address, values(azurerm_public_ip.public_ip)[*].id)
}