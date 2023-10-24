Манифест Service позволяет Kubernetes создать некую абстракцию над коллекцией подов и открыть к ним единый адрес доступа, закрепив за ними определенный хост и IP адрес.

Рассмотрим этот манифест:
```
apiVersion: v1
kind: Service
metadata:
  name: producer-internal-host
spec:
  ports:
    - port: 80
      name: http-80
      targetPort: 8082
  selector:
    app: service-b-app
```

Обратите внимание: значение ключа metadata.name содержит имя хоста, по которому будет доступно приложение внутри Service Mesh, имя которого указано в ключе spec.selector.app.

Также следует учесть, что spec.ports[0].port (80) содержит номер порта, на котором будет доступен хост из metadata.name, но трафик далее будет направлен на порт, указанный в значении ключа spec.ports[0].targetPort.

Примените этот манифест:

`kubectl apply -f producer-internal-host.yml`{{execute}}

Чтобы получить его детальное описание из kubectl, выполните команду:

`kubectl describe service producer-internal-host`{{execute}}

Перейдите к созданию Gateway.