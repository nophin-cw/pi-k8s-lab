#!/bin/bash

# Reset the K3s cluster and rebuild using Tailscale IP

# === CONFIG ===
MASTER_IP="100.89.121.96"  # Replace with your master Pi's Tailscale IP
K3S_TOKEN="PASTE_YOUR_TOKEN_HERE_AFTER_MASTER_SETUP"

echo "🚨 WARNING: This will wipe all K3s data and reset the cluster."

read -p "Are you on the MASTER node? (yes/no): " yn
if [ "$yn" != "yes" ]; then
  echo "❌ Run this on the master first."
  exit 1
fi

echo "🧹 Uninstalling K3s from master..."
sudo /usr/local/bin/k3s-uninstall.sh

echo "🛠️ Reinstalling K3s with TLS-SAN: $MASTER_IP..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--tls-san $MASTER_IP" sh -

echo "📁 Setting up kubeconfig..."
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
sed -i "s/127.0.0.1/$MASTER_IP/" ~/.kube/config

echo "✅ Master reinstalled! Run the following on each worker:"
echo ""
echo "    sudo /usr/local/bin/k3s-agent-uninstall.sh"
echo "    curl -sfL https://get.k3s.io | K3S_URL=\"https://$MASTER_IP:6443\" K3S_TOKEN=\"$K3S_TOKEN\" sh -"
echo ""

