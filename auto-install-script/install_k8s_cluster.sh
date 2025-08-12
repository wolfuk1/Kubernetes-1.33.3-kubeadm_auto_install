#!/bin/bash
set -e

echo "[INFO] === Начало установки Kubernetes кластера ==="

# Установка etcd
echo "[INFO] Запускаем установку etcd..."
./install_etcd.sh

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

echo "[INFO] Создание файла kubeadm-init.yaml..."
./create_kubeadm_init.sh

echo "[INFO] === Установка Kubernetes кластера завершена успешно ==="
echo "[INFO] Для инициализации кластера выполните:"
echo "в /etc/etcd/etcd.conf внесите свои ip-адреса"
echo "systemctl start etcd на каждой мастер-ноде"
echo "в kubeadm.yaml внесите свои ip-адреса и dns-имя мастер нод"
echo "выполните kubeadm init --config=kubeadm-init.yaml"
# Для связанности нод требуется еще установить сетевой плагин: calico/flannel
echo "------------------------------------------------------------"
echo "Если выбивает ошибки - можете попробовать ручную установку:"
echo ""

