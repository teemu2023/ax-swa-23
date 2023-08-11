Рассмотрим основные механизмы работы с логами в Kubernetes.

`kubectl logs -l app=simple-app`{{execute}}

Имя подов
kubectl get pods -l app=simple-app

kubectl logs <pod-name>

kubectl logs <pod-name> -c simple-app

