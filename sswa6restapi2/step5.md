### Изменение тарифного плана на новый

Сформируй запрос в формате RestAPI, с помощью которого продавец может изменить текущий тарифный план на новый plan123.

Правильный ответ от сервера должен содержать информацию в формате:
`* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Access-Control-Allow-Origin: *
< Access-Control-Allow-Headers: *
< Access-Control-Allow-Credentials: true
< Access-Control-Expose-Headers: *
< Content-type: application/json
< Content-Length: 237
< Date: Thu, 03 Aug 2023 07:34:53 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
< 
* Connection #0 to host localhost left intact
[{"buyer_id":-48710395,"timestamp":"dolor sint consequat","amount":-52189459.52041012,"bind_id":-53717335,"item_id":43173591},{"buyer_id":-60864716,"amount":-943870.4161149263,"timestamp":"laboris","item_id":22904144,"bind_id":32257970}]~`

Ответ (удалить в релизе):`curl -X PUT /sellers/123/subscriptions/321 \
-H "Content-Type: application/json" 
-d '{
        "plan_id": "plan123"
}'`