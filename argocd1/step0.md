## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}


`kubectl apply -f argocd.yaml`{{execute}}

`kubectl get pods -n argocd`{{execute}}


