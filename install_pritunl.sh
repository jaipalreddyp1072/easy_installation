#!/bin/bash

set -e

echo "Updating system packages..."
apt update && apt upgrade -y

echo "Installing dependencies..."
apt install -y curl gnupg apt-transport-https ca-certificates lsb-release

echo "Adding MongoDB GPG key..."
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
  gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg

echo "Adding MongoDB 6.0 repo for Ubuntu Jammy..."
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

echo "Adding Pritunl repo..."
echo "deb https://repo.pritunl.com/stable/apt jammy main" | tee /etc/apt/sources.list.d/pritunl.list

echo "Adding Pritunl GPG key..."
curl -fsSL https://raw.githubusercontent.com/pritunl/pritunl/master/keys/pritunl_repo_pub.asc | \
  gpg --dearmor -o /usr/share/keyrings/pritunl-archive-keyring.gpg || true

# Use backup key method if above fails (GitHub sometimes changes links)
if [ ! -f /usr/share/keyrings/pritunl-archive-keyring.gpg ]; then
  curl -fsSL https://repo.pritunl.com/stable/apt/keys.asc | \
    gpg --dearmor -o /usr/share/keyrings/pritunl-archive-keyring.gpg
fi

echo "Updating APT cache..."
apt update

echo "Installing MongoDB and Pritunl..."
apt install -y mongodb-org pritunl

echo "Enabling and starting services..."
systemctl enable --now mongod
systemctl enable --now pritunl

echo "Installation complete."
systemctl status pritunl --no-pager


