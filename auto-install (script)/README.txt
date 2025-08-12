Тут находятся скрипты для автоматической установки K8S kubeadm.
Скрипты выгружают последнюю стабильную версию и устанавливают необходимые компоненты.
Проверена следующая связка:
- kubeadm
- kubectl
- kubelet
- ETCD
- Docker/Containerd.io

HOW TO USE:
cd /var/tmp/  
git clone 
cd r
chmod +x *.sh
./install_k8s_cluster.sh

Если выбивает ошибки, то попробуйте выполнить установку руками:
hand-install в репоризитории

