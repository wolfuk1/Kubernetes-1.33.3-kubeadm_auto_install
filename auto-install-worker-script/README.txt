УСТАНОВКА ПРОИЗВОДИТСЯ НА ЧИСТУЮ СИСТЕМУ, БЕЗ УСТАНОВЛЕННЫХ КОМПОНЕНТОВ.
Для установки и настройки worker ноды требуется установка следующих компонентов:

- kubeadm
- kubectl
- kubelet
- Containerd.io

HOW TO 
cd /var/tmp/  &&
git clone https://github.com/wolfuk1/Kubernetes-1.33.3-kubeadm_auto_install.git &&
cd Kubernetes-1.33.3-kubeadm_auto_install/auto-install-worker-script/ &&
chmod +x *.sh &&
./install_worker_node.sh

Завершение установки:
--- Инициализируем Мастер-ноду через kubeadm join:
	(текст который у нас появился при инициализации):
	kubeadm join ip-address-node1:6443 --token 3n*.fz* \
        --discovery-token-ca-cert-hash sha256:ccba**** \


