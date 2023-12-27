### Запуск mock сервера Prism для самопроверки
**Обратите внимание:** прежде чем приступить в самопроверке, убедитесь, что Вы добавили сущности и атрибуты в файл openapi.yaml, которые описаны в заданиях на шагах 4-6, иначе Mock-сервер Prism не запустится.

Запустите кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

### Запуск Mock-сервера Prism

Создайте **ConfigMap** с конфигурацией на основе заранее подготовленного файла со спецификацией **OpenAPI** openapi.yaml:
`kubectl create configmap openapi-configmap --from-file=openapi.yaml`{{execute}}

Для запуска Prism в кластере Kubernetes воспользуйтесь командой:  
`kubectl apply -f prism.yaml`{{execute}}


### Проверка окружения
После выполнения установки Prism в текущее окружение проверьте список запущенных сервисов:
`kubectl get po -A`{{execute}}

Дождитесь, когда состояние prism-mock-server достигнет статуса **Running**.

Если состояние в течении длительного времени (около 5 минут) не изменится на **Running**, либо статус изменится на любой другой, фиксирующий наличие проблемы с запуском, необходимо проанализировать причины неудачи.
Для этого запишем имя созданного пода в переменную POD_NAME:

`export POD_NAME=$(kubectl get pod -l app=prism-mock-server -o jsonpath="{.items[0].metadata.name}")`{{execute}}  

Рассмотрим логи приложения *prism-mock-server*, выполнив команду:

`kubectl logs $POD_NAME`{{execute}}

Среди прочей информации, возможно будет зафиксирована проблема формата:

`[9:42:06 AM] › [CLI] …  awaiting  Starting Prism…
[9:42:08 AM] › [CLI] ✖  fatal     at "#/components/schemas/Auction/properties/highest_bid", token "Bid" in "#/components/schemas/Bid" does not exist`

В данном случае сообщается, что причиной неудачи старта сервиса стал некорректно заполненный файл **openapi.yaml**, а именно: не описана сущность *Bid*, которая используется в других местах контракта.

На этом настройка окружения завершена.

### Пример команды для самопроверки задания 1:
`curl -v -X GET localhost:32100/auctions`{{execute}}

Ожидаемый ответ среди прочего должен содержать:
`[{"id":12345,"title":"Древняя китайская ваза династии Мин","description":"Древнекитайская ваза династии Мин в хорошем состоянии.","start_time":"2023-04-01T00:00:00Z","end_time":"2023-04-05T00:00:00Z","starting_price":500,"highest_bid":{"bid":{"name":"Иван Иванов","email":"ivan4@example.ru"},"amount":700},"seller":{"id":123,"name":"Джеки Чан","email":"chan@example.ch"},"item":{"id":456,"name":"Древняя китайская ваза династии Мин","description":"Древнекитайская ваза династии Мин в хорошем состоянии.","tags":["антиквариат","ваза","Китай","династия Мин"],"image_url":"https://example.com/ancient-vase.jpg"}}]`

### Пример команды для самопроверки задания 2 шаг 2:
`curl -v -X GET localhost:32100/auctions/1234/bids`{{execute}}

Ожидаемый ответ среди прочего должен содержать:
`[{"id":1,"buyer_id":123,"auction_id":456,"amount":100,"timestamp":"2022-05-01T10:00:00Z"},{"id":2,"buyer_id":456,"auction_id":789,"amount":150,"timestamp":"2022-05-02T14:00:00Z"},{"id":3,"buyer_id":789,"auction_id":123,"amount":200,"timestamp":"2022-05-03T18:00:00Z"}]`

### Пример команды для самопроверки задания 3:
`curl -X POST localhost:32100/buyers -H "Content-Type: application/json" -d '{"id": 124, "name": "Петр Петров", "email": "p.petrov@example.ru", "phone": "+1 (333) 765-4321", "address": "122, РФ, Москва, Старая улица, д.1, кв.1"}'`{{execute}}

Ожидаемый ответ среди прочего должен содержать:
`{"id": 124, "name": "Петр Петров", "email": "p.petrov@example.ru", "phone": "+1 (333) 765-4321", "address": "122, РФ, Москва, Старая улица, д.1, кв.1"}`

