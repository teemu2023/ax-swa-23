Давайте с вами познакомимся с механизмами конфигурации приложений в Kubernetes. В частности посмотрим, как работают объекты ConfigMap и Secret в Kubernetes. Данные объекты используются для обеспечения возможности конфигурирования приложения, развернутого в среде Kubernetes.

Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

Давайте с вами создадим свой **namespace**, в котором будем работать:

`kubectl create namespace myapp`{{execute}}

Чтобы каждый раз не вводить название **namespace**-а в командах **kubectl** изменим контекст:

`kubectl config set-context --current --namespace=myapp`{{execute}}

Для того, чтобы увидеть текущий статус объектов **Kubernetes** запустим команду:

`kubectl get pods,deployments,service`{{execute}}

