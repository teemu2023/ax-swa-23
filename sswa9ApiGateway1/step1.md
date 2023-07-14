Импортируем файл с готовым описанием апи для httpbin в формате gravitee командой

`curl  -u admin:admin -H "Content-Type:application/json;charset=UTF-8" -d @httpbin-1-0-0.json    http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/import`{{execute}}

Стартуем апи командой
`curl  -u admin:admin -X POST http://localhost:32100/management/organizations/DEFAULT/environments/DEFAULT/apis/70baa1f6-0b52-4413-baa1-f60b526413ec?action=START`{{execute}}

Пробуем выполнить запрос к endpoint, опубликованному через API Gateway.

`curl -v http://localhost:32100/gateway/httpbin/get`{{execute}}

получаем ответ от сервиса httpbin, В перечне заголовков видим специфичные для api gateway gravitee. Если получаете ответ "No context-path matches the request URI.", значит API Gateway еще не успел развернуть endpoint. Попробуйте повторить эту операцию через 3-5 сек.

```
< X-Gravitee-Transaction-Id: 75bf1c39-f519-4432-bf1c-39f519943259
< X-Gravitee-Request-Id: 75bf1c39-f519-4432-bf1c-39f519943259
```
Т.к. эти заголовки присутствуют и в json ответе httpbin - они были сформированы на этапе запроса к сервису через api gateway. Это свидетельствует об успешной работе API Gateway по маршрутизации входящих запросов.

Далее скорректируем маппинг ответов, чтоб данные заголовки не приходили.