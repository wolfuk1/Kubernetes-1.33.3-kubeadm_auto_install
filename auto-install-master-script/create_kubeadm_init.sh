#!/bin/bash
set -e

echo "[INFO] === Создание конфигурационного файла kubeadm-init.yaml ==="

CONFIG_FILE="/root/kubeadm-init.yaml"

echo "[INFO] Создаем файл конфигурации kubeadm-init.yaml..."
cat <<EOF | sudo tee $CONFIG_FILE
apiVersion: kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration
kubernetesVersion: v1.33.3
clusterName: kubernetes
controlPlaneEndpoint: "192.168.110.165:6443"
networking:
  podSubnet: "192.168.120.0/16"
etcd:
  external:
    endpoints:
      - http://192.168.110.165:2379
      - http://192.168.110.166:2379
certificatesDir: /etc/kubernetes/pki
apiServer:
  certSANs:
    - "192.168.110.165"
    - "192.168.110.166"
    - "127.0.0.1"
    - "vm5"
    - "vm6"
---
apiVersion: kubeadm.k8s.io/v1beta4
kind: InitConfiguration
nodeRegistration:
  criSocket: "unix:///run/containerd/containerd.sock"
EOF

echo "[INFO] Проверяем созданный файл конфигурации:"
ls -l $CONFIG_FILE

echo "[INFO] === Файл kubeadm-init.yaml успешно создан /root/kubeamd-init.yaml ==="