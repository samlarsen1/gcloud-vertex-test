locals {
  install_vertex_workbench = false
  install_kafka = false
  install_k8s = false
  full_notebook_name    = "${var.name_prefix}-${var.notebook_name}"
  full_kafka_cluster_name = "${var.name_prefix}-${var.kafka_cluster_name}"
  main_zone = "${var.region}-b" // Define the main zone
}


module "vertex_workbench" {
  source = "./modules/vertex-workbench"
  count = abs(local.install_vertex_workbench ? 1 : 0)
  region     = var.region
  name = local.full_notebook_name
}

module "kafka_cluster" {
  source = "./modules/kafka-cluster"
  count = abs(local.install_kafka ? 1 : 0)
  region = var.region
  cluster_name   = local.full_kafka_cluster_name
}


module "k8s_cluster" {
  source       = "./modules/k8s-cluster"
  count       = abs(local.install_k8s ? 1 : 0)
  cluster_name = "my-gke-cluster"
  region       = "us-central1"
  network      = "default"
  subnetwork   = "default"
  namespaces   = ["dev", "staging", "prod"]
}
