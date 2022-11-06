**Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"**

**Задача 1**

**Опишите своими словами основные преимущества применения на практике IaaC паттернов.**
**Какой из принципов IaaC является основополагающим?**

Подход «Инфраструктура как код (IaaC)» — это паттерн, по которому процесс создания, настройки инфраструктуры 
аналогичен процессу разработки программного обеспечения.
Инфраструктура как код —  форма управления конфигурацией, направленная на автоматизацию управления облачной ИТ-инфраструктурой. 
Средства обработки можно использовать для достижения уровней автоматизации CI/CD, способных менять инфраструктуру проекта. 
IaaC позволяет получить множество полезных аналитических данных о коммуникативных процессах и обеспечивает прозрачность при 
изменении инфраструктуры. Для применения этого подхода требуется ряд зависимостей, например, платформы хостинга и 
инструменты автоматизации, которые сегодня часто предоставляются поставщиками хостинга.
Ценность IaaC стоит на 3 китах: цена, скорость и уменьшение рисков. Уменьшение расходов относится не только к финансовой составляющей, 
но и к количеству времени, затрачиваемого на рутинные операции. Принципы IaC позволяют не фокусироваться на рутине, 
а заниматься более важными задачами. Автоматизация инфраструктуры позволяет эффективнее использовать существующие ресурсы. 
Также автоматизация позволяет минимизировать риск возникновения человеческой ошибки. Всё это является частью культуры DevOps, 
которая является миксом из development и operations.

Главное преимущество применения IaaC:
Идемпотентность — это свойство объекта или операции, при повторном выполнении которой мы получаем результат идентичный 
предыдущему и всем последующим выполнениям

**Задача 2**

**Чем Ansible выгодно отличается от других систем управление конфигурациями?**


Ansible — это инструмент для управления конфигурациями.
Ansible — это современный инструмент управления конфигурацией, который упрощает настройку и удаленное администрирование серверов.

Пользователи пишут скрипты конфигурирования Ansible в удобном формате сериализации данных YAML, который не привязывается 
к какому-либо языку программирования. Это позволяет пользователям интуитивно создавать сложные скрипты конфигурирования, 
в отличие от аналогичных инструментов такой же категории.

Ansible не требует установки специального программного обеспечения на узлах, где будет работать эта система. Контрольный механизм, 
настроенный в программном обеспечении Ansible, связывается с узлами через стандартные каналы SSH.

Как инструмент управления конфигурацией и система автоматизации Ansible имеет все функции, присутствующие в других инструментах 
этой же категории, но при этом данная система ориентируется на простоту использования и производительность:
идемпотентное поведение, поддержка переменных, условий и циклов, системные сведения, система шаблонов, поддержка расширений и модулей.

**Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?**


Push:

+:

Стоимость. Не требует установки дополнительных серверов.
Простая архитектура. Все конфигурации хранятся локально в том виде, в котором удобно администратору.
Подходит для тестирования. DSC DevOps Way. При развёртывании серверов очень просто автоматизируется и вписывается в философию Infrastructure as a Code.
Отличная замена run-once скриптов при развёртывании виртуальных машин.

-:

В On-Premise инфраструктурах возможны cложности в управлении серверами. Требует доступного подключения к серверу в момент применения 
конфигурации, что не всегда возможно.


Pull:

+:

Автоматизация применения конфигураций. Конфигурации применяются автоматически самими управляемыми серверами.
Простота управления большим количеством серверов. Большая часть работы выполняется агентами DSC на самих серверах.
Этот же режим используется в Azure Automation State Configuration, что очень удобно при конфигурации виртуальных машин Windows 
Server 2012R2+

-:

Требует установки дополнительного сервера, который будет хранить все конфигурации управляемых серверов.
В On-Premise инфраструктурах настройки сервера с конфигурациями распространяются через GPO, что автоматически делает данный 
метод негарантированной доставкой конфигурации целевому серверу.
Как следствие — сложность мониторинга применения конфигурации, особенно если конфигураций несколько и они должны применяться 
в определенном порядке.

Исходя из вышеперечисленного, Push выглядит надежнее.


**Задача 3
Установить на личный компьютер:**

**VirtualBox**

**Vagrant**

**Ansible**

**Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.**


При выполнении домашних заданий первого модуля у меня не было своего личного компьютера и я использовала временно комп 
с ОС windows, там установив virtual box и vagrant (для выполнения домашних заданий для работы с терминалом в первом модуле).

