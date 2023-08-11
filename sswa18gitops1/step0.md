## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

Давайте с вами создадим свой **namespace**, в котором будем работать:

`kubectl create namespace myapp`{{execute}}

Чтобы каждый раз не вводить название **namespace**-а в командах **kubectl** изменим контекст:

`kubectl config set-context --current --namespace=myapp`{{execute}}

Для того, чтобы увидеть текущий статус объектов **Kubernetes** запустим команду:

`kubectl get pods,deployments,service`{{execute}}

Step 1: Setup

    Open a terminal and run the following commands to create a new directory for your tutorial:

    bash

    mkdir gitops-argocd-tutorial
    cd gitops-argocd-tutorial

Step 2: Prepare Application Files

    Inside the gitops-argocd-tutorial directory, create a subdirectory named app:

    bash

mkdir app
cd app

Return to the gitops-argocd-tutorial directory:

bash

cd ..

nitialize a new Git repository in the gitops-argocd-tutorial directory:

bash

git init

Add the app directory and commit the initial application files:

bash

git add .
git commit -m "Initial commit"
