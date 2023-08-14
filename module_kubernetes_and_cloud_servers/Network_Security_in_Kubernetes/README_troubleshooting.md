**Домашнее задание к занятию Troubleshooting**

**Цель задания**

Устранить неисправности при деплое приложения.

**Чеклист готовности к домашнему заданию**

Кластер K8s.

**Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить**

1. Установить приложение по команде:

`kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml`
 
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.

![img.png](img.png)
![img_1.png](img_1.png)

web-consumer не может подключиться к auth-db:

`curl: (6) Couldn't resolve host 'auth-db'`
