Название:  Введение в GitOps с ArgoCD 

Описание:  В этом руководстве вы узнаете о концепции GitOps и о том, как использовать инструмент ArgoCD для автоматизации развертывания приложений с помощью локального репозитория Git. Вы настроите простой пример, в котором изменения в репозитории Git запускают автоматическое развертывание в кластере Kubernetes. 

Шаг 1: Настройка 

    Откройте терминал и выполните следующие команды, чтобы создать новый каталог для учебника: 

    бить 

    mkdir gitops-argocd-tutorial
    cd gitops-argocd-tutorial

Шаг 2: Подготовьте файлы приложения 

    Внутри  gitops-argocd-tutorial , создайте подкаталог с именем  app: 

    бить 

mkdir app
cd app

Создайте простой YAML-файл развертывания Kubernetes с именем  app-deployment.yaml Для вашего приложения: 

YAML 

apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      containers:
        - name: sample-app
          image: nginx:latest
          ports:
            - containerPort: 80

Вернуться к разделу  gitops-argocd-tutorial каталог: 

бить 

    cd ..

Шаг 3: Настройка кластера Kubernetes 

    Предположим, что для работы с учебником доступен работающий кластер Kubernetes. Упомяните об этом в описании учебника. 

Шаг 4: Настройка локального репозитория Git 

    Инициализируйте новый репозиторий Git в каталоге  gitops-argocd-tutorial каталог: 

    бить 

git init

Добавьте файл  app и зафиксируйте исходные файлы приложения: 

бить 

    git add .
    git commit -m "Initial commit"

Шаг 5: Установка и настройка ArgoCD 

    Предоставьте инструкции по установке ArgoCD в кластере Kubernetes. Возможно, вы захотите включить ссылку на официальное руководство по установке. 

Шаг 6: Настройте приложение ArgoCD 

    Создайте новое приложение в ArgoCD, чтобы развернуть приложение из локального репозитория Git. 

    YAML 

    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: sample-app
    spec:
      destination:
        name: ''
        namespace: default
      source:
        path: app
        repoURL: <your_local_git_repo_url>
        targetRevision: HEAD
      project: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true

    Примечание:  Заменить  <your_local_git_repo_url> с фактическим URL-адресом локального репозитория Git. 

`kubectl apply -f argocd.yaml`{{execute}}    

Шаг 7: Запуск развертывания с помощью Git Push 

    Внесите небольшое изменение в файл  app-deployment.yaml,  например, обновление количества реплик. 

    Зафиксируйте и отправьте изменения в локальный репозиторий Git: 

    бить 

    git add app/app-deployment.yaml
    git commit -m "Update replicas"
    git push origin master

Шаг 8: Наблюдение за автоматическим развертыванием 

    В пользовательском интерфейсе ArgoCD перейдите к приложению  sample-app. . Вы увидите, что приложение автоматически синхронизируется и развертывается в кластере Kubernetes. 

Шаг 9: Заключение 

    Обобщите то, что было рассмотрено в руководстве, и подчеркните важность GitOps и ArgoCD для автоматизации развертывания приложений. 
