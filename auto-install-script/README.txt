УСТАНОВКА ПРОИЗВОДИТСЯ НА ЧИСТУЮ СИСТЕМУ, БЕЗ УСТАНОВЛЕННЫХ КОМПОНЕНТОВ.

Скрипты для автоматической установки K8S kubeadm:
Выгружают последнюю стабильную версию и устанавливают необходимые компоненты.
Проверена следующая связка:
- kubeadm
- kubectl
- kubelet
- ETCD
- Docker/Containerd.io

HOW TO USE:
cd /var/tmp/  &&
git clone https://github.com/wolfuk1/Kubernetes-1.33.3-kubeadm_auto_install.git &&
cd Kubernetes-1.33.3-kubeadm_auto_install/auto-install-script/
chmod +x *.sh
./install_k8s_cluster.sh

Завершение установки:
- Добавьте ip мастер-нод в /etc/etcd/etcd.conf
- Добавьте ip мастер-нод в /root/kubeadm-init.yaml
- Запустите одновременно на всех нодах etcd: systemctl start etcd
- После успешной запуска службы - запустите инициализацию класстера (на 1 ноде):
	kubeadm init config=kubeadm-init.yaml
- Если кластер поднялся, то выполняем рекомендацию из терминала:
	mkdir -p $HOME/.kube && sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config &&
	sudo chown $(id -u):$(id -g) $HOME/.kube/config
- Переносим ключи /etc/kubernetes/pki* на вторую ноду в эту же папку:
	scp -r /etc/kubernetes/pki master2:/etc/kubernetes
- Инициализируем второй кластер через kubeadm join:
	(текст который у нас появился при инициализации):
	kubeadm join ip-address-node1:6443 --token 3n*.fz* \
        --discovery-token-ca-cert-hash sha256:ccba**** \
        --control-plane

Если выбивает ошибки, то попробуйте выполнить установку руками:
hand-install в репоризитории

