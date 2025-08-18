#!/bin/bash
set -e

echo "[INFO] === Начало настройки iptables ==="

echo "[INFO] Устанавливаем iptables-persistent..."
sudo apt install -y iptables-persistent

echo "[INFO] Открываем порты для мастер-ноды..."
echo "[INFO] Kubernetes API (6443)"
sudo iptables -A INPUT -p tcp --dport 6443 -j ACCEPT
echo "[INFO] Etcd client and peer (2379-2380)"
sudo iptables -A INPUT -p tcp --dport 2379:2380 -j ACCEPT
echo "[INFO] Kubelet API (10250)"
sudo iptables -A INPUT -p tcp --dport 10250 -j ACCEPT
echo "[INFO] Kube Scheduler (10251)"
sudo iptables -A INPUT -p tcp --dport 10251 -j ACCEPT
echo "[INFO] Kube Controller Manager (10252)"
sudo iptables -A INPUT -p tcp --dport 10252 -j ACCEPT

echo "[INFO] Сохраняем правила iptables..."
sudo iptables-save > /etc/iptables/rules.v4

echo "[INFO] === Настройка iptables завершена успешно ==="