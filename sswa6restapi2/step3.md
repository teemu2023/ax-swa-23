### Регистрация нового пользователя

Сформируй запрос в формате REST API, который осществляет регистрацию нового пользователя.

Правильный ответ от сервера должен содержать среди прочего должен содержать следующую информацию:
`
{"id":"123","username":"user123","fullname":"Иванов Иван Иванович","email":"user123@example.ru","role":"buyer","icon":"onlineauction.ru/content/images/ico112233.png","Message":"Пользователь создан"}
`
Проверить правильность команды можно непосредственно в терминале.

Готовый ответ запиши в файл:
`answer2.txt`{{open}}

Ответ (удалить в релизе):`curl -X POST localhost:32100/auth/registration -H "Content-Type: application/json" -d '{"username": "user123","fullname": "Иванов Иван Иванович","email": "user123@example.ru","role": "buyer","icon": "onlineauction.ru/content/images/ico112233.png"}'`