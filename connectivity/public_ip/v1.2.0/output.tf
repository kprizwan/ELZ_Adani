#Public IP Outputs
output "public_ip_output" {
  value = { for k, v in azurerm_public_ip.public_ip : k => {
    id         = v.id
    ip_address = v.ip_address
    fqdn = v.fqdn }
  }
  description = "Public IP outputs"
}