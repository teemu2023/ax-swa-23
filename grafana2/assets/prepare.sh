#!/bin/bash

INGRESS_DONE=/tmp/ingress_installed
GRAFANA_DONE=/tmp/grafana_installed
BASE_PATH="$(cat /usr/local/etc/sbercode-prefix)"
INGRESS_HOSTNAME_PLACEHOLDER="$(cat /usr/local/etc/sbercode-ingress)"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

spinner() {
  local i sp n
  sp='/-\|'
  n=${#sp}
  printf ' '
  while sleep 0.2; do
    printf "%s\b" "${sp:i++%n:1}"
  done
}

function install_ingress() {
  echo -e "\n[INFO] Installing nginx ingress controller"
  if [ ! -f "$INGRESS_DONE" ]; then
    kubectl apply -f /usr/local/etc/nginx-ingress-deploy.yaml
    kubectl -n ingress-nginx wait --for=condition=available --timeout=3m deployment/ingress-nginx-controller
    test $? -eq 1 && echo "[ERROR] Ingress controller not ready" && kill "$!" && exit 1
    kubectl -n ingress-nginx patch svc ingress-nginx-controller --patch \
      '{"spec": { "type": "NodePort", "ports": [ {"nodePort": 32100, "port": 3000, "protocol": "TCP", "targetPort": 3000} ] } }'
    echo done
    touch $INGRESS_DONE
  else
    echo already installed
  fi
}


function install_grafana() {
   echo -e "\n[INFO] Installing grafana"

  if [ ! -f "$GRAFANA_DONE" ]; then
  cat <<EOF >/tmp/grafana.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: grafana-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: grafana
  name: grafana
spec:
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      securityContext:
        fsGroup: 472
        supplementalGroups:
          - 0
      containers:
        - name: grafana
          image: grafana/grafana:latest
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 3000
              name: http-grafana
              protocol: TCP
          readinessProbe:
            failureThreshold: 3
            httpGet:
              path: /robots.txt
              port: 3000
              scheme: HTTP
            initialDelaySeconds: 10
            periodSeconds: 30
            successThreshold: 1
            timeoutSeconds: 2
          livenessProbe:
            failureThreshold: 3
            initialDelaySeconds: 30
            periodSeconds: 10
            successThreshold: 1
            tcpSocket:
              port: 3000
            timeoutSeconds: 1
          resources:
            requests:
              cpu: 250m
              memory: 750Mi
          volumeMounts:
            - mountPath: /var/lib/grafana
              name: grafana-pv
      volumes:
        - name: grafana-pv
          persistentVolumeClaim:
            claimName: grafana-pvc
apiVersion: v1
kind: Service
metadata:
  name: grafana
spec:
  ports:
    - port: 3000
      protocol: TCP
      targetPort: http-grafana
  selector:
    app: grafana
EOF
    kubectl apply -f /tmp/grafana.yaml
    kubectl wait --for=condition=ContainersReady --timeout=5m --all pods
    test $? -eq 1 && echo "[ERROR] grafana not ready" && kill "$!" && exit 1
    echo done
    touch $GRAFANA_DONE
  else
    echo grafana already installed
  fi

}

# wait for cluster readiness
launch.sh

spinner &
install_ingress
install_grafana
#stop spinner
kill "$!"
