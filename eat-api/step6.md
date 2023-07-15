# Microservices Metrics

In our Eat API, we use Prometheus to get the microservices metrics and logs messages. 

Prometheus also monitors solutions for storing time-series data like metrics. 

We mainly target 4 microservices (Authentication, Store, Menu, and Order microservices) to monitor their functions.

To get Authentication service's metrics, Execute:

`curl -v http://localhost:5000/authentication-metrics`{{execute}}

To get Store service's metrics,Execute:

`curl -v http://localhost:5000/store-metrics`{{execute}}

To get Menu service's metrics,Execute:

`curl -v http://localhost:5000/menu-metrics`{{execute}}

To get Order service's metrics,Execute:

`curl -v http://localhost:5000/order-metrics`{{execute}}

In the next step, we will visualize the metrics/logs of above microservices as well as the node-exporter (host computer) by using Grafana Dashboard.
