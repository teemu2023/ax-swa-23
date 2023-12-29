Передавать конфигурацию через **env** не всегда удобно. Так как для разных сред, конфигурация может отличаться, придётся хранить несколько версий манифеста одной и той же операции развёртывания, но с разными настройками. Также хранение параметров напрямую в настройках развёртывания нарушает один из принципов 12 факторных приложений. В соответствии с этим, необходимо отделять конфигурацию приложения от артефактов сборки и развёртывания.

Поэтому в Kubernetes есть объекты ConfigMap и Secret, которые позволяют хранить конфигурацию приложения отдельно от манифестов приложения.

Для начала рассмотрим как можно создавать ConfigMap и Secret.

Прежде всего, ConfigMap и Secret, как и любые объекты в Kubernetes можно описать в файле и потом применить манифест.

## Создание ConfigMap из манифеста

Создайте манифест **configmap.yaml**

<pre class="file" data-filename="./configmap.yaml" data-target="replace">
apiVersion: v1
kind: ConfigMap
metadata:
  name: hello-config
data:
  GREETING: Hello
</pre>

Помимо стандартных атрибутов apiVersion, kind, metadata в ConfigMap есть атрибут data, где хранятся данные конфигурации.

Примените манифест **configmap.yaml**: 

`kubectl apply -f configmap.yaml`{{execute T1}}

Получить **ConfigMap** можно также как и любой объект:

`kubectl get cm hello-config`{{execute T1}}

```
controlplane $ kubectl get cm hello-config
NAME           DATA   AGE
hello-config   1      5s
```

Посмотреть значения параметров ConfigMap можно с помощью команды `kubectl describe`:

`kubectl describe configmap hello-config`{{execute T1}}

Так же можно посмотреть данные конфигурации:

```
controlplane $ kubectl describe configmap hello-config
Name:         hello-config
Namespace:    myapp
Labels:       <none>
Annotations:  
Data
====
GREETING:
----
Hello
Events:  <none>
```
Теперь перейдём к созданию **Secret**.  

## Создание Secret из манифеста

Создайте манифест **secret.yaml**

<pre class="file" data-filename="./secret.yaml" data-target="replace">
apiVersion: v1
kind: Secret
metadata:
  name: hello-secret
data:
  DATABASE_URI: cG9zdGdyZXNxbCtwc3ljb3BnMjovL215dXNlcjpwYXNzd2RAcG9zdGdyZXMubXlhcHAuc3ZjLmNsdXN0ZXIubG9jYWw6NTQzMi9teWFwcA==
</pre>

Данные в объекте **ConfigMap** хранятся как есть, а в **Secret** кодируются в **base64**.

Например, значение DATABASE_URI закодировано в **base64**.

Раскодируйте значение из DATABASE_URI, выполнив команду:

`echo 'cG9zdGdyZXNxbCtwc3ljb3BnMjovL215dXNlcjpwYXNzd2RAcG9zdGdyZXMubXlhcHAuc3ZjLmNsdXN0ZXIubG9jYWw6NTQzMi9teWFwcA==' | base64 -d`{{execute T1}}

```
controlplane $ echo 'cG9zdGdyZXNxbCtwc3ljb3BnMjovL215dXNlcjpwYXNzd2RAcG9zdGdyZXMubXlhcHAuc3ZjLmNsdXN0ZXIubG9jYWw6NTQzMi9teWFwcA==' | base64 -d
postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp
```

Когда создаётся **Secret** с помощью манифестов, то кодировать нужно самостоятельно. Например, с помощью утилиты **base64**: 

`echo -n 'postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp' | base64`{{execute T1}}

```
controlplane $ echo -n 'postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp' | base64
cG9zdGdyZXNxbCtwc3ljb3BnMjovL215dXNlcjpwYXNzd2RAcG9zdGdyZXMubXlhcHAuc3ZjLmNs
dXN0ZXIubG9jYWw6NTQzMi9teWFwcA==
```

Примените манифест **secret.yaml**: 

`kubectl apply -f secret.yaml`{{execute T1}}

Получить **Secret** можно также как и любой объект:

`kubectl get secret hello-secret`{{execute T1}}

```
controlplane $ kubectl get secret hello-secret
NAME           TYPE     DATA   AGE
hello-secret   Opaque   1      3s
```

Если выполнить команду `kubectl describe`, то данных из **Secret** Вы не получите:: 

`kubectl describe secret hello-secret`{{execute T1}}

Но если запросить в формате **yaml** или **json**, то там будет закодированная строка:

`kubectl get secret -o json hello-secret`{{execute T1}}

`kubectl get secret -o yaml hello-secret`{{execute T1}}

Чтобы получить значение конкретного параметра **Secret** из командной строки, можно воспользоваться параметром **jsonpath** и **base64**:

`kubectl get secret hello-secret -o jsonpath="{.data.DATABASE_URI}" | base64 -d`{{execute T1}}

```
controlplane $ kubectl get secret hello-secret -o jsonpath="{.data.DATABASE_URI}" | base64 -d
postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp
controlplane $ 
```

## Создание ConfigMap из командной строки

Создать **ConfigMap** и **Secret** можно и с помощью императивных команд **Kubernetes**.

Самый простой способ создать **ConfigMap** или **Secret** из строковых литералов.

**ConfigMap** можно создать с помощью такой команды: 

`kubectl create configmap {имя конфигмапы} --from-literal={ключ1}={значение1} --from-literal={ключ2}={значение2} ...`

Создайте **ConfigMap**:

`kubectl create configmap hello-config-literal --from-literal=GREETING=Hello --from-literal=GREETING2=ALLOHA`{{execute T1}}

