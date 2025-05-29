#!/bin/bash

# Exit on error
set -e

# Set architecture and platform
ARCH="amd64"
PLATFORM="$(uname -s)_$ARCH"

# Define filenames and download URLs
TAR_FILE="eksctl_${PLATFORM}.tar.gz"
CHECKSUM_FILE="eksctl_checksums.txt"
DOWNLOAD_BASE_URL="https://github.com/eksctl-io/eksctl/releases/latest/download"

# Define Jenkins-writable bin directory
BIN_DIR="/var/lib/jenkins/tools/bin"
mkdir -p "$BIN_DIR"

# Move to temporary working directory
cd /tmp

# Download eksctl and checksum file
echo "Downloading eksctl and checksum..."
curl -sLO "${DOWNLOAD_BASE_URL}/${TAR_FILE}"
curl -sLO "${DOWNLOAD_BASE_URL}/${CHECKSUM_FILE}"

# Verify checksum
echo "Verifying checksum..."
grep "$PLATFORM" "$CHECKSUM_FILE" | sha256sum --check

# Extract and install eksctl
echo "Extracting and installing eksctl..."
tar -xzf "$TAR_FILE" -C /tmp
cp /tmp/eksctl "$BIN_DIR/eksctl"

# Clean up
rm "$TAR_FILE" "$CHECKSUM_FILE"

echo "eksctl installed successfully!"
"$BIN_DIR/eksctl" version

echo ""
echo "✅ Add the following to your PATH in Jenkins job or global config:"
echo "export PATH=$BIN_DIR:\$PATH"

