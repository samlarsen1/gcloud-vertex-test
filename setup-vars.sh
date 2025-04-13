#!/bin/bash

# Get the default project ID from gcloud
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)

# Check if the project ID was retrieved successfully
if [ -z "$PROJECT_ID" ]; then
  echo "Error: No default project ID found in gcloud configuration."
  echo "Please set a default project using 'gcloud config set project PROJECT_ID'."
  exit 1
fi

# Create or update the terraform.tfvars file with the project ID
TFVARS_FILE="terraform.tfvars"

echo "project_id = \"$PROJECT_ID\"" > "$TFVARS_FILE"

echo "Default project ID ($PROJECT_ID) has been written to $TFVARS_FILE."

# Extract the region variable from variables.tf
REGION=$(grep -E '^variable "region"' variables.tf -A 3 | grep 'default' | sed -E 's/.*default *= *"([^"]+)".*/\1/')

# Check if the region was retrieved successfully
if [ -z "$REGION" ]; then
    echo "Error: No default region found in variables.tf."
    echo "Please ensure variables.tf contains a 'region' variable with a default value."
    exit 1
fi

# Set the region in gcloud configuration
gcloud config set compute/region "$REGION"

echo "Default region ($REGION) has been set in gcloud configuration."
