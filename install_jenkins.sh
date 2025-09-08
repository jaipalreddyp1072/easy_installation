#!/bin/bash
set -e

echo "🔹 Updating package index..."
sudo apt update -y

echo "🔹 Installing prerequisites..."
sudo apt install -y curl gnupg fontconfig openjdk-21-jdk

echo "🔹 Adding Jenkins GPG key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "🔹 Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔹 Updating package index with Jenkins repo..."
sudo apt update -y

echo "🔹 Installing/Upgrading Jenkins (latest stable)..."
sudo apt install -y jenkins

echo "✅ Jenkins installation/upgrade complete."
echo "👉 You can check version with:  systemctl status jenkins"
