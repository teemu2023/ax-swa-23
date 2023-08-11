Работа с fluentbit. 

kubectl apply -f fluentbit-daemonset.yaml

kubectl get pods -n kube-system -l k8s-app=fluentbit-logging

kubectl apply -f fluentbit-config.yaml

