# Liveness and Readiness Probes

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Liveness Probes](#liveness-probes) 

[Readiness Probes](#readiness-probes) 

[Exercises](#exercises)

## Overview

**Liveness Probes** are used to restart a container when doing so could help make the application more available, usually by detecting scenarios where an application is running but not making progress. 

**Readiness probes** are used so that a `kubelet ` knows when a container is ready to accept traffic. Combining the Readiness and Liveness probes helps ensure only healthy containers are running in the cluster.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up liveness and readiness probes. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing liveness and readiness probes as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn how to create Liveness and Readiness Probes in a Kubernetes environment.


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

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like example `MC_myResourceGroup_myAKSCluster_eastus`. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select Powershell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the powershell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the enviornment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a K8's cluster.

`kubectl get nodes`

**Output:**
```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. Using the following command, you get the default namespaces in Kubernetes cluster.

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
## Liveness Probes

The kubelet uses liveness probes to know when to restart a container. For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. Restarting a container in such a state can help to make the application more available despite bugs.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/live.png?st=2019-08-26T10%3A53%3A56Z&se=2022-08-27T10%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pEWhCMSoAc3Yfe%2F5NgcHp7pk65dKouaCT857Na3QGSk%3D" alt="image-alt-text" >

* Many applications running for long periods of time eventually transition to broken states, and cannot recover except by being restarted.

* Kubernetes provides liveness probes to detect and remedy such situations.

* Create the namespace using the following command.

```bash
kubectl create ns devteam
```

**Output:**
```
devteam namespace created
```

* Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of liveness probe, paste and save it in a file (e.g. liveness-probe.yml). Please make sure "All Files" is selected for "Save as Type" option.

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-liveness-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600"]
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```

* Use the following command to create liveness-probe pod

E.g. kubectl -n <namespace-name> create -f <filename>

```bash
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/liveness-probe.yml
```

**Output:**
```
pod "my-liveness-pod" created
```

* Get the pods in a namespace, using the following command in Powershell.

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME              READY     STATUS    RESTARTS   AGE
my-liveness-pod   1/1       Running   0          34s
```

* Within 30 seconds, inspect the Pod events

* Describe the pod using the command shown below

E.g. `kubectl -n <namespacename> describe pod <podname>`

```bash
kubectl -n devteam describe pod my-liveness-pod
```

**Output:**
```
Name:               my-liveness-pod
Namespace:          devteam
Priority:           0
PriorityClassName:  <none>
Node: oke-nodepool1-18284211-0 / 10.240.0.4
Start Time: Tue, 02 Jul 2019 15:42:53 +0530
Labels:             <none>
Annotations:        kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"my-liveness-pod","namespace":"livenessreadyness"},"spec":{"containers":[{"command"...
Status:             Running
IP:                 10.240.0.16
Containers:
  myapp-container:
    Container ID:  docker://1bb4c0001044c10808e99996bf34fb0f948eec964ef667830b16249f3d168a4b
    Image:         busybox
    Image ID:      docker-pullable://busybox@sha256:c94cf1b87ccb80f2e6414ef913c748b105060debda482058d2b8d0fce39f11b9
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo Hello, anjani! && sleep 600
    State:          Running
      Started:      Tue, 02 Jul 2019 15:42:56 +0530
    Ready:          True
    Restart Count:  0
    Liveness:       exec [echo testing] delay=5s timeout=1s period=5s #success=1 #failure=3
    Environment:
      KUBERNETES_PORT_443_TCP_ADDR:  oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io
      KUBERNETES_PORT:               tcp://oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io:443
      KUBERNETES_PORT_443_TCP:       tcp://oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io:443
      KUBERNETES_SERVICE_HOST: oke-cluse-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-294nv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-294nv:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-294nv
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age   From                               Message
  ----    ------     ----  ----                               -------
  Normal  Scheduled  5m    default-scheduler                  Successfully assigned livenessreadyness/my-liveness-pod to oke-nodepool1-18284211-0
  Normal  Pulling    5m    kubelet, oke-nodepool1-18284211-0  pulling image "busybox"
  Normal  Pulled     5m    kubelet, oke-nodepool1-18284211-0  Successfully pulled image "busybox"
  Normal  Created    5m    kubelet, oke-nodepool1-18284211-0  Created container
  Normal  Started    5m    kubelet, oke-nodepool1-18284211-0  Started container
```

* The output under Events indicates that no liveness probes have failed yet

* After `35` seconds, view the Pod events again, use the same command was used in previous step.

```bash
kubectl -n devteam describe pod my-liveness-pod
```

**Output:**
```
Name:         my-liveness-pod
Namespace:    devteam
Priority:     0
Node:         aks-agentpool-16107261-0/10.240.0.4
Start Time:   Tue, 03 Mar 2020 07:47:40 +0000
Labels:       <none>
Annotations:  <none>
Status:       Running
IP:           10.244.0.8
Containers:
  myapp-container:
    Container ID:  docker://d81e195b4b5e48aa2d9a68b01cb3b10c532d95ae18cdf52cb477e8908d884b7c
    Image:         busybox
    Image ID:      docker-pullable://busybox@sha256:6915be4043561d64e0ab0f8f098dc2ac48e077fe23f488ac24b665166898115a
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
    State:          Running
      Started:      Tue, 03 Mar 2020 07:48:57 +0000
    Last State:     Terminated
      Reason:       Error
      Exit Code:    137
      Started:      Tue, 03 Mar 2020 07:47:42 +0000
      Finished:     Tue, 03 Mar 2020 07:48:55 +0000
    Ready:          True
    Restart Count:  1
    Liveness:       exec [cat /tmp/healthy] delay=5s timeout=1s period=5s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-pxptv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-pxptv:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-pxptv
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age                  From                               Message
  ----     ------     ----                 ----                               -------
  Normal   Scheduled  2m13s                default-scheduler                  Successfully assigned devteam/my-liveness-
pod to aks-agentpool-16107261-0
  Normal   Pulling    57s (x2 over 2m12s)  kubelet, aks-agentpool-16107261-0  Pulling image "busybox"
  Normal   Pulled     56s (x2 over 2m11s)  kubelet, aks-agentpool-16107261-0  Successfully pulled image "busybox"
  Normal   Created    56s (x2 over 2m11s)  kubelet, aks-agentpool-16107261-0  Created container myapp-container
  Normal   Started    56s (x2 over 2m11s)  kubelet, aks-agentpool-16107261-0  Started container myapp-container
  Warning  Unhealthy  13s (x6 over 98s)    kubelet, aks-agentpool-16107261-0  Liveness probe failed: cat: can't open '/t
mp/healthy': No such file or directory
  Normal   Killing    13s (x2 over 88s)    kubelet, aks-agentpool-16107261-0  Container myapp-container failed liveness
probe, will be restarted
```

* At the bottom of the output, there are messages indicating that the liveness probes have failed, and the containers have been killed and recreated.

* Wait another 30 seconds, and verify that the Container has been restarted

* Get the pods, use the following command.

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME               READY     STATUS    RESTARTS   AGE
my-liveness-pod    1/1       Running   1          11m
```

* The output shows that `RESTARTS` has been incremented to `1`.

## Readiness Probes

The kubelet uses readiness probes to know when a container is ready to start accepting traffic. A pod is considered ready when all of its containers are ready. One use of this signal is to control which Pods are used as backends for Services. When a Pod is not ready, it is removed from Service load balancers.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/ready.png?st=2019-08-26T10%3A54%3A31Z&se=2022-08-27T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aI0W%2B6sU5qdw%2FAqPkQMiFi9mnJwWPFIuBdAbak%2F5RHs%3D" alt="image-alt-text" >

Sometimes, applications are temporarily unable to serve traffic. In such cases, you donâ€™t want to kill the application, but you donâ€™t want to send it requests either. Kubernetes provides readiness probes to detect and mitigate these situations. A pod with containers reporting that they are not ready does not receive traffic through Kubernetes Services.
 
**Note:** Readiness probes run on the container during its whole lifecycle.

* Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of readiness probe, paste and save it in a file (e.g. readiness-probe.yml). Please make sure "All Files" is selected for "Save as Type" option.

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-rediness-pod
  labels:
    app: readytest
spec:
  containers:
  - name: myapp-container
    image: nginx
    readinessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```
* Use the command  `kubectl -n devteam create -f <filename>` to create the Readiness-pod.

```bash
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/readiness-probe.yml
```

* List-out the pods using the following command.

```bash
kubectl -n devteam get po
```

**Output:**
```
NAME                      READY   STATUS    RESTARTS   AGE
my-rediness-pod           0/1     Running   1          14m
```

* Let's create a sample service using the following configuration code.

**Note:** Make sure choose selector as `app=readytest` so that service will communicate to the Readiness pod.

``` Yaml
apiVersion: v1
kind: Service
metadata:
  name: test-svc
spec:
  selector:
    app: readytest
  ports:
  - port: 8088
    targetPort: 80
  type: ClusterIP
```

* Deploy a service configuration using `test-svc.yaml`, use following command in Powershell.

```
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/test-svc.yml
```
* List-out the services make sure you have `test-svc` service

```bash
kubectl -n devteam get svc
```

* Get into a shell of the container Readiness Probe pod, using the following command in Powershell.

```
kubectl -n devteam exec -it my-rediness-pod sh
```

* Now open a new gitbash terminal, describe the service using the following command. You should see a endpoint without ip address and port.

```bash
kubectl -n devteam describe svc test-svc
```

**Output:**
```
Name:              test-svc
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          app=readytest
Type:              ClusterIP
IP:                10.96.156.236
Port:              <unset>  8088/TCP
TargetPort:        80/TCP
Endpoints:
Session Affinity:  None
Events:            <none>
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/without-endpoint-probe.PNG?st=2019-09-14T10%3A43%3A45Z&se=2022-09-15T10%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q60CrGZwNW6fvOshk%2B8zRViYxRit9dUxeTIbLlfK9Ts%3D" alt="image-alt-txt">

* Now go back to  previous Powershell/gitbash window which has readiness-probe pod, create a directory using `touch /tmp/healthy` inside a pod. wait for 5 seconds describe the service, you should see a endpoint with ip adress and port, shown below.

```bash
 kubectl -n devteam describe svc test-svc
```

**Output:**
```
Name:              test-svc
Namespace:         devteam
Labels:            <none>
Annotations:       kubectl.kubernetes.io/last-applied-configuration:
                     {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"test-svc","namespace":"devteam"},"spec":{"ports":[{"port":8088,"t...
Selector:          app=readytest
Type:              ClusterIP
IP:                10.96.244.150
Port:              <unset>  8088/TCP
TargetPort:        80/TCP
Endpoints:         10.244.3.200:80
Session Affinity:  None
Events:            <none>
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/service-with-endpoint-probe.PNG?st=2019-09-14T10%3A46%3A18Z&se=2022-09-15T10%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1CMXiWZVe5tMfAgj%2FK%2BYO2OZfh0LfPNtrREcDnW03zA%3D" alt="image-alt-text" >

* Switch to the Powershell/gitbash. Lets install `wget` to access the service. Use the following command to install wget inside a pod.

* Before that, you needs to be install `wget` to access the service, use the following command to install wget inside a pod.

```bash
root@my-rediness-pod:/# apt-get update && apt-get install wget -y
```

* Use the service name with port to verify the both pod and service are communicating.

**Output:**
```
root@my-rediness-pod:/# wget -q --timeout=5 test-svc:8088 -O -
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

## Exercises

1. Create an busybox pod with a liveness probe that just runs the command 'ls'. Save its YAML in pod.yaml. Run it, check its probe status, delete it

<details><summary>show</summary>
<p>

```bash
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml > liveness-pod.yaml
vi liveness-pod.yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-liveness-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo Hello, kubernetes123! && sleep 600"]
     livenessProbe:
      exec:
        command:
        - cat
        - ls
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```

```bash
kubectl create -f liveness-pod.yaml
kubectl describe pod my-liveness-pod | grep -i liveness # run this to see that liveness probe works
kubectl delete -f liveness-pod.yaml

```
</p>
</details>

2. Modify the liveness-pod.yaml file so that liveness probe starts kicking in after 5 seconds whereas the period of probing would be 10 seconds. Run it, check the probe, delete it.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-liveness-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo Hello, kubernetes123! && sleep 600"]
     livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5 ## Add this line
      periodSeconds: 10 # add this line
```
```bash
kubectl create -f liveness-pod.yaml
kubectl describe pod my-liveness-pod | grep -i liveness # run this to see that liveness probe works
kubectl delete -f liveness-pod.yaml
```
</p>
</details>

3. Create a readinessProbe, readinessProbe starts kicking in after 5 seconds whereas the period of probing would be 10 seconds. Run it, check the probe, delete it.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-rediness-pod
  labels:
    app: readytest
spec:
  containers:
  - name: myapp-container
    image: nginx
    readinessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```
```bash
kubectl create -f readiness-pod.yml
kubectl describe po <pod-name>
kubectl delete -f readiness-pod.yml

```
</p>
</details>

**Conclusion:** Congratulations! You have successfully completed the Liveness and Readiness Probes lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
