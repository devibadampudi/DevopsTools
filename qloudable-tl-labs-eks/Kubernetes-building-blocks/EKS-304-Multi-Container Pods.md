# Multi-Container Pods in Kubernetes

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Multi-Container Pods](#multi-container-pods)

[Exercises](#exercises)

## Overview

In Kubernetes, **Multi-Container Pods** are fairly straightforward concept it is a single pod with multiple containers inside it. The primary use case for this setup is to support helper processes for a primary application.

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up multi-container pods. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Management console, then move into actually creating, editing, and managing multi-container pods as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn how to create multi container pods in Kubernetes.

## Pre-Requisites

None required

## Accessing the EKS cluster

### Sign in to AWS Management console

* Navigate to **Chrome** on the right pane, you should see AWS console page.

* Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Use below credentials to login to AWS console.

* **Account ID:** `{{Account_ID}}` <br>
* **IAM username:** `{{User_Name}}` <br>
* **Password:** `{{Password}}`

* Select **IAM user** and then enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

*  Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/3.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/4.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{Region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/5.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Click Apps icon in the toolbar and select **Powershell** to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-23T06%3A16%3A39Z&se=2022-10-24T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Gg0Ouxr68ThRowxFznGsXgXiaWWNOTj7kM7gXm34dGs%3D" alt="image-alt-text">

* **Access_keyid:** {{Access_keyid}}

* **Access_secret:** {{Access_secret}}

* **Cluster-region:** {{Cluster-region}}

* **Output-format:** json

* Need to configure the AWS credentials for accessing the cluster run the command `aws configure` then enter the  specified credentials as you get in previous step.

`aws configure`

**Output:**

```
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json

```
* **Cluster-region:** {{Cluster-region}}

* **Cluster-name:** {{Cluster-name}}

* Run the following command to generate kubeconfig file for cluster.

```bash
aws eks --region {{Cluster-region}} update-kubeconfig --name {{Cluster-name}}

```

* We have initialized the enviornment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`kubectl get nodes`

**Output:**

```
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```

## Multi-Container Pods

Multiple containers in a pod run on the same Network IP and same IPC(inter-process communication), this makes the containers use same port so that it can be a tightly coupled instead of loosely coupled. Multicontainer pod uses shared volumes so they can easily communicate data between the containers, ensuring data localization.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/multicontainer.png?st=2019-08-26T10%3A35%3A09Z&se=2022-08-27T10%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pPjp6%2B6ayV2LQd%2FfiSFZOay9XWfPgSiOmRshYQJ7IpE%3D" alt="image-alt-text">)	

### Create a multi-container-pods:

* Create a namespace using the following command.

```bash
kubectl create ns devteam
```

**Output:**

```bash
 namespace `devteam`created
```

* Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of multi-container-pods, paste and save it in a file `multi-contaierpods.yml`. Please make sure "All Files" is selected for "Save as Type" option.

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
* Deploy `mutli-containerpod.yml` configuration by using the following command. Make sure choose correct path.

```bash
kubectl -n devteam create -f c:\user\PhotonUser\Desktop\multi-containerpod.yaml
```

**Output:**

 ```
 pod "two-containers" created
```
### Get the pods

* List-out the pods by using the command. 

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

1. **NGINX**

**Note:** If you are using gitbash terminal use  `winpty` infront of kubectl command.

```bash
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

* Type `exit` to get out of the container

**Ubuntu**

2. If you want to get shell into the ubuntu container, use the following command. 

**Note:** If you are using powerShell, ignore `winpty`

```bash
winpty kubectl -n devteam exec -it two-containers -c ubuntu bash
```

**Output:**

```
root@two-containers:/# apt-get update
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

* Type `exit` to get out of the container.

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
