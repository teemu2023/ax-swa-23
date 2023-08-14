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
      '{"spec": { "type": "NodePort", "ports": [ { "nodePort": 32100, "port": 3000, "protocol": "TCP", "targetPort": 3000 } ] } }'
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
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
  namespace: monitoring
  labels:
    app: grafana
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      name: grafana
      labels:
        app: grafana
    spec:
      securityContext:
        fsGroup: 472
        runAsGroup: 472
        runAsNonRoot: true
        runAsUser: 472
      containers:
      - name: grafana
        image: grafana/grafana:7.3.7
        imagePullPolicy: IfNotPresent
        ports:
        - name: grafana
          containerPort: 3000
        resources:
          limits:
            memory: "2Gi"
            cpu: "1000m"
          requests: 
            memory: "1Gi"
            cpu: "500m"
        volumeMounts:
          - name: grafana-config
            mountPath: /etc/grafana/grafana.ini
            subPath: grafana.ini

          - name: grafana-storage
            mountPath: /var/lib/grafana

          - name: grafana-certs
            mountPath: /etc/grafana/certs/
            readOnly: true

          - name: grafana-datasources
            mountPath: /etc/grafana/provisioning/datasources/prometheus.yaml
            subPath: prometheus.yaml

          - name: grafana-dashboard-providers
            mountPath: /etc/grafana/provisioning/dashboards/dashboardproviders.yaml
            subPath: dashboardproviders.yaml

          - name: dashboards-k8s-cluster-summary
            mountPath: /var/lib/grafana/dashboards/k8s-cluster-summary

          - name: dashboards-node-exporter-full
            mountPath: /var/lib/grafana/dashboards/node-exporter-full

      # See https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
      #initContainers:
      #  - name: fix-nfs-permissions
      #    image: busybox
      #    command: ["sh", "-c", "chown -R 472:472 /var/lib/grafana"]
      #    securityContext:
      #      runAsUser: 0
      #      runAsNonRoot: false
      #    volumeMounts:
      #      - name: grafana-storage
      #        mountPath: /var/lib/grafana/

      restartPolicy: Always
      terminationGracePeriodSeconds: 60
      volumes:
        - name: grafana-config
          configMap:
            name: grafana-ini

        - name: grafana-storage
          persistentVolumeClaim:
            claimName: nfs-pvc-grafana

        - name: grafana-certs
          secret:
            secretName: grafana-tls-cert
            items:
            - key: tls.crt
              path: tls.crt
            - key: tls.key
              path: tls.key

        - name: grafana-datasources
          configMap:
            name: grafana-datasources

        - name: grafana-dashboard-providers
          configMap:
            name: grafana-dashboard-providers

        - name: dashboards-k8s-cluster-summary
          configMap:
            name: grafana-dashboards-k8s-cluster-summary

        - name: dashboards-node-exporter-full
          configMap:
            name: grafana-dashboards-node-exporter-full
apiVersion: v1
kind: Service
metadata:
  name: grafana
  namespace: monitoring
  annotations:
    prometheus.io/scrape: 'true'
    prometheus.io/port:   '3000'
  labels:
    app: grafana
spec:
  selector: 
    app: grafana
  type: NodePort  
  ports:
    - port: 3000
      targetPort: 3000
      nodePort: 32100          
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
