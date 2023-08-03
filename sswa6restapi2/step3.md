### Регистрация нового пользователя

Сформируй запрос в формате RestAPI, который осществляет регистрацию нового пользователя.

Правильный ответ от сервера должен содержать информацию в формате:
`
`

Ответ (удалить в релизе):`curl -X POST localhost:32100/auth/registration -H "Content-Type: application/json" -d '{"username": "user123","fullname": "Иванов Иван Иванович","email": "user123@example.ru","role": "buyer","icon": "onlineauction.ru/content/images/ico112233.png"}'`