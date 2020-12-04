# Accessing the Kubernetes Web UI (Dashboard) in AKS

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Accessing the Kubernetes Web dashboard](#accessing-the-kubernetes-web-dashboard)

## Overview

The main aim of this lab about, learn how to access the Kubernetes web dashboard. Dashboard is a web-based Kubernetes user interface. You can use Dashboard to deploy containerized applications to a Kubernetes cluster, troubleshoot your containerized application, and manage the cluster resources.

Kubernetes has a web dashboard and is used for basic  management operations. This lets you view basic health status and metrics for application, create deployments and services, edit the existing applications.

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

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/landingpage.PNG?st=2019-10-16T09%3A58%3A17Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CUJ%2B2tK4s25F%2BL88voMTtzpAM8obbAYafLnFYsuYOzc%3D" alt="image-alt-text">

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like MC_myResourceGroup_myAKSCluster_eastus. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select Powershell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the powershell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Execute the following command to get the cluster access, using the following command in Powershell.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the environment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a K8's cluster.

```bash
kubectl get nodes
```

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using the following command, you get the default namespaces in K8's cluster

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
## Accessing the Kubernetes web dashboard

### For RBAC-enabled clusters

* Use the `kubectl` cli to create ClusterRoleBinding command To create a binding

```bash
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
```

**Output:**
```
clusterrolebinding.rbac.authorization.k8s.io "kubernetes-dashboard" created
```

* You can now access the Kubernetes dashboard in your RBAC-enabled cluster. 

### Starting the Kubernetes dashboard

* Using `az aks browse` command starts the Kuberentes dashboard.
 
`az aks browse --resource-group {{rg-name}} --name  {{cluster-name}}`

* Replace rg-name and cluster-name values as yours

`E.g. az aks browse --resource-group az-tl-cluster --name aztlcluster59`

**Output:**
```
Merged "aztlcluster59" as current context in C:\Users\Sysgain\AppData\Local\Temp\tmp7lrxx58g
Proxy running on http://127.0.0.1:8001/
Press CTRL+C to close the tunnel...
Forwarding from 127.0.0.1:8001 -> 9090
Forwarding from [::1]:8001 -> 9090
Handling connection for 8001
Handling connection for 8001
Handling connection for 8001
Handling connection for 8001
Handling connection for 8001
Handling connection for 8001
E0716 15:17:55.562275   11284 portforward.go:178] lost connection to pod
```
* This command creates a proxy between developments system and Kuberentes API. It also opens a web browser to the Kuberentes dashboard.	

* Copy the URL and paste in browser `http://127.0.0.1:8001/`
 
* Click **overview**, to view the page containing overall information. 

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k1.png?st=2019-10-30T05%3A38%3A43Z&se=2022-10-31T05%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s%2BAdKzlW2%2BSYGS0i2u3qQkXi709m9h%2F37EpYhisr1wM%3D" alt="image-alt-text">

### Create an application

* Create an application from the Kubernetes dashboard by providing following configuration yaml file.

``` yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
spec:
  selector:
    matchLabels:
      run: my-nginx
  replicas: 1
  template:
    metadata:
      labels:
        run: my-nginx
    spec:
      containers:
      - name: my-nginx
        image: nginx
        ports:
        - containerPort: 80
```
* Create the yaml files `my-nginx.yaml`

* Click **Create** button on the upper right corner.

* Select the **create from file** button and choose your yaml file then upload.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k2.png?st=2019-10-30T05%3A40%3A14Z&se=2022-10-31T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IAPeWrRbYxtLB5CLQRPlHO%2BFtg%2BNiKxedXQ7bZpijEk%3D" alt="image-alt-text">
 
* To use the graphical wizard, click **Create an app**
   
* Provide a name for the deployment, such as **my-nginx**

* Enter the name for the container image to use, such as **nginx**
   
* Select the no of pods 
   
* When ready, click **Deploy** to create the app

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k3.png?st=2019-10-30T05%3A40%3A39Z&se=2022-10-31T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3Zb3y8aAdihwTmjg1j7s6YYf7P09V7nq5QxQnD%2B%2BP3s%3D" alt="image-alt-text">
 
* After successful deployment, you can view application under deployments.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k4.png?st=2019-10-30T05%3A41%3A04Z&se=2022-10-31T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=R7Xlce%2F9dgUBtkEP%2FjZ2h0JlIELrDMDMoB%2FKX5KK9dI%3D" alt="image-alt-text">

* Choose your deployment to view the information.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k5.png?st=2019-10-30T05%3A41%3A28Z&se=2022-10-31T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IlwFCGCg926aVxVYxJgmDcIyIF%2BLTc%2Frss07j5FmldU%3D" alt="image-alt-text">

* Select Namespace in the list of available namespaces on the dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k6.png?st=2019-10-30T05%3A41%3A54Z&se=2022-10-31T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=akRhsfljykBclITRnELjlpj4u5ZzkMtvwWX%2Benc9pjw%3D" alt="image-alt-text">

* Select Nodes in the dashboard to view list the no of available Nodes.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k7.png?st=2019-10-30T05%3A42%3A29Z&se=2022-10-31T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sHT5nPZxnkjHUvX4AGL60cIdx0JytytN9lKMYQiV%2FkU%3D" alt="image-alt-text">

* Select Pods in the left-sided menu to view the list of available pods. Select your nginx pod to view information such as resource consumption.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k8.png?st=2019-10-30T05%3A43%3A00Z&se=2022-10-31T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rxJLKnDFuDJJaVeEGxnzeCCmCL9qHKQvrDD040TbQxU%3D" alt="image-alt-text">

### Running Commands in a Container with EXEC

* Execute the commands in the conditions of container and click the `EXEC` button.

 <img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k9.png?st=2019-10-30T05%3A43%3A23Z&se=2022-10-31T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s2Tzhazc2PDnIuzAWI404mJnl2I08UFKFXxgswX4giI%3D" alt="image-alt-text">

* Command promt will appear If you wish to install packages or resources like (ps -ef, curl) into a container.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k10.png?st=2019-10-30T05%3A43%3A58Z&se=2022-10-31T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Qw%2BK4aB3QaxoOFnUh6IB8ibcJW9bwypQJNbfhjuWDq4%3D" alt="image-alt-text">
 
root@my-nginx-74dd76b9b8-7jdsl:/# pwd
/


`root@my-nginx-74dd76b9b8-7jdsl:/# apt-get update`

**Output:**
```
Ign:1 http://cdn-fastly.deb.debian.org/debian stretch InRelease   
Get:2 http://security-cdn.debian.org/debian-security stretch/updates InRelease [94.3 kB]
Get:3 http://cdn-fastly.deb.debian.org/debian stretch-updates InRelease [91.0 kB]
Get:4 http://cdn-fastly.deb.debian.org/debian stretch Release [118 kB]               
Get:5 http://cdn-fastly.deb.debian.org/debian stretch Release.gpg [2434 B]
Get:6 http://security-cdn.debian.org/debian-security stretch/updates/main amd64 Packages [499 kB]
Get:7 http://cdn-fastly.deb.debian.org/debian stretch-updates/main amd64 Packages [27.4 kB]
Get:8 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 Packages [7082 kB]
Fetched 7915 kB in 1s (4035 kB/s)  
Reading package lists... Done
```

`root@my-nginx-74dd76b9b8-7jdsl:/# apt-get install procps`

**Output:**
```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libgpm2 libncurses5 libprocps6 psmisc
Suggested packages:
  gpm
The following NEW packages will be installed:
  libgpm2 libncurses5 libprocps6 procps psmisc
0 upgraded, 5 newly installed, 0 to remove and 2 not upgraded.
Need to get 559 kB of archives.
After this operation, 1789 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 libprocps6 amd64 2:3.3.12-3+deb9u1 [58.5 kB]
Get:2 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 libncurses5 amd64 6.0+20161126-1+deb9u2 [93.4 kB]
Get:3 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 procps amd64 2:3.3.12-3+deb9u1 [250 kB]
Get:4 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 libgpm2 amd64 1.20.4-6.2+b1 [34.2 kB]
Get:5 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 psmisc amd64 22.21-2.1+b2 [123 kB]
Fetched 559 kB in 0s (1903 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libprocps6:amd64.
(Reading database ... 7034 files and directories currently installed.)
Preparing to unpack .../libprocps6_2%3a3.3.12-3+deb9u1_amd64.deb ...
Unpacking libprocps6:amd64 (2:3.3.12-3+deb9u1) ...
Selecting previously unselected package libncurses5:amd64.
Preparing to unpack .../libncurses5_6.0+20161126-1+deb9u2_amd64.deb ...
Unpacking libncurses5:amd64 (6.0+20161126-1+deb9u2) ...
Selecting previously unselected package procps.
Preparing to unpack .../procps_2%3a3.3.12-3+deb9u1_amd64.deb ...
Unpacking procps (2:3.3.12-3+deb9u1) ...
Selecting previously unselected package libgpm2:amd64.
Preparing to unpack .../libgpm2_1.20.4-6.2+b1_amd64.deb ...
Unpacking libgpm2:amd64 (1.20.4-6.2+b1) ...
Selecting previously unselected package psmisc.
Preparing to unpack .../psmisc_22.21-2.1+b2_amd64.deb ...
Unpacking psmisc (22.21-2.1+b2) ...
Setting up libncurses5:amd64 (6.0+20161126-1+deb9u2) ...
Setting up psmisc (22.21-2.1+b2) ...
Setting up libgpm2:amd64 (1.20.4-6.2+b1) ...
Setting up libprocps6:amd64 (2:3.3.12-3+deb9u1) ...
Setting up procps (2:3.3.12-3+deb9u1) ...
update-alternatives: using /usr/bin/w.procps to provide /usr/bin/w (w) in auto mode
update-alternatives: warning: skip creation of /usr/share/man/man1/w.1.gz because associated file /usr/share/man/man1/w.procps.1.gz (of link group w) doesn't exist
Processing triggers for libc-bin (2.24-11+deb9u4) ...
```
`root@my-nginx-74dd76b9b8-7jdsl:/# ps -ef`

```
UID         PID   PPID  C STIME TTY          TIME CMD
root          1      0  0 11:10 ?        00:00:00 nginx: master process nginx -g daemon off;
nginx         6      1  0 11:10 ?        00:00:00 nginx: worker process
root          7      0  0 11:13 pts/0    00:00:00 bash
root        276      7  0 11:17 pts/0    00:00:00 ps -ef
root@my-nginx-74dd76b9b8-7jdsl:/# 
```

**Logs of the pod**

* Click the logs button to view the pod logs.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k11.png?st=2019-10-30T05%3A44%3A30Z&se=2022-10-31T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bOaboCFW9uUrmhKwke2HE%2FDYBRhMU9D5JuTaQYnsYWE%3D" alt="image-alt-text">
 
**Edit the application**

* Select the deployments in left sided menu to get the list of available deployments.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k12.png?st=2019-10-30T05%3A44%3A51Z&se=2022-10-31T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MkmAeE77847BgjK8CFoVjw3pg7vNRala97P8O1FxxwY%3D" alt="image-alt-text">

* Choose your nginx deployment. Click **Edit** at the top right of the navigation bar.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k13.png?st=2019-10-30T05%3A45%3A13Z&se=2022-10-31T05%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZnONzYmvJufVfDuW%2FK9o0PSBOvX5z1h7NmBkNbNH6K4%3D" alt="image-alt-text">
 
* Locate the **spec.replica** value, to increase the number of replicas for the application, change this value from 1 to 3. Click **Update** when ready.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k14.png?st=2019-10-30T05%3A45%3A34Z&se=2022-10-31T05%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q1e9dzkYB4zMEcRwrMVX6dt92HsIjPVzUCv1%2FH%2Bglio%3D" alt="image-alt-text">

* It takes a few moments for the new pods to be created inside a replica set. On the left sided menu, choose Replica Sets, and then select your nginx replica set. The list of pods now reflects on the updated replica count.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k15.png?st=2019-10-30T05%3A45%3A56Z&se=2022-10-31T05%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ObwrWPRgyGgfhTT5%2BPuguNGAkncM0YEYDJxCD6UmIWw%3D" alt="image-alt-text">

* Select the `Services` in the dashboard to see the list of available services.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k16.png?st=2019-10-30T05%3A46%3A32Z&se=2022-10-31T05%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0MYRwK2Cey92wjW373pRUklP21DUSzLtpg8c0F5HbL4%3D" alt="image-alt-text">
 
* Selecting the `secrets` in the dashboard, will display the list of available secrets.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k17.png?st=2019-10-30T05%3A46%3A51Z&se=2022-10-31T05%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=l%2BFViHzg%2B%2Baq8pWmdaWzS5vDdadgFzWP7XOCql4DXdA%3D" alt="image-alt-text">

* Selecting the configmap, displays the list of the configmaps.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/k18.png?st=2019-10-30T05%3A47%3A10Z&se=2022-10-31T05%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PUxfff4N6o8Hd7jLmjPoVy3mMz52nqF%2FBNLBQECpUpU%3D" alt="image-alt-text">

**Conclusion:** Congratulations! You have successfully completed the accessing the Kubernetes web UI dashboard ! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
