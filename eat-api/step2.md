# 2.1 supporting services by order microservice

The order microservice support various functions as follows:

First, a client sent an order to the API. The API will notify the store. After receiving a response with status code 200. The order will be inserted into the Redis the service own. Also, it will check the event bus whether the store is active, and check Redis whether such order id exists.

* /order: handle an order

`curl -X POST -v http://localhost:5000/order -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d @./order_service/sample_order_data2.json`{{execute}}

After the order is handled, the client can conduct the operations as follows.

* /order/< order_id >: get an order information

`curl -v http://localhost:5000/order/f9f363d1-e1c2-4595-b477-c649845bc952 -H 'authorization: 740becc4b623786cc812c956a5afb30e'`{{execute}}

* /stores/< store_id >/created-orders: get orders with state "CREATED"

`curl -v http://localhost:5000/stores/c7f1dc2f-fabe-4997-845c-cad26fdcb894/created-orders?limit=5 -H 'authorization: 740becc4b623786cc812c956a5afb30e'`{{execute}}

* /stores/< store_id >/canceled-orders: get orders with state "CANCELED"

`curl -v http://localhost:5000/stores/c7f1dc2f-fabe-4997-845c-cad26fdcb894/canceled-orders -H 'authorization: 740becc4b623786cc812c956a5afb30e'`{{execute}}

For this operation, the API only allows the order with the state "CREATED" or "DENIED" can be accepted.

* /orders/< order_id >/accept_pos_order: accept an order

`curl -X POST -v http://localhost:5000/orders/f9f363d1-e1c2-4595-b477-c649845bc952/accept_pos_order -H 'Content-Type: application/json' -d '{"reason": "accepted"}' -H 'authorization: 740becc4b623786cc812c956a5afb30e'`{{execute}}

For this operation, the API only allows the order with the state "CREATED" or "ACCEPTED" can be denied.

* /orders/< order_id >/deny_pos_order: deny an order

`curl -X POST -v http://localhost:5000/orders/f9f363d1-e1c2-4595-b477-c649845bc952/deny_pos_order -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d '{ "reason": { "explanation":"failed to submit order", "code":"ITEM_AVAILABILITY", "out_of_stock_items":[ "540cb880-0286-417b-9c6c-be586fd50f76", "094f3308-4389-4ce5-bf30-ce9e09c6ed1c" ], "invalid_items":[ "1cd26db9-6be3-4b0a-9216-e4868c5d79ec" ] } }'`{{execute}}

For this operation, the API only allows the order with the state "CREATED" or "DENIED" can be canceled.

* /orders/< order_id >/cancel: cancel an order

`curl -X POST -v http://localhost:5000/orders/f9f363d1-e1c2-4595-b477-c649845bc952/cancel -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d '{"reason":"CANNOT_COMPLETE_CUSTOMER_NOTE","details":"note is impossible"}'`{{execute}}

For this operation, the API only allows the order which its' state is not "CREATED" can be updated the delivery status.
Three delivery status is allowed including "started", "arriving" and "delivered".

* /orders/< order_id >/restaurantdelivery/status

`curl -X POST -v http://localhost:5000/orders/f9f363d1-e1c2-4595-b477-c649845bc952/restaurantdelivery/status -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d '{"status": "delivered"}'`{{execute}}

# 2.2 unit test

The unit test of order service contains 24 test cases.
1. Handle order successfully with HTTP response code 200
2. Handle orders successfully with HTTP response code 200
3. Handle order with paused store unsuccessfully with HTTP response code 409
4. Handle order with existent order_id unsuccessfully with HTTP response code 409
5. Get order successfully with HTTP response code 200
6. Get order with incorrect order id unsuccessfully with HTTP response code 404
7. Get created orders successfully with HTTP response code 200
8. Get created orders with limitation successfully with HTTP response code 200
9. Get created orders returned empty result successfully with HTTP response code 200
10. Get canceled orders successfully with HTTP response code 200
11. Get canceled orders returned empty result successfully with HTTP response code 200
12. Accept order successfully with HTTP response code 204
13. Accept order with nonexistent order_id unsuccessfully with HTTP response code 404
14. Accept order with incorrect state unsuccessfully with HTTP response code 409
15. Deny order successfully with HTTP response code 204
16. Deny order with nonexistent order_id unsuccessfully with HTTP response code 404
17. Deny order with incorrect state unsuccessfully with HTTP response code 409
18. Cancel order successfully with HTTP response code 204
19. Cancel order with nonexistent order_id unsuccessfully with HTTP response code 404
20. Cancel order with incorrect state unsuccessfully with HTTP response code 409
21. Update order's delivery status successfully with HTTP response code 204
22. Update order's delivery status with nonexistent order_id unsuccessfully with HTTP response code 404
23. Update order's delivery status with incorrect state unsuccessfully with HTTP response code 409
24. Update order's delivery status with incorrect delivery state unsuccessfully with HTTP response code 400

To install pytest and redis

`python3 -m pip install pytest`{{execute}}

`python3 -m pip install redis`{{execute}}

Perform unit test

`python3 -m pytest -v test_order_service.py`{{execute}}