#KUBERNETES CLUSTER OUTPUT
output "kubernetes_cluster_output" {
  value       = module.kubernetes_cluster.kubernetes_cluster_output
  description = "The Kubernetes cluster output"
}