Для управления развёртыванием приложений в среде Kubernetes используется объект **Deployment**. С помощью контроллера Deployment создаются поды и определяется, какой образ контейнера(ов) использовать в поде, сколько копий подов необходимо поддерживать в рабочем состоянии, а также другие параметры конфигурации пода. Kubernetes будет поддерживать работоспособность подов, развернутых на основе данного объекта Deployment, до тех пор, пока Deployment не будет явным образом удалён из кластера Kubernetes. Это означает, что если умрёт под, являющийся частью Deployment, Kubernetes автоматически создаст новый под, чтобы восстановить требуемое количество подов (указанное в Deployment).

Создайте **deployment.yaml** файл с манифестом Kubernetes: 

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

Как и в любом объекте Kubernetes есть ряд стандартных полей. Более подробно разберём описание спецификации **spec**: 

- **replicas** — это количество подов, которое запустит контроллер процесса развёртывания. В нашем случае 2. 
- **selector** — селектор указывает на то, что поды будут иметь метку app hello-demo. 
- **strategy** — указывается стратегия обновления на новую версию. В нашем случае это **rolling update**.
- **template** — это шаблон, по которому будут создаваться поды. В метаданных у этого шаблона нет имени, потому что при разворачивании имя назначается автоматически. Проставляемые метки обязаны включать в себя метки из селектора. 

Итого: **Deployments** — это контроллер, который управляет состоянием развёртывания подов, которое описывается в манифесте. А также следит за удалением и созданием экземпляров подов с помощью контроллеров **ReplicaSet**.

В свою очередь **ReplicaSet** гарантирует, что определенное количество экземпляров подов всегда будет запущено в кластере.
![Kubernetes Deployments](./assets/k8s-deployments.png)

Примените манифест, выполнив команду:

`kubectl apply -f deployment.yaml`{{execute T1}}

Команда kubectl apply создает объект, если он не был ещё создан, и обновляет, если он изменился. 

## Состояние Deployment

Состояние Deployment можно получить с помощью команд:

`kubectl get deploy hello-deployment `{{execute T1}}

```
controlplane $ kubectl get deploy hello-deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
hello-deployment   2/2     2            2           24m
```

Более подробное состояние можно увидеть, выполнив команду:

`kubectl describe deploy hello-deployment`{{execute T1}}

Например, полную статистику по репликам:
```
Replicas:           2 desired | 2 updated | 2 total | 2 available | 0 unavailable
```
