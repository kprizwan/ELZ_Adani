locals {
  generate_new_password         = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_windows_profile", null) != null ? v.kubernetes_cluster_windows_profile.windows_profile_admin_password_secret_exist != true ? v : null : null }
  use_existing_password         = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_windows_profile", null) != null ? v.kubernetes_cluster_windows_profile.windows_profile_admin_password_secret_exist != false ? v : null : null }
  use_existing_windows_username = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_windows_profile", null) != null ? v.kubernetes_cluster_windows_profile.windows_profile_admin_username_key_vault_secret_name != null ? v : null : null }
  use_existing_linux_username   = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_linux_profile", null) != null ? v.kubernetes_cluster_linux_profile.linux_profile_admin_username_key_vault_secret_name != null ? v : null : null }
  generate_ssh_keys             = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_linux_profile", null) != null ? v.kubernetes_cluster_linux_profile.linux_profile_ssh_key_secret_exist != true ? v : null : null }
  use_existing_ssh_keys         = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_linux_profile", null) != null ? v.kubernetes_cluster_linux_profile.linux_profile_ssh_key_secret_exist != false ? v : null : null }
  is_web_routing_enabled = flatten([for k, v in var.kubernetes_cluster_variables : [for i, j in v.kubernetes_cluster_identity.kubernetes_cluster_web_app_routing : [
    merge(
      {
        main_key                                = k
        web_app_routing_dns_zone_name           = j.web_app_routing_dns_zone_name
        web_app_routing_dns_zone_resource_group = j.web_app_routing_dns_zone_resource_group
  }, j)]] if lookup(v, "kubernetes_cluster_web_app_routing", []) != null])
  identities_list = flatten([for k, v in var.kubernetes_cluster_variables : [for i, j in v.kubernetes_cluster_identity.identity_ids : [
    merge(
      {
        main_key                     = k
        identity_name                = j.identity_name
        identity_resource_group_name = j.identity_resource_group_name
  }, j)]] if lookup(v, "kubernetes_cluster_identity", null) != null && v.kubernetes_cluster_identity.identity_ids != null])
  is_disk_encryption_set_exists                    = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "kubernetes_cluster_disk_encryption_set_name", null) != null }
  is_user_identity_required                        = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "identity_type", false) != "SystemAssigned" }
  load_balancer_profile_outbound_public_ip_prefixs = { for k, v in var.kubernetes_cluster_variables : k => v.kubernetes_cluster_network_profile != null ? lookup(v.kubernetes_cluster_network_profile, "network_profile_load_balancer_profile", null) != null ? lookup(v.kubernetes_cluster_network_profile.network_profile_load_balancer_profile, "load_balancer_profile_outbound_ip_prefix_name", null) != null ? format("%s#%s", v.kubernetes_cluster_network_profile.network_profile_load_balancer_profile.load_balancer_profile_outbound_ip_prefix_name, v.kubernetes_cluster_network_profile.network_profile_load_balancer_profile.load_balancer_profile_outbound_ip_prefix_resource_group_name) : null : null : null }
  public_ips_list                                  = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_network_profile", null) != null ? lookup(v.kubernetes_cluster_network_profile, "network_profile_load_balancer_profile", null) != null ? lookup(v.kubernetes_cluster_network_profile.network_profile_load_balancer_profile, "load_balancer_profile_outbound_ip_address", null) != null ? v : null : null : null }
  load_balancer_public_ips = flatten([for k, v in local.public_ips_list : [
    for i, j in v.kubernetes_cluster_network_profile.network_profile_load_balancer_profile.load_balancer_profile_outbound_ip_address :
    [merge({ "main_key" = k, "secondary_key" = j.outbound_ip_address_name, "resource_group" = j.outbound_ip_address_resource_group_name })]
  ] if v != null])
  ingress_application_gateway_subnet = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_ingress_application_gateway", null) != null ? (v.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_exists == false && v.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_subnet_exists == true) ? v : null : null }
  aad_rbac_server_app_secret_name    = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_azure_active_directory_role_based_access_control", null) != null ? v.kubernetes_cluster_azure_active_directory_role_based_access_control.azure_active_directory_role_based_access_control_managed == false ? v : null : null }
  ingress_application_gateway        = { for k, v in var.kubernetes_cluster_variables : k => lookup(v, "kubernetes_cluster_ingress_application_gateway", null) != null ? v.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_exists == true ? v : null : null }
}

# User Assigned Identity
data "azurerm_user_assigned_identity" "user_assigned_ids" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

# Ingress Application Gateway 
data "azurerm_application_gateway" "ingress_application_gateway_id" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = { for k, v in local.ingress_application_gateway : k => v if v != null }
  name                = each.value.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_name
  resource_group_name = each.value.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_resource_group_name
}

