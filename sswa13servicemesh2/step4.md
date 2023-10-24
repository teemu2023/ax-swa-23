На этом шаге исходящие запросы будут направлены из ServiceA в ServiceB. На схеме это выглядит следующим образом:

![Mesh configuration](../assets/sswa13servicemesh2-2.png)

Установите ServiceB, выполнив команду:
`kubectl apply -f service-b-deployment.yml`{{execute}}

Примените манифест Service для развёртывания выше:
`kubectl apply -f producer-internal-host.yml`{{execute}}

Далее необходимо определить правило маршрутизации запросов из ServiceA на хост producer-internal-host.

Рассмотрим producer-internal-host-vs:
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
```

Примените данный манифест, выполнив команду:
`kubectl apply -f producer-internal-host-vs.yml`{{execute}}

Проверьте готовность подов:
`kubectl get pods --all-namespaces`{{execute}}

Повторите совершенный на предыдущем шаге GET запрос по адресу ingress-шлюза:
`curl -v http://$GATEWAY_URL/service-a`{{execute}}

В случае успеха ответ на совершенный вызов должен быть следующим:
`Hello from ServiceA! Calling master system API... Received response from master system (http://producer-internal-host): Hello from ServiceB!`

Для сравнения аналогичный вызов на предыдущем шаге возвращал такой ответ: 
`Hello from ServiceA! Calling master system API... I/O error on GET request for "http://producer-internal-host": producer-internal-host; nested exception is java.net.UnknownHostException: producer-internal-host`

Теперь в кластере существует поставщик данных для ServiceA, который связан с хостом producer-internal-host, поэтому ServiceA на этом шаге получает корректный ответ.

Проверьте логи доступа Envoy ingress-шлюза:
`kubectl logs -l app=istio-ingressgateway -n istio-system -c istio-proxy`{{execute}}

Проверьте логи доступа Envoy в поде с бизнес-сервисом ServiceA:
`kubectl logs -l app=service-a-app -c istio-proxy`{{execute}}

Проверьте логи доступа Envoy в поде с бизнес-сервисом ServiceB:
`kubectl logs -l app=service-b-app -c istio-proxy`{{execute}}

Перейдите к следующему шагу.