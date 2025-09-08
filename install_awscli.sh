#!/bin/bash

# Exit on any error
set -e

# Download AWS CLI v2
echo "Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Install unzip if not already installed
if ! command -v unzip &> /dev/null; then
    echo "Installing unzip..."
    apt-get update -y
    apt-get install -y unzip
fi

# Unzip the AWS CLI installer
echo "Unzipping AWS CLI..."
unzip -o awscliv2.zip

# Install the AWS CLI
echo "Installing AWS CLI..."
./aws/install --update

# Confirm installation
echo "AWS CLI installed successfully!"
aws --version
