На данном шаге будет установлен ServiceB и выполнена настройка входящего трафика.

Схема создаваемой конфигурации сети представлена ниже:

![Mesh configuration](../assets/scheme1-b.png)

Установите ServiceB:
`kubectl apply -f service-b-deployment.yml`{{execute}}

Примените Service для развёртывания выше:
`kubectl apply -f producer-internal-host.yml`{{execute}}

Создайте Gateway для маршрутизации запросов из ingress-шлюза в ServiceB:
`kubectl apply -f service-b-gw.yml`{{execute}}

Примените правило маршрутизации:
`kubectl apply -f inbound-to-service-b-vs.yml`{{execute}}

Проверьте готовность подов:
`kubectl get pods --all-namespaces`{{execute}}

Дождитесь, когда состояния всех подов достигнут статуса Running.

Выполните GET запрос по адресу ingress-шлюза:
`curl -v http://$GATEWAY_URL/service-b`{{execute}}

В случае успеха в теле ответа Вы должны получить сообщение: Hello from ServiceB!

Перейдите к следующему шагу.