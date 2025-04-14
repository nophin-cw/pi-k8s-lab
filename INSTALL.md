# Pi K8s Lab Installation Guide

This guide walks through setting up a Kubernetes + Ansible lab using Raspberry Pi 5s.

## Requirements
- 3 Raspberry Pi 5s
- Ubuntu installed on each
- Hostnames:
  - k8s-master
  - k8s-worker1
  - k8s-worker2

## Setup Steps

1. Open a terminal on k8s-master
2. Run:
   ```bash
   mkdir -p pi-k8s-lab/ansible/{plays,roles/{tailscale,k3s-master,k3s-worker,grafana,awx}} scripts manifests dashboards
   cd pi-k8s-lab
   git init

