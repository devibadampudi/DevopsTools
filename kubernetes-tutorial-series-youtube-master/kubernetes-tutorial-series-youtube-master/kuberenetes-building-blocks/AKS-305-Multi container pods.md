# Multi-Container Pods in Kubernetes

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Multi-Container Pods](#multi-container-pods)

[Exercises](#exercises)

## Overview

In Kubernetes, **Multi-Container Pods** are fairly straightforward concept it is a single pod with multiple containers inside it. The primary use case for this setup is to support helper processes for a primary application.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up multi-container pods. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing multi-container pods as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn how to create multi container pods in Kubernetes.

## Pre-Requisites

1. Azure Cloud Infrastructure account credentials (User, Password, ResourceGroup, and Subscription).
2. Basic Linux Commands.
3. Docker Fundamentals.
4. Basic Azure Cloud Knowledge.

## Accessing the AKS cluster

**Sign in to Azure portal**

1.	Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

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

6. We have initialized the enviornment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`kubectl get nodes`

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using this command in Powershell, you get the default namespaces in K8's Cluster.

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
## Multi Container Pods

Multiple containers in a pod run on the same Network IP and same IPC(inter-process communication),this makes the containers use same port so that it can be a tightly coupled instead of loosely coupled. Multicontainer pod uses shared volumes so they can easily communicate data between the containers, ensuring data localization.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/multicontainer.png?st=2019-08-26T10%3A35%3A09Z&se=2022-08-27T10%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pPjp6%2B6ayV2LQd%2FfiSFZOay9XWfPgSiOmRshYQJ7IpE%3D" alt="image-alt-text">)	

### Create a multi-container-pods:

* Create a namespace using the following command.

```
kubectl create ns devteam
```

**Output:**
```
 namespace devteam created
```

* Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of multi-container-pods, paste and save it in a file (e.g. multi-containerpods.yml). Please make sure `All Files` is selected for `Save as Type` option.

``` Yaml
apiVersion: v1
kind: Pod
metadata:
  name: two-containers
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: Always
    ports:
    - containerPort: 80      
  - name: ubuntu
    image: ubuntu 
    imagePullPolicy: Always
    ports:
    - containerPort: 80
    command: ["sleep", "30d"]      
  restartPolicy: Always  
```

* Deploy mutli-containerpods.yml configuration by using the following command. Make sure choose correct path

```bash
kubectl -n devteam create -f c:\user\PhotonUser\Desktop\multi-containerpods.yml
```

**Output:**
```
 pod "two-containers" created
```

### Get the pods

* List-out the pods by using the command in Powershell.

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME                                READY     STATUS             RESTARTS   AGE
two-containers                      2/2       Running            0          12s
```

* In READY status `2/2` is shows that 2 containers are running in a pod, as created previosuly two-containers pod.

### Running commands in a container with exec:

* Execute the commands inside a container, use the following command to get into a shell. use `-c` at end of the command to go specific container.

1. nginx

**Note:** if you are using gitbash terminal use  `winpty` infront of kubectl command.

```
kubectl -n devteam exec -it two-containers -c nginx bash
```

* Update the packages inside a container and install `curl` using the following command.

```bash
apt-get update
```

**Output:**
```
Get:1 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
Get:2 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
Get:3 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [576 kB]
Get:4 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [4169 B]
Get:5 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64 Packages [5436 B]
Get:6 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [721 kB]
Get:7 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:8 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
Get:9 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [186 kB]
Get:10 http://archive.ubuntu.com/ubuntu bionic/restricted amd64 Packages [13.5 kB]
Get:11 http://archive.ubuntu.com/ubuntu bionic/main amd64 Packages [1344 kB]
Get:12 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [11.3 MB]
Get:13 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages [10.8 kB]
Get:14 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [7239 B]
Get:15 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [882 kB]
Get:16 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [1238 kB]
Get:17 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [2496 B]
Get:18 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [3927 B]
Fetched 16.8 MB in 4s (4479 kB/s)
Reading package lists... Done
root@two-containers:/#
```

```bash
apt-get install curl
```
* Access the service with use of `curl`

```bash
curl localhost:80
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
root@two-containers:/#
```

* Type `exit` to exit out of the container

2. If you want to get shell into the ubuntu container, use the following command. 

**Note:** If you are using powerShell, ignore `winpty`

```bash
winpty kubectl -n devteam exec -it two-containers -c ubuntu bash
```
**Output:**
```
root@two-containers:/#
```

* Type `exit` to exit out of the container.

### Get more information with logs:

*  Viewing full logs of a pod running a container inside it. This will also show the appending logs at run time. This can be achieved via running following command.

```bash
kubectl -n devteam logs -f two-containers
```
**Output:**
```
Error from server (BadRequest): a container name must be specified for pod two-containers, choose one of: [nginx busybox]
```
**Note:** If you are using multi-container pod, want to inspect the logs of single container use `-c` at end of the command, and then container name.

```bash
kubectl -n devteam logs -f two-containers -c nginx
```

**Output:**
```
127.0.0.1 - - [05/Jul/2019:09:11:21 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.52.1" "-"
```

## Exercises

1. Create a Pod with two containers with different images ubuntu and nginx and command "echo helloworld; sleep 30d". Connect to the second container and run 'ls'

<details><summary>show</summary>
<p>

``` Yaml
apiVersion: v1
kind: Pod
metadata:
  name: two-containers
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: Always
    ports:
    - containerPort: 80
    args:
    - /bin/sh
    - -c
    - echo helloworld;sleep 30d     
  - name: ubuntu
    image: ubuntu 
    imagePullPolicy: Always
    ports:
    - containerPort: 80
    command: ["sleep", "30d"]      
  restartPolicy: Always
```
</p>
</details>

2. Connect to the ubuntu container within the pod

<details><summary>show</summary>
<p>

```bash
kubectl exec -it <podname> -c ubuntu -- /bin/sh
```

</p>
</details>

3. See the logs of ubuntu container

<details><summary>show</summary>
<p>

```bash
kubectl logs two-containers -c ubuntu
```

</p>
</details>

4. Follow the logs of ubuntu container

<details><summary>show</summary>
<p>

```bash
kubectl logs two-containers -c ubuntu -f
```

</p>
</details>

5. Inspect the multi-container pod

<details><summary>show</summary>
<p>

```bash
kubectl describe po two-containers
```

</p>
</details>

6. Clean up the the multi-container pod

<details><summary>show</summary>
<p>

```bash
kubectl delete po two-containers
```

</p>
</details>


**Conclusion:** Congratulations! You have successfully completed the multi-container pods lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
