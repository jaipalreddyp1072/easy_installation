#!/bin/bash

# Set architecture and platform
ARCH="amd64"
PLATFORM="$(uname -s)_$ARCH"

# Define filenames
TAR_FILE="eksctl_${PLATFORM}.tar.gz"
CHECKSUM_FILE="eksctl_checksums.txt"

# Download eksctl tarball and checksum file
echo "Downloading eksctl and checksum file..."
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/${TAR_FILE}"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/${CHECKSUM_FILE}" -o ${CHECKSUM_FILE}

# Verify the checksum
echo "Verifying checksum..."
grep "$PLATFORM" "$CHECKSUM_FILE" | sha256sum --check

# Extract and move binary
echo "Extracting and installing eksctl..."
tar -xzf "$TAR_FILE" -C /tmp
rm "$TAR_FILE"
sudo mv /tmp/eksctl /usr/local/bin

# Show installed version
echo "eksctl version:"
eksctl version

