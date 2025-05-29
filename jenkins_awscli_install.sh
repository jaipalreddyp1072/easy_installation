#!/bin/bash

set -e

INSTALL_DIR="/var/lib/jenkins/tools/aws-cli-v2"
BIN_DIR="/var/lib/jenkins/tools/bin"

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"
cd /tmp

echo "Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

echo "Unzipping..."
unzip -q awscliv2.zip

echo "Installing AWS CLI..."
./aws/install -i "$INSTALL_DIR" -b "$BIN_DIR"

echo "Installation complete. Add $BIN_DIR to your PATH to use aws."

