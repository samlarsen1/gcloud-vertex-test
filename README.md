# GCloud Vertex Test

This project demonstrates the use of GCloud Vertex AI for machine learning workflows.

## Prerequisites

Before setting up this project, ensure you have completed the setup steps in the [chromebook-setup](https://github.com/samlarsen1/chromebook-setup) project. This will install the necessary dependencies and tools required for this project.

## Setup

* Follow the instructions in the `chromebook-setup` repository to configure your environment.
  * Run `setup-gcloud-project.sh` so you have a project to use for testing
  * Associate a billing account to that project
* Run `setup-vars.sh` to add default environment variables for terraform.


## Usage

```bash

terraform init

gcloud auth application-default login

terraform plan

# Create resources in gcp project
#   You may get an error that Notebooks API is disabled on your new project, if so, follow the link to enable the API
#   NOTE: These resources could be expensive, make sure you remove them with terraform destroy below

terraform apply



```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.