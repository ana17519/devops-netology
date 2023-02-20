**Домашнее задание к занятию "7.Жизненный цикл ПО"**

**Подготовка к выполнению**

* Получить бесплатную [JIRA](https://atlassian.com/ru/software/jira/free)
* Настроить её для своей "команды разработки"
* Создать доски kanban и scrum

**Основная часть**

В рамках основной части необходимо создать собственные workflow для двух типов задач: 
bug и остальные типы задач. 

Задачи типа bug должны проходить следующий жизненный цикл:

1. Open -> On reproduce
2. On reproduce -> Open, Done reproduce
3. Done reproduce -> On fix
4. On fix -> On reproduce, Done fix
5. Done fix -> On test
6. On test -> On fix, Done
7. Done -> Closed, Open

![img_7.png](images/img205.png)


Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop
2. On develop -> Open, Done develop
3. Done develop -> On test
4. On test -> On develop, Done
5. Done -> Closed, Open

![img_6.png](images/img204.png)
![img_5.png](images/img203.png)

Создать задачу с типом bug, попытаться провести его по всему workflow до Done. 

Создать задачу с типом epic, к ней привязать несколько задач с типом task, провести их по всему workflow до Done. 

При проведении обеих задач по статусам использовать kanban. Вернуть задачи в статус Open. 

![img_3.png](images/img202.png)

Перейти в scrum, 
запланировать новый спринт, состоящий из задач эпика и одного бага, стартовать спринт, 
провести задачи до состояния Closed. Закрыть спринт.

![img.png](images/img200.png)
![img_1.png](images/img201.png)

Если всё отработало в рамках ожидания - выгрузить схемы workflow для импорта в XML. Файлы с workflow приложить к решению задания.

[workflow для багов](BUG.xml)

[workflow для задач](TASK.xml)

