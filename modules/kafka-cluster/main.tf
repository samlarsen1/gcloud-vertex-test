
data "google_project" "project" {
}

resource "google_managed_kafka_cluster" "example" {
  cluster_id = var.cluster_name
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
  cluster = google_managed_kafka_cluster.example.id
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
  cluster = google_managed_kafka_cluster.example.id
  location = var.region
  partition_count = 1
  replication_factor = 2
  configs = {
    "cleanup.policy" = "compact"
  }
}
