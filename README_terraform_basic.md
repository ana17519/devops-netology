**Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"**

**Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).**

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, 
то давайте продолжим знакомство со взаимодействием терраформа и aws.

Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. 

Можно создать отдельного пользователя, а можно использовать созданного в рамках предыдущего задания, 
просто добавьте ему необходимы права, как описано здесь.

Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше.

создание сервисного аккаунта:

` yc iam service-account create --name default \ 
  --description "service account" `

id: aje4ofq2hpt96gqf6s7k
folder_id: b1g5et62diug35tdgb70
created_at: "2022-12-17T15:45:23.913794097Z"
name: default
description: service account

![img_85.png](img_85.png)

`yc iam access-key create --service-account-name default \
  --description "key is for bucket"`

access_key:
  id: ajeggl5c22hv3g42rom6
  service_account_id: aje4ofq2hpt96gqf6s7k
  created_at: "2022-12-17T15:49:24.989330926Z"
  description: key is for bucket
  key_id: YCAJEb_yGszI67YxlnKuVcrWv
secret: YCMOSkHvfbTEFkntLlyacBTPwq0-zG8bTqlfs8X8

![img_92.png](img_92.png)

Добавить права админа:

`yc resource-manager folder add-access-binding default \
  --role admin \
  --subject serviceAccount:aje4ofq2hpt96gqf6s7k`

![img_97.png](img_97.png)

бакет:

![img_93.png](img_93.png) 

ниже убрать

просмотре ролей:
yc iam service-account list-access-bindings default 
назначение роли:
yc iam service-account add-access-binding default \
  --role editor \
  --subject serviceAccount:aje4ofq2hpt96gqf6s7k
![img_96.png](img_96.png)

**Задача 2. Инициализируем проект и создаем воркспейсы.**

1. Выполните terraform init:

если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице dynamodb.

иначе будет создан локальный файл со стейтами.

![img_95.png](img_95.png)

2. Создайте два воркспейса stage и prod.

![img_94.png](img_94.png)

3. В уже созданный aws_instance добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные instance_type.
4. Добавим count. Для stage должен создаться один экземпляр ec2, а для prod два.

terraform plan:

![img_99.png](img_99.png)
![img_100.png](img_100.png)
![img_101.png](img_101.png)
![img_102.png](img_102.png)
![img_103.png](img_103.png)
![img_104.png](img_104.png)
![img_114.png](img_114.png)
![img_115.png](img_115.png)




terraform apply:

![img_105.png](img_105.png)
![img_106.png](img_106.png)
![img_107.png](img_107.png)
![img_108.png](img_108.png)
![img_109.png](img_109.png)
![img_110.png](img_110.png)
![img_111.png](img_111.png)
![img_112.png](img_112.png)
![img_113.png](img_113.png)

![img_98.png](img_98.png)