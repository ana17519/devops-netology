**Домашнее задание к занятию «Микросервисы: масштабирование»**

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры. Вам как DevOps-специалисту
необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

**Задача 1: Кластеризация**

Предложите решение для обеспечения развёртывания, запуска и управления приложениями. Решение может состоять из одного 
или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:

* поддержка контейнеров;
* обеспечивать обнаружение сервисов и маршрутизацию запросов;
* обеспечивать возможность горизонтального масштабирования;
* обеспечивать возможность автоматического масштабирования;
* обеспечивать явное разделение ресурсов, доступных извне и внутри системы;
* обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью 
безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т. п.

Обоснуйте свой выбор.

|      | Kubernetes | openshift |                                                    Docker Swarm                                                     |
| ------------ |:----------:|:---------:|:-------------------------------------------------------------------------------------------------------------------:|
| поддержка контейнеров   |     +      |     +     |                      + в Docker Swarm есть понятие сервиса – некая надстройка над контейнерами                      |
| обеспечивать обнаружение сервисов и маршрутизацию запросов|     +      |     +     |                                                          +                                                          |
| обеспечивать возможность горизонтального масштабирования|     +      |     +     |            + Масштабирование сервиса Docker достигается за счет указания необходимого количества реплик             |
| обеспечивать возможность автоматического масштабирования| Уровень кластера, которым управляет система автомасштабирования кластера (Cluster Autoscaler, CA), она увеличивает или уменьшает количество узлов внутри кластера |     +     | Docker Swarm не умеет делать этого «из коробки». Можно построить автомасштабируемую систему с использованием Swarm. |
| обеспечивать явное разделение ресурсов, доступных извне и внутри системы|     +      |     +     |                                                          +                                                          |
| обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т. п.|     +      |     +     |                                                     + .env файл                                                     |

На текущем месте работы у нас используется openshift, считаю, что это хорошее решение в силу стабильной версии 