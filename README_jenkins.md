**Домашнее задание к занятию 10 «Jenkins»**

**Подготовка к выполнению**

1. Создать два VM: для `jenkins-master` и `jenkins-agent`.

![img.png](images/img237.png)

2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.

`ansible-playbook -i inventory/hosts.yml site.yml`

![img.png](images/img238.png)

4. Сделать первоначальную настройку.

![img.png](images/img239.png)

![img.png](images/img240.png)

**Основная часть**

1. Сделать `Freestyle Job`, который будет запускать `molecule test` из любого вашего репозитория с ролью.
2. Сделать `Declarative Pipeline Job`, который будет запускать molecule test из любого вашего репозитория с ролью. 
3. Перенести `Declarative Pipeline` в репозиторий в файл `Jenkinsfile`. 
4. Создать `Multibranch Pipeline` на запуск `Jenkinsfile` из репозитория. 

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](https://github.com/netology-code/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/pipeline/Jenkinsfile). 

6. Внести необходимые изменения, чтобы Pipeline запускал ansible-playbook без флагов --check --diff, если не установлен параметр при запуске джобы (prod_run = True). 
По умолчанию параметр имеет значение False и запускает прогон с флагами --check --diff.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.

![img.png](images/img242.png)
![img.png](images/img241.png)
![img_1.png](images/img243.png)
![img.png](images/img244.png)

[ScriptedJenkinsfile](ScriptedJenkinsfile)

8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

[Scripted Pipeline](https://github.com/ana17519/practise-ansible/tree/feature/jenkins)

[Declarative Pipeline](https://github.com/ana17519/practise-playbook/blob/feature/jenkins/Jenkinsfile)