# Limit Range, Resource Quotas & Horizontal Pod Autoscaler

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Limit Range ](#limitRange )

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

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up fundamental Kubernetes objects -- Limit Range, Resource Quota & Horizontal Pod Autoscaler. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Management console, then move into actually creating, editing, and managing objects as you would in a real Kubernetes environment. There are also some helpful exercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll have learned how to create, update, describe, edit, delete a few Kubernetes objects like Limit Range, Resource Quota & Horizontal Pod Autoscaler.

## Pre-Requisites

None required

## Accessing the EKS cluster

### Sign in to AWS Management console

* Sign in using your Account ID, user name and password. Use the login option under **AWS Management console**

* Credentials will be provided here, copy these information and paste corresponding values in the AWS Management console.

* **AccountID:** {{Account_ID}}
* **UserName:** {{User_Name}}
* **Password:** {{Password}}
* **Region:** {{Region}}

* Mention account-id from the above information, then click on `Next`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in.png?st=2019-09-09T09%3A36%3A43Z&se=2022-09-10T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rkLZ0wwcYQdKbOea5VgPSlzS46FaE8u3plAwptI5nf4%3D" alt="image-alt-text" >

* Mention Username and password from the above information

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in-usrpass.png?st=2019-09-09T10%3A20%3A15Z&se=2022-09-10T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KrcF1fH7XzP9H5LPSqrcPgZV3TDNzB6%2FCv6wSxbXN0o%3D" alt="image-alt-text" >

* Once you were provided all those information correctly you will be able to see the AWS-managemnt console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >


* In the navigation bar, on the top-right, change region accordingly to provided in above.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

* Click Apps icon in the toolbar and select **PowerShell** to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-23T06%3A16%3A39Z&se=2022-10-24T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Gg0Ouxr68ThRowxFznGsXgXiaWWNOTj7kM7gXm34dGs%3D" alt="image-alt-text" >

* **Access_keyid:** {{Access_keyid}}

* **Access_secret:** {{Access_secret}}

* **Cluster-region:** {{Cluster-region}}

* **Output-format:** json

* Need to configure the AWS credentials for accessing the cluster run the command `aws configure` then enter the  specified credentials as you get previous step.

`aws configure` 

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

* We have initialized the environment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`$ kubectl get nodes`

**Output:**

```
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```
## Limit Range 

Assigning a memory request and a memory limit or a cpu request and a cpu limit to a container is called `LimitRange`.

A Container is guaranteed to have as much memory as it requests, but is not allowed to use more memory than its limit.

**Note:** Make sure you have the metrics server installed in your cluster before applying LimitRanges. 

### Installing Metric Server
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `cluster-role.yaml` and select All files, save it on the location.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: system:aggregated-metrics-reader
  labels:
    rbac.authorization.k8s.io/aggregate-to-view: "true"
    rbac.authorization.k8s.io/aggregate-to-edit: "true"
    rbac.authorization.k8s.io/aggregate-to-admin: "true"
rules:
- apiGroups: ["metrics.k8s.io"]
  resources: ["pods", "nodes"]
  verbs: ["get", "list", "watch"]
```


* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f cluster-role.yaml
```
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `cluster-rolebinding.yaml` and select All files, save it on the location.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: metrics-server:system:auth-delegator
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:auth-delegator
subjects:
- kind: ServiceAccount
  name: metrics-server
  namespace: kube-system
```

* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f cluster-rolebindings.yaml
```
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `rolebinding.yaml` and select All files, save it on the location.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: metrics-server-auth-reader
  namespace: kube-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: extension-apiserver-authentication-reader
subjects:
- kind: ServiceAccount
  name: metrics-server
  namespace: kube-system
```

* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f rolebinding.yaml
```
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `apiservice.yaml` and select All files, save it on the location.

```yaml
apiVersion: apiregistration.k8s.io/v1beta1
kind: APIService
metadata:
  name: v1beta1.metrics.k8s.io
spec:
  service:
    name: metrics-server
    namespace: kube-system
  group: metrics.k8s.io
  version: v1beta1
  insecureSkipTLSVerify: true
  groupPriorityMinimum: 100
  versionPriority: 100
```

* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f apiservice.yaml
```
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `deployment.yaml` and select All files, save it on the location.

```yaml
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    name: metrics-server
    namespace: kube-system
---
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: metrics-server
    namespace: kube-system
    labels:
      k8s-app: metrics-server
  spec:
    selector:
      matchLabels:
        k8s-app: metrics-server
    template:
      metadata:
        name: metrics-server
        labels:
          k8s-app: metrics-server
      spec:
        serviceAccountName: metrics-server
        volumes:
        # mount in tmp so we can safely use from-scratch images and/or read-only containers
        - name: tmp-dir
          emptyDir: {}
        containers:
        - name: metrics-server
          image: k8s.gcr.io/metrics-server-amd64:v0.3.6
          args:
            - --cert-dir=/tmp
            - --secure-port=4443
          command:
          - /metrics-server
          - --kubelet-insecure-tls
          - --kubelet-preferred-address-types=InternalIP
          ports:
          - name: main-port
            containerPort: 4443
            protocol: TCP
          securityContext:
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            runAsUser: 1000
          imagePullPolicy: IfNotPresent
          volumeMounts:
          - name: tmp-dir
            mountPath: /tmp
        nodeSelector:
          beta.kubernetes.io/os: linux
          kubernetes.io/arch: "amd64"
```
* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f deployment.yaml
```
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `service.yaml` and select All files, save it on the location.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: metrics-server
  namespace: kube-system
  labels:
    kubernetes.io/name: "Metrics-server"
    kubernetes.io/cluster-service: "true"
spec:
  selector:
    k8s-app: metrics-server
  ports:
  - port: 443
    protocol: TCP
    targetPort: main-port
```
* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f service.yaml
```
* Save the following manifest file consists of installation of metrics server, open a notepad copy & paste the below code save with a filename as `clusterroles-bindings.yaml` and select All files, save it on the location.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: system:metrics-server
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - nodes
  - nodes/stats
  - namespaces
  - configmaps
  verbs:
  - get
  - list
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: system:metrics-server
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:metrics-server
subjects:
- kind: ServiceAccount
  name: metrics-server
  namespace: kube-system
```

* Deploy the above manifest file into the cluster using the following command.

```
kubectl create -f clusterroles-bindings.yaml
```
### Create LimitRange

* Create a LimitRange to a namespace then all the pods that exists in that namespace will get applied by the LimitRange.

1. Create a namespace using the following command.

```bash
kubectl create ns devteam
```
**Output:**

```
namespace 'devteam' created
```

2. Create and apply the below limitrange configuration to the namespace.

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
3. Use the following command to deploy a limit range resource to the cluster.

```bash
 kubectl create -f limitranage.yaml
```
**Output:**

```
limitrange/cpu-memory created
```
4. Get the limit range resource as you deploys on previous step.

```
kubectl -n devteam get limitrange
```
**Output:**

```
NAME         CREATED AT
cpu-memory   2019-09-15T11:44:35Z
```

5. Describe the limit range resource using the following command.

```bash
kubectl -n devteam describe limitrange cpu-memory
```
**Output:**

```
Name:       cpu-memory
Namespace:  devteam
Type        Resource  Min  Max  Default Request  Default Limit  Max Limit/Request Ratio
----        --------  ---  ---  ---------------  -------------  -----------------------
Container   cpu       -    -    100m             250m           -
Container   memory    -    -    200Mi            300Mi          -

```

### Deploy a simple pod and service

6. Let's deploy a pod and service that creates a single container to demonstrate how default values are applied to each pod.

```bash
kubectl -n devteam run php-apache --image=k8s.gcr.io/hpa-example --expose --port=80
```
**Output:**

```
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed ina future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
service/php-apache created
deployment.apps/php-apache created
```

7. Get the pods and service using the commands.

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME                          READY     STATUS    RESTARTS   AGE
php-apache-55c4bb8b88-bb7jp   1/1       Running   0          4m
```

```bash
kubectl -n devteam get services
```

```
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
php-apache   ClusterIP   10.96.225.250   <none>        80/TCP    4m
```

### Get the configuration of the pod

8. Now get the configuration of the pod (php-apache) using the following command.


```bash
 kubectl -n devteam get po php-apache-b9d55d7f-7k6kb -o yaml
```
* Observe it in `spec.containers.resource` section limits and requests has been assigned to pod, as created previous step in limit range resource.


**Output:**

```
spec:
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
```
9. Get the metrics of the pods in your namespace using `kubectl top pods -n devteam`.


**Output:**

```
NAME                          CPU(cores)   MEMORY(bytes)
php-apache-55c4bb8b88-bb7jp   1m           9Mi

```

10. Get the nodes cpu usage and memory usage using `kubectl top nodes`


`kubectl top nodes`

**Output:**

```
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
10.0.1.2   78m          3%     1013Mi          15%
10.0.2.2   69m          3%     1000Mi          15%
10.0.3.2   82m          4%     1032Mi          15%
```

**Show example of pod crossing the Limit**

## Resource Quotas

In Kubernetes, ResourceQuota is used to limit the resources per namespace when multiple users sharing the cluster. We will apply the ResourceQuota for the compute resources.

#### Create a Namespace: 

* Create a namespace and apply the ResourceQuota to that namespace.

```bash
kubectl create ns devteam-test
```
**Output:**

```
namespace/devteam-test created
```

### Create a ResourceQuota

1. Create a ResourceQuota using the following YAML and apply it to the namespace by specifying the namespace name in the YAML file.

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

**Output:**

```
resourcequota/resourcequota-name created
```
* Get the resource quota using the following command.

```bash
kubectl -n devteam-test get resourcequota
```

**Output:**

```
NAME           CREATED AT
dev-resource   2019-09-15T11:55:53Z
```

3. Now use the `kubectl -n devteam-test get resourcequota resourcequota-name -o yaml` command to get detailed information about the ResourceQuota.

```bash
kubectl -n devteam-test get resourcequota resourcequota-name -o yaml
```

**Output:**

```Yaml
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
    limits.cpu: "0"
    limits.memory: "0"
    requests.cpu: "0"
    requests.memory: "0"  
```

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

4. Get more detailed information about the ResourceQuota, Use the following command in PowerShell.

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

* Create a namespace using the following command in PowerShell.

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

* Create another pod by specifying the memory request more than its ResourceQuota request.

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

* Apply the HPA configuration to the existing deployment php-apache, to get the deployments using the following command.

```
kubectl -n devteam get deploy
```

**Output:**

```
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
php-apache   1/1     1            1           17m
```

```bash
kubectl -n devteam autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

**Output:**

```
horizontalpodautoscaler.autoscaling/php-apache autoscaled
```

* Get the HPA configuration using the following command.

```bash
kubectl -n devteam get hpa 
```

**Output:**

```
  NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
  php-apache   Deployment/php-apache   1%/50%    1         10        1          10m

```

### Generate Load

1. Now we will use load generator to generate some load on apache.

2. Open an additional terminal window (use `Powershell`) and run the below command.

  ```bash
  kubectl -n devteam run -i --tty load-generator --image=busybox /bin/sh
  ```

3. Hit enter and run below command inside a pod, to generate load on apache service.

```
  while true; do wget -q -O- http://php-apache.devteam.svc.cluster.local; done 
```
**Output:**

```
  Output should be : `OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!`
```

* Use previous terminal, Within few minutes, we should see the higher CPU load by executing the following command. Observe Replicas `6` pods running.

```bash
kubectl -n devteam get hpa
```
**Output:**

```
NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   19%/50%   1         10        6          22m
```
* You can see the number of apache pods increased due to load on php-apache service using the following command.

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

* You can stop the load on apache by typing `CTRL+C` on a terminal, applied load on php-apache-service.

* You can verify the result within a minute using `kubectl -n devteam get hpa`.

**Output:**

```
NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   44%/50%   1         10        1          24m

```

* Check the logs of the php-apache pod using the following command.

E.g. `kubectl -n (namespace-name) logs <pod podname>`

```bash
kubectl -n devteam logs php-apache-b9d55d7f-8mwn5
```
**Output:**

```
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.244.2.8. Set the 'ServerName' directive globally to suppress this message
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.244.2.8. Set the 'ServerName' directive globally to suppress this message
[Sun Sep 15 12:26:49.506254 2019] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.10 (Debian) PHP/5.6.14 configured -- resuming normal operations
[Sun Sep 15 12:26:49.506320 2019] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
10.244.1.7 - - [15/Sep/2019:12:26:50 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:26:51 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:26:56 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:26:57 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:04 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:11 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:12 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:15 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:16 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:16 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:17 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:20 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:21 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:23 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:24 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:25 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:25 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:28 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:29 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:30 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:32 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:36 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:38 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:39 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:41 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:42 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:43 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:44 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:44 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:52 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:53 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:55 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:57 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:27:59 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:02 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:06 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:08 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:09 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:13 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:15 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:21 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:22 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:29 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:30 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:32 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:38 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:43 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:47 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:49 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
10.244.1.7 - - [15/Sep/2019:12:28:57 +0000] "GET / HTTP/1.1" 200 206 "-" "Wget"
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


**Conclusion:** Congratulations! You have successfully completed the Limit Range, Resource Quota & Horizontal Pod Autoscaler ! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
