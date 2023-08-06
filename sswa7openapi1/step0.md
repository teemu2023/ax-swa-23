Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

### Запуск mock сервера Prism
Для демонстрации взаимодействия по средством REST API будем использовать HTTP mock сервер [Prism](https://stoplight.io/open-source/prism).  
Создадим **ConfigMap** с конфигурацией на основе заранее подготовленного файла со спецификацией **OpenAPI** openapi.yaml:
`kubectl create configmap openapi-configmap --from-file=onlineauction.yaml.yaml`{{execute}}

Для запуска Prism в кластере Kubernetes воспользуемся командой:  
`kubectl apply -f prism.yaml`{{execute}}


### Проверка окружения
После выполнения установки Prism в текущее окружении, проверим список запущенных сервисов

`kubectl get po -A`{{execute}}

Дождитесь, когда состояние *prism-mock-server* достигнет статус **Running**.

На этом настройка окружения завершена.