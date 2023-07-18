Для управление развертыванием приложений в среде **Kubernetes** используется объект **Deployment**.
С помощью контроллера **Deployment** создаются **Pods** и определяется, какой образ контейнера(ов) использовать в Pod, сколько копий Pods необходимо поддерживать в рабочем состоянии, а также другие параметры конфигурации Pod.
**Kubernetes** будет поддерживать работоспособность **Pod'ов**, развернутых на основе данного объекта **Deployment**, до тех пор, пока **Deployment** не будет явным образом удален из кластера **Kubernetes**.
Это означает, что если умрет **Pod**, являющийся частью **Deployment**, **Kubernetes** автоматически создаст новый **Pod**, чтобы восстановить требуемое количество **Pod** (указанное в **Deployment**).

Создадим **deployment.yaml** файл с манифестом **Kubernetes**: 

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
          image: schetinnikov/hello-app:v1
          ports:
            - containerPort: 8000
</pre>

Как и в любом объекте **Kubernetes** есть ряд стандартных полей, мы на них останавливаться не будем. Посмотрим на описание спецификации **spec**. 

- **replicas** - это количество **Pods**, которое запустит контроллер деплоймента. В нашем случае 2. 
- **selector** - селектор указывает на то, что под управлением деплоймента будут **Pods** с меткой app hello-demo. 
- **strategy** - указывается стратегия обновления на новую версию. В нашем случае это **rolling update**. 
- **template** - это шаблон **Pods**, по которому будут создаваться **Pods** деплойментом. В метаданных у этого шаблона нет имени, потому что деплоймент сам назначает это имя. Проставляемые метки обязаны включать в себя метки из селектора. 

Итого: **Deployments** - это  контроллер, который управляет состоянием развертывания **Pods**, которое описывается в манифесте. А также следит за удалением и созданием экземпляров **Pods** с помощью контроллеров **ReplicaSet**.

В свою очередь **ReplicaSet** - гарантирует, что определенное количество экземпляров подов всегда будет запущено в кластере.
![Kubernetes Deployments](./assets/k8s-deployments.png)

Применим манифест

`kubectl apply -f deployment.yaml`{{execute T1}}

Команда kubectl apply создает объект, если он не был еще создан и обновляет, если он изменился. 

Во второй вкладке можем наблюдать за тем, как создаются поды. 
Дождемся, пока деплоймент раскатится - т.е. когда все поды станут в статусе **Running**

```
NAME                               READY   STATUS    RESTARTS   AGE
hello-deployment-d67cff5cc-hrfh8   1/1     Running   0          35s
hello-deployment-d67cff5cc-hsf6g   1/1     Running   0          35s
```

## Состояние деплоймента

Состояние деплоймента можно получить с помощью команд:

`kubectl get deploy hello-deployment `{{execute T1}}

```
controlplane $ kubectl get deploy hello-deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
hello-deployment   2/2     2            2           24m
```

Тут можно увидеть состояние более подробно:

`kubectl describe deploy hello-deployment`{{execute T1}}

Например, можно увидеть полную статистику по репликам:
```
Replicas:           2 desired | 2 updated | 2 total | 2 available | 0 unavailable
```
