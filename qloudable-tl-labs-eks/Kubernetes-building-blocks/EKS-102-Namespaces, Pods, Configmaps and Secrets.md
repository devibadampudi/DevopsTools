# Namespaces, Pods, Configmaps and Secrets

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Namespaces](#Namespaces)

[Pods](#pods)

[ConfigMaps](#configmaps)

[Secrets](#Secrets)

[Exercises](#exercises)

[Appendix](#appendix)

## Overview

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up fundamental Kubernetes objects -- Namespaces, Pods, ConfigMaps, and Secrets. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Management console, then move into actually creating, editing, and managing objects as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll have learned how to create, update, describe, edit, and delete Kubernetes objects like Namespaces, Pods, ConfigMaps, and Secrets.

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

## Namespaces 

In Kubernetes, a **namespace** is used to categorize objects in a cluster. Namespaces can be used to segregate your cluster for multiple dev teams for discrete purposes (e.g. dev, staging, and prod). A 'namespace' to Kubernetes is as a 'directory' is to a filesystem. It provides isolation for a set of container applications. There are three different namespaces that are created by default, which you can verify by using the following command to show the default namespaces in the cluster.

```bash
kubectl get ns
```

**Output:**

  ```bash
    NAME            STATUS    AGE
    default         Active    154d
    kube-public     Active    154d
    kube-system     Active    154d 
  ```
  
**default:** By default a Kubernetes cluster will instantiate a default namespace when provisioning the cluster to hold the default set of Pods, Services, and Deployments used by the cluster. If you do not specify namespace name kubernetes resources will be deployed into default namespace.

**kube-system:** The 'kube-system' namespace is for objects generated by the Kubernetes. Usually this has pods (containerized applications) like `kube-dns`, `kube-proxy`, `kubernetes-dashboard`. The following command will show all the pods in a namespace. It is recommended not to disturb any of the setup in this namespace.
  
  ```bash
  kubectl -n kube-system get pods
  ```
  
**kube-public**: the kube-public namespace is automatically created with the cluster (just like 'default' and 'kube-system'). This content is accessible for public unauthenticated users and is mainly used for system containers.
  
### Create the Namespace

1. To create a namespace in the cluster, use the following command:
 
```bash
 kubectl create ns devteam
```

**Note:** Here, 'devteam' is the name of the namespace.

**Output:**

  ```bash
  namespace/devteam created
  ```

2. Namespace can also be created using a manifest file. Click on Apps icon select a `Notepad`, create a new file with a file name, copy and paste the below configuration, save the file with a name `devteam-namespace.yml` on your app-stream desktop, please make sure "YAML" is selected for the `Save as Type` option, as shown in the screenshot below.

```yaml
  apiVersion: v1
  kind: Namespace
  metadata:
    name: devteam-namespace
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/ns.png?st=2020-03-05T06%3A33%3A03Z&se=2021-03-06T06%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=daRaXbvkSAUMqD3hc31IpigOcGUfmm9EFmN0230yTGM%3D" alt="image-alt-text">
  
 * Create a Namespace by using `kubectl` command line-tool.
   
 ```bash
   kubectl create -f <path-to-file>
 ```
  * Go to that path by running below commands

  ```
  cd ../..

  cd /Users/PhotonUser/Desktop/

  ```
* To list the downloaded file enter `ls` command.

* Specify the correct file name while deploying the manifest yaml file into the cluster.
  
  ```bash
  kubectl create -f devteam-namespace.yml
  
  ```
**Output:** 
  
  ```
  namespace/devteam-namespace created
  ```
 
3. Check it by using `kubectl get ns` to list out the all namespaces in a cluster. 
 
 ```bash
  kubectl get ns
 ```
 **Output:** 
 ```
 NAME                STATUS   AGE
default             Active   45m
devteam             Active   3m33s
devteam-namespace   Active   20s
kube-public         Active   45m
kube-system         Active   45m 
  ```
### Delete the Namespace

1. To delete the namespace, use the following command. **Please note that this is irreversible**. All objects within the namespace will be deleted.

  * Let's delete the second namespace that was created : `devteam-namespace`

2. You can leave the first namespace, 'devteam', so that we can use it in the next sections.

```bash
  kubectl delete ns devteam-namespace
```

**Output:**

```  
  namespace "devteam-namespace" deleted
```

## Pods

**Pods exist in a namespace in the cluster.**

A **Pod** is a collection of application containers running on the same node. Pods, not containers, are the smallest deployable artifacts in a Kubernetes cluster, which means all of the containers will be deployed on the same node (usually there is only one container per pod). Pods are faster to start, can self heal, are easy to scale & update when compared to virtual machines ("VMs"). Usually, containers are tasked with one job (e.g. as a http server, as a database, as a proxy).

### Create a Pod

1. Pod manifests can be written using YAML or JSON, but YAML is usually preferred because it is easier to edit, and comments can be added where necessary. In our labs we will use YAML files, which are text files with extensions .yml or .yaml.

2. Pod manifests include a few key fields and attributes. Below, YAML is used to create the pod.

Those key fileds and attributes include:

   * The metadata section for describing the pod's name and its namespace.
   * A spec section for describing volumes, images, container port, imagepullsecrets and much more. 
   * A list of containers that will run in the Pod.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/pod.png?st=2019-08-26T08%3A22%3A53Z&se=2022-08-27T08%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=O9UjF8Vg%2F4k78Jb7SlJ1ICiTkUSV1lCYSLBwlIIflT0%3D" alt="image-alt-text" >

3. Save the following pod YAML file with a filename extension (e.g. '.yml'), open a Notepad copy configuration of the pod, then paste and save it in a file (e.g. 'devteam-pod.yml'). Please make sure "All Files" is selected for the "Save as Type" option.

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: http-service
  namespace: devteam
  labels:
    run: my-nginx
spec:
  containers:
  - name: my-nginx
    image: nginx
    ports:
    - containerPort: 80
```

4. Choose the correct path of configuration for the yaml file, while deploys into the cluster.

```bash
kubectl create -f <file path>
```

 ```bash
 kubectl create -f /c/Users/PhotonUser/Desktop/devteam-pod.yml
  ```
 * This is a simple pod that deploys an nginx image of the latest version and exposes port 80. This pod is created in the devteam namespace with the podname 'http-service' and container name 'my-nginx'.

5. The pod manifest will be submitted to the Kubernetes API server.

6. The Kubernetes system will then schedule that pod to run on a healthy node in the cluster, where it will be monitored by the kubelet daemon process.

### Get the Pods

1. List out the pods running in a namespace, by using the following command;

  E.g: `kubectl -n <namespace-name> get pods`

  `kubectl -n devteam get pods`
  
  **Output:**
  
  ```
  NAME      READY     STATUS    RESTARTS   AGE
  http-service   1/1       Running   0          4m
  ```

2. You can see the name of pod ('http-service') that was provided in the previous YAML file. In addition to the number of ready containers, the output also shows the status, the number of times the pod was restarted, as well as the age of the pod.

### Describe the Pod Details

1. To find out additional details about the pod, use the following command. This will provide additional information about the pod IP address as well as the node IP address that the pod runs on.

 ```bash
 kubectl -n devteam get po http-service -o wide
```

**Output:**

```
 NAME           READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE
http-service   1/1     Running   0          7m35s   10.244.2.2   10.0.2.2   <none>
```

2. To find out more information about a pod (or any Kubernetes object), use the **kubectl describe** command:

  ```bash
  kubectl -n devteam describe po http-service
 ```
 **Output:** 
 ``` 
  Name:         http-service
Namespace:    devteam
Priority:     0
Node:         10.0.2.2/10.0.2.2
Start Time:   Thu, 12 Sep 2019 07:43:03 +0000
Labels:       run=my-nginx
Annotations:  <none>
Status:       Running
IP:           10.244.2.2
Containers:
  my-nginx:
    Container ID:   docker://03fa7b3bbdd80b9fb2ce673274bf65c02573053773011622168de3a078686106
    Image:          nginx:1.7.9
    Image ID:       docker-pullable://nginx@sha256:e3456c851a152494c3e4ff5fcc26f240206abac0c9d794affb40e0714846c451
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 12 Sep 2019 07:43:18 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-m6tkj (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-m6tkj:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-m6tkj
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  4m47s  default-scheduler  Successfully assigned devteam/http-service to 10.0.2.2
  Normal  Pulling    4m46s  kubelet, 10.0.2.2  pulling image "nginx:1.7.9"
  Normal  Pulled     4m33s  kubelet, 10.0.2.2  Successfully pulled image "nginx:1.7.9"
  Normal  Created    4m32s  kubelet, 10.0.2.2  Created container
  Normal  Started    4m32s  kubelet, 10.0.2.2  Started container
 ```
 
 * If any error occurs during the creation of the pod you should see errors in `Events` section of the above description of pod, you will use this to debug pod later.
 
  
### Running Commands in a Container with exec

1. Execute the commands in the conditions of container itself. Get an interactive session by adding the `-it` flag.

**Note** If you are using gitbash, use `winpty` infront of kubectl command

```bash
kubectl -n devteam exec -it http-service bash
Unable to use a TTY - input is not a terminal or the right kind of file
```

```
winpty kubectl -n devteam exec -it http-service bash

root@http-service:/#
```

2. If you want to install packages or resources like (e.g. curl) inside a pod, use the following commands. 

```bash
root@testpod:/# apt-get update
```
```bash
root@testpod:/# apt-get install curl
```
```bash
root@testpod:/# curl localhost:80
```
  
  * You should see the following output, if nginx is running.
  
**Output:**  

```
  root@http-service:/# curl localhost:80
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
  
* Type `exit` to getout of the pod and recover the command-line

```bash
  root@testpod:/# exit
```
  
 ### Logs of the pod
 
1. Switch to anoter powershell window access the nginx logs by using the following command. Kubectl logs command downloads the current logs from the running instance. Adding `-f` flag will allow to continuously stream logs.

  `kubectl -n devteam logs -f http-service`
  
 <img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/p2.PNG?st=2019-10-24T11%3A06%3A13Z&se=2022-10-25T11%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jMda1tSIhy4sihKcAG14bPG0JOXl8ZmIdwzPIUEOjSw%3D" alt="image-alt-text" >
  
2. In the first powershell window (make sure you are still inside the pod, if not  run `kubectl -n devteam exec -it http-service bash`) `curl localhost:80` watch log lines have been added to second powershell window.

 ```bash
 kubectl -n devteam logs -f http-service
 ```
 
```
127.0.0.1 - - [12/Sep/2019:14:26:25 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.64.0" "-"
```
**Note:** type `CTRL+C` to stop pod logs.


3. If you want to see the logs without tailing, you can run the same command without -f option

```bash
kubectl -n devteam logs http-service
 ```
 **Output:**
```
127.0.0.1 - - [12/Sep/2019:18:27:55 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.64.0" "-"
127.0.0.1 - - [12/Sep/2019:18:29:45 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.64.0" "-"
127.0.0.1 - - [12/Sep/2019:18:29:49 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.64.0" "-"
```

### Edit the Pod

1. Switch to powershell to use this feature. Edit a pod using command shown below, this will popup a notepad window with the pod configuration in yaml, if any additions to pod file add to here. If any changes made, this pod will restart. 


```bash
  kubectl -n devteam edit po http-service
```
<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/p1.PNG?st=2019-10-24T11%3A04%3A34Z&se=2022-10-25T11%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=czZyn6zZEtrI1OqGexHX1%2BJBEpZHBpBlm31ISSva96Q%3D" alt="image-alt-text" >

**Output:**

```
  Edit cancelled, no changes made
```
 2. To see this in action, change the image version to nginx:1.17. Save and close the file. This should automatically update the pod in your powershell window

  ```yaml
  containers:
  - image: nginx:1.17
  ```
 ```
 pod/http-service edited 
 
 ```
 Note: Most of the fields in the yml file are not editable. Deployments objects is a better and standard way to manage pods. This will be described in later labs.
 
 3. Run describe command again to see the changes in the pod configuration. You see the Image changed to nginx:1.17 and Restart count incremented by 1. 
 
 ```
 kubectl -n devteam describe po http-service
 
 ```
 **Output:**
 ```
 Containers:
  my-nginx:
    Container ID:   docker://9bb7b42f9111d65b08975dd772c4ed6fbda7ba82ab8698010a5f83771386a493
    Image:          nginx:1.17
    Image ID:       docker-pullable://nginx@sha256:74a15d1f452533d4eec9a6e8efc2180f5ca8ce38421567006df3aab849550a4c
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 12 Sep 2019 18:41:09 +0000
    Last State:     Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Thu, 12 Sep 2019 18:17:58 +0000
      Finished:     Thu, 12 Sep 2019 18:41:08 +0000
    Ready:          True
    Restart Count:  1
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-dxhq6 (ro)
```
 
 
### Delete the Pod

* To delete a pod, can delete it either by name or same file used to create it.

* When a Pod is deleted, it is not immediately killed. Instead, if run kubectl get pods, will see that the Pod is in the Terminating state.

```bash
kubectl -n devteam delete po http-service
```

**Output:**

```
  pod "http-service" deleted`
```
* To terminate a pod immediately use options `--grace-period=0 --force`

## ConfigMaps

ConfigMaps are used to provide configuration information (like environment variables) for containarized workloads, it is a Kubernetes object that defines small filesystem. These variables can also be set from command line.
 
The basic thing is that the ConfigMap is combined with the Pod right before it is run, which means that the container image and the pod definition itself can be reused across many apps by just changing the ConfigMap that is used.

### Create a ConfigMaps

1. There are three main ways to use configMaps:

  **Filesystem:**
      Can mount into a pod. A file is created for each entry based on the key name. The content of the file is set to value.
      
  **Environment variable:**
      ConfigMap can be used to dynamically set the value of an Environment variable.
      
  **Command-line argument:**
      Kubernetes supports dynamically creating the command line for a container based on ConfigMap values.

2. Create a configMap with a filename `test-cm.yml`, by using a following command.

  `kubectl -n devteam apply -f /c/Users/PhotonUser/Desktop/test-cm.yml`

  ``` yaml
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: test-cm
  data:
    # Configuration values can be set as key-value properties
    database: mongodb
    database_uri: mongodb://localhost:27017
    
    # Or set as complete file contents (even JSON!)
    keys: | 
      image.public.key=771 
      rsa.public.key=42
  ```
### Get the ConfigMaps

  `kubectl -n devteam get cm`
  
  **Output:**
  
  ```
  NAME             DATA      AGE
  test-cm          3         23s
  ```

### Describe the Configmap

  ```bash
  kubectl -n devteam  describe cm test-cm
 ```
 **Output:**
  ```
  Name:         test-cm
  Namespace:    devteam
  Labels:       <none>
  Annotations:  kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","data":{"database":"mongodb","database_uri":"mongodb://localhost:27017","keys":"image.public.key=771 \nrsa.public.key=42\n"},"kind":...

  Data
  ====
  keys:
  ----
  image.public.key=771
  rsa.public.key=42

  database:
  ----
  mongodb
  database_uri:
  ----
  mongodb://localhost:27017
  Events:  <none>

  ```

### Access the ConfigMaps from pods

1. Create a pod with a filename `env-pod.yml`, to pull environmental variables from the Configmaps.

2. Environmental variables are mentioned with a envFrom member. This references the ConfigMap and the data key to use within that ConfigMap.

3. Use the following command to create a pod:

  `kubectl -n devteam apply -f /c/Users/PhotonUser/Desktop/env-pod.yml`

  ```  yaml
    apiVersion: v1
    kind: Pod 
    metadata:
      name: env-pod 
    spec:
      containers: 
        - envFrom:
          - configMapRef:
              name: test-cm
          name: test-container
          image: nginx 
          imagePullPolicy: Always
          ports:
          - containerPort: 80    
  ```
4. After creating the pod, you will be able to access these environment variables, by using the following command:

**Note**: If you are using Git-Bash use `winpty` in front of the kubectl command.

  `winpty kubectl -n devteam exec -it env-pod  sh`
  
  **Output:**
  
  ```
  # env
  KUBERNETES_PORT=tcp://10.96.0.1:443
  KUBERNETES_SERVICE_PORT=443
  database=mongodb
  HOSTNAME=sample-pod
  database_uri=mongodb://localhost:27017
  HOME=/root
  keys=image.public.key=771
  rsa.public.key=42

  TERM=xterm
  KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
  NGINX_VERSION=1.15.12-1~stretch
  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  KUBERNETES_PORT_443_TCP_PORT=443
  NJS_VERSION=1.15.12.0.3.1-1~stretch
  KUBERNETES_PORT_443_TCP_PROTO=tcp
  KUBERNETES_SERVICE_PORT_HTTPS=443
  KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
  KUBERNETES_SERVICE_HOST=10.96.0.1
  PWD=/
  ```

### Edit the ConfigMap

 ```bash
  kubectl -n devteam edit cm test-cm
 ```
 
### Delete the ConfigMap
 
 ```bash
  kubectl -n devteam delete cm test-cm
 ```
 
 **Output:**
 
 ```
 configmap "test-cm" deleted
 ```

## Secrets

* Secrets are  objects in Kubernetes, that contain sensitive information such as credentials and tokens. They are stored in `etcd`. These are accessible by the Kubernetes API server, and it can be mounted as files into a pod. The same secret can be mounted into multiple pods.
* Another perspective is to use a secret as an environmental variable. Secrets in a pod are always stored in memory (tmfs-temporary file storage).
* Secrets are created using the Kubernetes API or the kubectl command-line tool. Secrets hold one or more data elements as a collection of key/value pairs.

### Create a Secret

There are different ways to create secrets in Kubernetes. Use any one of the following ways:

1. Create local files using `kubectl` tool.

2. Create by using a manifest file of `kind:secret`.
    
### Create the Secrets from Files using Kubectl

1. Create local files with sensitive information like passwords and ssh keys and then convert them into a Secret stored and managed by the Kubernetes API server. Kubernetes will create key-value pairs using the filenames and their contents and encode the sensitive data in `base64` format.

2. Create the files with the username and password, Run the following commands step-by-step

* Create a directory using the following command

```bash
  mkdir k8s-secrets
```
 * Change to the directory using the following command
 
 ```bash
  cd k8s-secrets
```
* Create a username and send output to a file

```bash
  echo -n 'test' > ./username.txt
```
 * Create a Password and send output to a file
 
```bash
  echo -n 'jiki893kdjnsaasdsa' > ./password.txt
```

* Create the secret using the command below, to package files into a Secret and create a Secret API object on the API server. Choose the correct path

```bash
  kubectl -n devteam create secret generic db --from-file=c:/Users/PhotonUser/Documents/k8s-secrets/username.txt --from-file=c:/Users/PhotonUser/Documents/k8s-secrets/password.txt
```

**Note** Here `db` is the secret name

**Output:**
```
  secret "db" created
```

### Get the Secrets

1. Verify it by using the following command to get the secrets created:

```bash
 kubectl get secrets -n devteam
```

**Output:** 
```
    NAME                  TYPE                                  DATA      AGE
    db                    Opaque                                2         1m
```  
### Describe the Secrets

1. Describe will shows you detailed information about the seceret, use the following command

```bash
  kubectl describe secrets db -n devteam
``` 
 
**Output:**
```
  Name:         db-auth
  Namespace:    default
  Labels:       <none>
  Annotations:  <none>
  Type:  Opaque
  Data
  ====
  password.txt:  15 bytes
  username.txt:  5 bytes
```
2. The `type:Opaque` refers to the Secret means that from Kubernetes point of view the contents of the Secret is unstructured.

### Edit the Secrets

1. Switch to powershell & edit the secrets by using a following command. Notepad will popup the secrets file to edit any changes.

```bash
  kubectl edit secrets db -n devteam
```

### Using Secrets as Environmental Variables

Environmental variables offer a convenient way for exposing some arbitrary data to your application without overcrowding the execution context. Environmental variables can be used for storing Secret keys as well. We can store Secrets in environmental variables using the `spec.containers.env`  field with a set of name-values in it.

* Create a Secrets using a secret spec. We need to convert the username and password data into base64 format encoding manually, use the following commands

```
echo -n admin | base64
YWRtaW4NCg==
echo -n password1 | base64
cGFzc3dvcmQxDQo=
```

* Now, we can safely use the base64-encoded credentials in the Secret spec

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: test-secret
type: Opaque
data:
  username: YWRtaW4NCg==
  password: cGFzc3dvcmQxDQo=
```
* Save this spec in the test-secret.yaml  file, and create the Secret by running the following command.

```
kubectl -n devteam create -f test-secret.yaml
```

```
secret "test-secret" created
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-secret
spec:
  containers:
  - name: db
    image: nginx
    env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: test-secret
            key: username
      - name: SECRET_PASSWORD
        valueFrom:
          secretKeyRef:
            name: test-secret
            key: password
  restartPolicy: Never
```

* Let's save the pod configuration with secrets using the following command.

```bash
kubectl -n devteam create -f pod-secret.yaml
```

**Output:**

```
pod "secret-env" created
```

* Get a shell to the running container:

```
kubectl -n devteam exec -it pod-secret bash
```

* Once inside the container, run the following the following command to access env variables. 

```
echo $SECRET_USERNAME
admin
echo $SECRET_PASSWORD
password1
```

### Get the Secrets

1. Verify it by using the following command to get the secrets created:

  `kubectl get secrets -n devteam`
  
**Output:**  

```
    NAME                  TYPE                                  DATA      AGE
    db                    Opaque                                2         1m
    test-secret           Opaque                                2         5m

```  

### Describe the Secrets

1. Describe will shows you detailed information about the seceret, use `kubectl describe`.

  `kubectl describe secrets db -n devteam`
  
  **Output:**
  
  ```
  Name:         db-auth
  Namespace:    default
  Labels:       <none>
  Annotations:  <none>
  Type:  Opaque
  Data
  ====
  password.txt:  15 bytes
  username.txt:  5 bytes
  ```
2. The `type:Opaque` refers to the Secret means that from Kubernetes point of view the contents of the Secret is unstructured.

### Edit the Secrets

1. Switch to powershell & edit the secrets by using a following command. Notepad will popup the secrets file to edit any changes. 

  `kubectl edit secrets <secretname> -n <namespace-name>`
  
  `kubectl edit secrets db -n devteam`

## Exercises

**Note**: Use **Powershell** to run the following excercises.

1. Create a namespace called 'test' and a pod with image nginx called 'nginx' in this namespace.

<details><summary>show</summary>
<p>

```bash
kubectl create namespace test
kubectl run nginx --image=nginx --restart=Never -n test
```
```pod/nginx created
```
</p>
</details>

2. Get the YAML for a new namespace called 'myns' without creating it

<details><summary>show</summary>
<p>

```bash
kubectl create namespace myns -o yaml --dry-run
```
```
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: myns
spec: {}
status: {}
```
</p>
</details>

3. Get pods in all namespaces

<details><summary>show</summary>
<p>

```bash
kubectl get po --all-namespaces
```
```
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE
kube-system   kube-dns-6fb9dcb8bf-4blm2               3/3     Running            0          43m
kube-system   kube-dns-6fb9dcb8bf-s5xrc               3/3     Running            0          43m
kube-system   kube-dns-6fb9dcb8bf-zcj8k               3/3     Running            0          54m
kube-system   kube-dns-autoscaler-656d6f6b8f-ln2c7    1/1     Running            0          54m
kube-system   kube-flannel-ds-dw2tg                   1/1     Running            1          44m
kube-system   kube-flannel-ds-fnvnb                   1/1     Running            1          44m
kube-system   kube-flannel-ds-q5n7s                   1/1     Running            1          44m
kube-system   kube-proxy-6p5d8                        1/1     Running            0          44m
kube-system   kube-proxy-j825h                        1/1     Running            0          44m
kube-system   kube-proxy-m8w2h                        1/1     Running            0          44m
kube-system   kubernetes-dashboard-85b859ccbb-b4x4v   1/1     Running            0          54m
kube-system   proxymux-client-10.0.0.2                1/1     Running            0          44m
kube-system   proxymux-client-10.0.1.2                1/1     Running            0          44m
kube-system   proxymux-client-10.0.2.2                1/1     Running            0          44m
kube-system   tiller-deploy-745d8748cc-zr76b          1/1     Running            0          54m
test          nginx                                   1/1     Running            0          11m
```
</p>
</details>

4. Create a pod with image nginx called nginx and allow traffic on port 80

<details><summary>show</summary>
<p>

```bash
kubectl run nginx --image=nginx --restart=Never --port=80
```

</p>
</details>

5. Change pod's image to nginx:1.7.1. Observe that the pod will be killed and recreated as soon as the image gets pulled

<details><summary>show</summary>
<p>

```bash
# E.g. kubectl set image POD/POD_NAME CONTAINER_NAME=IMAGE_NAME:TAG
kubectl set image pod/nginx nginx=nginx:1.7.1
kubectl describe po nginx # you will see an event 'Container will be killed and recreated'
kubectl get po nginx -w # watch it
```
```
pod/nginx image updated
```
*Note*: you can check pod's image by running, if doesn't work this command in powershell, use **gitbash** terminal

```bash
kubectl get po nginx -o jsonpath='{.spec.containers[].image}{"\n"}'
```

</p>
</details>

6. Get the pod's ip, use a temp busybox image to wget its '/'

<details><summary>show</summary>
<p>

```bash
kubectl -n test get po -o wide
```
```
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE
nginx   1/1     Running   0          31m   10.244.2.5   10.0.1.2   <none>
```

</p>
</details>

7. Get this pod's YAML without cluster specific information

<details><summary>show</summary>
<p>

```bash
kubectl get po nginx -o yaml --export
```

</p>
</details>

8. Get information about the pod, including details about potential issues (e.g. pod hasn't started)

<details><summary>show</summary>
<p>

```bash
kubectl -n test describe po nginx
```

</p>
</details>

9. Connect to the nginx pod

<details><summary>show</summary>
<p>

```bash
kubectl -n test exec -it nginx -- /bin/sh
```

</p>
</details>

10. Create a busybox pod that echoes 'hello world' and then exits

<details><summary>show</summary>
<p>

```bash
kubectl run busybox --image=busybox -it --restart=Never -- echo 'hello world'
# or
kubectl run busybox --image=busybox -it --restart=Never -- /bin/sh -c 'echo hello world'
```

</p>
</details>

11. Create an configmap using yaml template file

<details><summary>show</summary>
<p>
# see it

```YAML
kind: ConfigMap 
apiVersion: v1 
metadata:
  name: test-cm
data:
  # Configuration values can be set as key-value properties
  database: mongodb
  database_uri: mongodb://localhost:27017
  
  # Or set as complete file contents (even JSON!)
  keys: | 
    image.public.key=771 
    rsa.public.key=42
```
`kubectl -n test create -f testcm.yaml`

</p>
</details>

12. Create a sample pod, pod will fetch the configmap values

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
  kind: Pod 
  metadata:
    name: nginxpod 
  spec:
    containers: 
      - envFrom:
        - configMapRef:
            name: test-cm
        name: test-container
        image: nginx 
        imagePullPolicy: Always
        ports:
        - containerPort: 80 
    imagePullSecrets:
    - name: test
```
</p>
</details>

13. Access environment variables within a pod, access these Env variables in the pod

<details><summary>show</summary>
<p>

```bash
kubectl -n test exec -it nginxpod sh
env
```

</p>
</details>

14. Edit the configmap

<details><summary>show</summary>
<p>

```bash
kubectl -n test edit cm test-cm
```

</p>
</details>

15. Delete the configmap resources

<details><summary>show</summary>
<p>


```bash
kubectl -n test delete cm test-cm
```

</p>
</details>

16. Create secrets from the files, using kubectl command line

<details><summary>show</summary>
<p>

```bash
echo -n test > ./username.txt
echo -n jiki893kdjnsaasdsa > ./password.txt

kubectl -n test create secret generic db --from-file=/home/documents/username.txt --from-file=/home/documents/password.txt
```

</p>
</details>

17. Get the secrets from the namespace

<details><summary>show</summary>
<p>

```bash
kubectl get secrets -n test
```
</p>
</details>

18. Describe the secrets from the namespace

<details><summary>show</summary>
<p>

```bash
kubectl describe secrets db -n test
```
</p>
</details>

19. Edit the Secrets

<details><summary>show</summary>
<p>

```bash
kubectl edit secrets db -n test
```

</p>
</details>

20. Create the secrets for pod 

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod 
metadata:
  name: sample-pod 
spec:
  containers: 
    - envFrom:
      - configMapRef:
          name: test-cm
      name: test-container
      image: nginx
      imagePullPolicy: Always
      ports:
      - containerPort: 80 
    secret:
            defaultMode: 420
            secretName: db 
```
</p>
</details>

 **Conclusion:** Congratulations! You have successfully completed the Namespaces, Pods, Configmaps and Secrets ! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!

## Appendix 

### References

https://github.com/dgkanatsios/CKAD-exercises/blob/master/a.core_concepts.md
