#AKS CLUSTER

locals {
  is_subnet_exists = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "is_subnet_required", false) == true }
}

locals {
  is_disk_encryption_set_exists = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "is_disk_encryption_set_required", false) == true }
}

locals {
  is_application_gateway_exists = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "ingress_application_gateway_enabled", false) == true }
}

locals {
  is_log_analytics_workspace_exists = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "oms_agent_enabled", false) == true }
}


locals {
  is_user_identity_required = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "identity_type", false) != "SystemAssigned" }
}


data "azurerm_virtual_network" "vnet_id" {
  for_each            = local.is_subnet_exists
  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "subnet_id" {
  for_each             = local.is_subnet_exists
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_disk_encryption_set" "disk_encryption_set" {
  for_each            = local.is_disk_encryption_set_exists
  name                = each.value.disk_encryption_set_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_application_gateway" "application_gateway_id" {
  for_each            = local.is_application_gateway_exists
  name                = each.value.application_gateway_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  for_each            = local.is_log_analytics_workspace_exists
  name                = each.value.log_analytics_workspace_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_user_assigned_identity" "aks_user_identity" {
  for_each            = local.is_user_identity_required
  name                = each.value.user_identity_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  for_each                        = var.aks_cluster_variables
  name                            = each.value.aks_name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  dns_prefix                      = each.value.dns_prefix
  node_resource_group             = each.value.node_resource_group_name
  sku_tier                        = each.value.sku_tier
  dns_prefix_private_cluster      = each.value.dns_prefix_private_cluster
  disk_encryption_set_id          = each.value.is_disk_encryption_set_required == false ? null : data.azurerm_disk_encryption_set.disk_encryption_set[each.key].id
  private_cluster_enabled         = each.value.private_cluster_enabled
  private_dns_zone_id             = each.value.private_dns_zone_id
  api_server_authorized_ip_ranges = each.value.api_server_authorized_ip_ranges
  kubernetes_version              = each.value.kubernetes_version
  automatic_channel_upgrade       = each.value.automatic_channel_upgrade
  local_account_disabled          = each.value.local_account_disabled
  open_service_mesh_enabled       = each.value.open_service_mesh_enabled
  #azure_policy_enabled             = each.value.azure_policy_enabled
  #http_application_routing_enabled = each.value.http_application_routing_enabled


  http_proxy_config {
    http_proxy  = each.value.http_proxy
    https_proxy = each.value.https_proxy
    no_proxy    = each.value.no_proxy
    trusted_ca  = each.value.trusted_ca
  }

  default_node_pool {
    name                   = each.value.default_node_pool_name
    vm_size                = each.value.default_node_pool_vm_size
    type                   = each.value.default_node_pool_type
    vnet_subnet_id         = each.value.is_subnet_required == false ? null : data.azurerm_subnet.subnet_id[each.key].id
    enable_auto_scaling    = each.value.default_node_pool_enable_auto_scaling
    max_count              = each.value.default_node_pool_enable_auto_scaling == true ? each.value.default_node_pool_max_count : null
    min_count              = each.value.default_node_pool_enable_auto_scaling == true ? each.value.default_node_pool_min_count : null
    node_count             = each.value.default_node_pool_enable_auto_scaling == false ? each.value.default_node_pool_node_count : null
    enable_host_encryption = each.value.default_node_pool_enable_host_encryption
    enable_node_public_ip  = each.value.default_node_pool_enable_node_public_ip
    max_pods               = each.value.default_node_pool_max_pods
    node_labels            = each.value.default_node_pool_node_labels
    os_disk_size_gb        = each.value.default_node_pool_os_disk_size_gb
  }
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = each.value.azure_active_directory_role_based_access_control_enabled ? [1] : []
    content {
      managed                = each.value.aad_managed
      tenant_id              = each.value.aad_tenant_id
      admin_group_object_ids = each.value.aad_managed == true ? each.value.aad_admin_group_object_ids : null
      azure_rbac_enabled     = each.value.aad_managed == true ? each.value.aad_azure_rbac_enabled : false
      client_app_id          = each.value.aad_managed == false ? each.value.aad_client_app_id : null
      server_app_id          = each.value.aad_managed == false ? each.value.aad_server_app_id : null
      server_app_secret      = each.value.aad_managed == false ? each.value.aad_server_app_secret : null
    }
  }
  auto_scaler_profile {
    balance_similar_node_groups      = each.value.balance_similar_node_groups
    expander                         = each.value.expander
    max_graceful_termination_sec     = each.value.max_graceful_termination_sec
    max_node_provisioning_time       = each.value.max_node_provisioning_time
    max_unready_nodes                = each.value.max_unready_nodes
    max_unready_percentage           = each.value.max_unready_percentage
    new_pod_scale_up_delay           = each.value.new_pod_scale_up_delay
    scale_down_delay_after_add       = each.value.scale_down_delay_after_add
    scale_down_delay_after_delete    = each.value.scale_down_delay_after_delete
    scale_down_delay_after_failure   = each.value.scale_down_delay_after_failure
    scan_interval                    = each.value.scan_interval
    scale_down_unneeded              = each.value.scale_down_unneeded
    scale_down_unready               = each.value.scale_down_unready
    scale_down_utilization_threshold = each.value.scale_down_utilization_threshold
    empty_bulk_delete_max            = each.value.empty_bulk_delete_max
    skip_nodes_with_local_storage    = each.value.skip_nodes_with_local_storage
    skip_nodes_with_system_pods      = each.value.skip_nodes_with_system_pods
  }
  network_profile {
    network_plugin     = each.value.network_plugin
    network_policy     = each.value.network_plugin == "azure" ? "azure" : each.value.network_policy
    dns_service_ip     = each.value.dns_service_ip
    docker_bridge_cidr = each.value.docker_bridge_cidr
    outbound_type      = each.value.outbound_type
    pod_cidr           = each.value.network_plugin == "kubenet" ? each.value.pod_cidr : null
    service_cidr       = each.value.service_cidr
    # load_balancer_sku  = each.value.load_balancer_sku
    # load_balancer_profile {
    #   outbound_ports_allocated  = each.value.lb_outbound_ports_allocated
    #   idle_timeout_in_minutes   = each.value.lb_idle_timeout_in_minutes
    #   managed_outbound_ip_count = each.value.lb_managed_outbound_ip_count
    #   outbound_ip_prefix_ids    = each.value.lb_outbound_ip_prefix_ids
    #   outbound_ip_address_ids   = each.value.lb_outbound_ip_address_ids
    # }
  }

  dynamic "kubelet_identity" {
    for_each = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "kubelet_identity_enabled", true) == true && lookup(v, "identity_type", "SystemAssigned") == false }
    content {
      client_id                 = each.value.kubelet_identity_client_id
      object_id                 = each.value.kubelet_identity_object_id
      user_assigned_identity_id = each.value.kubelet_identity_user_assigned_identity_id
    }
  }


  dynamic "ingress_application_gateway" {
    for_each = each.value.ingress_application_gateway ? [1] : []
    content {
      gateway_id = each.value.ingress_application_gateway == true ? null : data.azurerm_application_gateway.application_gateway_id[each.key].id
    }
  }

  dynamic "oms_agent" {
    for_each = each.value.oms_agent_enabled ? [1] : []
    content {
      log_analytics_workspace_id = each.value.oms_agent_enabled == false ? null : data.azurerm_log_analytics_workspace.log_analytics_workspace[each.key].id
    }
  }


  dynamic "maintenance_window" {
    for_each = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "maintenance_window_enabled", true) == true }
    content {
      dynamic "allowed" {
        for_each = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "maintenance_window_allow_time_enabled", true) == true && lookup(v, "maintenance_window_enabled", true) == true }
        content {
          day   = each.value.maintenance_window_allow_time_day
          hours = each.value.maintenance_window_allow_time_hours
        }
      }
      dynamic "not_allowed" {
        for_each = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "maintenance_window_block_time_enabled", true) == true && lookup(v, "maintenance_window_enabled", true) == true }
        content {
          start = each.value.maintenance_window_block_starttime
          end   = each.value.maintenance_window_block_endtime
        }
      }
    }
  }

  dynamic "windows_profile" {
    for_each = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "windows_profile_enabled", true) == true }
    content {
      admin_username = each.value.windows_profile_admin_username
      admin_password = each.value.windows_profile_admin_password
      license        = each.value.windows_profile_license
    }
  }

  dynamic "linux_profile" {
    for_each = { for k, v in var.aks_cluster_variables : k => v if lookup(v, "linux_profile_enabled", true) == true }
    content {
      admin_username = each.value.linux_profile_admin_username
      ssh_key {
        key_data = each.value.linux_profile_ssh_key
      }
    }
  }

  identity {
    type = each.value.identity_type
    #user_assigned_identity_id = each.value.identity_type == "SystemAssigned" ? null : data.azurerm_user_assigned_identity.aks_user_identity[each.key].id
  }

  tags = merge(each.value.aks_cluster_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}






