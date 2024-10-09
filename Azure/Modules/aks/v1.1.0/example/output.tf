output "managed_cluster_id" {
  value = module.aks[*].managed_cluster_id
}

output "aks_principle_id" {
  value = module.aks[*].aks_principle_id
}

