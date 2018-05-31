# Example deployment
# Details in README.md

# create a separate Kubernetes namespace (only if wanted)
export NAMESPACE=info-server-only1
kubectl create namespace $NAMESPACE

# start the info-server
kubectl --namespace $NAMESPACE apply -f kubernetes-configurations/info-server-kubernetes.yaml 

# (optional) start the mongo DB service 
# - only needed when you want to check service access inside Kubernetes namespace
#kubectl --namespace $NAMESPACE apply -f kubernetes-configurations/mongo-kubernetes.yaml

# (optional) show running services
kubectl get services --namespace $NAMESPACE

# access the info-server service (when running normal/remote Kubernetes)
# get EXTERNAL-IP and PORT (e.g. 32751 of "8080:32751/TCP")
kubectl get services --namespace $NAMESPACE | egrep -e "(info-server|EXTERNAL-IP|PORT)"
# now access EXTERNAL-IP:PORT in any web browser, or on command line:
#curl http://192.168.99.100:32751/

# access the info-server service (when running Kubernetes locally in [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/)):
minikube service --namespace $NAMESPACE info-server

# cleanup and delete the namespace at the end
#kubectl delete namespace $NAMESPACE

