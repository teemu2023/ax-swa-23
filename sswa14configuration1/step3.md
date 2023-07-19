## Переменные окружения из ConfigMap и Secret
Использовать созданные ConfigMap и Secret возможно следующим образом: передавать значения из ConfigMap/Secret в виде переменных окружения, либо передавать значения из Configmap/Secret в виде примонтированной директории внутрь контейнера. 

Рассмотрим первый способ.  Получение значений переменных окружения из конфигмапов и секретов.
Пропишем получение переменных окружения из **ConfigMap** и **Secret** в *деплоймент*:

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



Применим манифест

`kubectl apply -f deployment.yaml`{{execute}}

Во втором терминале можем наблюдать за тем, как создаются *поды*. 
Дождемся, пока деплоймент раскатится - т.е. когда все поды не окажутся в статусе  **Running**

После раскатки можем убедиться, что конфигурация действительно берется из **СonfigMap** и **Secret**.

`curl -s http://$CLUSTER_IP:9000/env | jq`{{execute}}

```
controlplane $ curl -s http://$CLUSTER_IP:9000/env | jq
{
  "DATABASE_URI": "postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp",
  "HOSTNAME": "hello-deployment-5bb48d8d4b-tt4jg",
  "GREETING": "Privet"
}
```
Теперь посмотрим, как работает второй способ, т.е. как можно примонтировать ConfigMap внутрь пода, как директорию. В этом случае каждый файл в директории будет соответствовать одному параметру - имя файла в качества ключа, а содержимое файла - это значение.

## Монтирование ConfigMap внутрь пода 


Давайте посмотрим, как можно примонтировать **ConfigMap** внутрь пода, как директорию. Каждый файл в директории будет соответствовать одному параметру - имя файла в качества ключа, а содержимое файла - это значение.

Создадим **ConfigMap** из манифеста **mountconfig.yaml**: 

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


Применим манифест:

`kubectl apply -f mountconfig.yaml`{{execute}}

Спецификация пода позволяет описывать и использовать хранилища.  Чтобы примонтировать внутрь пода конфигмап, нам нужно определить хранилище (volume) в спецификации пода, а потом на уже уровне контейнера описать точку монтирования. 

И теперь уже монтируем внутрь пода:

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

Хранилища у нас описываются на уровне спецификации пода (spec) в атрибуте volumes. Мы описываем хранилище mount-config, которое будет создано из конфигмапы с именем mount-config. 

На уровне контейнера в атрибует volumeMounts мы описываем точку монтирования хранилищ, т.е. в данном случае вольюм mount-config должен быть примонтирован в директорию /tmp/config. 

Применяем манифест:

`kubectl apply -f deployment.yaml`{{execute}}

Во втором терминале можем наблюдать за тем, как создаются *поды*. 
Дождемся, пока *деплоймент* раскатится - т.е. когда все *поды* станут в статусе **Running**

Зайдем в *поду* *деплоймента* и посмотрим, как выглядят примонтированные конфиги в третьем терминале:

`kubectl exec -it deploy/hello-deployment -- /bin/bash`{{execute}}

>  если терминал не был до этого открыт, то команду нужно будет нажать 2 раза - первый раз будет открыт терминал, а во второй выполнится уже команда.

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
Содержимое соответвует значениям из конфигмапы. 

В случае, если поменяются значения в ConfigMap/Secret они автоматически НЕ будут обновлены, в случае использования в виде переменных окружения. Kubelet при создании проверяет, что нужный ConfigMap/Secret есть и передает в качестве переменных окружений конфигурацию оттуда. В случае использования Configmap/Secret как примонтированного директории в контейнере, kubelet периодически обновляет данные. И при изменения ConfigMap/Secret эти изменения там отразятся. Но в любом случае приложение должно уметь перечитывать и определять изменения из конфигурации.

Если мы с вами изменим **ConfigMap**, то через некоторое время изменения применятся и файлы внутри *пода* изменятся:

<pre class="file" data-filename="./mountconfig.yaml" data-target="insert" data-marker="    foo=bar">
  foo=FOOBARBAZQUUX</pre>


Применим манифест:

`kubectl apply -f mountconfig.yaml`{{execute}}

Смотрим изменения:

`cat /tmp/config/my.cfg`{{execute}}
```
root@hello-deployment-85fbc4cd8b-c5q7h:/usr/src/app# cat /tmp/config/my.cfg
foo=FOOBARBAZQUUX
baz=quux
```

Да, действительно, изменения произошли. 

Итак, мы с вами разобрали основы конфигурирования приложений в Kubernetes, а также изучили базовые команды для работы с объектами ConfigMap и Secret. 