# Qloudable-helmcharts
This repository contains helm chart for Qloudable NPR and PRD.

## Prerequisites
1. The namespace must have all neccesary secrets deployed
2. The namespace must have all configmaps of micros-services deployed

## List of commands to use
**Note:** The name of the chart is ***tl-qld***
### 1. To Get list of a helm charts
```
helm ls
```
### 2. To do a dry run
```
helm install tl-qld --debug --dry-run --set tlUrlEnv=al --set tlEnv=alp --set deployWithSecrets=no --namespace=<NAMESPACE-NAME>
```
### 3. To install a chart
```
helm install tl-qld --debug --name <HELM-RELEASE-NAME> --set tlUrlEnv=al --set tlEnv=alp --set deployWithSecrets=no --namespace=<NAMESPACE-NAME>
```
### 4. To upgrade a chart
```
helm upgrade <HELM-RELEASE-NAME> tl-qld --set tlUrlEnv=al --set tlEnv=alp --set deployWithSecrets=no --namespace=<NAMESPACE-NAME>
```
### 5. To upgrade and install a chart
```
helm upgrade --install <HELM-RELEASE-NAME> tl-qld --set tlUrlEnv=al --set tlEnv=alp --set deployWithSecrets=no --namespace=<NAMESPACE-NAME>
```
### 6. To delete a release
```
helm del --purge <HELM-RELEASE-NAME>
```

## For Pre Integration
### 1. To install a chart
```
helm install tl-qld --debug --name tl-qld-pint --set tlUrlEnv=pint --set tlEnv=pint --set deployWithSecrets=no --set env="-npr." --namespace=tl-qld-pint
```
### 2. To upgrade a chart
```
helm upgrade tl-qld-pint tl-qld --set tlUrlEnv=pint --set tlEnv=pint --set deployWithSecrets=no --set env="-npr." --set isHpa=false --set isResourceLimits=false --namespace=tl-qld-pint
```
## For Alp test environment for mon cluster
### 1. To install a chart
```
helm install tl-qld --debug --name tl-qld-alptest --set tlUrlEnv=altest --set tlEnv=alp --set deployWithSecrets=no --set env="-npr." --set isHpa=false --set isResourceLimits=false --namespace=tl-qld-alptest
```
### 2. To upgrade a chart
```
helm upgrade tl-qld-alptest tl-qld --set tlUrlEnv=altest --set tlEnv=alp --set deployWithSecrets=no --set env="-npr." --set isHpa=false --set isResourceLimits=false --namespace=tl-qld-alptest

## For Integration
### 1. To install a chart
```
helm install tl-qld --debug --name tl-qld-int --set tlUrlEnv=in --set tlEnv=int --set deployWithSecrets=no --set env="-npr." --namespace=tl-qld-int
```
### 2. To upgrade a chart
```
helm upgrade tl-qld-int tl-qld --set tlUrlEnv=in --set tlEnv=int --set deployWithSecrets=no --set env="-npr." --set isHpa=false --set isResourceLimits=false --namespace=tl-qld-int
```

## For Staging
### 1. To install a chart
```
helm install tl-qld --debug --name tl-qld-stg --set tlUrlEnv=st --set tlEnv=stg --set deployWithSecrets=yes --set env="-npr." --namespace=tl-qld-stg
```
### 2. To upgrade a chart
```
helm upgrade tl-qld-stg tl-qld --set tlUrlEnv=st --set tlEnv=stg --set deployWithSecrets=yes --set env="-npr." --namespace=tl-qld-stg
```


## For Production
### 1. To install a chart
```
helm install tl-qld --debug --name tl-qld-prd --set tlUrlEnv=pr --set tlEnv=prd --set deployWithSecrets=yes --set env="." --namespace=tl-qld-prd
```
### 2. To upgrade a chart
```
helm upgrade tl-qld-prd tl-qld --set tlUrlEnv=pr --set tlEnv=prd --set deployWithSecrets=yes --set env="." --namespace=tl-qld-prd
```

## For phx DR
### 1. To install a chart
```
helm install tl-qld --debug --name tl-qld-prd --set tlUrlEnv=pr --set tlEnv=prd --set deployWithSecrets=yes --set env="." --set image.repository=phx.ocir.io/jumpstart/tl-qld --set replicaCount=0 --namespace=tl-qld-prd
```
### 2. To upgrade a chart
```
helm upgrade tl-qld-prd tl-qld --set tlUrlEnv=pr --set tlEnv=prd --set deployWithSecrets=yes --set env="." --set image.repository=phx.ocir.io/jumpstart/tl-qld --set replicaCount=0 --namespace=tl-qld-prd