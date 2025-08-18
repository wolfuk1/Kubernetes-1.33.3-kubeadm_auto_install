#!/bin/bash
set -e

echo "[INFO] === Начало установки компонентов Kubernetes ==="

echo "[INFO] Добавляем репозиторий Kubernetes..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "[INFO] Устанавливаем kubelet, kubeadm и kubectl..."
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "[INFO] Включаем и запускаем kubelet..."
sudo systemctl enable --now kubelet

echo "[INFO] === Установка компонентов Kubernetes завершена успешно ==="