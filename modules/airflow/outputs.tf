output "composer_environment_name" {
  description = "The name of the Cloud Composer environment"
  value       = google_composer_environment.airflow.name
}

output "composer_environment_gke_cluster" {
  description = "The GKE cluster used by the Cloud Composer environment"
  value       = google_composer_environment.airflow.config[0].gke_cluster
}

output "composer_environment_bucket" {
  description = "The Cloud Storage bucket used by the Cloud Composer environment"
  value       = google_composer_environment.airflow.config[0].dag_gcs_prefix
}
