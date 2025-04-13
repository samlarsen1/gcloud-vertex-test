output "gke_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_node_pools" {
  description = "The node pools in the GKE cluster"
  value       = google_container_node_pool.small_node_pool.name
}
