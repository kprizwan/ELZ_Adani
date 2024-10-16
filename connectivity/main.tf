### Connectivity Subscription ########

#RESOURCE GROUP
module "resource_group" {
  source = "../Azure/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  resource_group_variables = var.resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  source = "../Azure/virtual_network/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source = "../Azure/subnet/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#SOURCE VIRTUAL NETWORK PEERING
module "source_virtual_network_peering" {
  source = "../Azure/virtual_network_peering/v1.3.0"
  providers = {
    azurerm.source_virtual_network_sub      = azurerm.connectivity
    azurerm.destination_virtual_network_sub = azurerm.management
  }
  virtual_network_peering_variables = var.source_virtual_network_peering_variables
  depends_on                        = [module.virtual_network]
}

#DESTINATION VIRTUAL NETWORK PEERING
module "destination_virtual_network_peering" {
  source = "../Azure/virtual_network_peering/v1.3.0"
  providers = {
    azurerm.source_virtual_network_sub      = azurerm.management
    azurerm.destination_virtual_network_sub = azurerm.connectivity
  }
  virtual_network_peering_variables = var.destination_virtual_network_peering_variables
  depends_on                        = [module.virtual_network]
}

# NETWORK INTERFACE
module "network_interface" {
  source = "../Azure/network_interface/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.resource_group, module.virtual_network, module.subnet]
}


#PUBLIC IP
module "public_ip" {
  source = "../Azure/public_ip/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}


#APPLICATION GATEWAY
module "application_gateway" {
  source = "../Azure/application_gateway/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  application_gateway_variables = var.application_gateway_variables
  depends_on                    = [module.subnet, module.public_ip]
}


#LINUX VM

module "linux_virtual_machine" {
  source = "../Azure/linux_virtual_machine/v1.3.0"
  providers = {
    azurerm.linux_vm_sub  = azurerm.connectivity
    azurerm.key_vault_sub = azurerm.management
    azurerm.gallery_sub   = azurerm.connectivity
  }
  linux_virtual_machine_variables = var.linux_virtual_machine_variables
  depends_on                      = [module.subnet, module.network_interface]
}


#LB
module "lb" {
  source = "../Azure/lb/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  lb_variables = var.lb_variables
  depends_on   = [module.resource_group, module.virtual_network, module.subnet, module.public_ip]
}

#NAT GATEWAY
module "nat_gateway" {
  source = "../Azure/nat_gateway/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  nat_gateway_variables = var.nat_gateway_variables
  depends_on            = [module.resource_group]
}

#NAT GATEWAY PUBLIC IP ASSOCIATION
module "nat_gateway_public_ip_association" {
  source = "../Azure/nat_gateway_public_ip_association/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  nat_gateway_public_ip_association_variables = var.nat_gateway_public_ip_association_variables
  depends_on                                  = [module.public_ip, module.nat_gateway]
}

#VPN GATEWAY
/*module "vpn_gateway" {
  source                = "../Azure/vpn_gateway/v1.3.0"
  providers = {
    azurerm = azurerm.connectivity
  }
  vpn_gateway_variables = var.vpn_gateway_variables
  //depends_on            = [module.virtual_]
}*/


