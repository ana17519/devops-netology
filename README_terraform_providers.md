**Домашнее задание к занятию "17. Написание собственных провайдеров для Terraform."**


Бывает, что

* общедоступная документация по терраформ ресурсам не всегда достоверна,
* в документации не хватает каких-нибудь правил валидации или неточно описаны параметры,
* понадобиться использовать провайдер без официальной документации,
* может возникнуть необходимость написать свой провайдер для системы используемой в ваших проектах.

**Задача 1.**

Давайте потренируемся читать исходный код AWS провайдера, который можно склонировать от сюда: 
https://github.com/hashicorp/terraform-provider-aws.git. Просто найдите нужные ресурсы в исходном коде и ответы на вопросы станут понятны.

* Найдите, где перечислены все доступные resource и data_source, приложите ссылку на эти строки в коде на гитхабе.

[data_source](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L169) - DataSourcesMap: map[string]*schema.Resource
[resource](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L411) - ResourcesMap: map[string]*schema.Resource

* Для создания очереди сообщений SQS используется ресурс aws_sqs_queue у которого есть параметр name.

**С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано.**

  name конфликтует с name_prefix - 
  [ConflictsWith: []string{"name_prefix"}](https://github.com/hashicorp/terraform-provider-aws/blob/1076f598ee88175e7409c5887edcf87e6cbeab20/internal/service/sqs/queue.go#L88)

**Какая максимальная длина имени?**

максимальная длина - 80 символов - [regexp.MustCompile(`^[a-zA-Z0-9_-]{1,80}$`)](https://github.com/hashicorp/terraform-provider-aws/blob/1076f598ee88175e7409c5887edcf87e6cbeab20/internal/service/sqs/queue.go#L433)

**Какому регулярному выражению должно подчиняться имя?**

Для некоторых имен ресурсов требуется "a fixed suffix" (for example Amazon SNS FIFO topic names must end in `.fifo`), в таком случае 
для fifo - [fifoQueue](https://github.com/hashicorp/terraform-provider-aws/blob/1076f598ee88175e7409c5887edcf87e6cbeab20/internal/service/sqs/queue.go#L431),

не для fifo - [queue](https://github.com/hashicorp/terraform-provider-aws/blob/1076f598ee88175e7409c5887edcf87e6cbeab20/internal/service/sqs/queue.go#L433)


**Задача 2. (Не обязательно)**

В рамках вебинара и презентации мы разобрали как создать свой собственный провайдер на примере кофемашины. Также вот официальная документация 
о создании провайдера: https://learn.hashicorp.com/collections/terraform/providers.

1. Проделайте все шаги создания провайдера.
2. В виде результата приложение ссылку на исходный код.
3. Попробуйте скомпилировать провайдер, если получится то приложите снимок экрана с командой и результатом компиляции.
