variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region where the GKE cluster will be created"
  type        = string
  default     = "us-central1"
}

variable "network" {
  description = "The VPC network to use for the GKE cluster"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to use for the GKE cluster"
  type        = string
}

variable "namespaces" {
  description = "A list of namespaces to create in the GKE cluster"
  type        = list(string)
  default     = ["dev", "staging", "prod"]
}
