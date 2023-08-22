## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

`kubectl create namespace argocd`{{execute}}

`kubectl apply -n argocd -f argocd.yaml`{{execute}}

`kubectl get all -n argocd`{{execute}}

`kubectl apply -n argocd -f argocd-project.yaml`{{execute}}

`kubectl get all -n argocd`{{execute}}

`kubectl apply -n argocd -f gogs.yaml`{{execute}}  

Получите внешний IP-адрес службы Gogs:

kubectl get svc gogs


EXTERNAL_IP=<gogs_external_ip>
REPO_NAME=my-new-public-repo

curl -X POST "http://$EXTERNAL_IP/api/v1/user/repos" -H "Content-Type: application/json" -d "{\"name\":\"$REPO_NAME\", \"private\": false}"