# Ingress Application Gateway Subnet 
data "azurerm_subnet" "ingress_application_gateway_subnet_id" {
  provider             = azurerm.kubernetes_cluster_sub
  for_each             = { for k, v in local.ingress_application_gateway_subnet : k => v if v != null }
  name                 = each.value.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_subnet_name
  virtual_network_name = each.value.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_virtual_network_name
  resource_group_name  = each.value.kubernetes_cluster_ingress_application_gateway.ingress_application_gateway_subnet_resource_group_name
}

# Cluster Default Node Pool Subnet
data "azurerm_subnet" "cluster_default_node_pool_subnet_id" {
  provider             = azurerm.kubernetes_cluster_sub
  for_each             = { for k, v in var.kubernetes_cluster_variables : k => v if v.kubernetes_cluster_default_node_pool_subnet_name != null }
  name                 = each.value.kubernetes_cluster_default_node_pool_subnet_name
  virtual_network_name = each.value.kubernetes_cluster_default_node_pool_virtual_network_name
  resource_group_name  = each.value.kubernetes_cluster_default_node_pool_virtual_network_resource_group_name
}

# Cluster Default Node Pool Pod Subnet 
data "azurerm_subnet" "default_node_pool_pod_subnet_id" {
  provider             = azurerm.kubernetes_cluster_sub
  for_each             = { for k, v in var.kubernetes_cluster_variables : k => v if v.kubernetes_cluster_default_node_pool_pod_subnet_name != null }
  name                 = each.value.kubernetes_cluster_default_node_pool_pod_subnet_name
  virtual_network_name = each.value.kubernetes_cluster_default_node_pool_pod_virtual_network_name
  resource_group_name  = each.value.kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name
}

# Node and Volume Disk Encryption Set
data "azurerm_disk_encryption_set" "disk_encryption_set" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = local.is_disk_encryption_set_exists
  name                = each.value.kubernetes_cluster_disk_encryption_set_name
  resource_group_name = each.value.kubernetes_cluster_disk_encryption_set_resource_group_name
}

# Cluster Default Node Pool Public IP Prefix
data "azurerm_public_ip_prefix" "default_node_pool_public_prefix_id" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = { for k, v in var.kubernetes_cluster_variables : k => v if v.kubernetes_cluster_default_node_pool_node_public_ip_prefix_name != null }
  name                = each.value.kubernetes_cluster_default_node_pool_node_public_ip_prefix_name
  resource_group_name = each.value.kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name
}

# Linux Profile Username Secret
data "azurerm_key_vault_secret" "existing_linux_username_keyvault_secret" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.use_existing_linux_username : k => v if v != null }
  name         = each.value.kubernetes_cluster_linux_profile.linux_profile_admin_username_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

#Creates new asymmetric key
resource "tls_private_key" "generate_ssh_keys_tls_private_key" {
  for_each  = { for k, v in local.generate_ssh_keys : k => v if v != null }
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Linux Profile SSH Private Secret
resource "azurerm_key_vault_secret" "linux_profile_ssh_key_private_key" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.generate_ssh_keys : k => v if v != null }
  name         = format("%s-private", each.value.kubernetes_cluster_linux_profile.linux_profile_ssh_key_secret_name)
  value        = tls_private_key.generate_ssh_keys_tls_private_key[each.key].private_key_pem
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# Linux Profile SSH Public Secret
resource "azurerm_key_vault_secret" "linux_profile_ssh_key_public_key" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.generate_ssh_keys : k => v if v != null }
  name         = each.value.kubernetes_cluster_linux_profile.linux_profile_ssh_key_secret_name
  value        = tls_private_key.generate_ssh_keys_tls_private_key[each.key].public_key_openssh
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# Linux Profile SSH Private Secret
data "azurerm_key_vault_secret" "existing_ssh_keys_key_vault_secret" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.use_existing_ssh_keys : k => v if v != null }
  name         = each.value.kubernetes_cluster_linux_profile.linux_profile_ssh_key_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# Kubelet User Identity
data "azurerm_user_assigned_identity" "kubelet_user_identity" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "kubernetes_cluster_kubelet_identity", null) != null }
  name                = each.value.kubelet_identity_user_assigned_identity_name
  resource_group_name = each.value.kubelet_identity_user_assigned_identity_resource_group
}

# Microsoft Defender Log Analytics
data "azurerm_log_analytics_workspace" "microsoft_defender_log_analytics_id" {
  provider            = azurerm.log_analytics_defender_sub
  for_each            = { for k, v in var.kubernetes_cluster_variables : k => v if v.kubernetes_cluster_microsoft_defender != null }
  name                = each.value.kubernetes_cluster_microsoft_defender.microsoft_defender_log_analytics_workspace_name
  resource_group_name = each.value.kubernetes_cluster_microsoft_defender.microsoft_defender_log_analytics_resource_group_name
}

