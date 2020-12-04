# Volumes

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#Accessing-the-aks-cluster)

[Volumes](#volumes)

[Exercises](#exercises)

## Overview

At its core, a Kubernetes Volume is just a directory, possibly with some data in it, which is accessible to the Containers in a Pod. Typically, on-disk files in a Container are ephemeral, which presents some problems for non-trivial applications when running in Containers. Kubernetes Volumes provide a persistent directory accessible to the containers within the pod, and are tied to the life cycle of the pod -- not the container. The data is preserved across container restarts, and is one of the key Kubernetes concepts to understand.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up volumes. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing volumes as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

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


`az login -u {{azure_login}} -p {{azure_password}`

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

5. Using this command you get the default namespaces in K8's cluster `kubectl get ns`

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
Now that you are able to connect to your cluster successfully, lets start learning about Volumes!

## Volumes

1. A Kubernetes volume is a directory accessible to all containers running in a pod. Firstly, the files present inside a container are short-lived, which can lead to issues in an important applications when running in containers. For some reason if a container crashes the kubelet will restart the container, but the files in the containers are lost ie the container starts with a clean state. Secondly, when running containers together in a pod, it is often neccessary to share files between those containers. The Kubernetes Volume solves both of these problems.

2. Kubernetes Volumes are a vast topic, and it is best understood when taught in byte size chunks. The first part of this section deals with the simplest volumes : emptyDir.

3. EmptyDir are volumes that get created empty when a Pod is created.

4. While a Pod is running its emptyDir exists. If a container in a Pod crashes the emptyDir content is unaffected. Deleting a Pod deletes all its emptyDirs.

5. There are several ways a Pod can be deleted. Accidental and deliberate. All result in immediate emptyDir deletion. emptyDir are meant for temporary working disk space.

6. Let's create our first emptyDir volume and use it to learn more. Save the following pod YAML file with a  filename extension `<filename>.yml`, open a notepad copy configuration of pod, paste and save it in a file `emptyvolume.yml`. Please make sure "All Files" is selected for "Save as Type" option.


``` yaml

apiVersion: v1
kind: Pod
metadata:
  name: myvolumes-pod
spec:
  containers:
  - image: alpine
    imagePullPolicy: IfNotPresent
    name: myvolumes-container
    
    command: [    'sh', '-c', 'echo The Bench Container 1 is Running ; sleep 3600']
    
    volumeMounts:
    - mountPath: /empty
      name: empty-volume
  volumes:
  - name: empty-volume
    emptyDir: {}
```

7. This `yaml` only uses the Alpine Linux image, since it is a very small Linux operating system.

8. Because of its small size, it's heavily used in containers providing quick boot up times.


9. I also use the imagePullPolicy: IfNotPresent . The Alpine image gets downloaded from Internet only once. Thereafter it uses the locally stored copy.

From Pod spec above:

``` yaml
  volumes:
  - name: empty-volume
    emptyDir: {}

```

10. We define an emptyDir volume named demo-volume. The {} at the end means we do not supply any further requirements for the emptyDir.

This emptyDir spec makes it available to all containers in the Pod.

From Pod spec above:

```yaml
    volumeMounts:
    - mountPath: /empty
      name: empty-volume
    
```

11. Every container in the Pod needs to specify where it wants to have the emptyDir mounted.

12. Our example mounts the emptyDir at the mountPath: /empty

13. The name: empty-volume must refer to the volume at the bottom of the Pod spec. It specifies : mount empty-volume at /empty in the container.

14. Create the Pod using the following the command.

```bash
kubectl apply -f D:\PhotonUser\Desktop\emptyvolume.yml
```

**Output:**

```bash
pod/myvolumes-pod created
```

15. Enter the Pod. Enter commands as shown at # shell prompt.

syntax: 

```bash
kubectl exec <podname> -i -t -- /bin/sh
```

```bash
kubectl exec myvolumes-pod -i -t -- /bin/sh
```
**Output:**

```bash
PS D:\PhotonUser\.oci> kubectl exec myvolumes-pod -i -t -- /bin/sh
/ # pwd
/
/ # ls
bin    empty  home   media  opt    root   sbin   sys    usr
dev    etc    lib    mnt    proc   run    srv    tmp    var
/ # ls empty/
/ # echo test > empty/textfile
/ # ls empty/
textfile
/ # cat empty/textfile
test
/ # exit
```

### EmptyDir Created in RAM

16. If you do not specify where to create an emptyDir , it gets created on the disk space of the Kubernetes node.

17. If you need a small scratch volume, you can define it to be created in RAM. See very last line of spec below.

18. Everything else is identical to previous example.


```yaml 
apiVersion: v1
kind: Pod
metadata:
  name: emptyvolumes-pod
spec:
  containers:
  - image: alpine
    imagePullPolicy: IfNotPresent
    name: myvolumes-container

    command: ['sh', '-c', 'echo Container 1 is Running ; sleep 3600']

    volumeMounts:
    - mountPath: /demo
      name: demo-volume
  volumes:
  - name: demo-volume
    emptyDir:
      medium: Memory    
```

19. Create the Pod using the following the command..

```bash
kubectl apply -f D:\PhotonUser\Desktop\emptyvolume.yml
```

**Output:**

```bash
pod/emptyvolumes-pod created
```

20. Enter the Pod. Enter commands as shown at # shell prompt.

```bash
kubectl exec myvolumes-pod -i -t -- /bin/sh

```

**Output:**

```
PS D:\PhotonUser\.oci> kubectl exec emptyvolumes-pod -i -t -- /bin/sh
/ #
/ # ls
bin    dev    home   media  opt    root   sbin   sys    usr
demo   etc    lib    mnt    proc   run    srv    tmp    var
/ # df -h
Filesystem                Size      Used Available Use% Mounted on
overlay                  38.4G      3.4G     34.9G   9% /
tmpfs                    64.0M         0     64.0M   0% /dev
tmpfs                     3.3G         0      3.3G   0% /sys/fs/cgroup
tmpfs                     3.3G         0      3.3G   0% /demo
/dev/sda3                38.4G      3.4G     34.9G   9% /dev/termination-log
/dev/sda3                38.4G      3.4G     34.9G   9% /etc/resolv.conf
/dev/sda3                38.4G      3.4G     34.9G   9% /etc/hostname
/dev/sda3                38.4G      3.4G     34.9G   9% /etc/hosts
shm                      64.0M         0     64.0M   0% /dev/shm
tmpfs                     3.3G     12.0K      3.3G   0% /run/secrets/kubernetes.io/serviceaccount
tmpfs                     3.3G         0      3.3G   0% /proc/acpi
tmpfs                    64.0M         0     64.0M   0% /proc/kcore
tmpfs                    64.0M         0     64.0M   0% /proc/keys
tmpfs                    64.0M         0     64.0M   0% /proc/timer_list
tmpfs                    64.0M         0     64.0M   0% /proc/sched_debug
tmpfs                     3.3G         0      3.3G   0% /proc/scsi
tmpfs                     3.3G         0      3.3G   0% /sys/firmware

/ # exit
```
* df ... displays how much disk space is available

* -h ... print sizes in human readable format ( otherwise it prints size in bytes - a long unreadable string )

* -h is the short version of --human-readable

* We note on last line that our emptyDir got mounted on tmpfs : RAM.

* The default size of a RAM-based emptyDir is half the RAM of the node it runs on. My tiny server has 1.8 GB RAM, so 900 MB is about right.

* Such massive RAM disks may be overkill for most Pods. There is functionality to specify a sizeLimit.

21. As you discovered, the sizeLimit parameter set for emptyDir volume could not be used for creating a volume with the size. Instead what it does it that eviction manager keeps monitoring the disk space used by pod emptyDir volume and it will evict pods when the usage exceeds the limit.

Enter the Pod and use the emptyDir.

``` bash

kubectl exec emptyvolumes-pod -i -t -- /bin/sh

```

``` bash

PS D:\PhotonUser\.oci> kubectl exec emptyvolumes-pod -i -t -- /bin/sh

```

**Output:**

``` bash

/ # dd if=/dev/urandom of=/demo/largefile bs=100M count=1
0+1 records in
0+1 records out
/ # df -h /demo
Filesystem                Size      Used Available Use% Mounted on
tmpfs                     3.3G     32.0M      3.2G   1% /demo

```

``` bash

/ # dd if=/dev/urandom of=/demo/largefile bs=100M count=2
```

**Output:**

``` bash

0+2 records in
0+2 records out
/ # df -h /demo
Filesystem                Size      Used Available Use% Mounted on
tmpfs                     3.3G     64.0M      3.2G   2% /demo
```

``` bash
/ # dd if=/dev/urandom of=/demo/largefile bs=10M count=10
```

**Output:**

``` bash
10+0 records in
10+0 records out
/ # df -h /demo
Filesystem                Size      Used Available Use% Mounted on
tmpfs                     3.3G    100.0M      3.2G   3% /demo

```

``` bash

/ # dd if=/dev/urandom of=/demo/largefile bs=10M count=20

```

**Output:**

``` bash
20+0 records in
20+0 records out
/ # df -h /demo
Filesystem                Size      Used Available Use% Mounted on
tmpfs                     3.3G    200.0M      3.1G   6% /demo
/ #
```

### HostPath


22. In this lab we mainly focus on **hostPath** type of Volume, later labs will show you different types of volumes.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/volume.png?st=2019-08-26T09%3A07%3A11Z&se=2022-08-27T09%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MTFRYesZtEMQvrl2LEAx56GL5kIIiJyDrzpHBPCug7Q%3D" alt="image-alt-text" >


23. A hostPath volume mounts a directory from the host node's filesystem into the pod. For instance, some cases for a hostPath are

 E.g. Running a Container that needs to access data like docker internals; use a hostPath of /var/lib/docker

To demonstrate Kubernetes Volumes , we will first create a deployment without any volumes, then exec into the pod, create a file using echo happy > /usr/src/happy.txt, exit the pod, delete the pod, wait for new pod to start running, exec into new pod ls -ltr /usr/src/happy.txt, file will not exist.
Then create a deployment with hostpath volume and node selector, do the same excercise as above and see that the file persists even when pod is deleted.

### Creating a Deployment without volume

1. Create a namespace with a name of devteam, enter the following command using git-bash terminal.

  E.g. kubectl create ns <namespace-name>

  ```bash
  kubectl create ns devteam
  ```

2. Save the following pod YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of pod, paste and save it in a file (e.g.withoutvolume-dep.yml). Please make sure "All Files" is selected for "Save as Type" option.

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: devteam
spec:
  replicas: 1
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

3. Create a deployment using this manifest file. Please provide the full path to the manifest file that was created in the step above. 

```bash
kubectl create -f <file path>
```

 ```bash
kubectl create -f /c/Users/PhotonUser/Desktop/withoutvolume-dep.yml 
```

4. list-out the pods, use the following command

```bash
kubectl -n devteam get po
```

```
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c5b5c6f7c-c5v7c   1/1     Running   0          67m
```

5. Exec into the pod using the following command. Use the name of the pod you created above.

**Note:** if you are using gitbash window use prefix `winpty`.

```bash
winpty kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-c5v7c bash
```
**Note** If you are get connection error, please switch to PowerShell application on the remote desktop and execute the above commands. In PowerShell, winpty prefix is not required.

```bash
kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-c5v7c bash
```

6. Add data into a pod. This will store the data within the container.
E.g. `echo happy > /usr/bin/happy.txt`
```
root@nginx-deployment-c5b5c6f7c-c5v7c:/# echo happy > /usr/bin/happy.txt
root@nginx-deployment-c5b5c6f7c-c5v7c:/# cat /usr/bin/happy.txt
happy
root@nginx-deployment-c5b5c6f7c-c5v7c:/# exit
exit
```
7. Now delete the pod and verify the data shouldn't persists in the new pod.

```bash
kubectl -n devteam delete po nginx-deployment-c5b5c6f7c-c5v7c
```
```
pod "nginx-deployment-c5b5c6f7c-c5v7c" deleted
```
8. Since deployment is created with Replicas set to 1, deployment will create a new pod to reach the desire state. Get the newly created pod information using the following command.

```
kubectl -n devteam get po
```
9. Get exec into a newly created pod , use the following command

```bash
winpty kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-kspvw bash
```
10. Now try to retrieve the file and its contents that was previously created in Step 6. You will notice that the file no longer exists and is deleted. If this file had any configuration or data that you need to persist, at this time you have lost it!

```
root@nginx-deployment-c5b5c6f7c-kspvw:/# cat /usr/bin/happy.txt
cat: /usr/bin/happy.txt: No such file or directory
root@nginx-deployment-c5b5c6f7c-kspvw:/# exit
```
* Type `exit` to exit out of the container

### Create a Deployment with Volume

1. Create a deployment with hostpath volume and node selector, do the same excercise as above and see that the file persists even when pod is deleted.

* To check the labels of nodes use the following command. Take the lables of the node as key (kubernetes.io/hostname=aks-agentpool-34239105-0) value

```bash
kubectl get nodes --show-labels
```
**Output:**
```
NAME                       STATUS   ROLES   AGE     VERSION   LABELS
aks-agentpool-34239105-0   Ready    agent   9m14s   v1.14.8   agentpool=agentpool,beta.kubernetes.io/arch=amd64,beta.kub
ernetes.io/instance-type=Standard_DS1_v2,beta.kubernetes.io/os=linux,failure-domain.beta.kubernetes.io/region=westus2,fa
ilure-domain.beta.kubernetes.io/zone=0,kubernetes.azure.com/cluster=MC_sidda1074b11e-rg_aks-clusterb11e_westus2,kubernet
es.azure.com/role=agent,kubernetes.io/arch=amd64,kubernetes.io/hostname=aks-agentpool-34239105-0,kubernetes.io/os=linux,
kubernetes.io/role=agent,node-role.kubernetes.io/agent=,storageprofile=managed,storagetier=Premium_LRS
```

2. Open a notepad & copy, paste configuration of pod below. Edit the deployment name to ***nginx-deployment2*** & nodeSelector IP address to one of the IP address of your Kubernetes Cluster and save it in a file (e.g.withvolume-dep.yml). Please make sure "All Files" is selected for "Save as Type" option.

``` Yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hostpath-deployment
  namespace: devteam
spec:
  replicas: 1
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
        volumeMounts:
        - mountPath: /usr/src
          name: testpersistence
      nodeSelector:
        kubernetes.io/hostname: aks-agentpool-34239105-0  # change this your node's ip, volume will be created on this node
      volumes:
      - hostPath:
          path: /usr/src
          type: ""
        name: testpersistence
```

3. Choose the correct path of configuration yaml file, while deploying into the cluster. This should create a new deployment with name 'nginx-deployment2'

```bash
kubectl create -f <file path>
```

```bash
 kubectl create -f /c/Users/PhotonUser/Desktop/withvolume-dep.yml 
```

4. Use **Powershell**, Exec into the pod using the following command

```powershell
 kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-c5v7c bash # Make sure replace pod with yours
```
5. Add data into a pod E.g. `echo happy > /usr/src/happy.txt`
```
root@nginx-deployment-c5b5c6f7c-c5v7c:/# echo happy > /usr/src/happy.txt
root@nginx-deployment-c5b5c6f7c-c5v7c:/# cat /usr/src/happy.txt
happy
root@nginx-deployment-c5b5c6f7c-c5v7c:/# exit
exit
```
6. Now delete the pod and verify the data should persists in the new pod.

```bash
kubectl -n devteam delete po nginx-deployment-c5b5c6f7c-c5v7c 
```
```
pod "nginx-deployment-c5b5c6f7c-c5v7c" deleted
```
7. Get the newly created pod using the following command. inspect using `-o wide` at end the command to see pod scheduled on node, which is specified in the deployment configuration yaml.

```
kubectl -n devteam get po -o wide 
```
```
NAME                                READY   STATUS    RESTARTS   AGE   IP             NODE          NOMINATED NODE
nginx-deployment-6bf5f6c79d-zmsnk   1/1     Running   0          14s   10.244.3.199   aks-agentpool-34239105-0 <none>
```

8. Use **Powershell**, Get exec into a newly created pod , use the following command

```bash
kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-kspvw bash
```
9. Observe the file created persisted to the new pod 

```
root@nginx-deployment-c5b5c6f7c-kspvw:/# cat /usr/src/happy.txt
happy
root@nginx-deployment-c5b5c6f7c-kspvw:/#
```


## Exercises

1. Create a nginx deployment without a volume, create a directory inside a pod and delete a pod, data shouldn't persist on newly created pod.

<details><summary>show</summary>
<p>

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
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

```bash
kubectl get po
kubectl exec -it nginx-deployment-6bf5f6c79d-5l8sp bash
root@nginx-deployment-6bf5f6c79d-5l8sp:/# echo helloworld > usr/src/hello.txt
root@nginx-deployment-6bf5f6c79d-5l8sp:/# cat usr/src/hello.txt
helloworld
```
```
kubectl delete po nginx-deployment-6bf5f6c79d-5l8sp
```

```
kubectl get po
```

```
kubectl exec -it nginx-deployment-6bf5f6c79d-5l8sp bash
```
```
root@nginx-deployment-c5b5c6f7c-kspvw:/# echo helloworld > usr/src/hello.txt
cat: usr/src/hello.txt: No such file or directory
root@nginx-deployment-c5b5c6f7c-kspvw:/#
```
</p>
</details>

2. Create a nginx deployment with a volume type hostpath, select using nodeSelector to available data on node, create a directory inside a pod and delete a pod, data should persist on newly created pod.

<details><summary>show</summary>
<p>

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
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
        volumeMounts:
        - mountPath: /usr/src
          name: testpersistence
      nodeSelector:
        kubernetes.io/hostname: 10.0.0.2  # change this your node's ip, volume will be created on this node
      volumes:
      - hostPath:
          path: /usr/src
          type: ""
        name: testpersistence
```

```bash
kubectl get po
kubectl exec -it nginx-deployment-6bf5f6c79d-5l8sp bash
root@nginx-deployment-6bf5f6c79d-5l8sp:/# echo helloworld > usr/src/hello.txt
root@nginx-deployment-6bf5f6c79d-5l8sp:/# cat usr/src/hello.txt
helloworld
```

```
kubectl delete po nginx-deployment-6bf5f6c79d-5l8sp
```

```
kubectl get po
```
```
kubectl exec -it nginx-deployment-6bf5f6c79d-5l8sp bash
```
```
root@nginx-deployment-c5b5c6f7c-kspvw:/# echo helloworld > usr/src/hello.txt
helloworld
root@nginx-deployment-c5b5c6f7c-kspvw:/#
```
</p>
</details>


 **Conclusion:** Congratulations! You have successfully completed the Kubernetes Volumes lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!

## Appendix

### References

1. [https://www.alibabacloud.com/blog/kubernetes-volume-basics-emptydir-and-persistentvolume_594834](https://www.alibabacloud.com/blog/kubernetes-volume-basics-emptydir-and-persistentvolume_594834)
