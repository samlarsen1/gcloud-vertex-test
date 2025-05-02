variable "name" {
  description = "The name of the Cloud Composer environment"
  type        = string
}

variable "region" {
  description = "The region where the Cloud Composer environment will be created"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the environment"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "The machine type for the environment nodes"
  type        = string
  default     = "n1-standard-1"
}

variable "disk_size_gb" {
  description = "The disk size for each node in the environment"
  type        = number
  default     = 100
}

variable "network" {
  description = "The VPC network to use for the environment"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to use for the environment"
  type        = string
}

variable "service_account" {
  description = "The service account to use for the environment"
  type        = string
}

variable "image_version" {
  description = "The version of the Cloud Composer image to use"
  type        = string
  default     = "composer-2.0.30-airflow-2.5.1"
}

variable "airflow_config_overrides" {
  description = "Airflow configuration overrides"
  type        = map(string)
  default     = {}
}

variable "pypi_packages" {
  description = "PyPI packages to install in the environment"
  type        = map(string)
  default     = {}
}
