## Kubernetes Deployment

---

**WARNING - YOU HAVE LESS THAN 1 HOUR BEFORE YOUR SESSION EXPIRES!**

>Note the time left (in HH:MM) for the session, it is in your prompt and updated after every command run:

![Terminal Time Remaining](./assets/term-expire.png)

---

Lets deploy something
```
curl -o /root/nginx-deploy.yaml https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/deployment.yaml
kubectl apply -f nginx-deploy.yaml --record
kubectl rollout status deployment/nginx-deployment
```{{execute}}

---

Check if the pods are running: `kubectl get pods`{{execute}}

---

Port forward
`kubectl port-forward --address 0.0.0.0 deployment/nginx-deployment 8080:80`{{execute}}

---

Check for nginx page
https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

---

Stop port forward
`^C`{{execute ctrl-seq}}

---
