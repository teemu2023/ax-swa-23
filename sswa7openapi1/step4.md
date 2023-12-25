### Задание 2 для добавления описания сущности

Шаг 1. Добавь соответствующее описание в секцию **components** для сущности *Bid* (ставка), содержащей в том числе секцию *example* для id 123. 

Шаг 2. Добавь описание соответствующей конечной точки (endpoints) в секции **path**, позволяющие получить список всех ставок для выбранного аукциона 123.


Ожидаемый ответ (удалить при запуске):
Шаг 1
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

Шаг2

paths:
  /auctions/{auction_id}/bids:
    get:
      summary: Извлечение списка ставок для аукциона
      description: Возвращает постраничный список всех ставок для указанного аукциона.
      parameters:
        - $ref: '#/components/parameters/AuctionIdParam'
        - $ref: '#/components/parameters/LimitQueryParam'
        - $ref: '#/components/parameters/OffsetQueryParam'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Bids'
        default:
          $ref: '#/components/responses/Error'
    post:
      summary: Сделать ставку на аукционе
      description: Размещает новую ставку на указанном аукционе с указанной суммой ставки.
      parameters:
        - $ref: '#/components/parameters/AuctionIdParam'
      requestBody:
        $ref: '#/components/requestBodies/BidRequestBody'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BidResponse'
        default:
          $ref: '#/components/responses/Error'