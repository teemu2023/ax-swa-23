На данный момент Вы завершили создание манифестов, необходимых для достижения цели открытия входящего трафика в Service Mesh.

Для того чтобы апробировать путь входящих запросов в ServiceB, следует совершить запрос на адрес ingress-шлюза, который должен перенаправить поступивший запрос в адрес Envoy-прокси в поде с бизнес-сервисом, который в свою очередь направит запрос в ServiceB. Этот сервис, получив запрос, сформирует и отправит ответ по обратному пути.

Для начала запросите краткое описание манифеста Service ingress-шлюза, созданного при установке Istio:

`kubectl get svc istio-ingressgateway -n istio-system`{{execute}}

Экспортируйте IP-адрес из этого ресурса в переменную, выполнив команду:

`export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')`{{execute}}

То же самое выполните для номера порта ingress-шлюза:

`export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')`{{execute}}

Создайте переменную, содержащую извлечённые ранее данные:

`export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT`{{execute}}

Таким образом, переменная GATEWAY_URL содержит адрес по которому можно совершить запрос в ingress-шлюз:

`echo $GATEWAY_URL`{{execute}}

Перед запросом убедитесь в корректности статусов всех подов всех пространств имён, выполнив команду:

`kubectl get pods --all-namespaces`{{execute}}

И наконец, выполните GET запрос по адресу ingress-шлюза:

`curl -v http://$GATEWAY_URL/service-b`{{execute}}

В случае успеха в теле ответа Вы должны получить сообщение: Hello from ServiceB!

Проверьте логи доступа Envoy ingress-шлюза:

`kubectl logs -l app=istio-ingressgateway -n istio-system -c istio-proxy`{{execute}}

Обратите внимание на запись стандартного вывода Envoy: 

`[2021-09-13T20:04:15.299Z] "GET /service-b HTTP/1.1" 200 - via_upstream - "-" 0 21 125 124 "10.42.0.1" "curl/7.68.0" "9629157d-09ba-4c97-b3f4-f7a277ee055e" "10.180.179.167" "10.42.0.9:8082" outbound|80||producer-internal-host.dev-service-mesh.svc.cluster.local 10.42.0.7:60256 10.42.0.7:8080 10.42.0.1:60625 - -`

В нем приведено подробное описание полученного запроса Envoy-прокси, выступающего в роли ingress-шлюза, и совершенного перенаправления этого запроса согласно правилам маршрутизации. Подробнее о стандартном выводе Envoy приведено в разделе «Телеметрия» теоретической части курса.

Для проверки логов доступа Envoy в поде с бизнес-сервисом выполните команду:

`kubectl logs -l app=service-b-app -c istio-proxy`{{execute}}
