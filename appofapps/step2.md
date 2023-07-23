Install the ArgoCD application:

`kubectl apply -k appofappssample/applications/argocd`{{execute}}

This will install ArgoCD controllers to argocd namespace.

Wait until all resources up and running(It can take some time):

`kubectl get pods -n argocd -w`{{execute}}

