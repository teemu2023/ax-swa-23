Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

### Деплой приложения prism
Для демонстрации взаимодействия по средством REST API будем использовать приложение prism.  
Создайте ConfigMap с файлом openapi.yaml:
`kubectl create configmap openapi-configmap --from-file=openapi.yaml`{{execute}}

Для установки prism воспользуемся командой:  
`kubectl apply -f prism.yaml`{{execute}}


### Проверка окружения
После выполнения установки prism в текущее окружении, проверим список запущенных сервисов

`kubectl get po -A`{{execute}}

На этом настройка окружения завершена.