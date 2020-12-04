# Services and Deployments

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#Accessing-the-aks-cluster)

[Deployments](#deployments)

[Services](#services)

[Exercises](#exercises)


## Overview

**Service** enables network access to a set of Pods in Kubernetes. Services select Pods based on their labels. When a network request is made to the service, it selects all Pods in the cluster matching the service's selector, chooses one of them, and forwards the network request to it. In this lab you can explore different types of services.

A **Deployment** provides declarative updates for Pods and ReplicaSets. This lab describes Kubernetes Deployment objects and their use in AKS. Deployments represent a set of multiple, identical Pods with no unique identities. A Deployment runs multiple replicas of your application and automatically replaces any instances that fail or become unresponsive. In this way, Deployments help ensure that one or more instances of your application are available to serve user requests. Deployments are managed by the Kubernetes Deployment controller.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up fundamental Kubernetes objects -- Services & Deployments. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing,and managing objects as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

## Pre-Requisites

1. Azure Cloud Infrastructure account credentials (User, Password, ResourceGroup, and Subscription).
2. Basic Linux Commands.
3. Docker Fundamentals.
4. Basic Azure Cloud Knowledge.

## Accessing the AKS cluster

**Sign in to Azure portal**

1. Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

* **Azure Login ID :** {{azure_login}}

* **Azure Password :** {{azure_password}}

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage1.png?st=2020-07-08T07%3A23%3A06Z&se=2025-07-09T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jyCYE309j%2B4CNRo8KCcw6n4iP52L97M7lHSj4aAkmvU%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage2.png?st=2020-07-08T07%3A23%3A42Z&se=2025-07-09T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YbUJrHqetC4tgFCqttp1E0iMy5iwIZ1CtOpCoqKxx6o%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage3.png?st=2020-07-08T07%3A24%3A19Z&se=2025-07-09T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h1qLT2oGKl06UclTL1b8TdIdRi9yTXNUu3ck%2BcqDHus%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Portalimage4.png?st=2020-07-08T07%3A24%3A54Z&se=2025-07-09T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fNloJnlOJLwLOAvaibTuppCZ862VTo2K9KoOfd6uL4M%3D" alt="image-alt-text">

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like MC_myResourceGroup_myAKSCluster_eastus. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select Powershell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the powershell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the enviornment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

```bash
kubectl get nodes
```

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using this command you get the default namespaces in Kubernetes cluster, `kubectl get ns`

```bash
kubectl get ns
```
**Output:**
```
NAME          STATUS    AGE
default       Active    8m
kube-public   Active    8m
kube-system   Active    8m
```

##  Deployments

* A deployment is a supervisor for pods. It provides declarative updates for Pods and ReplicaSets. 

* A ReplicaSetâ€™s purpose is to maintain a stable set of replica Pods running at any given time.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/deployments.png?st=2019-08-26T08%3A52%3A43Z&se=2022-08-27T08%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KSKizAKagtcubPj%2FN355VfFniAlT%2F4cMkdavKMPI7Ls%3D" alt="image-alt-text" >

### Create a Deployment

1. Create a namespace with a name of 'devteam'. Enter the following command using the git-bash terminal.

E.g. `kubectl create ns <namespace-name>`

```bash 
kubectl create ns devteam
```

2. Create a deployment that creates a replicaset to bring up three nginx pods. You can create the deployment in a particular namespace with specification of `-n <namespace-name >`, if you don't mention namespace while deploying into cluster, the default namespace is used. Open the notepad, copy the configuration of the deployment, then paste and save it in a file `nginx-deployment.yml`. Please make sure "All Files" is selected for "Save as Type" option. Choose the path you want to save the `nginx-deployment.yaml` file.

**Note:** Notice that `spec.template.metadata.labels` is set to `app: nginx`, this label will be applied to every pod created by this deployment

``` yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: nginx-deployment
    namespace: devteam
  spec:
    replicas: 3
    selector:
      matchLabels:
        app: nginx
    template:
      metadata:
        labels:
          app: nginx
      spec:
        containers:
        - name: nginx
          image: nginx
          ports:
          - containerPort: 80
```
  
* Use the following to deploy `nginx-deployment.yaml` to the cluster, make sure to choose the correct path of yaml file.
 
`kubectl create -f <file-path>`
 
```bash
 kubectl create -f /c/Users/PhotonUser/Desktop/nginx-deployment.yml
```
 
3. Get the deployment object as you deployed in a previous step. Enter the following command to list-out deployments in a namespace.

```bash
kubectl -n devteam get deployments
```

```
  NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
  nginx-deployment   3         3         3            3           4m
```

4. A Deployment named `nginx-deployment` is created, indicated by the `.metadata.name` field in `yaml`.

5. The Deployment creates three replicated Pods, indicated by the `replicas` field.

6. The `selector` field defines how the deployment finds which Pods to manage. In this case, you simply select a label that is defined in the Pod template `app: nginx`. However, more sophisticated selection rules are possible, as long as the Pod template itself satisfies the rule.

7. Get the pods in nginx deployment using the following command. Notice that the label `app: nginx` is on every pod.

```bash
kubectl -n devteam get pods --show-labels
```

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE   LABELS
nginx-deployment-c5b5c6f7c-74brr   1/1     Running   0          98s   app=nginx,pod-template-hash=c5b5c6f7c
nginx-deployment-c5b5c6f7c-vvvm4   1/1     Running   0          98s   app=nginx,pod-template-hash=c5b5c6f7c
nginx-deployment-c5b5c6f7c-zxz9s   1/1     Running   0          98s   app=nginx,pod-template-hash=c5b5c6f7c
```

### Updating a Deployment

1. Next, open and use Powershell. If you want to edit the existing deployment you can use 

`kubectl -n devteam edit deployment nginx-deployment`

* This command will pop up a notepad window change the `no.of replicas` to `2`, notice that the no.of pods gone to 2.

```bash
kubectl -n devteam get po 
```

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c5b5c6f7c-74brr   1/1     Running   0          3m41s
nginx-deployment-c5b5c6f7c-vvvm4   1/1     Running   0          3m41s
```

### Delete the pod

* Delete the first pod using (e.g. kubectl -n devteam  delete pod <podname>). Once the pod is deleted, a new pod will comeup with the same configuration.
 
**Note:** In the below command replace the pod name with yours

```bash
kubectl -n devteam delete pod nginx-deployment-c5b5c6f7c-74brr
```

**Output:**
```
pod "nginx-deployment-c5b5c6f7c-74brr" deleted
```

* Get the pods in nginx deployment using `kubectl -n devteam get pods`. Observe the `AGE` of new pod created.

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c5b5c6f7c-mc9d6   1/1     Running   0          91s
nginx-deployment-c5b5c6f7c-vvvm4   1/1     Running   0          7m29s
```

## Services

A Service is a Kubernetes object used to define a logical set of **Pods** and also create a policy by which other service can access them. The logical set of pods that is under a service is determined by a **Label Selector**.

**Types of Services**

1. ClusterIp
2. NodePort
3. LoadBalancer
4. ExternalName
5. ExternalIPs

### ClusterIP

ClusterIP service is the default service type in kubernetes cluster. It exposes the service on a cluster-internal IP. This type of service are reachable from within the cluster. 

1. Below is code for a clusterIP type service. Open the notepad copy configuration of pod, paste and save it in a file `clusterIP-service.yml`. Make sure "All Files" is selected for "Save as Type" option.
This manifest file creates a Service with name ***test-service*** and exposes port 8089. If you notice the manifest file, there is a key `spec.selector` with a value `app: nginx`. The pods within this namespace and with this label are selected by the service.

``` yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: test-service
  spec:
    ports:
    - name: tcp-8089
      protocol: TCP
      port: 8089
      targetPort: 80
    selector:
      app: nginx

``` 
  
2. Choose the correct path of configuration yml file to deploy the service on the cluster.
 
E.g. `kubectl create -f <file-path>` 

```bash
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/clusterIP-service.yml
```

**Output:**
```
service/test-service created
```

### NodePort

1. NodePort type of service exposes the service on each node's IP at a static port. One can access a NodePort type service from outside of the cluster, by accessing the `NodeIP:StaticPort`. Below is code for a NodePort type service, use the command `kubectl create -f <filename-name>` to deploy the service.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/nodeport.png?st=2019-08-26T08%3A50%3A05Z&se=2022-08-27T08%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cPpQtbYMwNDdll17rCO3iXRfr6%2BYfRGgX2Z1%2F7yWqf4%3D" alt="image-alt-text" >

2. Below is code for a **NodePort** type service. Open the notepad copy configuration of pod, paste and save it in a file `nodeport-service`. Make sure "All Files" is selected for "Save as Type" option.

3. This manifest file creates a Service with name **nodeport-service** and exposes port 8089. If you notice the manifest file, there is a key `spec.selector` with a value `app: nginx`. The pods within this namespace and with this label are selected by the service.



``` yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: nodeport-service
  spec:
    type: NodePort
    ports:
    - name: tcp-8089
      protocol: TCP
      port: 8089
      targetPort: 80
    selector:
      app: nginx
```
  
4. Choose the correct path of configuration yml file to deploy the loadbalancer-service on the cluster.

```bash
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/nodeport-service.yml
```

**Output:**
```
service/nodeport-service created
```

### LoadBalancer

1. LoadBalancer type of service exposes the service externally using a cloud provider's Load Balancer resource (i.e. Load Balancer in OCI). One can access a LoadBalancer type service from outside of the cluster, by accessing the LoadBalancerPublicIP:Port. Below is code for a LoadBalancer type service, use the command `kubectl create -f <filename-name>` to deploy the service.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/loadbalancer%20.png?st=2019-08-26T08%3A50%3A57Z&se=2022-08-27T08%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RNMLGT0g9lQpfR2YaGNki%2Bo5Glg9Ms%2BaXgLQxuBQsTw%3D" alt="image-alt-text" >

2.Below is code for a **LoadBalance** type service. Open the notepad copy configuration of pod, paste and save it in a file `loadbalancer-service.yml`. Make sure "All Files" is selected for "Save as Type" option.

3. This manifest file creates a Service with name **loadbalancer-service** and exposes port 8089. If you notice the manifest file, there is a key `spec.selector` with a value `app: nginx`. The pods within this namespace and with this label are selected by the service.

``` yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: loadbalancer-service
  spec:
    type: LoadBalancer
    ports:
    - name: tcp-8089
      protocol: TCP
      port: 8089
      targetPort: 80
    selector:
      app: nginx
```

2. Choose the correct path of configuration yml file to deploy the loadbalancer-service on the cluster.

```bash
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/loadbalancer-service.yml
```

**Output:**
```
service/loadbalancer-service created
```

###  ExternalName

ExternalName type of the service maps the service to the contents of the externalName field, by returning a CNAME record with its vault. This type of service requires version 1.7 or higher of **kube-dns**. Below is code for a ExternalName type service, use the command `kubectl create -f <filename-name>` to deploy the service.

**Note:** you will not going to use Extername and ExternalIP's services in this lab.

``` yaml
  kind: Service
  apiVersion: v1
  metadata:
    name: test-service
  spec:
    type: ExternalName
    externalName: test-service.example.com
```
  
### ExternalIPs

If there are ExternalIP's that route traffic to the cluster nodes, then kubernetes services can be exposed on those **externalIPs**. Traffic that ingresses into the cluster with the external IP (as destination IP), on the service port, will be routed to one of the service endpoints. In the **ServiceSpec**, **externalIPs** can be specified along with any of the **ServiceTypes**. In the example below, db-service can be accessed by client on the IP.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/Externalip.png?st=2019-08-26T08%3A51%3A50Z&se=2022-08-27T08%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jsT0IV54KlU12kMhx%2BN6%2FW274y7KXXmmgtBdhW2IYZY%3D" alt="image-alt-text" >

``` yaml
  kind: Service
  apiVersion: v1
  metadata:
    name: db-service
  spec:
    selector:
      service-name: db-service
    ports:
    - name: http
      protocol: TCP
      port: 28015
      targetPort: 28015
    externalIPs:
    - <replace-with-external-service-IP-address>
```
### Get list of Services

1. To get a list of services in a namespace use the command `kubectl -n devteam get services`

**Output:**
```
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP               PORT(S)          AGE
external-service       ExternalName   <none>          test-service.example.com  <none>           13m
loadbalancer-service   LoadBalancer   10.96.254.133   129.213.211.38            8089:30658/TCP   11m
nodeport-service       NodePort       10.96.67.43     <none>                    8089:31376/TCP   21m
test-service           ClusterIP      10.96.160.53    <none>                    8089/TCP         23m
```

### Describe a Service

* To describe and get more information on a service use the following command shown below, mention service name to see detailed information about the service.

E.g. `kubectl -n devteam describe service <service-name>`

```bash
kubectl -n devteam describe service test-service
```
**Output:**
``` 
Name:              test-service
Namespace:         devteam
Labels:            <none>
Annotations:       <none>
Selector:          app=nginx
Type:              ClusterIP
IP:                10.96.160.53
Port:              tcp-8089  8089/TCP
TargetPort:        80/TCP
Endpoints:         10.244.1.3:80,10.244.2.3:80
Session Affinity:  None
Events:            <none>
```

### Edit a Service

* Use powershell, If you want to edit the existing service you can use `kubectl -n devteam edit service test-service`, this command will pop up a notepad window change the targetport to 8080, if any changes made in the service configuration, service will be updated.

E.g. `kubectl -n devteam edit service <service-name>`

```bash
kubectl -n devteam edit service test-service
```

### Labels

* Get labels using the following command

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/labels.png?st=2019-08-26T08%3A58%3A05Z&se=2022-08-27T08%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rDbP0mE7Q4RCPnBGlDhExYNjX81J2jxQ9Uwyu9zXMoU%3D" alt="image-alt-text" >

```bash
kubectl -n devteam get po --show-labels
```

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE   LABELS
nginx-deployment-c5b5c6f7c-vvvm4   1/1     Running   0          40m   app=nginx,pod-template-hash=c5b5c6f7c
nginx-deployment-c5b5c6f7c-zxz9s   1/1     Running   0          40m   app=nginx,pod-template-hash=c5b5c6f7c
```

* List out the  pods with label using `kubectl -n devteam get po -l app=nginx`

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c5b5c6f7c-vvvm4   1/1     Running   0          41m
nginx-deployment-c5b5c6f7c-zxz9s   1/1     Running   0          41m
```

* If you want to add a label `label=myservice` to pods, use the following command.
* Make sure replace podname with yours

E.g. `kubectl -n (namespacename) label po (podname) <key-value>`

```bash
kubectl -n devteam label po nginx-deployment-c5b5c6f7c-vvvm4 label=myservice`
```

**Ouput:**
```
pod/nginx-deployment-c5b5c6f7c-vvvm4 labeled
```

* Verify the pod labels have been created in previous step, use the following command to display the labels on pod.

```bash
kubectl -n devteam get po --show-labels
```

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE   LABELS
nginx-deployment-c5b5c6f7c-vvvm4   1/1     Running   0          46m   app=nginx,label=myservice,pod-template-hash=c5b5c6f7c
nginx-deployment-c5b5c6f7c-zxz9s   1/1     Running   0          46m   app=nginx,pod-template-hash=c5b5c6f7c
```

* Show the all pods using label `app=nginx-service`, enter the following command in Powershell.

```bash
kubectl -n devteam get po -l app=nginx
```

**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c5b5c6f7c-66f6m   1/1     Running   0          91s
nginx-deployment-c5b5c6f7c-zxz9s   1/1     Running   0          51m
```

### Access the Services

* Services can be accessed from the pod with service names and port assigned, shown below.

**Note:** If you are using gitbash use `winpty` infront of kubectl command.

* Get into the pod using the following command shown below. Replace pod name with yours

* Run the commands using powershell.

```bash
kubectl -n devteam exec -it <your pod id> bash
```

* Update the `apt-get` repository, use the following command to update.

`apt-get update && apt-get install -y curl`

**Services can be called by its name, while using curl & wget etc, from any pod in the same namespace**

* Access Cluster-IP service with <servicename:port> has shown below.

```bash
curl test-service:8089
```

**Output:**
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

**Note:** Type `exit` to get-out of the pod shell.

* Access Node-port service from the pod shown below, copy the node-ip using the command.

```bash
kubectl get nodes
```

**Output:**
```
NAME                       STATUS   ROLES   AGE   VERSION
aks-agentpool-16957051-0   Ready    agent   28m   v1.14.8
```

* Note down the nodename and nodeport-service port (e.g.31368) shown below. If you want to get the port **(PORT)** of nodeport-service use the following command.

```bash
kubectl -n devteam get svc
```

**Output:**
```
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP                PORT(S)          AGE
external-service       ExternalName   <none>          test-service.example.com   <none>           44m
loadbalancer-service   LoadBalancer   10.96.254.133   129.213.211.38             8089:30658/TCP   41m
nodeport-service       NodePort       10.96.67.43     <none>                     8089:31376/TCP   52m
test-service           ClusterIP      10.96.160.53    <none>                     8089/TCP         54m
```

E.g `nodename: nodeport`

```bash
 kubectl -n devteam exec -it my-nginx-64fc468bd4-2wqtm bash
```

* Install `curl` if necessary and execute below command. Make sure you replace the IP's as per your deployment.

`curl aks-agentpool-16957051-0:30558`

**Output:**
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

* The examples of other types of services can be found in later labs

### Delete a service

* To delete a Service use the following command to delete service in a cluster.

E.g. `kubectl -n <namespace-name> delete service <service-name>`

```bash
kubectl -n devteam delete service test-service
```

* This will delete the service resource with a name `test-service`.

## Exercises

1. Create a pod with image nginx called nginx and expose its port 80

<details><summary>show</summary>
<p>

```bash
kubectl run nginx --image=nginx --restart=Never --port=80 --expose
# observe that a pod as well as a service are created
```
```
service/nginx created
pod/nginx created
```
</p>
</details>

2. List-out the all services objects have been deployed

<details><summary>show</summary>
<p>

```bash
kubectl get svc 
```
</p>
</details>

3. Discover more details about the service

<details><summary>show</summary>
<p>

```bash
kubectl describe svc nginx
```
```
Name:              nginx
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          run=nginx
Type:              ClusterIP
IP:                10.96.12.23
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         10.244.1.7:80
Session Affinity:  None
Events:            <none>
```
</p>
</details>

4. Access the service using service names, replace podname with yours

<details><summary>show</summary>
<p>
  
```bash
kubectl exec -it my-nginx-64fc468bd4-2wqtm bash
curl nginx:80
```
</p>
</details>

5. Confirm that ClusterIP has been created. Also check endpoints

<details><summary>show</summary>
<p>

```bash
kubectl get svc nginx # services
kubectl get ep # endpoints
```
```
NAME    TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
nginx   ClusterIP   10.96.12.23   <none>        80/TCP    7m16s
```
</p>
</details>

6. Create a deployment called nginx using image 'dgkanatsios/simpleapp' (a simple server that returns hostname) and 3 replicas. Label it as 'app=foo'. Declare that containers in this pod will accept traffic on port 8080 (do NOT create a service yet)

<details><summary>show</summary>
<p>
 
```bash
kubectl run foo --image=dgkanatsios/simpleapp --labels=app=foo --port=8080 --replicas=3
```
```
deployment.apps/foo created
```
</p>
</details>

7. Create a service that exposes the deployment on port 6262. Verify its existence, check the endpoints

<details><summary>show</summary>
<p>

```bash
kubectl expose deploy nginx-deployment --port=6262 --target-port=8080
kubectl get service foo # you will see ClusterIP as well as port 6262
kubectl get endpoints foo # you will see the IPs of the three replica nodes, listening on port 8080
```
```
service/foo exposed
foo          ClusterIP   10.96.130.10   <none>        6262/TCP   39s
NAME   ENDPOINTS                                         AGE
foo    10.244.0.6:8080,10.244.1.8:8080,10.244.2.6:8080   2m37s
```
</p>
</details>

8. List-out the all deployments

<details><summary>show</summary>
<p>

```bash
kubectl get deploy
```
</p>
</details>

9. Create an nginx deployment of 2 replicas, expose it via a ClusterIP service on port 80.

<details><summary>show</summary>
<p>

```bash
kubectl run nginxsvc --image=nginx --replicas=2 --port=80 --expose
kubectl describe svc nginxsvc # see the 'run=nginxsvc' selector for the pods
```
```
Name:              nginxsvc
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          run=nginxsvc
Type:              ClusterIP
IP:                10.96.104.12
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         10.244.1.9:80,10.244.2.8:80
Session Affinity:  None
Events:            <none>
```
</p>
</details>

10. Describe the details of individual deployments

<details><summary>show</summary>
<p>

```bash
kubectl describe deploy foo
```

</p>
</details>

11. Create a label for deployments

<details><summary>show</summary>
<p>

```bash
kubectl label deploy foo service-name=test
```
```
deployment.extensions/foo labeled
```
</p>
</details>


12. Verify the logs of the pod

<details><summary>show</summary>
<p>

```bash
kubectl logs foo-6884ddd565-ghwnp
```
```
> simpleapp@1.0.0 start /usr/src/app
> node server.js

Running version 2.0 on http://0.0.0.0:8080
```
</p>
</details>


**Conclusion:** Congratulations! You have successfully completed the Kubernetes Services and Deployments lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
