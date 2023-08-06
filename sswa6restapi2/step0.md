Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

### Запуск mock сервера Prism
Для демонстрации взаимодействия по средством REST API будем использовать HTTP mock сервер [Prism](https://stoplight.io/open-source/prism).  
Создадим ConfigMap с конфигурацией на основе заранее подготовленного файла со спецификацией OpenAPI openapi.yaml:
`kubectl create configmap openapi-configmap --from-file=openapi.yaml`{{execute}}

Для запуска Prism в кластере Kubernetes воспользуемся командой:  
`kubectl apply -f prism.yaml`{{execute}}


### Проверка окружения
После выполнения установки Prism в текущее окружении, проверим список запущенных сервисов

`kubectl get po -A`{{execute}}

Дождитесь, когда состояние окружение достигнет такого состояния:
`
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   local-path-provisioner-5ff76fc89d-tksmc   1/1     Running   0          8m27s
kube-system   coredns-7448499f4d-8xv7q                  1/1     Running   0          8m27s
kube-system   metrics-server-86cbb8457f-ck5zf           1/1     Running   0          8m27s
default       prism-mock-server-7749d46f46-sgs8t        1/1     Running   0          10s
`
На этом настройка окружения завершена.