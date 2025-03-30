terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" // Use a specific version range for stability
    }
  }

  required_version = ">= 1.3.0" // Ensure compatibility with Terraform version
}