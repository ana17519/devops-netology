**Домашнее задание к занятию 11 «Teamcity»**

**Подготовка к выполнению**

1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.
2. Дождитесь запуска teamcity, выполните первоначальную настройку.
3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. 
Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.
4. Авторизуйте агент.

![img.png](images/img245.png)

![img.png](images/img246.png)

5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity). 
6. Создайте VM (2CPU4RAM) и запустите [playbook](teamcity).

![img_1.png](images/img257.png)

`ansible-playbook -i inventory/hosts.yml site.yml`

![img.png](images/img247.png)

**Основная часть**

1. Создайте новый проект в `teamcity` на основе [fork](https://github.com/ana17519/example-teamcity).
2. Сделайте autodetect конфигурации.

![img.png](images/img258.png)

3. Сохраните необходимые шаги, запустите первую сборку master.

![img_1.png](images/img248.png)

4. Поменяйте условия сборки: если сборка по ветке master, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.

![img_1.png](images/img249.png)

5. Для deploy будет необходимо загрузить [settings.xml](https://github.com/netology-code/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/teamcity/settings.xml) 
в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.

![img_1.png](images/img250.png)
![img_1.png](images/img251.png)

8. Мигрируйте build configuration в репозиторий.
9. Создайте отдельную ветку `feature/add_reply` в репозитории.
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово hunter.
11. Дополните тест для нового метода на поиск слова hunter в новой реплике.
12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.

![img_1.png](images/img252.png)

14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.

![img_1.png](images/img253.png)

15. Убедитесь, что нет собранного артефакта в сборке по ветке master.
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.

![img_1.png](images/img256.png)

17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.

![img_1.png](images/img254.png)
![img_1.png](images/img255.png)

18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
19. В ответе пришлите ссылку на репозиторий.

[репозиторий](https://github.com/ana17519/example-teamcity)