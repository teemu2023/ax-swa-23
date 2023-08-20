## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

kind create cluster --config=kind-argocd.yaml

kubectl apply -f ingress.yaml

`kubectl create namespace argocd`{{execute}}

`kubectl apply -f argocd.yaml`{{execute}}

kubectl apply -f ingress-argocd.yaml

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

[ArgoOps](https://[[HOST_SUBDOMAIN]]-[[KATACODA_HOST]].environments.katacoda.com/)

`kubectl get all`{{execute}}






