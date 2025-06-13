#!/usr/bin/env bash
set -euo pipefail

# 1. Update and install prerequisites
echo "=== 1. Update system and install prerequisites ==="
sudo apt update -y
sudo apt install -y gnupg curl lsb-release ca-certificates apt-transport-https software-properties-common

# 2. Install MongoDB
echo
echo "=== 2. Add MongoDB repository and install MongoDB ==="
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
  sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg

echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

sudo apt update -y
sudo apt install -y mongodb-org

echo
echo "=== 3. Enable and start MongoDB ==="
sudo systemctl enable mongod
sudo systemctl start mongod

# 4. Clean up any old Pritunl entries
echo
echo "=== 4. Remove old Pritunl repo/key if present ==="
sudo rm -f /etc/apt/sources.list.d/pritunl.list
sudo rm -f /usr/share/keyrings/pritunl.gpg

# 5. Add the Pritunl APT repository
echo
echo "=== 5. Add Pritunl repository for jammy ==="
sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null <<EOF
deb [signed-by=/usr/share/keyrings/pritunl.gpg] https://repo.pritunl.com/stable/apt $(lsb_release -cs) main
EOF

# 6. Fetch and install the Pritunl GPG key
echo
echo "=== 6. Fetch and install Pritunl GPG key ==="
curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc \
  | sudo gpg --dearmor -o /usr/share/keyrings/pritunl.gpg

# 7. Update APT and install Pritunl
echo
echo "=== 7. Update APT and install Pritunl ==="
sudo apt update -y
sudo apt install -y pritunl

# 8. Enable and start the Pritunl service
echo
echo "=== 8. Enable & start Pritunl service ==="
sudo systemctl enable pritunl
sudo systemctl start pritunl

echo
echo "✅ Pritunl and MongoDB have been installed and started successfully!"
echo "Access the web UI at: https://<YOUR_SERVER_IP>/"
echo "Get your setup key:      sudo pritunl setup-key"
echo "Get default credentials: sudo pritunl default-password"
