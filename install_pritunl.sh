#!/usr/bin/env bash
set -euo pipefail

# 1. Update and install prerequisites
echo "=== 1. Update system and install prerequisites ==="
sudo apt update -y
sudo apt install -y gnupg curl lsb-release ca-certificates apt-transport-https

# 2. Clean up any old Pritunl entries
echo
echo "=== 2. Remove old Pritunl repo/key if present ==="
sudo rm -f /etc/apt/sources.list.d/pritunl.list
sudo rm -f /usr/share/keyrings/pritunl.gpg

# 3. Add the Pritunl APT repository
echo
echo "=== 3. Add Pritunl repository for jammy ==="
sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null <<EOF
deb [signed-by=/usr/share/keyrings/pritunl.gpg] https://repo.pritunl.com/stable/apt $(lsb_release -cs) main
EOF

# 4. Fetch and install the Pritunl GPG key
echo
echo "=== 4. Fetch and install Pritunl GPG key ==="
curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc \
  | sudo gpg --dearmor -o /usr/share/keyrings/pritunl.gpg

# 5. Update APT and install Pritunl
echo
echo "=== 5. Update APT and install Pritunl ==="
sudo apt update -y
sudo apt install -y pritunl

# 6. Enable and start the Pritunl service
echo
echo "=== 6. Enable & start Pritunl service ==="
sudo systemctl enable pritunl
sudo systemctl start pritunl

echo
echo "✅ Pritunl has been installed and started successfully!"
echo "Access the web UI at https://<YOUR_SERVER_IP>/"
echo "Get your setup key with:    sudo pritunl setup-key"
echo "Get your default password with: sudo pritunl default-password"
