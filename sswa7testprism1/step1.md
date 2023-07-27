### Работа с ресурсами OnlineAuction
С помощью cURL (client URL) выполни команды согласно постановке задачи.

Общий формат команды выглядит следующим образом:
curl -v -X {HTTP_METHOD} localhost:32100/onlineauction/{API_ENDPOINT} -H "Content-Type: application/json" -d'{"data":"test data here"}', где необходимо заполнить следующие поля для выполнения задач:
* HTTP_METHOD - указывается конкретный метод HTTP, который необходимо использовать в запросе. Например: GET, POST, PUT, PATCH, DELETE.
* {API_ENDPOINT} - указывается ресурс/подресурс, над которым необходимо произвести операцию чтения, создания, изменения, обновления или удаления. Например: "/auctions", "/auctions/12345/bids".
*  -d'{"data":"test data here"}' - указывается тело запроса в формате "ключ":"значание". Например: -d'{"name": "Китайская ваза", "description": "Древняя китайская ваза династии Мин", "image": "onlineauction.ru/content/images/ico205211141.png"}'


Также можно ознакомиться с полной спецификацией в формате OpenApi
`openapi.yaml`{{open}}