В недавнем времени купила mac m1, т.к. m1 не intel based, пришлось повозиться как на нем установить
VirtualBox
Vagrant
 
На m1 не не удалось сделать vagrant up по причине:

`Unsupported CPU. (VERR_UNSUPPORTED_CPU).
Код ошибки:
NS_ERROR_FAILURE (0X80004005)
Компонент:
ConsoleWrap
Интерфейс:
IConsole {6ac83d89-6ee7-4e33-8ae6-b257b2e81be8}`

Нашла заметку о том,что можно использовать vmWare Fusion определенную версию, но мне так и не прилетел approve на разврешение
скачать vmWare Fusion версию под m1. Далее увидела, что можно использовать провайдер parallels вместо virtual box, что и
решило мою проблему.

vagrant:

`anastasiasuhodola@MacBook-Pro-Anastasia vag % vagrant --version
`

`Vagrant 2.3.2`

далее установила плагин parallels:

`vagrant plugin install vagrant-parallels`

т.о. список плагинов:

`anastasiasuhodola@MacBook-Pro-Anastasia vag % vagrant plugin list
`

`vagrant-parallels (2.2.5, global)
vagrant-vmware-desktop (3.0.1, global)`

добавила box c arm:

`anastasiasuhodola@MacBook-Pro-Anastasia vag % vagrant box add bento/ubuntu-20.04-arm64 --provider=parallels --force
`

сделала up:

`anastasiasuhodola@MacBook-Pro-Anastasia vag %  vagrant up --provider parallels 
`
`anastasiasuhodola@MacBook-Pro-Anastasia 2004arm % vagrant ssh`
`Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic aarch64)`

` * Documentation:  https://help.ubuntu.com`
` * Management:     https://landscape.canonical.com`
`  * Support:        https://ubuntu.com/advantage`

 ` System information as of Sun 06 Nov 2022 04:16:32 AM PST`

`  System load:           0.0
  Usage of /:            11.9% of 30.63GB
  Memory usage:          23%
  Swap usage:            0%
  Processes:             122
  Users logged in:       0
  IPv4 address for eth0: 10.211.55.4
  IPv6 address for eth0: fdb2:2c26:f4e4:0:21c:42ff:fe75:de00`


`This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Sun Nov  6 03:50:58 2022 from 10.211.55.2
`

`vagrant@vagrant:~$ pwd
/home/vagrant`

ansible:

`
anastasiasuhodola@MacBook-Pro-Anastasia ~ % ansible --version
ansible [core 2.13.5]
  config file = None
  configured module search path = ['/Users/anastasiasuhodola/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']`

`ansible python module location = /opt/homebrew/Cellar/ansible/6.5.0/libexec/lib/python3.10/site-packages/ansible
  ansible collection location = /Users/anastasiasuhodola/.ansible/collections:/usr/share/ansible/collections
  executable location = /opt/homebrew/bin/ansible
  python version = 3.10.8 (main, Oct 13 2022, 09:48:40) [Clang 14.0.0 (clang-1400.0.29.102)]
  jinja version = 3.1.2
  libyaml = True`

`anastasiasuhodola@MacBook-Pro-Anastasia ~ % `



**Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.**

**Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
docker ps**

`anastasiasuhodola@MacBook-Pro-Anastasia 2004arm_newFile % vagrant ssh                                 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic aarch64)
`

` * Documentation:  https://help.ubuntu.com`
` * Management:     https://landscape.canonical.com`
` * Support:        https://ubuntu.com/advantage`


`System information as of Sun 06 Nov 2022 07:07:10 AM PST`

`  System load:              0.07
  Usage of /:               13.4% of 30.63GB`
`  Memory usage:             31%
  Swap usage:               0%`
`  Processes:                128
  Users logged in:          0`
`  IPv4 address for docker0: 172.17.0.1
  IPv4 address for eth0:    10.211.55.5`
`  IPv6 address for eth0:    fdb2:2c26:f4e4:0:21c:42ff:fe9f:5847
  IPv4 address for eth1:    192.168.56.11`
`  IPv6 address for eth1:    fdb2:2c26:f4e4:2:21c:42ff:fe4d:cc01
`

`This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento`

`Last login: Sun Nov  6 07:06:55 2022 from 10.211.55.1
vagrant@server1:~$ docker --version`

`Docker version 20.10.21, build baeda1f
vagrant@server1:~$ docker ps`


`CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ `