**Домашнее задание к занятию «Конфигурация приложений»**

**Цель задания**

В тестовой среде Kubernetes необходимо создать конфигурацию и продемонстрировать работу приложения.

**Чеклист готовности к домашнему заданию**
1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

**Инструменты и дополнительные материалы, которые пригодятся для выполнения задания**
1. Описание [Secret](https://kubernetes.io/docs/concepts/configuration/secret/).
2. Описание [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/).
3. Описание [Multitool](https://github.com/wbitt/Network-MultiTool).

**Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу**

1. Создать `Deployment` приложения, состоящего из контейнеров `Nginx` и `multitool`.
2. Решить возникшую проблему с помощью `ConfigMap`.
3. Продемонстрировать, что `pod` стартовал и оба контейнера работают.
4. Сделать простую веб-страницу и подключить её к `Nginx` с помощью `ConfigMap`. 
Подключить `Service` и показать вывод `curl` или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

![img_1.png](img_1.png)
![img_2.png](img_2.png)

[манифест service](k8_yaml/nginx-service.yaml)

[манифест cm](k8_yaml/index-html-configmap.yaml)

[манифест deployment](k8_yaml/configuration.yaml)

**Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS**

1. Создать `Deployment` приложения, состоящего из `Nginx`.
2. Создать собственную веб-страницу и подключить её как `ConfigMap` к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


![img_4.png](img_4.png)

![img_7.png](img_7.png)

![img_8.png](img_8.png)
![img_6.png](img_6.png)

![img_9.png](img_9.png)


[манифест](k8_yaml//configuration_2.yaml)



openssl req -x509 -sha256 -newkey rsa:4096 -keyout caa.key -out caa.crt -days 356 -nodes -subj '/CN=51.250.66.238'
openssl req -new -newkey rsa:4096 -keyout server.key -out server.csr -nodes -subj '/CN=micro.ru-central1.internal'
openssl x509 -req -sha256 -days 365 -in server.csr -CA caa.crt -CAkey caa.key -set_serial 01 -out server.crt
1
kubectl create secret generic orthweb-cred --from-file=tls.key=server.key --from-file=tls.crt=server.crt --from-file=caa.crt=caa.crt


![img_10.png](img_10.png)
![img_11.png](img_11.png)
![img_12.png](img_12.png)
![img_13.png](img_13.png)