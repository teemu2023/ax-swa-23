Для демонстрации разграничения доступа к API настроим 2 плана подписок:
* запрос типа GET c публичным адресом /get/**;
* полный доступ с API KEY.

Откройте описание API и изучите секцию «plans»:

`httpbin-1-0-0.json`{{open}}

Импортируйте файл с описанием API:

`curl  -u admin:admin -H "Content-Type:application/json;charset=UTF-8" -d @httpbin-1-0-0.json    http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/import`{{execute}}

Запустите API:
`curl  -u admin:admin -X POST http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/70baa1f6-0b52-4413-baa1-f60b526413ec?action=START`{{execute}}

Выполните запрос к публичному API, опубликованному через API Gateway:

`curl http://localhost:32100/gateway/httpbin/get`{{execute}}

Если всё сделано верно — запрос успешно выполнится. Если получите ответ «No context-path matches the request URI» — API Gateway еще не успел развернуть конечный адрес (endpoint). Попробуйте повторить через 3-5 сек.

Попробуйте выполнить запрос к закрытой части API:

`curl -XPOST http://localhost:32100/gateway/httpbin/post`{{execute}}

Вышла ошибка доступа 403 — это значит нам не хватает полномочий. Необходимо получить ключ для доступа к этой части API. Для этого запустите скрипт:

`generate_key.sh`{{execute}}

Скрипт генерирует приложение, запрос на подписку и подтверждение. Ключ для доступа записывается в файл ~/apikey

Проверим доступ с ключом к закрытой части API:

`curl -XPOST -H @apikey http://localhost:32100/gateway/httpbin/post`{{execute}}

Запрос успешно выполнен.

Далее рассмотрим каким образом настроены ограничения доступа и добавим в публичный доступ ещё одну конечную точку (endpoint) /post c типом запроса POST.