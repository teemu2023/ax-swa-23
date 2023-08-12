Работа с fluentbit. 

`kubectl apply -f fluentbit-daemonset.yaml`{{execute}}

`kubectl get pods -n kube-system -l k8s-app=fluentbit-logging`{{execute}}

`kubectl apply -f fluentbit-config.yaml`{{execute}}

`kubectl apply -f fluentbit-daemonset.yaml`{{execute}}

`kubectl get pods,deployments, DaemonSet, service`{{execute}}
