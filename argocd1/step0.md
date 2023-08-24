## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

`kubectl create namespace argocd`{{execute}}

`kubectl apply -n argocd -f argocd.yaml`{{execute}}

`kubectl get all -n argocd`{{execute}}

`kubectl apply -n argocd -f argocd-project.yaml`{{execute}}

`kubectl get all -n argocd`{{execute}}

`kubectl apply -n argocd -f gogs.yaml`{{execute}}  

kubectl apply -f gogs-deployment.yaml

kubectl apply -f gogs-service.yaml

Получите внешний IP-адрес службы Gogs:

kubectl get svc gogs

Создание пользователя в Gogs
В открытом терминале выполните следующие команды:
a. Зарегистрируйте нового пользователя:

EXTERNAL_IP=<gogs_external_ip>
NEW_USER=<new_username>
PASSWORD=<new_password>

curl -X POST "http://$EXTERNAL_IP/api/v1/admin/users" -H "Content-Type: application/json" -d "{\"username\":\"$NEW_USER\", \"password\":\"$PASSWORD\"}"


Шаг 3: Создание нового репозитория для нового пользователя
В том же терминале выполните следующие команды:
a. Создайте новый репозиторий для нового пользователя:

REPO_NAME=<new_repository_name>

curl -X POST "http://$EXTERNAL_IP/api/v1/user/repos" -H "Content-Type: application/json" -d "{\"username\":\"$NEW_USER\", \"name\":\"$REPO_NAME\", \"private\": false}"


