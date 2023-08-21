Step 1: Set Up the Environment

kubectl create namespace argocd

kubectl apply -n argocd -f argocd.yaml

kubectl get all -n argocd

kubectl apply -n argocd -f argocd-project.yaml

Step 2: Prepare Application Files

    Inside the terminal, create a directory for your tutorial and navigate to it:

    bash

mkdir gitops-tutorial

cd gitops-tutorial

Create a subdirectory named app:

bash

mkdir app

cd app

Create a Kubernetes Deployment YAML file named app-deployment.yaml:

yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      containers:
        - name: sample-app
          image: nginx:latest
          ports:
            - containerPort: 80

Return to the gitops-tutorial directory:

bash

    cd ..

Step 3: Initialize Local Git Repository

    Initialize a new Git repository:

    bash

git init

Add and commit the application files:

bash

    git add .
    git commit -m "Initial commit"

    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"



Step 4: Deploy ArgoCD

    Install ArgoCD on your Kubernetes cluster. You can use Helm or the ArgoCD manifests directly.

Step 5: Configure ArgoCD Application

    Create a new ArgoCD application YAML file, argocd-app.yaml:

    yaml

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sample-app
spec:
  destination:
    name: ''
    namespace: default
  source:
    path: app
    repoURL: file:///root/gitops-tutorial
    targetRevision: HEAD
  project: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true

Apply the application YAML to create the ArgoCD application:

bash

    kubectl apply -f argocd-app.yaml

Step 6: Observe Automatic Deployment

    Monitor the ArgoCD UI or use kubectl get pods to observe the application deployment.

Step 7: Trigger Deployment with Git Push

    Modify the app-deployment.yaml file, for example, change the replicas to 3.

    Commit and push the change to your local Git repository:

    bash

    git add app/app-deployment.yaml
    git commit -m "Update replicas"
    git push origin master

Step 8: Verify Automatic Redeployment

    Watch the ArgoCD UI or use kubectl get pods to see the updated deployment triggered by ArgoCD.

Step 9: Conclusion

    Summarize the tutorial, explaining how GitOps and ArgoCD automate application deployments.

Remember to adapt the steps to the Katacoda environment and format them using Katacoda's tools to create an interactive learning experience for your tutorial users.