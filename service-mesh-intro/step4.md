# Kaili

Let's look at the kaili tool. It's a management console for the service mesh.

## Port-forward for kaili

`kubectl port-forward -n istio-system --address 0.0.0.0 service/kiali 20001:20001`{{execute}}

## View the dashboard
[click here]({{TRAFFIC_HOST1_20001}})
