# Grafana Dashboard

In our Eat API, we expose the Grafana dashboard to port 3000.

Therefore, to access the Grafana, we need to click the plus symbol **+** next to the terminal and click
**Select port to view on Host 1**

Then, the Katacoda will pop up a new window and say **To display an HTTP server, please enter the port number below**.

In the box, we type **3000** and click the **Display port** button to access the Grafana.

After we access Grafana, we need to log in to view the dashboard. We have configured the username and password as **COMP3122** and **12345** respectively.

We can then successfully log in the Grafana. in the left side taskbar, we hover the dashboard ![icon](./assets/22.png) and click **Manage**.

Then, we can click into the dashboard folder and **Application Health Monitoring**.

Now, we can see the dashboard about our microservices metrics and log messages stored in Prometheus.

In the Grafana dashboard, we display our server statistics, like the RAM used and Sys load.

Besides, we also visualize our microservices (Authentication, Store, Menu, and Order) status.


