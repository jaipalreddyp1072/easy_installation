#!/bin/bash

# Define variables
KUBECTL_VERSION="1.33.0"
RELEASE_DATE="2025-05-01"
ARCH="amd64"
OS="linux"
BASE_URL="https://s3.us-west-2.amazonaws.com/amazon-eks/${KUBECTL_VERSION}/${RELEASE_DATE}/bin/${OS}/${ARCH}"

# Download kubectl binary and its SHA256 checksum
echo "Downloading kubectl and checksum..."
curl -O "${BASE_URL}/kubectl"
curl -O "${BASE_URL}/kubectl.sha256"

# Verify the checksum
echo "Verifying checksum..."
sha256sum -c kubectl.sha256

# Make the kubectl binary executable
chmod +x ./kubectl

# Move it to a user bin directory
mkdir -p "$HOME/bin"
cp ./kubectl "$HOME/bin/kubectl"

# Add to PATH temporarily and persistently
export PATH="$HOME/bin:$PATH"
if ! grep -q 'export PATH=$HOME/bin:$PATH' ~/.bashrc; then
  echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
fi

# Display kubectl version
echo "kubectl version:"
kubectl version --client

