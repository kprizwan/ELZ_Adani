#RESOURCE GROUP FOR SOURCE VIRTUAL NETWORK
module "source_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.source_virtual_network_sub
  }
  resource_group_variables = var.resource_group_variables_source
}

#RESOURCE GROUP FOR DESTINATION VIRTUAL NETWORK
module "destination_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.destination_virtual_network_sub
  }
  resource_group_variables = var.resource_group_variables_destination
}

#DDOS PROTECTION PLAN
/* module "network_ddos_protection_plan" {
  providers = {
    azurerm = azurerm.source_virtual_network_sub
  }
  source                                 = "../../../network_ddos_protection_plan/v1.3.0"
  network_ddos_protection_plan_variables = var.network_ddos_protection_plan_variables
  depends_on                             = [module.source_resource_group]
} */

#SOURCE VIRTUAL NETWORK
module "source_virtual_network" {
  providers = {
    azurerm = azurerm.source_virtual_network_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables_source
  depends_on                = [module.source_resource_group]
}

#DESTINATION VIRTUAL NETWORK
module "destination_virtual_network" {
  providers = {
    azurerm = azurerm.destination_virtual_network_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables_destination
  depends_on                = [module.destination_resource_group]
}

#SOURCE VIRTUAL NETWORK PEERING
module "source_virtual_network_peering" {
  source = "../"
  providers = {
    azurerm.source_virtual_network_sub      = azurerm.source_virtual_network_sub
    azurerm.destination_virtual_network_sub = azurerm.destination_virtual_network_sub
  }
  virtual_network_peering_variables = var.source_virtual_network_peering_variables
  depends_on                        = [module.source_virtual_network, module.destination_virtual_network]
}

#DESTINATION VIRTUAL NETWORK PEERING
module "destination_virtual_network_peering" {
  source = "../"
  providers = {
    azurerm.source_virtual_network_sub      = azurerm.destination_virtual_network_sub
    azurerm.destination_virtual_network_sub = azurerm.source_virtual_network_sub
  }
  virtual_network_peering_variables = var.destination_virtual_network_peering_variables
  depends_on                        = [module.source_virtual_network, module.destination_virtual_network]
}