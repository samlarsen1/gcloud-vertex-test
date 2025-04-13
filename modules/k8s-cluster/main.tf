resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = 1 # Default node count for the default node pool

  # Enable basic GKE features
  remove_default_node_pool = true
  network                  = var.network
  subnetwork               = var.subnetwork

}

# Create a small node pool with minimal resources
resource "google_container_node_pool" "small_node_pool" {
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  name       = "small-node-pool"
  node_count = 1

  node_config {
    machine_type = "e2-small" # Minimal resource configuration
    disk_size_gb = 10         # Small disk size
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

# Create namespaces in the GKE cluster
resource "kubernetes_namespace" "namespace" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.key
  }
}
