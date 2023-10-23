###  Создание новой версии
Создайте ещё одну функцию по шаблону:

`faas-cli new --lang python3-sbercode apiv2`{{execute}}  
Внесите изменения в эту функцию. Для этого откройте в редакторе файл:
`apiv2/handler.py`{{open}} 

Измените текст, который выдаётся в ответ на запрос:

<pre class="file" data-filename="./apiv2/handler.py" data-target="insert" data-marker="Hello from OpenFaaS!">
Version_2</pre>

Для публикации изменений пересоберите и опубликуйте образ:
`faas-cli up -f apiv2.yml `{{execute}}

Сборка образа упала с ошибкой. Что произошло? Не прошли юнит-тесты, так как было изменено поведение функции.
Поправьте ошибку в файле:
`apiv2/handler_test.py`{{open}}

<pre class="file" data-filename="./apiv2/handler_test.py" data-target="insert" data-marker="Hello from OpenFaaS!">
Version_2</pre>

Затем заново запустите сборку и публикацию функции:
`faas-cli up -f apiv2.yml `{{execute}}

Kubernetes развернёт новый под с функцией и уничтожит предыдущую версию. Посмотреть статус развёртывания можно командой:
`kubectl get po -n openfaas-fn`{{execute}}

### Публикация новой версии

Импортируйте файл с готовым описанием API для этой функции командой:

`curl -u admin:admin -H "Content-Type:application/json;charset=UTF-8" -d @demoapi-2-0-0.json    http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/import`{{execute}}

Запустите API командой:
`curl  -u admin:admin -X POST http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/e3c7e657-26f6-4b20-87e6-5726f6eb208d?action=START`{{execute}}

Выполните запрос к API, опубликованному через API Gateway:

`curl http://localhost:32100/gateway/api/v2`{{execute}}

В случае успеха должен вернуться текст:
`Version_2`
