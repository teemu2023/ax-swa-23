Сначала запустите кластер **Kubernetes**. Для этого дождитесь выполнения команды:

`launch.sh`{{execute}}

### Запуск mock сервера Prism
Для демонстрации взаимодействия посредством REST API используйте HTTP Mock-сервер Prism.
Создайте ConfigMap с конфигурацией на основе заранее подготовленного файла со спецификацией OpenAPI openapi.yaml:
`kubectl create configmap openapi-configmap --from-file=openapi.yaml`{{execute}}

Для запуска Prism в кластере Kubernetes воспользуйтесь следующей командой:  
`kubectl apply -f prism.yaml`{{execute}}


### Проверка окружения
После выполнения установки Prism в текущее окружение, проверьте список запущенных сервисов:
`kubectl get po -A`{{execute}}

Дождитесь, когда состояние *prism-mock-server* достигнет статуса **Running**.

На этом настройка окружения завершена.