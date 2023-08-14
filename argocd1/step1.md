Use kubectl (the Kubernetes command-line tool) to apply the ArgoCD installation manifest. This manifest will create the necessary resources in your Kubernetes cluster.

bash

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f argocd.yaml

Wait for the ArgoCD components to be deployed. You can check the status using:

bash

kubectl get pods -n argocd

Substep 2: Access ArgoCD UI

    Expose the ArgoCD API server using a port-forward command. This will allow you to access the ArgoCD UI in your local browser.

    bash

kubectl port-forward svc/argocd-server -n argocd 8080:443

Open your web browser and navigate to http://localhost:8080. This will open the ArgoCD UI login page.

Retrieve the initial ArgoCD admin password:

bash

    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

    Use the password from the previous step to log in to the ArgoCD UI. You will be prompted to change the password after the initial login.

Substep 3: Configure ArgoCD CLI (Optional)

    Install the ArgoCD CLI tool, argocd, on your local machine to interact with ArgoCD from the command line. Follow the installation instructions for your operating system: https://argoproj.github.io/argo-cd/cli_installation/

    Configure the ArgoCD CLI to use the correct ArgoCD API server:

    bash

    argocd login localhost:8080 --username=admin --password=<your_admin_password>

    Replace <your_admin_password> with the password you set during the initial login.

Substep 4: Secure ArgoCD

    By default, the ArgoCD API server is accessible without authentication. For a production environment, it's recommended to secure it using various methods, such as Ingress controllers, OAuth2, or HTTPS.

Substep 5: Import Application to ArgoCD

    In the ArgoCD UI, navigate to the Apps tab.

    Click on the New App button.

    Fill in the application details:
        Application Name: Choose a name (e.g., sample-app).
        Project: Select the default project.
        Sync Policy: Choose Automatic.
        Repository URL: Provide the URL of your local Git repository.
        Revision: Use HEAD.
        Path: Set to the directory containing your application YAML files (e.g., app).

    Click on the Create button to create the application.

Substep 6: Observe Automatic Sync

    After creating the application, you will be redirected to the application details page.

    ArgoCD will automatically start syncing the application. You can see the sync progress and details on this page.

    Once the sync is complete, the application will be deployed to the Kubernetes cluster based on the configuration in your local Git repository.

Substep 7: Verify Deployment

    Use kubectl to verify that the application has been deployed to the Kubernetes cluster:

    bash

kubectl get pods
