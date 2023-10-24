Сначала запустите кластер **Kubernetes**. Для этого дождитесь выполнения команды:

`launch.sh`{{execute}}

Создайте свое пространство имён, в котором будете работать:

`kubectl create namespace myapp`{{execute}}

Чтобы каждый раз не вводить название пространства в командах **kubectl** измените контекст:

`kubectl config set-context --current --namespace=myapp`{{execute}}

Для того, чтобы увидеть текущий статус объектов Kubernetes запустите команду:

`kubectl get pods,deployments,service`{{execute}}
