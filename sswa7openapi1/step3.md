### Задания для добавления описания сущности

Добавь соответствующее описание в секцию **components** сущности *Auctions* для извлечения списка аукционов GET запросом по пути */auctions/*.

Пример команды для самопроверки задания 1:
`curl -v -X GET localhost:32100/auctions`

Ожидаемый ответ (удалить при запуске):
components:
  schemas:
    Auctions:
      type: array
      items:
        $ref: '#/components/schemas/Auction'
      example:
        - id: 1
          title: "Auction 1"
          description: "Description of Auction 1"
          start_time: "2023-08-01T12:00:00Z"
          end_time: "2023-08-05T12:00:00Z"
          starting_price: 100.0
          highest_bid:
            bid:
              name: "John Doe"
              email: "johndoe@example.com"
            amount: 200.0
          seller:
            id: 123
            name: "Jane Smith"
            email: "janesmith@example.com"
          item:
            id: 456
            name: "Item 1"
            description: "Description of Item 1"
            tags:
              - "tag1"
              - "tag2"
            image_url: "https://example.com/item1.jpg"
        - id: 2
          title: "Auction 2"
          description: "Description of Auction 2"
          start_time: "2023-08-10T09:00:00Z"
          end_time: "2023-08-15T09:00:00Z"
          starting_price: 50.0
          highest_bid:
            bid:
              name: "Jane Doe"
              email: "janedoe@example.com"
            amount: 100.0
          seller:
            id: 456
            name: "John Smith"
            email: "johnsmith@example.com"
          item:
            id: 789
            name: "Item 2"
            description: "Description of Item 2"
            tags:
              - "tag3"
              - "tag4"
            image_url: "https://example.com/item2.jpg"
