На этом шаге будет создано новое пространство имён или виртуальный кластер, который изолирован от текущего пространства имён dev-service-mesh, и будет содержать прикладной сервис, поставляющий данные для Service C.

Весь исходящий трафик из dev-service-mesh будет направляться на egress-шлюз, который в свою очередь будет направлять (проксировать) все запросы в пространство external-cluster.

Создайте новое пространство имён (виртуальный кластер):

`kubectl create namespace external-cluster`{{execute}}

Чтобы приступить к настройке автовнедрение Envoy-прокси в данном пространстве имён, выполните команду:

`kubectl label namespace external-cluster istio-injection=enabled`{{execute}}

Выполните развёртывание нового прикладного сервиса External Cluster Service:

`kubectl apply -f service-ext-deployment.yml -n external-cluster`{{execute}}

Создайте для него Service:

`kubectl apply -f service-ext-srv.yml -n external-cluster`{{execute}}

Откройте доступ к хосту данного сервиса через ingress-шлюз:

`kubectl apply -f service-ext-gw.yml -n external-cluster`{{execute}}

Выполните настройку внутрикластерной маршрутизации трафика из ingress-шлюза в прикладной сервис:

`kubectl apply -f inbound-to-service-ext-vs.yml -n external-cluster`{{execute}}

Убедитесь, что все поды работают:

`kubectl get pods --all-namespaces`{{execute}}

Проверьте новый сервис обратившись к нему:

`curl -v http://$GATEWAY_URL/service-ext`{{execute}}

Перейдите к следующему шагу.