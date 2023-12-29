На этом и последующих шагах будет развёрнут бизнес-сервис в Service Mesh и открыт к нему доступ из вне.

Схема создаваемой конфигурации сети представлена ниже:

![Mesh configuration](../assets/scheme1-b.png)

Для запуска пода, содержащий бизнес-сервис, необходимо применить манифест Deployment.

Рассмотрим этот манифест:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-b-deployment
  labels:
    app: service-b-app
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: service-b-app
      version: v1
  template:
    metadata:
      labels:
        app: service-b-app
        version: v1
    spec:
      containers:
        - name: service-b-container
          image: artashesavetisyan/istio-basics-course:service-b
          imagePullPolicy: Always
          ports:
            - containerPort: 8082
          securityContext:
            runAsUser: 1000
```

Обратите внимание: ключ spec.template.spec.containers[0].image, значение которого содержит ссылку на image с бизнес-сервисом ServiceB из DockerHub, ключ spec.template.spec.containers[0].ports[0].containerPort (8082), содержит номер порта, который будет открыт у создаваемого контейнера и ключ metadata.labels.app, значение которого будет использовано в следующем манифесте.

ServiceB — это веб-приложение на базе Spring Boot и Java, которое принимает GET запросы по адресу http://localhost:8082/ и возвращает константный ответ вида: `Hello from ServiceB!`

Исходный код приложения: `https://github.com/ArtashesAvetisyan/sbercode-scenarios/tree/master/apps/ServiceB`{{copy}}

Примените манифест, выполнив команду:

`kubectl apply -f service-b-deployment.yml`{{execute}}

Проверьте статус созданного пода:

`kubectl get pods`{{execute}}

Дождитесь следующего состояния пода:
```
NAME                                    READY   STATUS    RESTARTS   AGE
service-b-deployment-786dc4d5b4-h8lkm   2/2     Running   0          14s
```

Запишите имя созданного пода в переменную POD_NAME, выполнив команду:

`export POD_NAME=$(kubectl get pod -l app=service-b-app -o jsonpath="{.items[0].metadata.name}")`{{execute}}

Выведите логи приложения ServiceB:

`kubectl logs $POD_NAME`{{execute}}

Чтобы рассмотреть конфигурацию и состояние пода более подробно, выполните команду:

`kubectl describe pod $POD_NAME`{{execute}}

Перейдите к следующему шагу.