# Deploy Kubernetes objects using EKS

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Kubernetes objects](#kubernetes-objects)

## Overview

The main of the lab about the deploy basic kubernetes objects like namespaces, services, deployments,configmaps and secerts. deploys a sample voting application to use these objects.

## Pre-Requisites

None required

## Accessing the Eks cluster

### Sign in to AWS Management console

* Sign in using your Account ID, user name and password. Use the login option under **AWS Management console**

* Credentials will be provided here, copy these information and paste corresponding values in the AWS Management console.

* **Account ID:**{{Account_ID}}
* **user name:**{{User_Name}}
* **password:**{{Password}}
* **region:**{{Region}}

* Mention account-id from the above information, then click on `Next`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in.png?st=2019-09-09T09%3A36%3A43Z&se=2022-09-10T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rkLZ0wwcYQdKbOea5VgPSlzS46FaE8u3plAwptI5nf4%3D" alt="image-alt-text" >

* Mention Username and password from the above information

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in-usrpass.png?st=2019-09-09T10%3A20%3A15Z&se=2022-09-10T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KrcF1fH7XzP9H5LPSqrcPgZV3TDNzB6%2FCv6wSxbXN0o%3D" alt="image-alt-text" >

* Once you were provided all those information correctly you will be able to see the AWS-managemnt console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >


* In the navigation bar, on the top-right, change region accordingly to provided in above.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

* Click Apps icon in the toolbar and select Git-Bash to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/22.png?st=2019-09-10T09%3A14%3A02Z&se=2022-09-11T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=M8QVwu3%2FI%2FuUmsECKXyaUerYVXQy%2F0O%2BEbL6fXkdr8c%3D" alt="image-alt-text">


* Configure Your AWS Credentials using the following values, run the following command to create
configure aws.

```bash
aws configure
```

1. **AWS Access Key ID [None]:**{{access_keyid}}
2. **AWS Secret Access Key [None]:**{{access_secret}}
3. **Default region name [None]:** {{Region}}
4. **Default output format [None]:** json

* Run the following command to generate kubeconfig file for cluster.

```bash
aws eks --region us-east-1 update-kubeconfig --name eks-cluster
```

* Run `kubectl get nodes` command to view the nodes, it should show no resources found 

```
no resources found
```

* To enable workernodes to join with the eks cluster, use the following configmap and deploy to the cluster.


* **aws-auth-cm:**{{Configmap}}

* Copy the configmap values into a file `aws-auth.yaml` and deploy it using the following command.

```
kubectl apply -f aws-auth.yaml
```

* We have initialized the enviornment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a k8's cluster.

```
kubectl get nodes
````

```bash
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
```

* Using this command you get the default namespaces in the cluster

```bash
kubectl get ns
```

```
NAME          STATUS    AGE
default       Active    8m
kube-public   Active    8m
kube-system   Active    8m
```

## Kubernetes objects

The following are the some of the basic kubernetes objects, will show you how to deploy each kubernetes objects in a cluster.

* Namespaces

* Deployments

* Services

* ConfigMaps

* Secrets

**Voting App**

This sample app creates a multi-container application in an EKS cluster. The application interface has been built using Python / Flask. The data component is using Redis.

**Namespaces** are virtual clusters backed by the physical cluster, you can create a namespace using the following command.

```
kubectl create ns devteam
```

**Service** is used to define a logical set of Pods and related policies used to access them.

* Deploy the service using the following command

```bash
kubectl -n devteam create -f vote-service.yaml
```
```yaml
apiVersion: v1
kind: Service
metadata:
  name: vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: vote-back
```

**Deploymet:** Deployment is to provide declarative update to both Pod and replica set. In Kubernetes, Deployment is the recommended way to deploy Pod or replica set.

* Below is an example of a manifest file that creates two deployments, one for the python applications and one for Redis.

* Save the following configuration code in .yaml file format (E.g. votingapp-dep.yaml) 

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: vote-back
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: vote-back
    spec:
      containers:
      - name: vote-back
        image: redis
        ports:
        - containerPort: 6379
          name: redis
---
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: vote-front
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5 
  template:
    metadata:
      labels:
        app: vote-front
    spec:
      containers:
      - name: vote-front
        image: sysgaininc/vote-front:v1
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 250m
          limits:
            cpu: 500m
        env:
        - name: REDIS
          value: "vote-back"
```

* Deploy the deployment configuration using the following command.

```bash
kubectl -n devteam create -f votingapp-dep.yaml
```

* Create a loadbalancer service type and deploy it using the following configuration yaml code.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: vote-front
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: vote-front
```

* Deploy vote-front loadbalancer service configuration using the following command.

```
kubectl -n devteam create -f votingapp-lb.yaml
```

* Kubernetes service exposes the application front end to the internet. This process can take a few minutes to complete.

* Initially the EXTERNAL-IP for the `vote-front` service is shown as `pending`

```bash
kubectl -n devteam get svc
```
```
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
vote-back    ClusterIP      172.20.59.11     <none>        6379/TCP       3m27s
vote-front   LoadBalancer   172.20.252.108   <pending>     80:32605/TCP   12s
```
* Run the `kubectl -n devteam get svc` command you should see a external-ip of load-balancer service.

```bash
kubectl -n devteam get svc
```

```
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
vote-back    ClusterIP      172.20.59.11     <none>                                                                   6379/TCP       3m37s
vote-front   LoadBalancer   172.20.252.108   a014562c5e5c111e9817d128fe827814-135509166.us-east-1.elb.amazonaws.com   80:32605/TCP   22s
```

* To see the application in action, open a web browser, copy and paste external IP address of your loadbalancer vote-front service. you should see the following output of voting app.

img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/votingapp-output.png?st=2019-10-03T10%3A19%3A09Z&se=2022-10-04T10%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IB5u4IhDv1P9hmLWgNmV1Bi9C%2F%2B0Ed11TH3pfzboU24%3D" alt="image-alt-text">

**Configmap** Configmap is one of the ways to provide configurations to your application.

* Create a configmap for votingapp. Save the following configuration code in .yaml format.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: vote
data:
  OPTION_A: Visa
  OPTION_B: Mastercard
```

* Lets create the configmap object, use the following command to create it.

```bash
kubectl -n devteam apply -f vote-cm.yaml
```

* In order to use this configmap in the vote-front deployment, needs to reference it from the deployment file.

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: vote-front
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5 
  template:
    metadata:
      labels:
        app: vote-front
    spec:
      containers:
      - name: vote-front
        image: sysgaininc/vote-front:v1
        envFrom:
          - configMapRef:
              name: vote
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 250m
          limits:
            cpu: 500m
        env:
        - name: REDIS
          value: "vote-back"
```
* Use the following command to deploy, when you creates a deployment for vote-front, these configurations will be made available to your application

```bash
kubectl -n devteam apply -f votefront-deploy.yaml
``` 
```deployment.apps/vote-front configured```

* To verify configmap values, get into the `Running` vote-front pod, use the following command.

```bash
kubectl -n devteam get po
```
```
NAME                          READY   STATUS        RESTARTS   AGE
vote-back-75d7d5f7-zdktq      1/1     Running       0          10m
vote-front-59f5bc6588-rglc6   1/1     Running       0          36s
vote-front-c7dfb6689-cckcd    0/1     Terminating   0          10m
```

* Exec into the vote-front pod using the following command. Replace pod name with yours

**Note** Use `winpty` if you are using gitbash terminal.

```bash
winpty kubectl exec -it vote-front-59f5bc6588-rglc6 bash
```
* Type `env` to get the configmap values inside a pod. observe Option_A and Option_B values being used while deployed configmap.

```
<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/cm-output.png?st=2019-10-03T10%3A09%3A37Z&se=2022-10-04T10%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cIvdr%2BRi%2Frnes5ADESb8c%2BsmDPRcqUJQ%2Ba0vtOwDAOQ%3D" alt="image-alt-text" >
```

**Secrets**

* Secrets are for storing sensitive data like passwords and keychains. We will see how db deployment uses username and password in form of a secret.

You would define two fields for db,

* username
* password

* To create secrets for db you need to generate base64 format as follows, use gitbash to create a secrets in base64 format.

```
E.g. echo "admin" | base64
     echo "password" | base64
```
```bash
echo "admin" | base64
```
```YWRtaW4K```

```bash
echo "password" | base64
```

```cGFzc3dvcmQK```

* If you do not have a unix host, you can make use of online base64 utility to generate these strings.

http://www.utilities-online.info/base64

where `admin` and `password` are the actual values that you would want to inject into the pod environment.

Lets now add it to the secrets file,

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db
type: Opaque
data:
  POSTGRES_USER: YWRtaW4K
  POSTGRES_PASSWD: cGFzc3dvcmQK
```

```
kubectl -n devteam apply -f db-secrets.yaml
```

```bash
kubectl -n devteam get secrets
```
```
NAME                  TYPE                                  DATA   AGE
db                    Opaque                                2      19s
default-token-bb627   kubernetes.io/service-account-token   3      22m
```

* Secrets can be referred to inside a container spec with following syntax. save it in a yaml format.

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: vote-back
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: vote-back
    spec:
      containers:
      - name: vote-back
        image: redis
        ports:
        - containerPort: 6379
          name: redis
        env:
          - name: POSTGRES_USER
            valueFrom:
              secretKeyRef:
                name: db
                key: POSTGRES_USER
          - name: POSTGRES_PASSWD
            valueFrom:
              secretKeyRef:
                name: db
                key: POSTGRES_PASSWD
```

* To apply this deployment for voteback, use the following command to deploy it.

```
kubectl -n devteam apply -f voteback-deploy.yaml
```

```bash
winpty kubectl -n devteam exec -it vote-back-5d7bc8c5d4-4fdnq bash
```

```
root@vote-back-5d7bc8c5d4-4fdnq:/data# env | grep -i postgres
POSTGRES_USER=admin
POSTGRES_PASSWD=password
root@vote-back-5d7bc8c5d4-4fdnq:/data#
```

[here you should see the env vars defined for POSTGRES_USER and POSTGRES_PASS]
