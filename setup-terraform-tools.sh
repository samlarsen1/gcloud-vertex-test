#!/bin/bash

set -euo pipefail

# Update and install required packages
sudo apt update
sudo apt install -y unzip software-properties-common python3 python3-pip python-is-python3 jq


# Install terraform-docs
echo "Installing terraform-docs..."
curl -sL "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E "https://.+?-linux-amd64.tar.gz")" | tar -xz terraform-docs
chmod +x terraform-docs
sudo mv terraform-docs /usr/bin/

# Install terrascan
echo "Installing terrascan..."
curl -sL "$(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" | tar -xz terrascan
sudo mv terrascan /usr/bin/
terrascan init

# Install tflint
echo "Installing tflint..."
curl -sL "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip
unzip tflint.zip
rm tflint.zip
sudo mv tflint /usr/bin/

# Install tfsec
echo "Installing tfsec..."
curl -sL "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" -o tfsec
chmod +x tfsec
sudo mv tfsec /usr/bin/

# Install trivy
echo "Installing trivy..."
curl -sL "$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep -o -E -m 1 "https://.+?/trivy_.+?_Linux-64bit.tar.gz")" | tar -xz trivy
sudo mv trivy /usr/bin/

# Install infracost
echo "Installing infracost..."
curl -sL "$(curl -s https://api.github.com/repos/infracost/infracost/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" | tar -xz
sudo mv infracost-linux-amd64 /usr/bin/infracost

# Install tfupdate
echo "Installing tfupdate..."
curl -sL "$(curl -s https://api.github.com/repos/minamijoyo/tfupdate/releases/latest | grep -o -E "https://.+?_linux_amd64.tar.gz")" | tar -xz tfupdate
sudo mv tfupdate /usr/bin/

# Install hcledit
echo "Installing hcledit..."
curl -sL "$(curl -s https://api.github.com/repos/minamijoyo/hcledit/releases/latest | grep -o -E "https://.+?_linux_amd64.tar.gz")" | tar -xz hcledit
sudo mv hcledit /usr/bin/

# Install shfmt
echo "Installing shfmt..."
curl -sL "$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest | grep -o -E "https://.+?/_linux_amd64")" -o shfmt
chmod +x shfmt
sudo mv shfmt /usr/bin/

DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}
