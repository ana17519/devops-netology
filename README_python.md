### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  |  разные типы для операции сложения: int и str,  будет ошибка  |
| Как получить для переменной `c` значение 12?  | привести a к строке:       c=str(a)+b  |
| Как получить для переменной `c` значение 3?  | привести b к целому числу: c=a+int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

dir = "C:/Users/ASukhodola/PycharmProjects/devops-netology"
bash_command = ["cd " + dir, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
cwd=result_os.split('\n')
for result in result_os.split('\n'):
   if result.find('modified') != -1:
       prepare_result = cwd[0]+'/'+result.replace('\tmodified:   ', '')
       print(prepare_result)
       #break

```

### Вывод скрипта при запуске при тестировании:
```
On branch main/README_python.md
On branch main/branching/script.py
On branch main/branching/scrypt1.py
On branch main/branching/scrypt3.py
On branch main/branching/scrypt4.py
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

bash_command = ["cd "+sys.argv[1], "pwd", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
cwd=result_os.split('\n')
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = cwd[0]+'/'+result.replace('\tmodified:   ', '')
        print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
ASukhodola@ASukhodola MINGW64 ~/PycharmProjects/devops-netology/branching (main)
$ python scrypt1.py ~/PycharmProjects/devops-netology/
/c/Users/ASukhodola/PycharmProjects/devops-netology/README_python.md
/c/Users/ASukhodola/PycharmProjects/devops-netology/branching/script.py
/c/Users/ASukhodola/PycharmProjects/devops-netology/branching/scrypt1.py
/c/Users/ASukhodola/PycharmProjects/devops-netology/branching/scrypt3.py
/c/Users/ASukhodola/PycharmProjects/devops-netology/branching/scrypt4.py

```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3
from datetime import datetime
import socket
import time

dns_list = ['drive.google.com', 'mail.google.com', 'google.com']
ip_list = [None, None, None]
# счетчик времени для отладки, целевое значение   while True
start_time = time.time()
while int((time.time() - start_time)) < 30:
    # while True:
    print("*******")
    for i in range(0, len(dns_list)):
        time.sleep(1)
        ip = socket.gethostbyname(dns_list[i])
        print(dns_list[i] + ' -> ' + ip)
        if ip_list[i] is None:
            ip_list[i] = ip
        elif ip_list[i] != ip:
            print('[ERROR] ' + dns_list[i] + ' IP mismatch: ' + ip_list[i] + ' ' + ip)

```

### Вывод скрипта при запуске при тестировании:
```
ASukhodola@ASukhodola MINGW64 ~/PycharmProjects/devops-netology/branching (main)
$ python scrypt3.py
******* 
drive.google.com -> 64.233.162.194 
mail.google.com -> 108.177.14.19 
google.com -> 74.125.131.102 
******* 
drive.google.com -> 64.233.162.194 
mail.google.com -> 108.177.14.19 
google.com -> 74.125.131.102 
******* 
drive.google.com -> 64.233.162.194 
mail.google.com -> 108.177.14.19 
google.com -> 74.125.131.102 
******* 
drive.google.com -> 64.233.162.194 
mail.google.com -> 108.177.14.19 
google.com -> 74.125.131.102 
*******
drive.google.com -> 64.233.162.194
mail.google.com -> 108.177.14.19
google.com -> 74.125.131.102
*******
drive.google.com -> 64.233.162.194
mail.google.com -> 108.177.14.19
google.com -> 74.125.131.102
*******
drive.google.com -> 64.233.162.194
mail.google.com -> 108.177.14.19
google.com -> 74.125.131.102
*******
drive.google.com -> 64.233.162.194
mail.google.com -> 108.177.14.19
google.com -> 74.125.131.102
*******
drive.google.com -> 64.233.162.194
mail.google.com -> 108.177.14.19
google.com -> 74.125.131.102
*******
drive.google.com -> 64.233.162.194
mail.google.com -> 108.177.14.19
google.com -> 74.125.131.102

```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```