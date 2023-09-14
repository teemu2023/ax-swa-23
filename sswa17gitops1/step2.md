## Пример работы GitOps
Создадим директорию для нового проекта:
`mkdir gitops-tutorial`{{execute}}

Перейдем в созданную директорию проекта:
`cd gitops-tutorial`{{execute}}

Создадим в здесь новую дерикторию для приложения:
`mkdir app`{{execute}}

Перейдем в директорию *app*
`cd app`{{execute}}

Создадим манифест для запуска приложения:
<pre class="file" data-filename="./app-deployment.yaml" data-target="replace">
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-app
  labels:
    app: nginx-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-app
  template:
    metadata:
      labels:
        app: nginx-app
    spec:
      containers:
      - name: nginx-app
        image: nginx:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "1024Mi"
            cpu: "500m"
</pre>
В даном манифесте мы декларируем осуществить запуск 2 экземпляров сервиса на базе nGINX.

Далее перейдем в корневую дерикторию проекта:
`cd ..`{{execute}}

И иницируем создание Git репозитория для отслеживания изменений: 
`git init`{{execute}}

Добавим конфигурационные данные:
`git config --global user.email "you@example.com"`{{execute}}

`git config --global user.name "Your Name"`{{execute}}

Для того чтобы начать отслеживать (добавить под версионный контроль) все текущие файлы проекта с помощью следующей команды:
`git add .`{{execute}}

Теперь зафиксируем все текущие изменения:
`git commit -m "Initial commit"`{{execute}}

Далее до передачи текущего состояния локального репоизотрия в удаленный репозиторий необходимо подключить **Argo CD** для отслеживания изменений. Выполним следующую команду, предварительно заменив параметр *repoURL* в файле `application.yaml`{{execute}} на корректный IP-адрес сервиса **Gogs**:
`kubectl apply -n argocd -f application.yaml`{{execute}}

Теперь мы можем передать текущий инкремент изменений локального Git репозиторий в отслеживаемый **Argo CD** удаленной репозиторий на базе сервиса **Gogs**. Для этого свяжем локальный репозиторий с удаленным:
git remote add origin <gogs_repository_url>

И отправим текущие изменения локального репозиторий в удаленный:
`git push origin master"`{{execute}}

После отправки изменений в удаленный репозиторий, по истечению короткого промежутка времени **Argo CD** заметит внесенный изменения и запустит процедуру приведения текущего состояния кластера к желаемому. В нашем случае будет запущен сервис nGINX в 2 экземплярах. 
`kubectl get all`{{execute}}

Теперь можно вручную внести изменения в файл `app-deployment.yaml`{{open}}
Например, изменим желаемое количество экзмепляров сервиса на 3 (параметр *replicas*).

Добавим измененный файл в индекс:
`git add app/app-deployment.yaml`{{execute}}

Зафиксируем текущие изменения:
`git commit -m "Update replicas"`{{execute}}

И отправим изменения на удаленный репозиторий:
`git push origin master"`{{execute}}

Через какое-то время количество запущенных подов сервиса измениться на 3:
`kubectl get all`{{execute}}


