#!/bin/bash

set -euo pipefail

# Update and install required packages
sudo apt update
sudo apt install -y unzip software-properties-common python3 python3-pip python-is-python3 jq

# Upgrade pip and install Python tools
python3 -m pip install --upgrade pip
pip3 install --no-cache-dir pre-commit checkov

# Install terraform-docs
curl -sL "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E "https://.+?-linux-amd64.tar.gz")" | tar -xz terraform-docs
chmod +x terraform-docs
sudo mv terraform-docs /usr/bin/

# Install terrascan
curl -sL "$(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" | tar -xz terrascan
sudo mv terrascan /usr/bin/
terrascan init

# Install tflint
curl -sL "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip
unzip tflint.zip
rm tflint.zip
sudo mv tflint /usr/bin/

# Install tfsec
curl -sL "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E "https://.+?tfsec-linux-amd64")" -o tfsec
chmod +x tfsec
sudo mv tfsec /usr/bin/

# Install trivy
curl -sL "$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep -o -E "https://.+?/trivy_.+?_Linux-64bit.tar.gz")" | tar -xz trivy
sudo mv trivy /usr/bin/

# Install infracost
curl -sL "$(curl -s https://api.github.com/repos/infracost/infracost/releases/latest | grep -o -E "https://.+?-linux-amd64.tar.gz")" | tar -xz
sudo mv infracost-linux-amd64 /usr/bin/infracost
infracost auth login

# Install tfupdate
curl -sL "$(curl -s https://api.github.com/repos/minamijoyo/tfupdate/releases/latest | grep -o -E "https://.+?_linux_amd64.tar.gz")" | tar -xz tfupdate
sudo mv tfupdate /usr/bin/

# Install hcledit
curl -sL "$(curl -s https://api.github.com/repos/minamijoyo/hcledit/releases/latest | grep -o -E "https://.+?_linux_amd64.tar.gz")" | tar -xz hcledit
sudo mv hcledit /usr/bin/

DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}