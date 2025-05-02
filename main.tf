locals {
  install_vertex_workbench = false
  install_kafka = false
  install_k8s = false
  full_notebook_name    = "${var.name_prefix}-${var.notebook_name}"
  full_kafka_cluster_name = "${var.name_prefix}-${var.kafka_cluster_name}"
  main_zone = "${var.region}-b" // Define the main zone
}

resource "google_project_service" "composer" {
  project = var.project_id
  service = "composer.googleapis.com"
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "storage" {
  project = var.project_id
  service = "storage.googleapis.com"
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
  namespaces   = ["dev"]  #, "staging", "prod"]
}

# Create a service account for Cloud Composer
resource "google_service_account" "composer_service_account" {
  account_id   = "${var.name_prefix}-composer-sa"
  display_name = "Service Account for Cloud Composer"
  project      = var.project_id
}

# Assign roles to the service account
resource "google_project_iam_member" "composer_roles" {
  for_each = toset([
    "roles/composer.worker",
    "roles/storage.objectAdmin",
    "roles/iam.serviceAccountUser",
    "roles/cloudsql.client",
    "roles/pubsub.editor"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.composer_service_account.email}"
}

module "airflow" {
  source       = "./modules/airflow"
  name         = "my-airflow-environment"
  region       = "us-central1"
  project_id   = var.project_id
  node_count   = 3
  machine_type = "n1-standard-1"
  disk_size_gb = 100
  network      = "default"
  subnetwork   = "default"
  service_account = google_service_account.composer_service_account.email
  image_version   = "composer-3-airflow-2.10.5"

  airflow_config_overrides = {
    "core-dag_concurrency" = "10"
    "core-max_active_runs_per_dag" = "5"
  }

  pypi_packages = {
    "apache-beam" = "2.40.0"
    "pandas"      = "1.3.3"
  }
}
