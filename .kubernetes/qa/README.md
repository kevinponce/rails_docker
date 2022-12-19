### References
* https://www.youtube.com/watch?v=s_o8dwzRlu4
* https://www.youtube.com/watch?v=OVVGwc90guo
* https://gitlab.com/codeching/kubernetes-multicontainer-application-react-nodejs-postgres-nginx/-/tree/master/

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
echo -n rails_docker_development | base64 # cmFpbHNfZG9ja2VyX2RldmVsb3BtZW50
echo -n postgres | base64 # cG9zdGdyZXM=
echo -n password | base64 # cGFzc3dvcmQ=
```

### Apply yaml files
```
kubectl apply -f .kubernetes/qa/postgres-config.yaml
kubectl apply -f .kubernetes/qa/postgres-secret.yaml
kubectl apply -f .kubernetes/qa/postgres.yaml

kubectl apply -f .kubernetes/qa/s3.yaml

kubectl apply -f .kubernetes/qa/redis-config.yaml
kubectl apply -f .kubernetes/qa/redis.yaml

kubectl apply -f .kubernetes/qa/sidekiq.yaml

kubectl apply -f .kubernetes/qa/webapp.yaml
```

### Debug
```
kubectl get pods
kubectl describe pod webapp-deployment-65d4754f9d-5btbf
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