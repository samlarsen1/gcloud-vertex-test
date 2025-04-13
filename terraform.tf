terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.2" // Use a specific version range for stability
    }

  }

  required_version = ">= 1.3.0" // Ensure compatibility with Terraform version
}
