#!/bin/bash
set -e

echo "[INFO] === Начало установки Kubernetes кластера ==="

# Настройка сети
echo "[INFO] Запускаем настройку сети..."
./setup_network.sh

# Настройка iptables
echo "[INFO] Запускаем настройку iptables..."
./setup_iptables.sh

# Установка Docker/containerd
echo "[INFO] Запускаем установку Docker и containerd..."
./install_docker_containerd.sh

# Установка компонентов K8S
echo "[INFO] Запускаем установку компонентов Kubernetes..."
./install_k8s_components.sh

echo "[INFO] === Установка Kubernetes кластера завершена успешно ==="
echo "[INFO] Для инициализации кластера выполните:"
echo ""
echo "[!!!!] Завершение установки посмотрите в файле README [!!!!]"