Проверьте, что **ConfigMap** создался правильно:

`kubectl describe configmap hello-config-literal`{{execute T1}}

```
controlplane $ kubectl describe configmap hello-config-literal
Name:         hello-config-literal
Namespace:    myapp
Labels:       <none>
Annotations:  <none>

Data
====
GREETING:
----
Hello
GREETING2:
----
ALLOHA
Events:  <none>
```

## Создание Secret из командной строки

Для **Secret** чуть по-другому выглядит команда, но очень похоже: `kubectl create secret generic {имя секрета} --from-literal={ключ1}={значение1} --from-literal={ключ2}={значение2} ...`

Создайте **Secret** с `PASSWORD=SuperCoolPassword2`. Данные в команду передаются чистые, незакодированные, а **Kubernetes** сам занимается их кодированием:

`kubectl create secret generic hello-secret-literal --from-literal=PASSWORD=SuperCoolPassword2`{{execute T1}}

Проверьте, что данные закодированы:

`kubectl get secret hello-secret-literal -o jsonpath="{.data.PASSWORD}"`{{execute T1}}

```
controlplane $ kubectl get secret hello-secret-literal -o jsonpath="{.data.PASSWORD}"
U3VwZXJDb29sUGFzc3dvcmQy
controlplane $ 
```

Проверьте, что данные совпадают с теми данными, которые отправляли в команде:

`kubectl get secret hello-secret-literal -o jsonpath="{.data.PASSWORD}" | base64 -d`{{execute T1}}

```
controlplane $ kubectl get secret hello-secret-literal -o jsonpath="{.data.PASSWORD}"
U3VwZXJDb29sUGFzc3dvcmQy
controlplane $ 
```

Удалите **Secret** и **ConfigMap**, чтобы они Вам не мешали:

`kubectl delete secret hello-secret-literal`{{execute T1}}

`kubectl delete configmap hello-config-literal`{{execute T1}}

## Создание ConfigMap из файлов

Есть ещё возможность создавать **ConfigMap** и **Secret** из файлов. В общем случае передаётся имя директории. И для каждого файла создаётся пара, где ключом является имя файла, а значением — его содержимое. Для **ConfigMap** данные сохраняются как есть, а данные для **Secret** кодируются в **base64**. 

Создайте директорию `hello-configmap-dir`, а в ней файлы `GREETING` и `GREETING2`:

`mkdir hello-configmap-dir`{{execute T1}}

`echo 'Hello' > hello-configmap-dir/GREETING`{{execute T1}}

`echo 'ALLOHA' > hello-configmap-dir/GREETING2`{{execute T1}}

Теперь с помощью команды `kubectl create configmap {имя конфигмапы} --from-file={путь до директории}` можно создать **ConfigMap**:

`kubectl create configmap hello-configmap-from-file --from-file=hello-configmap-dir`{{execute T1}}

Проверьте, что **ConfigMap** создался правильно:

`kubectl describe configmaps hello-configmap-from-file`{{execute T1}}

```
controlplane $ kubectl describe configmaps hello-configmap-from-file
Name:         hello-configmap-from-file
Namespace:    myapp
Labels:       <none>
Annotations:  <none>

Data
====
GREETING2:
----
ALLOHA

GREETING:
----
Hello

Events:  <none>
controlplane $ 
```

## Создание Secret из файлов

Для **Secret** это работает аналогично.

Создайте директорию `hello-secret-dir`, а в ней файлы `DATABASE_URI` и `PASSWORD`. В содержимом файла должны хранится данные в незакодированном виде, **Kubernetes** сам их закодирует. 

`mkdir hello-secret-dir`{{execute T1}}

`echo 'postgresql+psycopg2://myuser:passwd@postgres.myapp.svc.cluster.local:5432/myapp' > hello-secret-dir/DATABASE_URI`{{execute T1}}

`echo 'SuperCoolStrongPassword' > hello-secret-dir/PASSWORD`{{execute T1}}

Теперь с помощью команды `kubectl create secret generic {имя секрета} --from-file={путь до директории}` можно создать секрет. 

`kubectl create secret generic hello-secret-from-file --from-file=hello-secret-dir`{{execute T1}}

Проверьте, что данные закодированы:

`kubectl get secret hello-secret-from-file -o jsonpath="{.data.PASSWORD}"`{{execute T1}}

```
controlplane $ kubectl get secret hello-secret-from-file -o jsonpath="{.data.PASSWORD}"U3VwZXJDb29sU3Ryb25nUGFzc3dvcmQKcontrolplane $ 
```

`kubectl get secret hello-secret-from-file -o jsonpath="{.data.DATABASE_URI}"`{{execute T1}}

```
kubectl get secret hello-secret-from-file -o jsonpath="{.data.DATABASE_URI}"
cG9zdGdyZXNxbCtwc3ljb3BnMjovL215dXNlcjpwYXNzd2RAcG9zdGdyZXMubXlhcHAuc3ZjLmNsdXN0ZXIubG9jYWw6NTQzMi9teWFwcAo=
controlplane $
```

Проверьте, что данные совпадают с теми данными, что были отправлены в команде:

`kubectl get secret hello-secret-from-file -o jsonpath="{.data.PASSWORD}" | base64 -d`{{execute T1}}

```
controlplane $ kubectl get secret hello-secret-from-file -o jsonpath="{.data.PASSWORD}" | base64 -d
SuperCoolStrongPassword
```

Удалите **Secret** и **ConfigMap**, чтобы они Вам не мешали:

`kubectl delete secret hello-secret-from-file`{{execute T1}}

`kubectl delete configmap hello-configmap-from-file`{{execute T1}}
