**Домашнее задание к занятию «Введение в микросервисы»**

**Задача 1: Интернет Магазин**

Руководство крупного интернет-магазина, у которого постоянно растёт пользовательская база и 
количество заказов, рассматривает возможность переделки своей внутренней ИТ-системы на основе микросервисов.

Вас пригласили в качестве консультанта для оценки целесообразности перехода на микросервисную архитектуру.

Опишите, какие выгоды может получить компания от перехода на микросервисную архитектуру и какие проблемы 
нужно решить в первую очередь.


**Выгоды компании от перехода на микросервисную архитектуру:**

1. Простое развертывание
Так как все компоненты связаны друг с другом достаточно слабо, нет необходимости каждый раз 
разворачивать приложение целиком — только микросервисы, в которые были внесены какие-то изменения.
Т.е. получаем: небольшие изменения, частые выкладки, низкие риски, простота замены, независимость

2. Повышение скорости обновлений
Когда есть возможность разворачивать отдельные компоненты и не тратить много времени на тестирование, 
скорость выпуска обновлений существенно повышается. А значит, можно быстрее доставлять пользователям 
новые возможности и совершенствовать продукт.

3. Оптимизация масштабирования
Когда приложение развивается, пользовательская база растет и приходит понимание, что нужно масштабироваться,
то можно ограничиться конкретными сервисами, которые нуждаются в «росте». 
Это намного ускоряет процесс и позволяет сэкономить на вычислительных ресурсах.

4. Повышение отказоустойчивости
Если один из модулей микросервисного приложения сломается, вся остальная система продолжит работать. 
Для восстановления работоспособности на 100% придется только исправить ошибку или устранить сбой на 
«пострадавшем» модуле и быстро обновить этот компонент.

5. Возможность использовать разные технологии
При создании приложения с микросервисной архитектурой разработчики могут выбирать любые нужные технологии и формировать стэк.

6. Повышение эффективности
Как правило, в разработке микросервисного приложения не участвует вся команда целиком. Разработчики разделяются на группы, 
за каждой из которых закрепляется некая функциональность приложения. Это значительно упрощает процесс управления и 
позволяет сократить time-to-market цифрового продукта.

7. Повышение гибкости приложения
Так как между сервисами нет сильных связей, можно без труда заменить какой-либо из компонентов. 
И сделать это в приложении с микросервисной архитектурой намного быстрее и проще, чем в монолите.

**Какие проблемы нужно решить в первую очередь**

1. Проблемы разработки

* Совместимость API
* Версионирование артефактов
* Автоматизация сборки и тестирования
* Документация
* Инфраструктура разработки

2. Проблемы эксплуатации

* Мониторинг
* Сбор логов
* Управление настройками
* Управление инфраструктурой