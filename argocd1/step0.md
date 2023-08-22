## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

`kubectl create namespace argocd`{{execute}}

`kubectl apply -n argocd -f argocd.yaml`{{execute}}

`kubectl get all -n argocd`{{execute}}

`kubectl apply -n argocd -f argocd-project.yaml`{{execute}}

`kubectl get all -n argocd`{{execute}}

`kubectl apply -n argocd -f gogs.yaml`{{execute}}   
