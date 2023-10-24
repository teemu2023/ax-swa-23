## Переменные окружения из **ConfigMap** и **Secret**
Использовать созданные **ConfigMap** и **Secret** возможно следующим образом: передавать значения из **ConfigMap/Secret** в виде переменных окружения, либо передавать значения из **ConfigMap/Secret** в виде директории внутри контейнера (доступ к локальной директории настраивается).

Рассмотрим первый способ — получение значений переменных окружения из **ConfigMap** и **Secret**.

Пропишите получение переменных окружения из **ConfigMap** и **Secret**:

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
              valueFrom:
                secretKeyRef:
                  name: hello-secret
                  key: DATABASE_URI
            - name: GREETING
              valueFrom:
                configMapKeyRef:
                  name: hello-config
                  key: GREETING
</pre>



Примените манифест

`kubectl apply -f deployment.yaml`{{execute T1}}

Во втором терминале можно наблюдать за тем, как создаются поды. Дождитесь, пока операция развёртывания завершится, то есть когда все поды окажутся в статусе **Running**.

После завершения развёртывания можно убедиться, что конфигурация действительно берётся из **СonfigMap** и **Secret**, выполнив команду

`curl -s http://$CLUSTER_IP:9000/env | jq`{{execute}}

```
controlplane $ curl -s http://$CLUSTER_IP:9000/env | jq
{
  "DATABASE_URI": "postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp",
  "HOSTNAME": "hello-deployment-5bb48d8d4b-tt4jg",
  "GREETING": "Hello"
}
```
Теперь рассмотрим второй способ, то есть как можно настроить получение ConfigMap по заданному пути из контейнера. В этом случае каждый файл в директории будет соответствовать одному параметру — имя файла в качества ключа, а содержимое файла — это значение.

## Монтирование ConfigMap внутрь пода 

Создайте **ConfigMap** из манифеста **mountconfig.yaml**: 

<pre class="file" data-filename="./mountconfig.yaml" data-target="replace">
apiVersion: v1
kind: ConfigMap
metadata:
  name: mount-config
data:
  test.json: |
    {
       "status": "OK"
    }
  my.cfg: |
    foo=bar
    baz=quux
  .env: |
    DATABASE_URI=....
</pre>


Примените манифест:

`kubectl apply -f mountconfig.yaml`{{execute}}

Спецификация пода позволяет описывать и использовать хранилища. Чтобы указать директорию внутри пода для получения **ConfigMap**, необходимо определить хранилище (volume) в спецификации пода, а потом на уровне контейнера описать точку монтирования.

Опишите конфигурацию ConfigMap внутрь пода:

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
          volumeMounts:
            - name: mount-config
              mountPath: /tmp/config
      volumes:
        - name: mount-config
          configMap:
            name: mount-config
</pre>

Хранилища описываются на уровне спецификации пода (spec) в атрибуте volumes. Мы описываем хранилище mount-config, которое будет создано из ConfigMap с именем mount-config.

На уровне контейнера в атрибут volumeMounts описываем точку монтирования хранилищ, то есть в данном случае хранилище mount-config должно иметь директорию /tmp/config.

Примените манифест:

`kubectl apply -f deployment.yaml`{{execute}}

Во втором терминале можно наблюдать за тем, как создаются поды. Дождитесь, пока операция развёртывания завершиться, то есть когда все поды достигнут статуса **Running**.

Зайдите в настройки поды и посмотрите, как выглядят конфиги, полученные по локальному адресу в третьем терминале:

`kubectl exec -it deploy/hello-deployment -- /bin/bash`{{execute}}

Если терминал не был до этого открыт, то команду нужно будет нажать 2 раза — первый раз будет открыт терминал, а во второй выполнится уже команда.

`ls /tmp/config`{{execute}}

```
root@hello-deployment-85fbc4cd8b-c5q7h:/usr/src/app# ls /tmp/config
my.cfg  test.json
```


`cat /tmp/config/test.json`{{execute}}
```
root@hello-deployment-85fbc4cd8b-c5q7h:/usr/src/app# cat /tmp/config/test.json
{
   "status": "OK"
}
```

`cat /tmp/config/my.cfg`{{execute}}
```
root@hello-deployment-85fbc4cd8b-c5q7h:/usr/src/app# cat /tmp/config/my.cfg
foo=bar
baz=quux
```
Содержимое соответствует значениям из **ConfigMap**. 

В случае использования в виде переменных окружения, если поменяются значения в ConfigMap/Secret они автоматически НЕ будут обновлены. Kubelet при создании проверяет, что нужный ConfigMap/Secret есть и передаёт в качестве переменных окружений конфигурацию оттуда. Если директория Config/Secret подключена к контейнеру, kubelet периодически обновляет данные. И при изменения ConfigMap/Secret эти изменения там отразятся. Но в любом случае приложение должно уметь перечитывать и определять изменения из конфигурации.

Если изменить **ConfigMap**, то через некоторое время изменения применятся и файлы внутри пода тоже изменятся:

<pre class="file" data-filename="./mountconfig.yaml" data-target="insert" data-marker="    foo=bar">
foo=FOOBARBAZQUUX</pre>

Примените манифест:

`kubectl apply -f mountconfig.yaml`{{execute}}

Проверьте изменения:

`cat /tmp/config/my.cfg`{{execute}}
```
root@hello-deployment-85fbc4cd8b-c5q7h:/usr/src/app# cat /tmp/config/my.cfg
foo=FOOBARBAZQUUX
baz=quux
```

Да, действительно, изменения произошли.

Итак, мы с Вами разобрали основы конфигурирования приложений в **Kubernetes**, а также изучили базовые команды для работы с объектами **ConfigMap** и **Secret**. 
