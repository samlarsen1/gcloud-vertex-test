locals {
  install_vertex_workbench = false
  install_kafka = true
  full_notebook_name    = "${var.name_prefix}-${var.notebook_name}"
  full_kafka_cluster_name = "${var.name_prefix}-${var.kafka_cluster_name}"
  main_zone = "${var.region}-b" // Define the main zone
}

data "google_project" "project" {
}



resource "google_workbench_instance" "vertex_notebook" {
  count = local.install_vertex_workbench ? 1 : 0
  name     = local.full_notebook_name // Use variables for naming
  location = "${var.region}-b" // Concatenate a zone suffix to the region variable
}


resource "google_managed_kafka_cluster" "example" {
  count = local.install_kafka ? 1 : 0
  cluster_id = local.full_kafka_cluster_name
  location = var.region
  capacity_config {
    vcpu_count = 3
    memory_bytes = 1073741824
  }
  gcp_config {
    access_config {
      network_configs {
        subnet = "projects/${data.google_project.project.number}/regions/${var.region}/subnetworks/default"
      }
    }
  }
  rebalance_config {
    mode = "AUTO_REBALANCE_ON_SCALE_UP"
  }
}

# Create a Kafka topic for incoming communications
resource "google_managed_kafka_topic" "incoming_comms" {
  depends_on = [google_managed_kafka_cluster.example]
  topic_id       = "incoming-comms"
  cluster = google_managed_kafka_cluster.example[0].id
  location = var.region
  partition_count = 1
  replication_factor = 2
  configs = {
    "cleanup.policy" = "compact"
  }
}

# Create a Kafka topic for outgoing communications
resource "google_managed_kafka_topic" "outgoing_comms" {
  depends_on = [google_managed_kafka_cluster.example]
  topic_id       = "outgoing-comms"
  cluster = google_managed_kafka_cluster.example[0].id
  location = var.region
  partition_count = 1
  replication_factor = 2
  configs = {
    "cleanup.policy" = "compact"
  }
}

module "k8s_cluster" {
  source       = "./modules/k8s-cluster"
  cluster_name = "my-gke-cluster"
  region       = "us-central1"
  network      = "default"
  subnetwork   = "default"
  namespaces   = ["dev", "staging", "prod"]
}
