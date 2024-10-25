output "bastion_host_output" {
  value = { for k, v in azurerm_bastion_host.bastion_host : k => {
    id = v.id
    }
  }
  description = "Bastion Host output values"
}