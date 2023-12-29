На этом шаге будет настроена балансировка исходящего трафика из ServiceA на два сервиса-поставщика данных — ServiceB и ServiceC.

Схема Service Mesh, в соответствии с которой будем настраивать кластер, представлена ниже:

![Mesh configuration](../assets/sswa13servicemesh2-3.png)

Установите ServiceC:
`kubectl apply -f service-c-deployment.yml`{{execute}}

Примените манифест Service для развёртывания ServiceC:
`kubectl apply -f service-c-srv.yml`{{execute}}

Рассмотрим новую версию правила маршрутизации producer-internal-host-vs:
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: producer-internal-host-vs
spec:
  hosts:
    - producer-internal-host
  gateways:
    - mesh
  http:
    - route:
        - destination:
            host: producer-internal-host
            port:
              number: 80
          weight: 50
        - destination:
            host: service-c-srv
            port:
              number: 80
          weight: 50
```

Блок spec.http[0].route содержит два вложенных блока destination с хостами producer-internal-host и service-c-srv, а также с ключами weight, содержащими значения процентных долей для расщепления трафика и перенаправления всех поступивших на хост producer-internal-host (ключ spec.hosts) запросов.

Обновите виртуальный сервис producer-internal-host-vs, созданный на предыдущем шаге, на новый манифест producer-internal-host-50-c-vs.yml:
`kubectl apply -f producer-internal-host-50-c-vs.yml`{{execute}}

Теперь, приблизительно 50% запросов будут направлены на Service C, оставшиеся как и ранее — на Service B. Совершите 5-6 запросов и убедитесь, что в ответе присутствуют данные из разных сервисов.
`curl -v http://$GATEWAY_URL/service-a`{{execute}}

Теперь среди ответов Вы увидите уже известный нам вариант:
`Hello from ServiceA! Calling master system API... Received response from master system (http://producer-internal-host): Hello from ServiceB!`

Но будет также и новый вариант:

`Hello from ServiceA! Calling master system API... Received response from master system (http://producer-internal-host): Hello from ServiceC! Calling master system API... 404 Not Found: [no body]`

Такой ответ — результат направления запроса из ServiceA в ServiceC, который пытается получить данные из своего поставщика http://istio-ingressgateway.istio-system.svc.cluster.local/service-ext.

При последующих вызовах ответы продолжат чередоваться, так как трафик был разделён на два сервиса, как отражено на схеме.

`curl -v http://$GATEWAY_URL/service-a`{{execute}}

Перейдите к следующему шагу.