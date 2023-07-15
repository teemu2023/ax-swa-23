## Kubernetes Rollout Update

---

**WARNING - YOU HAVE LESS THAN 1 HOUR BEFORE YOUR SESSION EXPIRES!**

>Note the time left (in HH:MM) for the session, it is in your prompt and updated after every command run:

![Terminal Time Remaining](./assets/term-expire.png)

---

Lets deploy something else
```
curl -o /root/nginx-deploy-new.yaml https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/deployment-update.yaml
kubectl apply -f nginx-deploy-new.yaml --record
kubectl rollout status deployment/nginx-deployment
```{{execute}}

---

Check what is running: `kubectl get pods`{{execute}}

---

Check for nginx page
https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

---
