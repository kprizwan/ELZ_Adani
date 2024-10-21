#RESOURCE GROUP
module "resource_group" {
  source = "../Azure/resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.stage_env
  }
  resource_group_variables = var.resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  source = "../Azure/virtual_network/v1.3.0"
  providers = {
    azurerm = azurerm.stage_env
  }
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source = "../Azure/subnet/v1.3.0"
  providers = {
    azurerm = azurerm.stage_env
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#AKS CLUSTER
module "kubernetes_cluster" {
  source = "../Azure/kubernetes_cluster/v1.3.0"
  providers = {
    azurerm.keyvault_sub                    = azurerm.stage_env
    azurerm.log_analytics_oms_sub           = azurerm.stage_env
    azurerm.log_analytics_defender_sub      = azurerm.stage_env
    azurerm.kubernetes_cluster_sub          = azurerm.stage_env
    azurerm.private_dns_zone_sub            = azurerm.stage_env
    azurerm.user_assigned_identity_sub      = azurerm.stage_env
    azurerm.ingress_application_gateway_sub = azurerm.stage_env

  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on                   = [module.resource_group, module.subnet]
}


#SOURCE VIRTUAL NETWORK PEERING
/*module "source_virtual_network_peering" {
  source = "../Azure/virtual_network_peering/v1.3.0"
  providers = {
    azurerm.source_virtual_network_sub      = azurerm.connectivity
    azurerm.destination_virtual_network_sub = azurerm.stage_env
  }
  virtual_network_peering_variables = var.source_virtual_network_peering_variables
  depends_on                        = [module.virtual_network]
}

#DESTINATION VIRTUAL NETWORK PEERING
module "destination_virtual_network_peering" {
  source = "../Azure/virtual_network_peering/v1.3.0"
  providers = {
    azurerm.source_virtual_network_sub      = azurerm.stage_env
    azurerm.destination_virtual_network_sub = azurerm.connectivity
  }
  virtual_network_peering_variables = var.destination_virtual_network_peering_variables
  depends_on                        = [module.virtual_network]
}


#PRIVATE DNS ZONE
/*module "private_dns_zone" {
  source = "../Azure/private_dns_zone/v1.3.0"
  providers = {
    azurerm = azurerm.stage_env
  }
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.key_vault]
}
*/

#PRIVATE ENDPOINT
/*module "private_endpoint" {
  source = "../Azure/private_endpoint/v1.3.0"
  providers = {
    azurerm.private_connection_sub = azurerm.stage_env
    azurerm.private_dns_zone_sub   = azurerm.stage_env
    azurerm.private_endpoint_sub   = azurerm.stage_env
  }
  private_endpoint_variables = var.private_endpoint_variables
  depends_on                 = [module.key_vault, module.private_dns_zone]
}*/




