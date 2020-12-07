# Volumes

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Volumes](#volumes)

[Exercises](#exercises)

## Overview

At its core, a Kubernetes Volume is just a directory, possibly with some data in it, which is accessible to the Containers in a Pod. Typically, on-disk files in a Container are ephemeral, which presents some problems for non-trivial applications when running in Containers. Kubernetes Volumes provide a persistent directory accessible to the containers within the pod, and are tied to the life cycle of the pod -- not the container. The data is preserved across container restarts, and is one of the key Kubernetes concepts to understand.

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up volumes. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Management console, then move into actually creating, editing, and managing volumes as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll have learned how to create, update, describe, edit, and delete Kubernetes objects like volumes.

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
Now that you are able to connect to your cluster successfully, let's start learning about Volumes!

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
kubectl exec emptyvolumes-pod -i -t -- /bin/sh
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
 kubectl exec emptyvolumes-pod -i -t -- /bin/sh
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

1. Create a namespace with a name of "devteam", enter the following command in Powershell.

```bash
  kubectl create ns devteam
```

2. Save the following pod YAML file with a  filename extension `<filename>.yml`, open a notepad copy configuration of pod, paste and save it in a file `withoutvolume-dep.yml`. Please make sure "All Files" is selected for "Save as Type" option.

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

4. List out the pods running in a namespace, by using the following command

```bash
kubectl -n devteam get po
```
**Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-c5b5c6f7c-c5v7c   1/1     Running   0          67m
```

5. `Exec` into the pod using the following command. Use the name of the pod you created above.

**Note:** If you are using gitbash window use prefix `winpty`.

```bash
winpty kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-c5v7c bash
```
**Note:** If you get connection error, please switch to PowerShell application on the remote desktop and execute the above commands. In PowerShell, winpty prefix is not required.

```bash
kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-c5v7c bash
```

6. Add data into a pod. This will store the data within the container.

``` bash
echo happy > /usr/bin/happy.txt`
```

```
root@nginx-deployment-c5b5c6f7c-c5v7c:/# echo happy > /usr/bin/happy.txt
```

```
root@nginx-deployment-c5b5c6f7c-c5v7c:/# cat /usr/bin/happy.txt
```

**Output:**

```
happy
```

* Type `exit` to get out of the container

```root@nginx-deployment-c5b5c6f7c-c5v7c:/# exit
```

7. Now delete the pod and verify the data shouldn't persists in the new pod.

```bash
kubectl -n devteam delete po nginx-deployment-c5b5c6f7c-c5v7c
```
**Output:**

```
pod "nginx-deployment-c5b5c6f7c-c5v7c" deleted
```
8. Since deployment is created with replica set as 1, deployment will create a new pod to reach the desire state. Get the newly created pod information using the following command.

```
kubectl -n devteam get po
```
9. To `exec` into a newly created pod , use the following command

```bash
winpty kubectl -n devteam exec -it <new-pod-id> bash
```
```bash
winpty kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-kspvw bash
```
10. Now try to retrieve the file and its contents that was previously created in Step 6. You will notice that the file no longer exists. If this file had any configuration or data that you need to persist, at this time you have lost it!

```
root@nginx-deployment-c5b5c6f7c-kspvw:/# cat /usr/bin/happy.txt
```

**Output:**
```
cat: /usr/bin/happy.txt: No such file or directory
```

* Type `exit` to exit out of the container

### Create a Deployment with Volume

1. Create a deployment with hostpath volume and node selector, do the same excercise as above and see that the file persists even when pod is deleted.

* Run the following command to get the nodes labels, choose one label key and value use it in yaml file,in this file we are copying the label `kubernetes.io/hostname : ip-10-0-1-82.ec2.internal` these are must changed everytime, update accordingly.

```bash
kubectl get nodes --show-labels
```
**Output:**
```
NAME                         STATUS   ROLES    AGE     VERSION               LABELS
ip-10-0-0-212.ec2.internal   Ready    <none>   9m14s   v1.13.10-eks-d6460e   beta.kubernetes.io/arch=amd64,beta.kubernet
es.io/instance-type=t3.small,beta.kubernetes.io/os=linux,failure-domain.beta.kubernetes.io/region=us-east-1,failure-doma
in.beta.kubernetes.io/zone=us-east-1a,kubernetes.io/hostname=ip-10-0-0-212.ec2.internal
ip-10-0-1-82.ec2.internal    Ready    <none>   9m12s   v1.13.10-eks-d6460e   beta.kubernetes.io/arch=amd64,beta.kubernet
es.io/instance-type=t3.small,beta.kubernetes.io/os=linux,failure-domain.beta.kubernetes.io/region=us-east-1,failure-doma
in.beta.kubernetes.io/zone=us-east-1b,kubernetes.io/hostname=ip-10-0-1-82.ec2.internal
```

2. Open a notepad, copy and paste below pod configuration. Edit the deployment name to ***nginx-deployment2*** & nodeSelector IP address to one of the IP address of your Kubernetes Cluster and save it in a file `withvolume-dep.yml`. Please make sure "All Files" is selected for "Save as Type" option.

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
        kubernetes.io/hostname: ip-10-0-1-82.ec2.internal  # change this your node's ip, volume will be created on this node
      volumes:
      - hostPath:
          path: /usr/src
          type: ""
        name: testpersistence
```

3. Choose the correct path of configuration yaml file, while deploying into the cluster. This should create a new deployment with name `nginx-deployment2`

```bash
kubectl create -f <file path>
```

```bash
 kubectl create -f /c/Users/PhotonUser/Desktop/withvolume-dep.yml 
```

4. Use **Powershell**, `exec` into the pod using the following command

```powershell
 kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-c5v7c bash # Make sure replace pod with yours
```
5. Add data into a pod. This will store the data in the volume that is mounted to the container 

**Output:**

```
root@nginx-deployment-c5b5c6f7c-c5v7c:/# echo happy > /usr/src/happy.txt
```

```
root@nginx-deployment-c5b5c6f7c-c5v7c:/# cat /usr/src/happy.txt
```

**Output:**

```
happy
```

```
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
7. Get the newly created pod using the following command. Inspect using `-o wide` at end the command to see pod scheduled on node, which is specified in the deployment configuration yaml.

```
kubectl -n devteam get po -o wide 
```
**Output:**

```
NAME                                READY   STATUS    RESTARTS   AGE   IP             NODE          NOMINATED NODE
nginx-deployment-6bf5f6c79d-zmsnk   1/1     Running   0          14s   10.244.3.199    ip-10-0-1-82.ec2.internal  <none>
```

8. Use **Powershell**, `exec` into newly created pod

```bash
kubectl -n devteam exec -it nginx-deployment-c5b5c6f7c-kspvw bash
```
9. Observe the file created persisted to the new pod 

```
root@nginx-deployment-c5b5c6f7c-kspvw:/# cat /usr/src/happy.txt
```

**Output:**

```
happy
```
* Type `exit` to exit out of the container.

```
root@nginx-deployment-c5b5c6f7c-kspvw:/#exit
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

