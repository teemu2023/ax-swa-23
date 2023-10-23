### Создание serverless функции OpenFaas
Чтобы создать структуру директорий новой функции из шаблона (template) выполните команду:
`faas-cli new --lang python3-sbercode apiv1`{{execute}}
Данная команда ищет шаблон с именем python3-sbercode (Вы скачали его при подготовке окружения) и на его основе создает скелет функции в текущей директории. Результат можно посмотреть в директории apiv1.

Выполните сборку и развёртывание функции командой:
`faas-cli up -f apiv1.yml`{{execute}}

Чтобы проверить статус выполните скрипт:
`kubectl get po -n openfaas-fn`{{execute}}
Дождитесь, пока статус пода станет «Running»:
```
NAME                   READY   STATUS    RESTARTS   AGE
apiv1-794f59b5fd-448pd   1/1     Running   0          14s
```

### Публикация функции через Gravitee API Gateway

Импортируйте файл с готовым описанием API для нашей функции командой:

`curl -u admin:admin -H "Content-Type:application/json;charset=UTF-8" -d @demoapi-1-0-0.json    http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/import`{{execute}}

Выполните запрос к API, опубликованному через API Gateway:
`curl  -u admin:admin -X POST http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/32707a13-6fb4-4146-b07a-136fb4d1464c?action=START`{{execute}}

Если всё сделано верно — функция вернёт текст по умолчанию: 

`curl -v http://localhost:32100/gateway/api/v1`{{execute}}

Если получите ответ «No context-path matches the request URI» — API Gateway еще не успел развернуть конечный адрес (endpoint). Попробуйте повторить через 3-5 сек.

Вы успешно собрали и развернули простейшую функцию в Kubernetes, а также опубликовали её через API Gateway.