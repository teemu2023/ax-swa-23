Check if ArgoCD setup completed:

`kubectl get pods -n argocd -w`{{execute}}

Check if applications synchronized:

`kubectl get application -n argocd -owide -w`{{execute}}