### Задания для добавления описания конечной точки

Добавь соответствующее описание в секцию **path** для новой конечной точки, которая позволяет создавать нового покупателя.


Ожидаемый ответ (удалить при запуске):
  /buyers:
    post:
      summary: Создать нового покупателя
      description: Позволяет создать нового покупателя.
      requestBody:
        description: Инормация для новых покупателей.
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Buyer'
            example:
              id: 123
              name: Петр Петров
              email: p.petrov@example.ru
              phone: +1 (333) 765-4321
              address: "122, РФ, Москва, Старая улица, д.1, кв.1"
      responses:
        '201':
          description: Создан новый покупатель.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Buyer'
        '400':
          description: Bad request. Invalid input.
        '500':
          description: Internal server error.