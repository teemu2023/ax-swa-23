Теперь, когда Вы убедились в работоспособности пути ingress-шлюз -> ServiceA -> SericeC -> external-cluster, давайте переключим 100% трафика из ServiceA в ServiceC.

Для этого Вам нужно будет обновить манифест producer-internal-host-vs.

Рассмотрим новую версию:
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
            host: service-c-srv
            port:
              number: 80
```

Как видите, теперь в блоке destination присутствует только хост service-c-srv, который ведет на ServiceC. Обратите внимание, ServiceA продолжит высылать запросы на хост producer-internal-host. Но сработает перенаправление на ServiceC, вместо ServiceB.

Примените манифест:
`kubectl apply -f producer-internal-host-100-c-vs.yml`{{execute}}

Совершите несколько запросов на ingress-шлюз:
`curl -v http://$GATEWAY_URL/service-a`{{execute}}

Теперь Вы можете видеть, что все ответы из ServiceC:
```
Hello from ServiceA! Calling master system API... Received response from master system (http://producer-internal-host): Hello from ServiceC! Calling master system API... Received response from master system (http://istio-ingressgateway.istio-system.svc.cluster.local/service-ext): Hello from External Cluster Service!
```
