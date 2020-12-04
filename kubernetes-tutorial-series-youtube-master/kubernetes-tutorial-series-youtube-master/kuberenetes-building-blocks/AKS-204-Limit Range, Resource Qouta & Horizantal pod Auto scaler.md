# Limit Range, Resource Quotas & Horizontal Pod Autoscaler

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Limit Ranges ](#limit-ranges )

[Resource Quotas](#resource-quotas)

[Horizontal Pod Autoscaler](#horizontal-pod-autoscaler)

[Exercises](#exercises)

## Overview

**Limit Range** provides constraints that can:
  * Enforce minimum and maximum compute resources usage per Pod or Container in a namespace.
  * Enforce minimum and maximum storage request per PersistentVolumeClaim in a namespace.
  * Enforce a ratio between request and limit for a resource in a namespace.
  * Set default request/limit for compute resources in a namespace and automatically inject them to Containers at runtime.

**Resource Quota** provides constraints that limit aggregate resource consumption per namespace. It can limit the quantity of objects that can be created in a namespace by type, as well as the total amount of compute resources that may be consumed by resources in that project.

**Horizontal Pod Autoscaler** automatically scales the number of pods in a replication controller deployment or replica set based on observed CPU utilization.

This lab you will learn about how to create, update, describe, edit, delete a few Kubernetes objects like Limit Range, Resource Quota & Horizantal Pod Autoscaler.

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

```bash
kubectl get nodes
```

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using the following command, you get the default namespaces in kubernetes cluster.

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

## Limit Ranges

Assigning a memory request and a memory limit or a cpu request and a cpu limit to a container is called `LimitRange`.

A Container is guaranteed to have as much memory as it requests, but is not allowed to use more memory than its limit.

**Note:** Make sure you have the metrics server installed in your cluster before applying LimitRanges.


**Create LimitRanges**

Create a LimitRange to a namespace then all the pods that exists in that namespace will get applied by the LimitRange.

1. Create a namespace using the following command in Powershell.

```bash
kubectl create ns devteam
```

2. Save the following manifest file, open up a notepad, copy and paste into a file `limitrange.yaml` and save it as All files.

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-memory
  namespace: devteam
spec:
  limits:
  - default:
      cpu: 250m
      memory: 300Mi
    defaultRequest:
      cpu: 100m
      memory: 200Mi
    type: Container
```
* Deploy the `limitrange.yaml` manifestfile for deploying into the cluster.

```bash
kubectl -n devteam create -f limitrange.yaml
```
### Deploy a sample pod and service

1. Let's deploy a pod and service that creates a single container to demonstrate how default values are applied to each pod. Use the following command in Powershell.

```bash
kubectl -n devteam run php-apache --image=k8s.gcr.io/hpa-example --expose --port=80
```

2. Get the pods and service using the following commands

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME                          READY     STATUS    RESTARTS   AGE
php-apache-55c4bb8b88-bb7jp   1/1       Running   0          4m
```

* For list-out the services in a devteam namespace

```bash
kubectl -n devteam get services
```
**Output:**
```
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
php-apache   ClusterIP   10.96.225.250   <none>        80/TCP    4m
```

### Get the configuration of the pod

1. Now get the configuration of the pod using the following command in Powershell.

```bash
kubectl -n devteam get pod php-apache -o yaml
```
```
....................
....................
  containers:
  - image: k8s.gcr.io/hpa-example
    imagePullPolicy: Always
    name: php-apache
    ports:
    - containerPort: 80
      protocol: TCP
    resources:
      limits:
        cpu: 250m
        memory: 300Mi
      requests:
        cpu: 100m
        memory: 200Mi
...................
...................
...................
```
2. Get the metrics of the pods in your namespace using the following command in Powershell.

```bash
kubectl top pods -n devteam
```

**Output:**
```
NAME                          CPU(cores)   MEMORY(bytes)
php-apache-55c4bb8b88-bb7jp   1m           9Mi
```

3. Get the nodes cpu usage and memory usage using the following command in Powershell.

```bash
kubectl top nodes
```

**Show example of pod crossing the Limit**

## Resource Quotas

In Kubernetes, ResourceQuota is used to limit the resources per namespace when multiple users sharing the cluster. We will apply the ResourceQuota for the compute resources.

#### Create a Namespace: 

* Create a namespace and apply the ResourceQuota to that namespace.

```bash
kubectl create ns devteam-test
```

### Create a ResourceQuota

Create a ResourceQuota using the following YAML and apply it to the namespace by specifying the namespace name in the YAML file.

``` yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: resourcequota-name
  namespace: devteam-test
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
```
2. Save the above YAML file with name of resource-quota.yaml, and create a ResourceQuota using the following command.

`kubectl create -f resource-quota.yaml`

3. Now use the `kubectl -n devteam-test get resourcequota resourcequota-name -o yaml` command to get detailed information about the ResourceQuota.

### Create a Pod 

1. Create a Pod in `devteam-test` namespace using the following configuration code with a file name `nginx-memory.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-cpu-memory
  namespace: devteam-test
spec:
  containers:
  - name: nginx-cpu-memory-quota
    image: nginx
    resources:
      limits:
        memory: "700Mi"
        cpu: "700m" 
      requests:
        memory: "500Mi"
        cpu: "300m"
```

2. Deploy the pod using the following command

```bash
kubectl create -f nginx-memory.yaml
```

3. List-out the pods in `kubectl -n devteam-test get pods`

```bash
kubectl -n devteam-test get pods
```

**Output:**
```
NAME               READY   STATUS    RESTARTS   AGE
nginx-cpu-memory   1/1     Running   0          23s
```

4. Get more detailed information about the ResourceQuota, Use the following command in Powershell.

```bash
kubectl -n devteam-test get resourcequota resourcequota-name -o yaml
```
**Output:**
```yaml
spec:
  hard:
    limits.cpu: "2"
    limits.memory: 2Gi
    requests.cpu: "1"
    requests.memory: 1Gi
status:
  hard:
    limits.cpu: "2"
    limits.memory: 2Gi
    requests.cpu: "1"
    requests.memory: 1Gi
  used:
    limits.cpu: 700m
    limits.memory: 700Mi
    requests.cpu: 300m
    requests.memory: 500Mi
```

5. The output shows how much of the quota has been used along with the quota limits.

### Create Another Pod 

* Create another pod by specifying the memory request more than its ResourceQuota request.

* Create a namespace using the following command in Powershell.

```bash
kubectl create ns resourcequota
```

* Save the following yaml configuration code with a file name `redis-cpu-memory.yaml`

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-cpu-memory
  namespace: resourcequota
spec:
  containers:
  - name: redis-cpu-memory-quota
    image: redis
    resources:
      limits:
        memory: "1Gi"
        cpu: "900m"      
      requests:
        memory: "600Mi"
        cpu: "500m"
```

* Deploy the `redis-cpu-memory.yaml`manifest file into the cluster, using the following command.

```bash
kubectl create -f redis-cpu-memory.yaml
```

### Create Another Pod: 

* Create another pod by specifying the memory request more than its ResuorceQuota request.

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-cpu-memory
  namespace: devteam-test
spec:
  containers:
  - name: redis-cpu-memory-quota
    image: redis
    resources:
      limits:
        memory: "1Gi"
        cpu: "900m"      
      requests:
        memory: "600Mi"
        cpu: "500m"

```
* Create the pod using `kubectl -n devteam-test create -f <file path>`

* Now the second pod doesn't get created and gives an error because of the exceeding memory request.

```
kubectl -n devteam-test create -f redis-cpu.yaml
```

**Output:**

```
Error from server (Forbidden): error when creating "redis-cpu.yaml": pods "redis-cpu-memory" is forbidden: exceeded quota: dev-resource, requested: requests.memory=600Mi, used: requests.memory=500Mi, limited: requests.memory=1Gi
```

* You can also restrict the totals for memory limit, CPU request, and CPU limit.

## Horizontal Pod Autoscaler

Horizontal Pod Autoscaler scales the number pods in a deployment, replica controller or replica set automatically based on the CPU utilization. ( or other custom metric )

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/HPA.png?st=2019-08-26T09%3A25%3A19Z&se=2022-08-27T09%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y5%2B4xBopy46XjH%2FGgezMOOyx6A0igJFENnzlWCqm98w%3D" alt="image-alt-text" >

### Apply Horizontal Pod Autoscaling

1. Apply the HPA configuration to the existing deployment.

```bash
kubectl -n devteam autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

2. Get the HPA configuration using the following command in Powershell.

`kubectl -n devteam get hpa -o yaml`

```
  NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
  php-apache   Deployment/php-apache   1%/50%    1         10        1          10m
```

### Generate Load

1. Now we will use load generator to generate some load on apache.

2. Open an additional terminal window and run the below command.

```bash
kubectl -n devteam run -i --tty load-generator --image=busybox /bin/sh
```
3. Hit enter and run below command to generate load on apache.

```
while true; do wget -q -O- http://php-apache.devteam.svc.cluster.local; done
```

**Output:**  
```
`OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!`
```
4. Within few minutes, we should see the higher CPU load by executing the following command.

```bash
kubectl -n devteam get hpa
```
**Output:**
```
NAME         REFERENCE               TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   158%/50%   1         10        4          16m
```

5. You can see the number of apache pods increased due to load on apache, verify it using the following command 

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME                              READY     STATUS    RESTARTS   AGE
load-generator-5ff6784f85-7wgnm   1/1       Running   0          9m
php-apache-55c4bb8b88-2j2nl       1/1       Running   0          7m
php-apache-55c4bb8b88-bp5mf       1/1       Running   0          5m
php-apache-55c4bb8b88-jx5qr       1/1       Running   0          7m
php-apache-55c4bb8b88-kc68r       1/1       Running   0          52m
php-apache-55c4bb8b88-m4hzb       1/1       Running   0          5m
php-apache-55c4bb8b88-trvrm       1/1       Running   0          7m
```
### Stop Load

1. You can stop the load on apache by typing <Ctrl> + C on new terminal.

2. You can verify the result within a minute using the following command, 

`kubectl -n devteam get hpa`

**Output:**
```
NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   44%/50%   1         10        6          24m
```
**Note:** Make sure that replace podname with yours.

* Check the logs of pod using the following command in powershell to view logs in pod.

```bash
kubectl -n devteam logs php-apache-55c4bb8b88-2j2nl
```

## Exercises

### Create a configuration file for limitRange object

<details><summary>show</summary>
<p>

``` yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-memory
  namespace: test
spec:
  limits:
  - default:
      cpu: 250m
      memory: 300Mi
    defaultRequest:
      cpu: 100m
      memory: 200Mi
    type: Container
```
</p>
</details>

### Inspect a limitRange object

<details><summary>show</summary>
<p>

```bash
kubectl describe limitrange <name-of-limitrange> -n <namespace-name>
```
</p>
</details>

### Get the metrics of the pods in your namespace

<details><summary>show</summary>
<p>

```bash
kubectl top pods -n <namespace-name>
```

</p>
</details>

### Get the nodes cpu usage and memory usage

<details><summary>show</summary>
<p>

```bash
kubectl top nodes
```

</p>
</details>

### Clean up the limitRange namespace to free all resources

<details><summary>show</summary>
<p>

```bash
kubectl delete namespace <namespace-name>
```
</p>
</details>

### Create a ResourceQuota Object 

<details><summary>show</summary>
<p>

``` yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: <resourcequota name>
  namespace: <namespace name>
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
```

</p>
</details>

### Create pod specify the memory request more than its ResuorceQuota request

<details><summary>show</summary>
<p>

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-cpu-memory
  namespace: resourcequota
spec:
  containers:
  - name: redis-cpu-memory-quota
    image: redis
    resources:
      limits:
        memory: "1Gi"
        cpu: "900m"      
      requests:
        memory: "600Mi"
        cpu: "500m"
```
</p>
</details>

### Create a Horizontal Pod Autoscaler (HPA) to a existing deployment

<details><summary>show</summary>
<p>

```bash
kubectl -n test autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

</p>
</details>

### Get the Horizontal Pod Autoscaler configuration 

<details><summary>show</summary>
<p>

```bash
kubectl -n test get hpa -o yaml
```

</p>
</details>


### Create a load generator to generate some load on pod or deployment

<details><summary>show</summary>
<p>

```bash
kubectl -n test run -it --tty load-generator --image=busybox /bin/sh
```
</p>
</details>


### Verify the logs of the pod

<details><summary>show</summary>
<p>

```bash
kubectl -n test logs <pod-name>
```
</p>
</details>

**Conclusion:** Congratulations! You have successfully completed the Limit Ranges, Resource Quotas & Horizontal Pod Autoscaler! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
