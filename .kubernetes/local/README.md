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

## Build Docker Image
```
docker build -t kevinponce/rails_docker .
docker push kevinponce/rails_docker
```

### Apply yaml files
```
kubectl get all
kubectl apply -f .kubernetes/local/postgres-config.yaml
kubectl apply -f .kubernetes/local/postgres-secret.yaml
kubectl apply -f .kubernetes/local/postgres-persistent-volume.yaml
kubectl apply -f .kubernetes/local/postgres.yaml

kubectl apply -f .kubernetes/local/dynamodb-persistent-volume.yaml
kubectl apply -f .kubernetes/local/dynamodb-config.yaml
kubectl apply -f .kubernetes/local/dynamodb.yaml

kubectl apply -f .kubernetes/local/webapp.yaml
```

### Debug
```
kubectl get pods
kubectl describe pod mongo-deployment-795bcf459d-q5m8v
kubectl exec pod/webapp-deployment-64fbc66499-5lfns printenv
```

#### dynamodb cli test
```
aws dynamodb list-tables --endpoint-url http://192.168.64.2:30433
```

### Access container shell
```
kubectl get pods
kubectl exec -it pod/webapp-deployment-64fbc66499-5lfns -- /bin/sh
bin/rails c
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