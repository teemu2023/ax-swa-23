На этом шаге будет настроен Service Mesh согласно следующей схеме:

![Mesh configuration](../assets/sswa13servicemesh2-1.png)

Установите ServiceA, выполнив команду:
`kubectl apply -f serviceA-v1-deployment.yml`{{execute}}

Примените Service для развёртывания выше:
`kubectl apply -f serviceA-srv.yml`{{execute}}

Создайте Gateway, выполнив команду:
`kubectl apply -f serviceA-gw.yml`{{execute}}

Определите правило маршрутизации:
`kubectl apply -f inbound-to-serviceA-vs.yml`{{execute}}

Проверьте готовность подов:
`kubectl get pods --all-namespaces`{{execute}}

Дождитесь, когда состояния всех подов достигнут статуса **Running**.

Выполните GET запрос по адресу ingress-шлюза:
`curl -v http://$GATEWAY_URL/service-a`{{execute}}

В ответ на совершенный вызов на данном шаге Вы должны получить сообщение:
`Hello from ServiceA! Calling master system API... I/O error on GET request for "http://producer-internal-host": producer-internal-host; nested exception is java.net.UnknownHostException: producer-internal-host`

Что произошло?

Вы совершили запрос в ingress-шлюз, который был перенаправлен в Envoy-прокси пода с контейнером ServiceA. Далее запрос был маршрутизирован непосредственно в приложение ServiceA.

ServiceA, получив запрос, совершил запрос по адресу http://producer-internal-host:80/, однако данного хоста ещё нет в Service Mesh, поэтому произошло исключение java.net.UnknownHostException. ServiceA подготовил ответ на внешний вызов и вернул его.

Проверьте логи доступа Envoy ingress-шлюза:
`kubectl logs -l app=istio-ingressgateway -n istio-system -c istio-proxy`{{execute}}

Проверьте логи доступа Envoy в поде с бизнес-сервисом:
`kubectl logs -l app=service-a-app -c istio-proxy`{{execute}}

Перейдите к следующему шагу.