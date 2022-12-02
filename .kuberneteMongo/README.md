### References
* https://www.youtube.com/watch?v=s_o8dwzRlu4

### Install
```
brew install kubectl
brew install hyperkit
brew install minikube
```

### Start
```
minikube start --vm-driver=hyperkit
```

### base 64 encode secrets
```
echo -n mongouser | base64
```

### Apply yaml files
```
kubectl apply -f .kuberneteMongo/mongo-config.yaml
kubectl apply -f .kuberneteMongo/mongo-secret.yaml
kubectl apply -f .kuberneteMongo/mongo.yaml
kubectl apply -f .kuberneteMongo/webapp.yaml
```

### Debug
```
kubectl get pods
kubectl describe pod mongo-deployment-795bcf459d-q5m8v
```

### Access container shell
```
kubectl exec -it pod/webapp-deployment-65d4754f9d-5btbf -- /bin/sh
```

### Logs
```
kubectl get pods
kubectl logs webapp-deployment-8b9d9f448-th29j -f
```

### Test
```
minikube ip # get the ip
kubectl get svc # PORTS
```

### Teardown
```
kubectl get deployments

kubectl delete deployments mongo-deployment
kubectl delete deployments webapp-deployment

kubectl get services

kubectl delete service mongo-service
kubectl delete service webapp-service
```