**Домашнее задание к занятию "1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."**


**Задача 1**
**Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.**

Аппаратная виртуализация — виртуализация с поддержкой специальной процессорной архитектуры, с помощью данной техники возможно использование изолированных гостевых операционных систем, управляемых гипервизором напрямую.

Гостевая ОС не зависит от архитектуры хостовой платформы и реализации платформы виртуализации.

Аппаратная виртуализация обеспечивает производительность, сравнимую с производительностью невиртуализованной машины, что дает виртуализации возможность практического использования и влечет её широкое распространение.

Паравиртулизация - в том числе эмуляция работы устройств, однако гостевая ОС знает о наличии гипервизора, а выполнения привилегированных инструкций происходит через гипервизор, поэтому происходит серьезное изменение ядра гостевой ОС. В силу данной особенности подходит для ОС с открытым кодом, издержки меньше, производительность не особо страдает.

Виртуализация на основе ОС - еще называется контейнеризация, при помощи механизмов namespace и cgroups, можно выделять новые пространства имен, ограничивать ресурсы хостовой машины, тем самым создавать изолированные контейнеры, в которых будут выполняться процессы. Ядро гостевой ОС не может отличаться от ядра хостовой ОС.


**Задача 2**
**Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.**

Организация серверов:

* физические сервера,
* паравиртуализация,
* виртуализация уровня ОС.

Условия использования:

* Высоконагруженная база данных, чувствительная к отказу.
* Различные web-приложения.
* Windows системы для использования бухгалтерским отделом.
* Системы, выполняющие высокопроизводительные расчеты на GPU.

**Опишите, почему вы выбрали к каждому целевому использованию такую организацию.**

* физические сервера - Системы, выполняющие высокопроизводительные расчеты на GPU- думаю, нужна установка мощных графических процессоров для обработки данных. Хотя, графические интерфейсы в том, числе виртуализируются, однако предполагаю, что все таки физические решения для графических вычислений более производительны.
* паравиртуализация - Windows системы для использования бухгалтерским отделом - системы для бухучета, думаю, не требуют оченб высокой производительности и кол-во обращений может прогнозироваться и поддается подсчету. Виртуализация кажется масштабируемым решением, скорее всего можно сформировать единую точку управления.
* виртуализация уровня ОС - Высоконагруженная база данных, чувствительная к отказу - БД можно рассматривать, как приложение (сервис), если запаковать приложение в контейнер, создать несколько таких контейнеров, тем самым получить отказоустойчивый кластер, а управление контейнером сводится к управлению процессом - быстро и без накладных расходов. В случае чего? контейнер можно удалить, что быстро.
* виртуализация уровня ОС -Различные web-приложения - подходит виртуализация уровня ОС, так как обеспечивает быструю развертываемость приложения и необходую призводительность


**Задача 3
Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.**

Сценарии:

* 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.

VMWare. В рамках продуктов виртуализации и управления, решения от VMWare являются наиболее сбалансированными, имеют достаточно обширный функционал, который позволит закрыть вопросы по сопровождению и администрированию среды на 100 VM Windows, Linux.
* Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин. 

KVM. Решение на базе KVM позволит управлять гостевыми ОС, как Windows, так и Linux, без особых потерь в производительности, что обеспечивает решение поставленной задачи. Проект развивающийся, это несет в себе риски, но ими можно пренебречь, так как производительность нас интересует в первую очередь.
* Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.

XEN PV. Решение позволит поднять инфраструктуру на базе Windows OS, является open source проектом, обеспечит высокую производительность, универсален.
* Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

для автоматизаторов подойдет docker - среда для контейнеризации софта, позволяющая легко создавать и передавать отдельные контейнеры с софтом, которые работают везде одинаково.
если в большинстве ручные проверки, то Virtual Box совместно с Vagrant. Для создания окружения для тестирования подойдет open source решение Virtual Box, с помощью Vagrant можно добиться автоматизации сборки такого окружения, при помощи Vagrantfile отдавать данное окружения всем, кто заинтересован, это позволит точно быть уверенным, что среда у всех единая.

**Задача 4**

**Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. 
Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.**

В гетерогенных средах, когда приложения размещены в разных средах виртуализации, каждой такой средой приходится управлять собственным инструментом. Выход — механизм скриптов, что трудоемко и может значительно усложнить задачи управления и мониторинга. 

В процессе эксплуатации гетерогенной виртуальной среды могут быть выявлены следующие системные проблемы:

• в гетерогенной среде сокращаются возможности автоматического распределения вычислительных ресурсов, что увеличивает вероятность появления дефицита 
вычислительных ресурсов на одном из участков виртуальной среды;

• для автоматизации мониторинга используются несколько различных программных продуктов, что снижает оперативность оценки состояния вычислительных ресурсов;

• в гетерогенной среде усиливаются последствия ошибок в распределении вычислительных ресурсов, что ужесточает требования к точности оценки состояния ресурсов в
виртуальной среде.

Решением задачи снижения угрозы отказа в обслуживании является обеспечение достаточного количества вычислительных ресурсов на всех узлах 
виртуальной среды. Для
эффективного размещения виртуальных серверов на физических узлах необходимо выделение групп узлов со схожими значениями
ресурсообеспеченности из общего множества. Необходимость выделения групп узлов
определяется задачей миграции виртуализованных серверов в группу с высокой ресурсообеспеченностью. 
Таким образом, процедура оценки состояния вычислительных ресурсов в гетерогенной виртуальной среде
заключается в распределении физических узлов по группам ресурсообеспеченности c
минимальным количеством ошибок.

Программная система мониторинга вычислительных ресурсов в гетерогенной виртуальной среде должна удовлетворять следующим требованиям:

• агенты системы должны функционировать в различных операционных системах;

• для получения сведений о состоянии
вычислительных ресурсов агенты должны использовать API различных гипервизоров и
собирать сведения о состоянии различных
вычислительных ресурсов на физических узлах виртуальной среды;

• система мониторинга должна использовать модель состояния вычислительных
ресурсов, исключающую влияние случайных
отклонений и дающую целостную картину состояния вычислительных ресурсов в виртуальной среде;

• система мониторинга должна предоставлять гибкую настройку и различные методы оповещения пользователей.

Выбор среды виртуализации делается на основании анализа, изучения требований. 
Если есть возможность избежать гетерогенной среды, то не за чем ее вводить.
Однако, если же этого не избежать, то нужны квалифицированные кадры, вероятно, потребуются доработки,
возможно будет ограничен выбор стека технологий по мониторингу, логированию и бекапированию или, наоборот, увеличит кол-во продуктов. 
На мой взляд, гетерогенная среда требует определенного баланса между необходмиым и достаточным, необходимо отдавать себе отчет в том, 
какой стек технологий будет использоваться, и точно не стоит боятся, необходимо ответственно подходить к архитектуре решения.

