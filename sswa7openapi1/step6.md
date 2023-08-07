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

Ожидаемый ответ:

### Пример команды для самопроверки задания 2:
`curl -v -X GET localhost:32100/auctions/1234/bids`{{execute}}
`curl -X POST localhost:32100/auctions/1234/bids -H "Content-Type: application/json" -d '{"id": "123","buyer_id": "456", "auction_id":"789","amount":"100.0","timestamp":"2022-04-01T14:30:00Z"}'`

Ожидаемый ответ:

### Пример команды для самопроверки задания 3:
`curl -X POST localhost:32100/auctions/findItems -H "Content-Type: application/json" -d '{"itemName": "Китайская ваза","itemTags": ["антиквариат", "ваза", "Китай"]}'`

Ожидаемый ответ:

