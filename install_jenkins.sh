#!/bin/bash

# Exit on any error
set -e

echo "Updating system packages..."
sudo apt update -y

echo "Installing OpenJDK 21..."
sudo apt install openjdk-21-jre-headless -y

echo "Verifying Java installation..."
java -version

echo "Adding Jenkins key and repository..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "Adding Jenkins source list..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package index..."
sudo apt-get update

echo "Installing Jenkins..."
sudo apt-get install jenkins -y

echo "Jenkins installation complete."
