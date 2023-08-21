`mkdir gitops-tutorial`{{execute}}

`cd gitops-tutorial`{{execute}}

`mkdir app`{{execute}}

`cd app`{{execute}}

`touch app-deployment.yaml`{{execute}}

`cd ..`{{execute}}

`git init`{{execute}}

`git config --global user.email "you@example.com"`{{execute}}

`git config --global user.name "Your Name"`{{execute}}

`git add .`{{execute}}

`git commit -m "Initial commit"`{{execute}}

`touch argocd-app.yaml`{{execute}}

`kubectl apply -n argocd -f argocd-app.yaml`{{execute}}

`git add app/app-deployment.yaml`{{execute}}

`git commit -m "Update replicas"`{{execute}}

`git push origin master"`{{execute}}


