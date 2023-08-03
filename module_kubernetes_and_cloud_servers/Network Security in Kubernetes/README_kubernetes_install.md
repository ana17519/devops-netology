**Домашнее задание к занятию «Установка Kubernetes»**

**Цель задания**

Установить кластер K8s.

**Чеклист готовности к домашнему заданию**
1. Развёрнутые ВМ с ОС Ubuntu 20.04-lts.

**Инструменты и дополнительные материалы, которые пригодятся для выполнения задания**
1. [Инструкция по установке kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).
2. [Документация kubespray](https://kubespray.io/#/).

**Задание 1. Установить кластер k8s с 1 master node**
1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

`git clone https://github.com/kubernetes-sigs/kubespray`

![img_11.png](../../images/img420.png)
![img_12.png](../../images/img421.png)

`sudo pip3 install -r requirements.txt`

`cp -rfp inventory/sample inventory/mycluster`

`declare -a IPS=(10.128.0.35 10.128.0.31 10.128.0.5 10.128.0.20  10.128.0.27)`

`CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}`

![img_2.png](../../images/img412.png)
![img_3.png](../../images/img413.png)
![img_4.png](../../images/img414.png)

после добавления `ansible_user: ana` и `etcd` на master:

![img_7.png](../../images/img416.png)
![img_6.png](../../images/img415.png)

добавлен приватный ключ и права, запуск плейбука:

```
chmod 007 ~/.ssh/id_rsa
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v
```

kubectl должен понимать к чему подключаться используя конфиг:

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get nodes
```
![img_8.png](../../images/img417.png)

![img_9.png](../../images/img418.png)

![img_10.png](../../images/img419.png)