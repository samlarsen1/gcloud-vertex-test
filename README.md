# GCloud Vertex Test

This project demonstrates the use of GCloud Vertex AI for machine learning workflows.

## Prerequisites

Before setting up this project, ensure you have completed the setup steps in the [chromebook-setup](https://github.com/samlarsen1/chromebook-setup) project. This will install the necessary dependencies and tools required for this project.

## Setup

* Follow the instructions in the `chromebook-setup` repository to configure your environment.
  * Run `setup-gcloud-project.sh` so you have a project to use for testing
  * Associate a billing account to that project
* Run `setup-vars.sh` to add default environment variables for terraform.
* Install `pre-commit` dependencies
  * Run`setup-terraform-tools.sh` for additional tf quality tools
  * Install python `pre-commit` tools with venv
    ```bash
    python3 -m venv ~/.venvs/terraform-tools
    source ~/.venvs/terraform-tools/bin/activate
    pip3 install --no-cache-dir pre-commit checkov
    pre-commit install
    ```


## Usage

```bash

terraform init

gcloud auth application-default login

terraform plan

# Create resources in GCP project
#   You may encounter an error indicating that the Notebooks API is
#   disabled on your new project. If this happens, follow the provided
#   link to enable the API.

#   **Note:** These resources could be expensive. Ensure you remove
#   them using `terraform destroy` after you are done.

terraform apply

# Log in to the console and play with the workbench instance

# Remember to destroy to manage costs
terraform destroy

```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
