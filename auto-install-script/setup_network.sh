#!/bin/bash
set -e

echo "[INFO] === Начало настройки сети ==="

echo "[INFO] Настраиваем модули ядра..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

echo "[INFO] Загружаем модули ядра..."
sudo modprobe overlay
sudo modprobe br_netfilter

echo "[INFO] Настраиваем сетевые параметры..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

echo "[INFO] Применяем изменения сети..."
sudo sysctl --system

echo "[INFO] === Настройка сети завершена успешно ==="