### Изменение статуса доставки товара

Сформируй запрос в формате RestAPI, с помощью которого продавец изменяет статус доставки по заказу на "Принят покупателем".

Правильный ответ от сервера должен содержать информацию в формате:
`
HTTP/1.1 200 OK
{"order_id":"culpa laboris reprehenderit","status":"anim sunt","timestamp":"1964-05-01T00:00:00.0Z","tracking_number":"reprehenderit adipisicing tempor"}
`

Ответ (удалить в релизе):`curl -X PATCH curl -v localhost:32100/sellers/123/orders/321 -H "Content-Type: application/json" -d '{"status": "Принят покупателем", "tracking_number": "1234-5678-9876-5432", "timestamp": "2023-03-19T15:30:00Z"}'`