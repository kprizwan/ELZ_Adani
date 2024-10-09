#LINUX VIRTUAL MACHINE OUTPUT
output "linux_virtual_machine_output" {
  value = { for k, v in azurerm_linux_virtual_machine.linux_virtual_machine : k => {
    id                   = v.id
    virtual_machine_id   = v.virtual_machine_id
    private_ip_addresses = v.private_ip_addresses
    public_ip_addresses  = v.public_ip_addresses
    identity             = v.identity
    private_ip_address   = v.private_ip_address
    public_ip_address    = v.public_ip_address
    }
  }
}