# Deploy our services

Deploy the backend service

`kubectl apply -f roll-backend.yaml`{{execute}}

Deploy the frontend service

`kubectl apply -f roll-frontend.yaml`{{execute}}

# It looks something like this
![Scan results](./assets/topo.png)

# Verify all instances are deployed

`kubectl get pods`{{execute}}

# Port forward to see app in browser

`kubectl port-forward -n istio-system --address 0.0.0.0 service/istio-ingressgateway 8080:80`{{execute}}

# View application
[click here]({{TRAFFIC_HOST1_8080}})
