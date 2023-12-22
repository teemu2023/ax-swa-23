### Задание 2 для добавления описания сущности

Шаг 1. Добавь соответствующее описание в секцию **components** для сущности *Bid* (ставка), содержащей в том числе секцию *example* для id 123, 
Шаг 2. Добавь описание соответствующих конечных точек (endpoints) в секции **path**, позволяющие получить список всех ставок для выбранного аукциона 123 и сделать ставку на конкретный аукцион 123.


Ожидаемый ответ (удалить при запуске):
        Bid:
      type: object
      properties:
        id:
          type: integer
          format: int64
          description: Уникальный идентификатор ставки.
        buyer_id:
          type: integer
          description: Идентификатор покупателя, сделавшего ставку.
        auction_id:
          type: string
          description: Идентификатор аукциона, где была сделана эта ставка.
        amount:
          type: number
          format: float
          description: Сумма ставки.
        timestamp:
          type: string
          format: date-time
          description: Время ставки.
      required:
        - id
        - buyer_id
        - auction_id
        - amount
        - timestamp
      example:
        id: 123
        buyer_id: 456
        auction_id: 789
        amount: 100.0
        timestamp: '2022-04-01T14:30:00Z'