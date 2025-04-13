variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "europe-west1"
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "gcp-test"
}
variable "notebook_name" {
  description = "The name of the Vertex AI Workbench notebook"
  type        = string
  default     = "notebook"
}
variable "kafka_cluster_name" {
  description = "The name of the Confluent Kafka cluster"
  type        = string
  default     = "kafka-cluster"
}

variable "machine_type" {
  description = "The machine type for the notebook instance"
  type        = string
  default     = "n1-standard-4"
}

variable "install_gpu_driver" {
  description = "Whether to install GPU drivers"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment label for the notebook (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}
