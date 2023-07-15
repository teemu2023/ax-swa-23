mkdir -p /var/lib/katacoda

kubectl get deploy/nginx-deployment -o jsonpath='{.status.availableReplicas}' > /var/lib/katacoda/step1.out
egrep -s "^2" /var/lib/katacoda/step1.out && echo "done"
