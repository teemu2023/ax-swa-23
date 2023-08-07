### Задания для добавления описания конечной точки

Добавь соответствующее описание в секцию **path** для новой конечной точки, которая позволяет покупателям искать товары на всех аукционах. Поиск может быть отфильтрован по названию товара и/или тегам товара. В качестве примера можно привести поиск покупателем китайской вазы.


Ожидаемый ответ (удалить при запуске):
  /auctions/findItems:
    post:
      summary: Поиск товаров во всех аукционах
      description: |
        Эта конечная точка позволяет покупателям искать товары на всех аукционах. Поиск может быть отфильтрован по названию товара и/или тегам товара.
      parameters:
        - $ref: '#/components/parameters/ItemNameQueryParam'
        - $ref: '#/components/parameters/ItemTagQueryParam'
        - $ref: '#/components/parameters/LimitQueryParam'
        - $ref: '#/components/parameters/OffsetQueryParam'
      requestBody:
        description: Тело запроса для поиска товаров
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                itemName:
                  type: string
                  description: Название товара для поиска
                itemTags:
                  type: array
                  items:
                    type: string
                    description: Теги, связанные с товаром для поиска
      responses:
        '200':
          description: Successfully retrieved list of items
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Item'
          example:
            - id: 123
              name: "Китайская ваза династии Мин"
              description: "Антикварная китайская ваза династии Мин в хорошем состоянии."
              tags:
                - "антиквариат"
                - "ваза"
                - "Китай"
                - "династия Мин"
              starting_price: 500.0
              seller:
                id: 456
                name: "Антикварный магазин"
                email: "info@antiques.com"
              image_url: "https://example.com/vase.jpg"
            - id: 789
              name: "Китайская ваза с драконами"
              description: "Редкая китайская ваза с изображением драконов."
              tags:
                - "антиквариат"
                - "ваза"
                - "Китай"
                - "драконы"
              starting_price: 800.0
              seller:
                id: 101
                name: "Коллекционерский клуб"
                email: "info@collectorsclub.com"
              image_url: "https://example.com/vase2.jpg"
