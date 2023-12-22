### Запуск mock сервера Prism для самопроверки

Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

### Запуск mock сервера Prism

Создадим **ConfigMap** с конфигурацией на основе заранее подготовленного файла со спецификацией **OpenAPI** openapi.yaml:
`kubectl create configmap openapi-configmap --from-file=openapi.yaml`{{execute}}

Для запуска Prism в кластере Kubernetes воспользуемся командой:  
`kubectl apply -f prism.yaml`{{execute}}


### Проверка окружения
После выполнения установки Prism в текущее окружении, проверим список запущенных сервисов

`kubectl get po -A`{{execute}}

Дождитесь, когда состояние *prism-mock-server* достигнет статус **Running**.

На этом настройка окружения завершена.

### Пример команды для самопроверки задания 1:
`curl -v -X GET localhost:32100/auctions`{{execute}}

Ожидаемый ответ должен содержать среди прочего:
`[{"id":12345,"title":"Древняя китайская ваза династии Мин","description":"Древнекитайская ваза династии Мин в хорошем состоянии.","start_time":"2023-04-01T00:00:00Z","end_time":"2023-04-05T00:00:00Z","starting_price":500,"highest_bid":{"bid":{"name":"Иван Иванов","email":"ivan4@example.ru"},"amount":700},"seller":{"id":123,"name":"Джеки Чан","email":"chan@example.ch"},"item":{"id":456,"name":"Древняя китайская ваза династии Мин","description":"Древнекитайская ваза династии Мин в хорошем состоянии.","tags":["антиквариат","ваза","Китай","династия Мин"],"image_url":"https://example.com/ancient-vase.jpg"}}]`

### Пример команды для самопроверки задания 2:
`curl -v -X GET localhost:32100/auctions/1234/bids`{{execute}}

Ожидаемый ответ должен содержать среди прочего:
`[{"id":1,"buyer_id":123,"auction_id":456,"amount":100,"timestamp":"2022-05-01T10:00:00Z"},{"id":2,"buyer_id":456,"auction_id":789,"amount":150,"timestamp":"2022-05-02T14:00:00Z"},{"id":3,"buyer_id":789,"auction_id":123,"amount":200,"timestamp":"2022-05-03T18:00:00Z"}]`

### Пример команды для самопроверки задания 3:
`curl -X POST localhost:32100/buyers -H "Content-Type: application/json" -d '{"id": 124, "name": "Петр Петров", "email": "p.petrov@example.ru", "phone": "+1 (333) 765-4321", "address": "122, РФ, Москва, Старая улица, д.1, кв.1"}'`{{execute}}

Ожидаемый ответ должен содержать среди прочего:
`{"id": 124, "name": "Петр Петров", "email": "p.petrov@example.ru", "phone": "+1 (333) 765-4321", "address": "122, РФ, Москва, Старая улица, д.1, кв.1"}`

