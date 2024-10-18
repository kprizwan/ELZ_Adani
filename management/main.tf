#KEYVAULT
module "key_vault" {
  source = "../Azure/key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  key_vault_variables = var.key_vault_variables
}

#PRIVATE DNS ZONE
module "private_dns_zone" {
  source = "../Azure/private_dns_zone/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  private_dns_zone_variables = var.private_dns_zone_variables
  depends_on                 = [module.key_vault]
}

#PRIVATE ENDPOINT
module "private_endpoint" {
  source = "../Azure/private_endpoint/v1.3.0"
  providers = {
    azurerm.private_connection_sub = azurerm.management
    azurerm.private_dns_zone_sub   = azurerm.management
    azurerm.private_endpoint_sub   = azurerm.management
  }
  private_endpoint_variables = var.private_endpoint_variables
  depends_on                 = [module.key_vault, module.private_dns_zone]
}

#CONTAINER REGISTRY
module "container_registry" {
  source = "../Azure/container_registry/v1.3.0"
  providers = {
    azurerm.key_vault_sub          = azurerm.management
    azurerm.container_registry_sub = azurerm.management
  }
  container_registry_variables = var.container_registry_variables
  depends_on                   = [module.private_endpoint]
}

#AKS CLUSTER
module "kubernetes_cluster" {
  source = "../Azure/kubernetes_cluster/v1.3.0"
  providers = {
    azurerm.keyvault_sub                    = azurerm.management
    azurerm.log_analytics_oms_sub           = azurerm.management
    azurerm.log_analytics_defender_sub      = azurerm.management
    azurerm.kubernetes_cluster_sub          = azurerm.management
    azurerm.private_dns_zone_sub            = azurerm.management
    azurerm.user_assigned_identity_sub      = azurerm.management
    azurerm.ingress_application_gateway_sub = azurerm.management

  }
  kubernetes_cluster_variables = var.kubernetes_cluster_variables
  depends_on                   = [module.key_vault, module.container_registry]
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  source = "../Azure/network_security_group/v1.3.0"
  providers = {
    azurerm = azurerm.management
  }
  network_security_group_variables = var.network_security_group_variables
}

/*#Network Security Group Association
module "network_security_group_association" {
  source                                       = "../"
  network_security_group_association_variables = var.network_security_group_association_variables
  depends_on                                   = [module.network_security_group, module.subnet, module.network_interface]
}*/

#LINUX VM

module "linux_virtual_machine" {
  source = "../Azure/linux_virtual_machine/v1.3.0"
  providers = {
    azurerm.linux_vm_sub  = azurerm.management
    azurerm.key_vault_sub = azurerm.management
    azurerm.gallery_sub   = azurerm.management
  }
  linux_virtual_machine_variables = var.linux_virtual_machine_variables
  depends_on                      = [module.key_vault]
}