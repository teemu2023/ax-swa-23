Манифест Gateway из API Istio конфигурирует изолированный Envoy-proxy, который управляет всем входящим (ingress-шлюз) или исходящим (egress-шлюз) трафиком сети.

На данном шаге будет сконфигурирован ingres-шлюз, представляющий собой под с контейнером Envoy-proxy из пространства имён istio-system, где он был развёрнут автоматически при установке Istio.

Рассмотрим манифест:
```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: service-b-gw
spec:
  selector:
    istio: ingressgateway
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - "*"
```

Обратите внимание: значение ключа spec.selector.istio содержит значение селектора istio, таким образом определяя свое действие на под, имеющий подобный селектор (istio=ingressgateway).

Ключ spec.servers[0].port.number содержит номер порта, который будет открыт у ingress-шлюза для приёма входящих запросов, а ключ spec.servers[0].hosts — имя хостов, которые могут быть запрошены.

Чтобы рассмотреть детальное описание пода istio-ingressgateway, в том числе блок Labels, содержащий среди прочего istio=ingressgateway, выполните команду:

`kubectl describe pod -l app=istio-ingressgateway -n istio-system`{{execute}}

Примените манифест service-b-gw.yml:

`kubectl apply -f service-b-gw.yml`{{execute}}

Чтобы получить детальное описание созданного ресурса, выполните команду:

`kubectl describe gateway.networking.istio.io service-b-gw`{{execute}}

Перейдите к следующему шагу.