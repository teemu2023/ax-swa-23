# Canary deployment

A canary deployment allows us to slowy roll out our changes to a subset of users.

## Deploy a new version of our frontend

Deploy the new version

`kubectl apply -f roll-frontend-v2.yaml`{{execute}}

## Add a canary rule

Let's add a rule to route 20% of traffic to new version but keep 80% of old traffic.

`kubectl apply -f roll-virtual-service-update.yaml`{{execute}}

To see what the changes actually are lets use diff

`diff roll-virtual-service-update.yaml roll-virtual-service.yaml`{{execute}}

# Verify all new instances are deployed

`kubectl get pods`{{execute}}

# Port forward to see app in browser

`kubectl port-forward -n istio-system --address 0.0.0.0 service/istio-ingressgateway 8080:80`{{execute}}

# View application
[click here]({{TRAFFIC_HOST1_8080}})

Note: There are many options for canary deployments. Usernames, matching on certain headers etc. Also this is just one feature of traffic management there is also a/b testing and circuit breakers.
