#!/bin/bash
set -e

echo "[INFO] === Начало установки Docker и containerd ==="

echo "[INFO] Добавляем репозиторий Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "[INFO] Устанавливаем Docker и containerd..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "[INFO] Настраиваем containerd..."
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

echo "[INFO] Перезапускаем containerd..."
sudo systemctl restart containerd

echo "[INFO] === Установка Docker и containerd завершена успешно ==="