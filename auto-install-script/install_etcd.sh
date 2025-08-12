#!/bin/bash
set -e

echo "[INFO] === Начало установки etcd ==="
echo "[INFO] Получаем последнюю версию etcd с GitHub..."
ETCD_VER=$(curl -s https://api.github.com/repos/etcd-io/etcd/releases/latest | grep tag_name | cut -d '"' -f4)

echo "[INFO] Скачиваем etcd $ETCD_VER..."
wget -q --show-progress https://github.com/etcd-io/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz

echo "[INFO] Распаковываем архив..."
tar xzvf etcd-${ETCD_VER}-linux-amd64.tar.gz

echo "[INFO] Перемещаем бинарники в /usr/local/bin..."
sudo mv etcd-${ETCD_VER}-linux-amd64/etcd /usr/local/bin/
sudo mv etcd-${ETCD_VER}-linux-amd64/etcdctl /usr/local/bin/

echo "[INFO] Очищаем временные файлы..."
rm -rf etcd-${ETCD_VER}-linux-amd64*

export PATH="$PATH:/usr/local/bin"
cd /

echo "[INFO] Создаем пользователя etcd..."
sudo adduser --system --no-create-home --group etcd

echo "[INFO] Создаем директории для etcd..."
sudo mkdir -p /etc/etcd /var/lib/etcd
sudo chown etcd:etcd /var/lib/etcd

echo "[INFO] Создаем файл конфигурации etcd.service..."
sudo cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd - highly-available key value store
Documentation=https://etcd.io/docs
Documentation=man:etcd
After=network.target
Wants=network-online.target

[Service]
EnvironmentFile=/etc/etcd/etcd.conf
Type=notify
User=etcd
Group=etcd
PermissionsStartOnly=true
ExecStart=/usr/local/bin/etcd
Restart=on-abnormal
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

echo "[INFO] Создаем файл конфигурации etcd.conf..."
sudo cat <<EOF | sudo tee /etc/etcd/etcd.conf
ETCD_NAME="VM5"
ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"
ETCD_ADVERTISE_CLIENT_URLS="http://192.168.110.165:2379"
ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://192.168.110.165:2380"
ETCD_INITIAL_CLUSTER_TOKEN="EtcdKuberCluster"
ETCD_INITIAL_CLUSTER="VM5=http://192.168.110.165:2380,VM6=http://192.168.110.166:2380"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_DATA_DIR="/var/lib/etcd"
ETCD_ELECTION_TIMEOUT="5000"
ETCD_HEARTBEAT_INTERVAL="1000"
EOF

echo "[INFO] Перезагружаем systemd и включаем etcd..."
sudo systemctl daemon-reload
sudo systemctl enable etcd

echo "[INFO] Проверяем версию etcd:"
etcd --version
echo "[INFO] Проверяем версию etcdctl:"
etcdctl version

echo "[INFO] === Установка etcd завершена успешно ==="