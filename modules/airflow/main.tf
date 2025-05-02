resource "google_composer_environment" "airflow" {
  name   = var.name
  region = var.region
  project = var.project_id

  config {

    software_config {
      image_version = var.image_version
      airflow_config_overrides = var.airflow_config_overrides
      pypi_packages = var.pypi_packages
    }

    node_config {
      network      = var.network
      subnetwork   = var.subnetwork
      service_account = var.service_account
    }
  }
}
