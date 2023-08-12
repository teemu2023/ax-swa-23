## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

Давайте с вами создадим свой **namespace**, в котором будем работать:

`kubectl create namespace myapp`{{execute}}

Чтобы каждый раз не вводить название **namespace**-а в командах **kubectl** изменим контекст:

`kubectl config set-context --current --namespace=myapp`{{execute}}

Для того, чтобы увидеть текущий статус объектов **Kubernetes** запустим команду:

`kubectl get pods,deployments,service`{{execute}}

## Запуск простейшего приложения
Для изучения механизмов логирования запустим простейшее приложение на основе манифесте:
`simple-app.yaml`{{open}}

Применим манифст развертывания к текущемуему окружению.
`kubectl apply -f simple-app.yaml`{{execute}}

Состояние деплоймента можно получить с помощью команды:
`kubectl get deploy simple-app.yaml`{{execute}}

Дождемся когда статус будет *Running*.