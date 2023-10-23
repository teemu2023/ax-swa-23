Импортируйте файл с готовым описанием API для httpbin в формате Gravitee:

`curl -u admin:admin -H "Content-Type:application/json;charset=UTF-8" -d @httpbin-1-0-0.json    http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/import`{{execute}}

Запустите API:
`curl -u admin:admin -X POST http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/70baa1f6-0b52-4413-baa1-f60b526413ec?action=START`{{execute}}

Выполните запрос, который опубликован через API Gateway:

`curl -v http://localhost:32100/gateway/httpbin/get`{{execute}}

В полученном ответе от сервиса httpbin, в перечне заголовков обратите внимание на специфичные для API Gateway Gravitee.

Если получили ответ «No context-path matches the request URL», значит API Gateway ещё не успел развернуть конечный адрес (endpoint). Попробуйте повторить эту операцию через 3-5 сек.

```
< X-Gravitee-Transaction-Id: 75bf1c39-f519-4432-bf1c-39f519943259
< X-Gravitee-Request-Id: 75bf1c39-f519-4432-bf1c-39f519943259
```
Эти заголовки присутствуют и в JSON ответе httpbin, так как они были сформированы на этапе запроса к сервису через API Gateway. Это свидетельствует об успешной работе API Gateway по маршрутизации входящих запросов.

Далее необходимо скорректировать маппинг ответов, чтоб данные заголовки не приходили.