Один из самых простых способов конфигурации приложения — это передача параметров конфигурации через переменные окружения (.env). Давайте познакомимся с тем, как работать с переменными окружения в Kubernetes.

Прежде всего необходимо запустить приложение. Создайте файл **deployment.yaml**: 

<pre class="file" data-filename="./deployment.yaml" data-target="replace">
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello-demo
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: hello-demo
    spec:
      containers:
        - name: hello-demo
          image: schetinnikov/hello-app:v3
          ports:
            - containerPort: 8000
</pre>

Создайте файл **service.yaml**

<pre class="file" data-filename="./service.yaml" data-target="replace">
apiVersion: v1
kind: Service
metadata:
  name: hello-service
spec:
  selector:
    app: hello-demo
  ports:
    - port: 9000
      targetPort: 8000
  type: ClusterIP
</pre>

Примените манифесты:

`kubectl apply -f deployment.yaml -f service.yaml`{{execute T1}}

Во втором терминале можно наблюдать за тем, как создаются поды. Дождитесь, пока операция развёртывания завершится, то есть когда все поды окажутся в статусе *Running*:

```
NAME                                    READY   STATUS    RESTARTS   AGE
pod/hello-deployment-7d79b5c767-2v8th   1/1     Running   0          70s
pod/hello-deployment-7d79b5c767-4hxll   1/1     Running   0          70s
```

## Переменные окружения
Мы используем версию приложения, которая по пути '/env' отдает свою конфигурацию, вместе с переменными окружения.

Выполните запрос к приложению и посмотрите на настройки по умолчанию.

Сохраните **clusterIp** сервиса в переменную 'CLUSTER_IP', выполнив команду:

`CLUSTER_IP=$(kubectl get service hello-service -o jsonpath="{.spec.clusterIP}")`{{execute T1}}

Посмотрите ответ приложения:

`curl -s http://$CLUSTER_IP:9000/env | jq`{{execute T1}}

```
controlplane $ curl -s http://$CLUSTER_IP:9000/env | jq
{
  "DATABASE_URI": "",
  "HOSTNAME": "hello-deployment-7d79b5c767-4hxll",
  "GREETING": "Hello"
}
```

В ответе три переменные конфигурации: DATABASE_URI, GREETING, HOSTNAME. DATABASE_URI и GREETING берутся из переменных окружения, а HOSTNAME — это имя хоста приложения.

Значения, которые мы с Вами видим — это значения по умолчанию, то есть когда никаких переменных окружения не выставлено.

Переопределим DATABASE_URI и GREETING, добавив в явном виде секцию env в спецификацию контейнера. В этой секции можно перечислить набор пар name-value. В результате контейнеру при запуске будут добавлены переменные окружения с именем из name и значением из value.

Измените их, добавив секцию **env** в спецификацию контейнера и добавив переменные окружения DATABASE_URI и GREETING: 

<pre class="file" data-filename="./deployment.yaml" data-target="replace">
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello-demo
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: hello-demo
    spec:
      containers:
        - name: hello-demo
          image: schetinnikov/hello-app:v3
          ports:
            - containerPort: 8000
          env:
            - name: DATABASE_URI
              value: 'postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp'
            - name: GREETING
              value: 'Alloha'
</pre>

Примените манифест:

`kubectl apply -f deployment.yaml`{{execute T1}}

Дождитесь, когда операция выполниться и все поды окажутся в статусе **Running**:

`kubectl get pods,deployments,service`{{execute}}

После обновления, приложение отдает другие переменные окружения: 

`curl -s http://$CLUSTER_IP:9000/env | jq`{{execute T1}}

```
controlplane $ curl -s http://$CLUSTER_IP:9000/env | jq
{
  "HOSTNAME": "hello-deployment-9797f8f6d-nnzcm",
  "DATABASE_URI": "postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp",
  "GREETING": "Alloha"
}
```
В ответе видно, что те переменные, которые мы передали подхватываются в конфигурации приложения.
