# AKS Module Change Log

## AKS module v1.0.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm 2.98
3. Tested compatibility with Terraform version 1.1.7

## AKS module v1.1.0 features and bug fixes:

1. Add changes implemented in new module version here
2. Use  az aks get-versions --location <region-name> to know available Kubernetes versions
3. For default node pool's orchestration version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
4. For default node pool's upgrade setting max_surge parameter If a percentage is provided, the number of surge nodes is calculated from the node_count value on the current cluster. 
   Node surge can allow a cluster to have more nodes than max_count during an upgrade. Ensure that your cluster has enough IP space during an upgrade.
5. If you specify the default_node_pool vnet_subnet_id, be sure to include the Subnet CIDR in the no_proxy list.   
6. If specifying ingress_application_gateway in conjunction with only_critical_addons_enabled, the AGIC pod will fail to start. 
   A separate azurerm_kubernetes_cluster_node_pool is required to run the AGIC pod successfully. This is because AGIC is classed as a "non-critical addon".
7. When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
8. Set outbound_ip_address_ids to an empty slice [] in order to unlink it from the cluster. Unlinking a outbound_ip_address_ids will revert the load balancing for the cluster back to a managed one.
9. Set outbound_ip_prefix_ids to an empty slice [] in order to unlink it from the cluster. Unlinking a outbound_ip_prefix_ids will revert the load balancing for the cluster back to a managed one.
10. The fields managed_outbound_ip_count, outbound_ip_address_ids and outbound_ip_prefix_ids are mutually exclusive. Note that when specifying outbound_ip_address_ids (azurerm_public_ip) the SKU must be standard.
11. The kubernetes_cluster_oidc_issuer_enabled parameter requires that the Preview Feature Microsoft.ContainerService/EnableOIDCIssuerPreview is enabled and the Resource Provider is re-registered, see the documentation for more information.
12. For parameter kubernetes_cluster_node_resource_group_name Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
13. If you use BYO DNS Zone, AKS cluster should either use a User Assigned Identity or a service principal (which is deprecated) with the Private DNS Zone Contributor role and access to this Private DNS Zone. If UserAssigned identity is used - to prevent improper resource order destruction - cluster should depend on the role assignment,
14. The parameter kubernetes_cluster_private_cluster_public_fqdn_enabled requires that the Preview Feature Microsoft.ContainerService/EnablePrivateClusterPublicFQDN is enabled and the Resource Provider is re-registered,
15. If kubernetes_cluster_network_profile is not defined, kubenet profile will be used by default.
16. When kubernetes_cluster_public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges.
17. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically. 
	Cluster Auto-Upgrade only updates to GA versions of Kubernetes and will not update to Preview versions.
18. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
19. At this time there's a bug in the AKS API where Tags for a Node Pool are not stored in the correct case
20. network_profile_network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future.
21. When network_profile_network_policy is set to azure, the network_profile_network_plugin field can only be set to azure.
22. For network_profile_service_cidr, the  range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
23. To configure dual-stack networking network_profile_ip_versions should be set to ["IPv4", "IPv6"]

## AKS module v1.2.0 features and bug fixes:

1. Upgraded the azurerm version to 3.33.0 and terraform v1.3.0
2. Tested by running terraform plan and apply. Module works as expected.

## AKS module v1.3.0 features and bug fixes:

1. Upgraded the azurerm version to 3.75.0 and terraform v1.6.2
2. Tested by running terraform plan and apply. Module works as expected.
3. Updated the module with the following new arguments:
   - api_server_access_profile
   - confidential_computing
   - custom_ca_trust_certificates_base64
   - image_cleaner_enabled
   - image_cleaner_interval_hours
   - key_management_service
   - maintenance_window_auto_upgrade
   - maintenance_window_node_os
   - monitor_metrics
   - node_os_channel_upgrade
   - service_mesh_profile
   - storage_profile