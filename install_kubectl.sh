#!/bin/bash

set -euo pipefail

# Define variables
KUBECTL_VERSION="1.33.0"
RELEASE_DATE="2025-05-01"
ARCH="amd64"
OS="linux"
BASE_URL="https://s3.us-west-2.amazonaws.com/amazon-eks/${KUBECTL_VERSION}/${RELEASE_DATE}/bin/${OS}/${ARCH}"

# Download kubectl binary and checksum
echo "Downloading kubectl and checksum..."
curl -sS -O "${BASE_URL}/kubectl"
curl -sS -O "${BASE_URL}/kubectl.sha256"

# Verify checksum
echo "Verifying checksum..."
sha256sum -c kubectl.sha256 || { echo "Checksum verification failed!"; exit 1; }

# Make it executable
chmod +x ./kubectl

# Move to user local bin
mkdir -p "$HOME/bin"
cp ./kubectl "$HOME/bin/kubectl"

# Add $HOME/bin to PATH temporarily
export PATH="$HOME/bin:$PATH"

# Persist $HOME/bin to PATH in .bashrc (if not already added)
if ! grep -Fxq 'export PATH="$HOME/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
  echo "Added PATH to ~/.bashrc"
fi

# Print version to confirm
echo "kubectl version:"
"$HOME/bin/kubectl" version --client
