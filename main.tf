terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0" // Use a specific version range for stability
    }
  }

  required_version = ">= 1.3.0" // Ensure compatibility with Terraform version
}

provider "google" {
  project = var.project_id // Use variables for flexibility
  region  = var.region     // Use variables for flexibility
}


resource "google_notebooks_instance" "vertex_notebook" {
  name     = var.notebook_name // Use variables for naming
  location = "${var.region}-b" // Concatenate a zone suffix to the region variable

  machine_type = var.machine_type // Specify the machine type

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "tf-latest-cpu"
  }                                 

  labels = {
    environment = var.environment // Add labels for better resource organization
  }
}

