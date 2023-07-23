Check if kubernetes is up and running(It can take some time):

`kubectl cluster-info`{{execute}}

Run below commands to setup argocd autopilot:

`VERSION=$(curl --silent "https://api.github.com/repos/argoproj-labs/argocd-autopilot/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')`{{execute}}

`curl -L --output - https://github.com/argoproj-labs/argocd-autopilot/releases/download/$VERSION/argocd-autopilot-linux-amd64.tar.gz | tar zx`{{execute}}

`mv ./argocd-autopilot-* /usr/local/bin/argocd-autopilot`{{execute}}

`argocd-autopilot version`{{execute}}