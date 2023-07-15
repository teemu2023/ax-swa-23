# 5.1 supporting services by listener microservice (Event bus)

1. listener microservice will subscribe store_status_change_channel since web app started.
2. When user use store api to change the status of store, store api will publish a message to the store_status_change_channel with store id.
3. listener microservice catched the message then will send the store id of the not active store to the redis of order api.
4. when user use order api to create order, the order api can know whether the store is active for create order, if not, cannot create order.


# 5.2 Demo:

0. Call order api to create a order with that store id. and we can create order.
`curl -X POST -v http://localhost:5000/order -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d @./order_service/sample_order_data3.json`{{execute}}


1. Call store api to change a store status to PAUSED, then will publish the message.

`curl -v -H 'authorization: 740becc4b623786cc812c956a5afb30e' http://localhost:5000/store/85e652b8-40b5-4b58-b01d-c7d15bd114d6/setStatus?newStatus=PAUSED&reason=NA `{{execute}}


2. listener microservice catched the message then updated the redis of order api


3. Call order api to create a order with that store id.
`curl -X POST -v http://localhost:5000/order -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d @./order_service/sample_order_data4.json`{{execute}}


4. Cannot craete because the store is not active anymore.