# OMS Log Analytics
data "azurerm_log_analytics_workspace" "oms_log_analytics_id" {
  provider            = azurerm.log_analytics_oms_sub
  for_each            = { for k, v in var.kubernetes_cluster_variables : k => v if v.kubernetes_cluster_oms_agent != null }
  name                = each.value.kubernetes_cluster_oms_agent.oms_agent_log_analytics_workspace_name
  resource_group_name = each.value.kubernetes_cluster_oms_agent.oms_agent_log_analytics_resource_group_name
}

# Windows Username
data "azurerm_key_vault_secret" "existing_username_secret" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.use_existing_windows_username : k => v if v != null }
  name         = each.value.kubernetes_cluster_windows_profile.windows_profile_admin_username_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# Windows Existing Password
data "azurerm_key_vault_secret" "existing_password_secret" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.use_existing_password : k => v if v != null }
  name         = each.value.kubernetes_cluster_windows_profile.windows_profile_admin_password_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

#Generate random password
resource "random_password" "password" {
  for_each    = { for k, v in local.generate_new_password : k => v if v != null }
  length      = each.value.kubernetes_cluster_windows_profile.windows_profile_admin_password_length
  special     = true
  lower       = true
  upper       = true
  numeric     = true
  min_lower   = 4
  min_upper   = 4
  min_numeric = 2
  min_special = 2
}

# Windows New Password
resource "azurerm_key_vault_secret" "key_vault_secret" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.generate_new_password : k => v if v != null }
  name         = each.value.kubernetes_cluster_windows_profile.windows_profile_admin_password_secret_name
  value        = random_password.password[each.key].result
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# AKS related Key Vault
data "azurerm_key_vault" "key_vault_id" {
  provider            = azurerm.keyvault_sub
  for_each            = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "kubernetes_cluster_key_vault_name", null) != null }
  name                = each.value.kubernetes_cluster_key_vault_name
  resource_group_name = each.value.kubernetes_cluster_key_vault_resource_group_name
}

# AAD RBAC App Secret Name
data "azurerm_key_vault_secret" "aad_rbac_server_app_secret_name" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in local.aad_rbac_server_app_secret_name : k => v if v != null }
  name         = each.value.kubernetes_cluster_azure_active_directory_role_based_access_control.azure_active_directory_role_based_access_control_server_app_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# Cluster Private DNS Zone 
data "azurerm_private_dns_zone" "private_dns_zone_id" {
  provider            = azurerm.private_dns_zone_sub
  for_each            = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "kubernetes_cluster_private_dns_zone_name", null) != null }
  name                = each.value.kubernetes_cluster_private_dns_zone_name
  resource_group_name = each.value.kubernetes_cluster_private_dns_zone_resource_group_name
}

# Service Principal Client Secret
data "azurerm_key_vault_secret" "service_principal_client_secret_name" {
  provider     = azurerm.keyvault_sub
  for_each     = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "service_principal", null) != null }
  name         = each.value.kubernetes_cluster_service_principal.service_principal_client_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

# Load Balancer Outboung Public Ip Prefix
data "azurerm_public_ip_prefix" "load_balancer_profile_outbound_ip_prefix_id" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = { for k, v in local.load_balancer_profile_outbound_public_ip_prefixs : k => v if v != null }
  name                = element(split("#", each.value), 0)
  resource_group_name = element(split("#", each.value), 1)
}

# Load Balancer Outboung Public Ips
data "azurerm_public_ip" "load_balancer_profile_outbound_public_ip_id" {
  provider            = azurerm.kubernetes_cluster_sub
  for_each            = { for k, v in local.load_balancer_public_ips : "${v.main_key}#${v.secondary_key}" => v }
  resource_group_name = each.value.resource_group_name
  name                = each.value.public_ip_name
}

#Data block to fetch dns_zone_id
data "azurerm_dns_zone" "dns_zone_id" {
  provider            = azurerm.private_dns_zone_sub
  for_each            = { for k, v in local.is_web_routing_enabled : "${v.main_key}#{v.web_app_routing_dns_zone_name}" => v }
  name                = each.value.web_app_routing_dns_zone_name
  resource_group_name = each.value.web_app_routing_dns_zone_resource_group
}

#Data block for capacity_reservation_group_id 
data "azurerm_resource_group" "resource_group_id" {
  provider = azurerm.kubernetes_cluster_sub
  for_each = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "kubernetes_cluster_capacity_reservation_resource_group_name", null) != null }
  name     = each.value.kubernetes_cluster_capacity_reservation_resource_group_name
}

#Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  provider                            = azurerm.kubernetes_cluster_sub
  for_each                            = var.kubernetes_cluster_variables
  name                                = each.value.kubernetes_cluster_name
  location                            = each.value.kubernetes_cluster_location
  resource_group_name                 = each.value.kubernetes_cluster_resource_group_name
  automatic_channel_upgrade           = each.value.kubernetes_cluster_automatic_channel_upgrade
  api_server_authorized_ip_ranges     = each.value.kubernetes_cluster_api_server_authorized_ip_ranges
  azure_policy_enabled                = each.value.kubernetes_cluster_azure_policy_enabled
  disk_encryption_set_id              = each.value.kubernetes_cluster_disk_encryption_set_name == null ? null : data.azurerm_disk_encryption_set.disk_encryption_set[each.key].id
  edge_zone                           = each.value.kubernetes_cluster_edge_zone
  dns_prefix                          = each.value.kubernetes_cluster_dns_prefix
  dns_prefix_private_cluster          = each.value.kubernetes_cluster_dns_prefix_private_cluster
  http_application_routing_enabled    = each.value.kubernetes_cluster_http_application_routing_enabled
  kubernetes_version                  = each.value.kubernetes_cluster_kubernetes_version
  local_account_disabled              = each.value.kubernetes_cluster_local_account_disabled
  node_resource_group                 = each.value.kubernetes_cluster_node_resource_group_name
  oidc_issuer_enabled                 = each.value.kubernetes_cluster_oidc_issuer_enabled
  open_service_mesh_enabled           = each.value.kubernetes_cluster_open_service_mesh_enabled
  private_cluster_enabled             = each.value.kubernetes_cluster_private_cluster_enabled
  private_dns_zone_id                 = each.value.kubernetes_cluster_private_dns_zone_name != null ? data.azurerm_private_dns_zone.private_dns_zone_id[each.key].id : null
  private_cluster_public_fqdn_enabled = each.value.kubernetes_cluster_private_cluster_public_fqdn_enabled
  public_network_access_enabled       = each.value.kubernetes_cluster_public_network_access_enabled
  role_based_access_control_enabled   = each.value.kubernetes_cluster_role_based_access_control_enabled
  run_command_enabled                 = each.value.kubernetes_cluster_run_command_enabled
  workload_identity_enabled           = each.value.kubernetes_cluster_workload_identity_enabled
  sku_tier                            = each.value.kubernetes_cluster_sku_tier
  dynamic "workload_autoscaler_profile" {
    for_each = each.value.kubernetes_cluster_workload_autoscaler_profile == null ? [] : [each.value.kubernetes_cluster_workload_autoscaler_profile]
    content {
      keda_enabled = workload_autoscaler_profile.workload_autoscaler_profile_keda_enabled
    }
  }
  default_node_pool {
    name                          = each.value.kubernetes_cluster_default_node_pool_name
    vm_size                       = each.value.kubernetes_cluster_default_node_pool_vm_size
    enable_auto_scaling           = each.value.kubernetes_cluster_default_node_pool_enable_auto_scaling
    enable_host_encryption        = each.value.kubernetes_cluster_default_node_pool_enable_host_encryption
    enable_node_public_ip         = each.value.kubernetes_cluster_default_node_pool_enable_node_public_ip
    capacity_reservation_group_id = each.value.kubernetes_cluster_capacity_reservation_resource_group_name != null ? format("%s/%s/%s/%s%s", data.azurerm_resource_group.resource_group_id[each.key].id, "providers", "Microsoft.Compute", "capacityReservationGroups", each.value.kubernetes_cluster_capacity_reservation_group_name) : null
    dynamic "kubelet_config" {
      for_each = each.value.kubernetes_cluster_default_node_pool_kubelet_config != null ? [each.value.kubernetes_cluster_default_node_pool_kubelet_config] : []
      content {
        allowed_unsafe_sysctls    = kubelet_config.value.kubelet_config_allowed_unsafe_sysctls
        container_log_max_line    = kubelet_config.value.kubelet_config_container_log_max_line
        container_log_max_size_mb = kubelet_config.value.kubelet_config_container_log_max_size_mb
        cpu_cfs_quota_enabled     = kubelet_config.value.kubelet_config_cpu_cfs_quota_enabled
        cpu_cfs_quota_period      = kubelet_config.value.kubelet_config_cpu_cfs_quota_period
        cpu_manager_policy        = kubelet_config.value.kubelet_config_cpu_manager_policy
        image_gc_high_threshold   = kubelet_config.value.kubelet_config_image_gc_high_threshold
        image_gc_low_threshold    = kubelet_config.value.kubelet_config_image_gc_low_threshold
        pod_max_pid               = kubelet_config.value.kubelet_config_pod_max_pid
        topology_manager_policy   = kubelet_config.value.kubelet_config_topology_manager_policy
      }
    }
    dynamic "linux_os_config" {
      for_each = each.value.kubernetes_cluster_default_node_pool_linux_os_config != null ? [each.value.kubernetes_cluster_default_node_pool_linux_os_config] : []
      content {
        swap_file_size_mb = linux_os_config.value.linux_os_config_swap_file_size_mb
        dynamic "sysctl_config" {
          for_each = linux_os_config.value.sysctl_config != null ? toset(linux_os_config.value.sysctl_config) : []
          content {
            fs_aio_max_nr                      = sysctl_config.value.sysctl_config_fs_aio_max_nr
            fs_file_max                        = sysctl_config.value.sysctl_config_fs_file_max
            fs_inotify_max_user_watches        = sysctl_config.value.sysctl_config_fs_inotify_max_user_watches
            fs_nr_open                         = sysctl_config.value.sysctl_config_fs_nr_open
            kernel_threads_max                 = sysctl_config.value.sysctl_config_kernel_threads_max
            net_core_netdev_max_backlog        = sysctl_config.value.sysctl_config_net_core_netdev_max_backlog
            net_core_optmem_max                = sysctl_config.value.sysctl_config_net_core_optmem_max
            net_core_rmem_default              = sysctl_config.value.sysctl_config_net_core_rmem_default
            net_core_rmem_max                  = sysctl_config.value.sysctl_config_net_core_rmem_max
            net_core_somaxconn                 = sysctl_config.value.sysctl_config_net_core_somaxconn
            net_core_wmem_default              = sysctl_config.value.sysctl_config_net_core_wmem_default
            net_core_wmem_max                  = sysctl_config.value.sysctl_config_net_core_wmem_max
            net_ipv4_ip_local_port_range_max   = sysctl_config.value.sysctl_config_net_ipv4_ip_local_port_range_max
            net_ipv4_ip_local_port_range_min   = sysctl_config.value.sysctl_config_net_ipv4_ip_local_port_range_min
            net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.sysctl_config_net_ipv4_neigh_default_gc_thresh1
            net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.sysctl_config_net_ipv4_neigh_default_gc_thresh2
            net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.sysctl_config_net_ipv4_neigh_default_gc_thresh3
            net_ipv4_tcp_fin_timeout           = sysctl_config.value.sysctl_config_net_ipv4_tcp_fin_timeout
            net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.sysctl_config_net_ipv4_tcp_keepalive_intvl
            net_ipv4_tcp_keepalive_probes      = sysctl_config.value.sysctl_config_net_ipv4_tcp_keepalive_probes
            net_ipv4_tcp_keepalive_time        = sysctl_config.value.sysctl_config_net_ipv4_tcp_keepalive_time
            net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.sysctl_config_net_ipv4_tcp_max_syn_backlog
            net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.sysctl_config_net_ipv4_tcp_max_tw_buckets
            net_ipv4_tcp_tw_reuse              = sysctl_config.value.sysctl_config_net_ipv4_tcp_tw_reuse
            net_netfilter_nf_conntrack_buckets = sysctl_config.value.sysctl_config_net_netfilter_nf_conntrack_buckets
            net_netfilter_nf_conntrack_max     = sysctl_config.value.sysctl_config_net_netfilter_nf_conntrack_max
            vm_max_map_count                   = sysctl_config.value.sysctl_config_vm_max_map_count
            vm_swappiness                      = sysctl_config.value.sysctl_config_vm_swappiness
            vm_vfs_cache_pressure              = sysctl_config.value.sysctl_config_vm_vfs_cache_pressure
          }
        }
        transparent_huge_page_defrag  = linux_os_config.value.linux_os_config_transparent_huge_page_defrag
        transparent_huge_page_enabled = linux_os_config.value.linux_os_config_transparent_huge_page_enabled
      }
    }
    fips_enabled                 = each.value.kubernetes_cluster_default_node_pool_fips_enabled
    kubelet_disk_type            = each.value.kubernetes_cluster_default_node_pool_kubelet_disk_type
    max_pods                     = each.value.kubernetes_cluster_default_node_pool_max_pods
    message_of_the_day           = each.value.kubernetes_cluster_message_of_the_day
    node_public_ip_prefix_id     = each.value.kubernetes_cluster_default_node_pool_node_public_ip_prefix_name != null ? data.azurerm_public_ip_prefix.default_node_pool_public_prefix_id[each.key].id : null
    node_labels                  = each.value.kubernetes_cluster_default_node_pool_node_labels
    only_critical_addons_enabled = each.value.kubernetes_cluster_default_node_pool_only_critical_addons_enabled
    orchestrator_version         = each.value.kubernetes_cluster_default_node_pool_orchestrator_version
    os_disk_size_gb              = each.value.kubernetes_cluster_default_node_pool_os_disk_size_gb
    os_disk_type                 = each.value.kubernetes_cluster_default_node_pool_os_disk_type
    os_sku                       = each.value.kubernetes_cluster_default_node_pool_os_sku
    pod_subnet_id                = each.value.kubernetes_cluster_default_node_pool_pod_subnet_name != null ? data.azurerm_subnet.default_node_pool_pod_subnet_id[each.key].id : null
    scale_down_mode              = each.value.kubernetes_cluster_default_node_pool_pod_scale_down_mode
    type                         = each.value.kubernetes_cluster_default_node_pool_type
    tags                         = merge(each.value.kubernetes_cluster_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
    ultra_ssd_enabled            = each.value.kubernetes_cluster_default_node_pool_ultra_ssd_enabled

    dynamic "upgrade_settings" {
      for_each = each.value.kubernetes_cluster_default_node_pool_upgrade_settings != null ? [each.value.kubernetes_cluster_default_node_pool_upgrade_settings] : []
      content {
        max_surge = upgrade_settings.value.upgrade_settings_max_surge
      }
    }
    vnet_subnet_id   = each.value.kubernetes_cluster_default_node_pool_subnet_name == null ? null : data.azurerm_subnet.cluster_default_node_pool_subnet_id[each.key].id
    max_count        = each.value.kubernetes_cluster_default_node_pool_enable_auto_scaling == true ? each.value.kubernetes_cluster_default_node_pool_max_count : null
    min_count        = each.value.kubernetes_cluster_default_node_pool_enable_auto_scaling == true ? each.value.kubernetes_cluster_default_node_pool_min_count : null
    node_count       = each.value.kubernetes_cluster_default_node_pool_enable_auto_scaling == false ? each.value.kubernetes_cluster_default_node_pool_node_count : null
    workload_runtime = each.value.kubernetes_cluster_default_node_pool_enable_auto_scaling == false ? each.value.kubernetes_cluster_default_node_pool_enable_auto_scaling_workload_runtime : null
    zones            = each.value.kubernetes_cluster_default_node_pool_availability_zones
  }

  dynamic "aci_connector_linux" {
    for_each = each.value.kubernetes_cluster_aci_connector_linux == null ? [] : [each.value.kubernetes_cluster_aci_connector_linux]
    content {
      subnet_name = aci_connector_linux.value.aci_connector_linux_subnet_name
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = each.value.kubernetes_cluster_auto_scaler_profile != null ? [each.value.kubernetes_cluster_auto_scaler_profile] : []
    content {
      balance_similar_node_groups      = auto_scaler_profile.value.auto_scaler_profile_balance_similar_node_groups
      expander                         = auto_scaler_profile.value.auto_scaler_profile_expander
      max_graceful_termination_sec     = auto_scaler_profile.value.auto_scaler_profile_max_graceful_termination_sec
      max_node_provisioning_time       = auto_scaler_profile.value.auto_scaler_profile_max_node_provisioning_time
      max_unready_nodes                = auto_scaler_profile.value.auto_scaler_profile_max_unready_nodes
      max_unready_percentage           = auto_scaler_profile.value.auto_scaler_profile_max_unready_percentage
      new_pod_scale_up_delay           = auto_scaler_profile.value.auto_scaler_profile_new_pod_scale_up_delay
      scale_down_delay_after_add       = auto_scaler_profile.value.auto_scaler_profile_scale_down_delay_after_add
      scale_down_delay_after_delete    = auto_scaler_profile.value.auto_scaler_profile_scale_down_delay_after_delete
      scale_down_delay_after_failure   = auto_scaler_profile.value.auto_scaler_profile_scale_down_delay_after_failure
      scan_interval                    = auto_scaler_profile.value.auto_scaler_profile_scan_interval
      scale_down_unneeded              = auto_scaler_profile.value.auto_scaler_profile_scale_down_unneeded
      scale_down_unready               = auto_scaler_profile.value.auto_scaler_profile_scale_down_unready
      scale_down_utilization_threshold = auto_scaler_profile.value.auto_scaler_profile_scale_down_utilization_threshold
      empty_bulk_delete_max            = auto_scaler_profile.value.auto_scaler_profile_empty_bulk_delete_max
      skip_nodes_with_local_storage    = auto_scaler_profile.value.auto_scaler_profile_skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = auto_scaler_profile.value.auto_scaler_profile_skip_nodes_with_system_pods
    }
  }
  #Data block for azure ad is available for this but for security purpose of ADO agent connecting to AD tenant we have not used it.
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = each.value.kubernetes_cluster_azure_active_directory_role_based_access_control != null ? [each.value.kubernetes_cluster_azure_active_directory_role_based_access_control] : []
    content {
      managed                = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_managed
      tenant_id              = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_tenant_id
      admin_group_object_ids = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_managed == true ? azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_admin_group_object_ids : null
      azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_managed == true ? azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_azure_rbac_enabled : false
      client_app_id          = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_managed == false ? azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_client_app_id : null
      server_app_id          = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_managed == false ? azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_server_app_id : null
      server_app_secret      = azure_active_directory_role_based_access_control.value.azure_active_directory_role_based_access_control_managed == false ? data.azurerm_key_vault_secret.aad_rbac_server_app_secret_name[each.key].value : null
    }
  }

  dynamic "http_proxy_config" {
    for_each = each.value.kubernetes_cluster_http_proxy_config != null ? [each.value.kubernetes_cluster_http_proxy_config] : []
    content {
      http_proxy  = http_proxy_config.value.http_proxy_config_http_proxy
      https_proxy = http_proxy_config.value.http_proxy_config_https_proxy
      no_proxy    = http_proxy_config.value.http_proxy_config_no_proxy
      trusted_ca  = http_proxy_config.value.http_proxy_trusted_ca
    }
  }

  dynamic "identity" {
    for_each = (each.value.kubernetes_cluster_identity != null) && (each.value.kubernetes_cluster_service_principal == null) ? [each.value.kubernetes_cluster_identity] : []
    content {
      type = identity.value.identity_type
      identity_ids = identity.value.identity_type == "SystemAssigned, UserAssigned" || identity.value.identity_type == "UserAssigned" ? [
        for k, v in identity.value.identity_ids : data.azurerm_user_assigned_identity.user_assigned_ids["${each.key},${v.identity_name}"].id
      ] : null
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = each.value.kubernetes_cluster_ingress_application_gateway != null ? [each.value.kubernetes_cluster_ingress_application_gateway] : []
    content {
      gateway_id   = ingress_application_gateway.value.ingress_application_gateway_exists == false ? null : data.azurerm_application_gateway.ingress_application_gateway_id[each.key].id
      gateway_name = ingress_application_gateway.value.ingress_application_gateway_exists == false ? ingress_application_gateway.value.ingress_application_gateway_name : null
      subnet_cidr  = ((ingress_application_gateway.value.ingress_application_gateway_exists == false) && (ingress_application_gateway.value.ingress_application_gateway_subnet_exists == true)) ? null : ingress_application_gateway.value.ingress_application_gateway_subnet_cidr
      subnet_id    = ((ingress_application_gateway.value.ingress_application_gateway_exists == false) && (ingress_application_gateway.value.ingress_application_gateway_subnet_exists == true)) ? data.azurerm_subnet.ingress_application_gateway_subnet_id[each.key].id : null
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = each.value.kubernetes_cluster_key_vault_secrets_provider != null ? [each.value.kubernetes_cluster_key_vault_secrets_provider] : []
    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.key_vault_secrets_provider_secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.key_vault_secrets_provider_secret_rotation_interval
    }
  }

  dynamic "kubelet_identity" {
    for_each = { for k, v in var.kubernetes_cluster_variables : k => v if lookup(v, "kubernetes_cluster_kubelet_identity_enabled", true) == true && lookup(v, "identity_type", "SystemAssigned") == false }
    content {
      client_id                 = kubelet_identity.value.kubernetes_cluster_kubelet_identity_client_id
      object_id                 = kubelet_identity.value.kubernetes_cluster_kubelet_identity_object_id
      user_assigned_identity_id = data.azurerm_user_assigned_identity.kubelet_user_identity[each.key].id
    }
  }

  dynamic "linux_profile" {
    for_each = each.value.kubernetes_cluster_linux_profile != null ? [each.value.kubernetes_cluster_linux_profile] : []
    content {
      admin_username = linux_profile.value.linux_profile_admin_username_key_vault_secret_name != null ? data.azurerm_key_vault_secret.existing_linux_username_keyvault_secret[each.key].value : linux_profile.value.linux_profile_admin_username
      ssh_key {
        key_data = linux_profile.value.linux_profile_ssh_key_secret_exist == true ? data.azurerm_key_vault_secret.existing_ssh_keys_key_vault_secret[each.key].value : tls_private_key.generate_ssh_keys_tls_private_key[each.key].public_key_openssh
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = each.value.kubernetes_cluster_maintenance_window != null ? [each.value.kubernetes_cluster_maintenance_window] : []
    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.maintenance_window_allowed != null ? maintenance_window.value.maintenance_window_allowed : []
        content {
          day   = allowed.value.allowed_day
          hours = allowed.value.allowed_hours
        }
      }
      dynamic "not_allowed" {
        for_each = maintenance_window.value.maintenance_window_not_allowed != null ? maintenance_window.value.maintenance_window_not_allowed : []
        content {
          start = not_allowed.value.not_allowed_start
          end   = not_allowed.value.not_allowed_end
        }
      }
    }
  }

  dynamic "microsoft_defender" {
    for_each = each.value.kubernetes_cluster_microsoft_defender != null ? [each.value.kubernetes_cluster_microsoft_defender] : []
    content {
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.microsoft_defender_log_analytics_id[each.key].id
    }
  }

  dynamic "network_profile" {
    for_each = each.value.kubernetes_cluster_network_profile != null ? [each.value.kubernetes_cluster_network_profile] : []
    content {
      network_plugin     = network_profile.value.network_profile_network_plugin
      network_mode       = network_profile.value.network_profile_network_plugin == "azure" ? network_profile.value.network_profile_network_mode : null
      network_policy     = network_profile.value.network_profile_network_plugin == "azure" && network_profile.value.network_profile_network_policy == "azure" ? "azure" : network_profile.value.network_profile_network_policy
      dns_service_ip     = network_profile.value.network_profile_dns_service_ip
      docker_bridge_cidr = network_profile.value.network_profile_docker_bridge_cidr
      outbound_type      = network_profile.value.network_profile_outbound_type
      pod_cidr           = network_profile.value.network_profile_network_plugin == "kubenet" ? each.value.network_profile_pod_cidr : null
      pod_cidrs          = network_profile.value.network_profile_network_plugin == "kubenet" ? each.value.network_profile_pod_cidrs : null
      service_cidr       = network_profile.value.network_profile_service_cidr
      service_cidrs      = network_profile.value.network_profile_service_cidrs
      ip_versions        = network_profile.value.network_profile_ip_versions
      load_balancer_sku  = network_profile.value.network_profile_load_balancer_sku
      dynamic "load_balancer_profile" {
        for_each = network_profile.value.network_profile_load_balancer_sku == "standard" && network_profile.value.network_profile_load_balancer_profile != null ? [network_profile.value.network_profile_load_balancer_profile] : []
        content {
          idle_timeout_in_minutes     = load_balancer_profile.value.load_balancer_profile_idle_timeout_in_minutes
          managed_outbound_ip_count   = load_balancer_profile.value.load_balancer_profile_managed_outbound_ip_count
          outbound_ip_address_ids     = load_balancer_profile.value.load_balancer_profile_outbound_ip_address != null ? [for i in load_balancer_profile.value.load_balancer_profile_outbound_ip_address : data.azurerm_public_ip.load_balancer_profile_outbound_public_ip_id["${each.key}#${i.outbound_ip_address_name}"].id] : null
          outbound_ip_prefix_ids      = load_balancer_profile.value.load_balancer_profile_outbound_ip_prefix_name != null ? data.azurerm_public_ip_prefix.load_balancer_profile_outbound_ip_prefix_id[each.key].id : null
          outbound_ports_allocated    = load_balancer_profile.value.load_balancer_profile_outbound_ports_allocated
          managed_outbound_ipv6_count = load_balancer_profile.value.load_balancer_profile_managed_outbound_ipv6_count
        }
      }
      dynamic "nat_gateway_profile" {
        for_each = (network_profile.value.network_profile_load_balancer_sku == "standard") && (network_profile.value.network_profile_nat_gateway_profile != null) ? (network_profile.value.network_profile_outbound_type == "managedNATGateway") || (network_profile.value.network_profile_outbound_type == "userAssignedNATGateway") ? [network_profile.value.network_profile_nat_gateway_profile] : [] : []
        content {
          idle_timeout_in_minutes   = nat_gateway_profile.value.nat_gateway_profile_idle_timeout_in_minutes
          managed_outbound_ip_count = nat_gateway_profile.value.nat_gateway_profile_managed_outbound_ip_count
        }
      }
    }
  }

  dynamic "oms_agent" {
    for_each = each.value.kubernetes_cluster_oms_agent != null ? [each.value.kubernetes_cluster_oms_agent] : []
    content {
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.oms_log_analytics_id[each.key].id
    }
  }

  dynamic "service_principal" {
    for_each = (each.value.kubernetes_cluster_identity == null) && (each.value.kubernetes_cluster_service_principal != null) ? [each.value.kubernetes_cluster_service_principal] : []
    content {
      client_id     = service_principal.value.service_principal_client_id
      client_secret = data.azurerm_key_vault_secret.service_principal_client_secret_name[each.key].value
    }
  }

  dynamic "windows_profile" {
    for_each = each.value.kubernetes_cluster_windows_profile != null ? [each.value.kubernetes_cluster_windows_profile] : []
    content {
      admin_username = windows_profile.value.windows_profile_admin_username_key_vault_secret_name != null ? data.azurerm_key_vault_secret.existing_username_secret[each.key].value : windows_profile.value.windows_profile_admin_username
      admin_password = windows_profile.value.windows_profile_admin_password_secret_exist == true ? data.azurerm_key_vault_secret.existing_password_secret[each.key].value : random_password.password[each.key].result
      license        = windows_profile.value.windows_profile_license

      dynamic "gmsa" {
        for_each = windows_profile.value.kubernetes_cluster_gmsa != null ? windows_profile.value.kubernetes_cluster_gmsa : []
        content {
          dns_server  = kubernetes_cluster_gmsa.value.gmsa_dns_server
          root_domain = kubernetes_cluster_gmsa.value.gmsa_root_domain
        }
      }
    }
  }
  dynamic "web_app_routing" {
    for_each = each.value.kubernetes_cluster_web_app_routing != null ? [each.value.kubernetes_cluster_web_app_routing] : []
    content {
      dns_zone_id = data.azurerm_dns_zone.dns_zone_id[0].id
    }
  }

  tags = merge(each.value.kubernetes_cluster_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"], default_node_pool[0].tags["Created_Time"]] }
}
