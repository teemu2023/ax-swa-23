## Настройка окружения
Сначала запустим кластер **Kubernetes**. Для этого нужно дождаться выполнения команды:

`launch.sh`{{execute}}

`kubectl apply -f coredns.yaml.sed`{{execute}}


`kubectl apply -f argocd.yaml`{{execute}}

`kubectl get all`{{execute}}

`kubectl patch deployment -n argocd argocd-server --patch-file no-tls.yaml`{{execute}}





