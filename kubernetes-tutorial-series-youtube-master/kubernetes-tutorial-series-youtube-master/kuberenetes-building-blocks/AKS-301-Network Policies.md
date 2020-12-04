# Network Policies on AKS

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Network Policies](#network-Policies)

[Exercises](#exercises)

## Overview

**Network Policies** are used in Kubernetes to specify how groups of pods should communicate with each other, as well as with other Network endpoints.

Network Policy resources use labels to select pods and define rules which specify what traffic is allowed to the selected pods.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up Network Policies. You will start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing network policies as you would in a real Kubernetes environment.

At the end of this lab, you will learn how to create, update, describe, edit, delete a few Kubernetes Objects like Network Policies.

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

3. Click Apps icon in the toolbar and select `Powershell` to open a Powershell window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with Azure credentials as provided in previous section, using powershell run the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Execute the following command to get the credentials for the kubernetes cluster.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. Verify the connection to your cluster, use the `kubectl get nodes` command to return a list of the cluster nodes.

`kubectl get nodes`

* The following output shows the single node created in the previous steps. Make sure that the status of the node is `Ready`.

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
## Network Policies

By default, Kubernetes has an open network where every pod can talk to every pod. Network policies are implemented by the network plugin, so you must use networking solution which supports NetworkPolicy - simply creating the resource without a controller to implement it will have no effect. We will be using Kube router as the network controller and firewall. The network policies determine which pod can talk to which pod depending on the rules set. The examples in this lab will illustrate the rules of communication.

### Kube-router

Kube-router can be deployed as a daemonset and offers this functionality. Kube-router is a turnkey solution for Kubernetes networking with aim to provide operational simplicity and performance.


* Then create kuberouter by using the following configuration code, Save the following **kuberouter** YAML file with a filename extension (e.g. .yml), open a notepad copy configuration of **kuberouter**, paste and save it in a file (e.g.kuberouter.yml). Please make sure "All Files" is selected for "Save as Type" option.


``` yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kube-router-cfg
  namespace: kube-system
  labels:
    tier: node
    k8s-app: kube-router
data:
  cni-conf.json: |
    {
      "name":"kubernetes",
      "type":"bridge",
      "bridge":"kube-bridge",
      "isDefaultGateway":true,
      "ipam": {
        "type":"host-local"
      }
    }

---
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  labels:
    k8s-app: kube-router
    tier: node
  name: kube-router
  namespace: kube-system
spec:
  template:
    metadata:
      labels:
        k8s-app: kube-router
        tier: node
      annotations:
        scheduler.alpha.kubernetes.io/critical-pod: ''
    spec:
      serviceAccountName: kube-router
      containers:
      - name: kube-router
        image: cloudnativelabs/kube-router
        imagePullPolicy: Always
        args:
        - "--run-router=true"
        - "--run-firewall=true"
        - "--run-service-proxy=false"
        env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        livenessProbe:
          httpGet:
            path: /healthz
            port: 20244
          initialDelaySeconds: 10
          periodSeconds: 3
        resources:
          requests:
            cpu: 250m
            memory: 250Mi
        securityContext:
          privileged: true
        volumeMounts:
        - name: lib-modules
          mountPath: /lib/modules
          readOnly: true
        - name: cni-conf-dir
          mountPath: /etc/cni/net.d
        - name: kubeconfig
          mountPath: /var/lib/kube-router
          readOnly: true
      initContainers:
      - name: install-cni
        image: busybox
        imagePullPolicy: Always
        command:
        - /bin/sh
        - -c
        - set -e -x;
          if [ ! -f /etc/cni/net.d/10-kuberouter.conf ]; then
            TMP=/etc/cni/net.d/.tmp-kuberouter-cfg;
            cp /etc/kube-router/cni-conf.json ${TMP};
            mv ${TMP} /etc/cni/net.d/10-kuberouter.conf;
          fi;
          if [ ! -f /var/lib/kube-router/kubeconfig ]; then
            TMP=/var/lib/kube-router/.tmp-kubeconfig;
            cp /etc/kube-router/kubeconfig ${TMP};
            mv ${TMP} /var/lib/kube-router/kubeconfig;
          fi
        volumeMounts:
        - mountPath: /etc/cni/net.d
          name: cni-conf-dir
        - mountPath: /etc/kube-router
          name: kube-router-cfg
        - name: kubeconfig
          mountPath: /var/lib/kube-router
      hostNetwork: true
      tolerations:
      - key: CriticalAddonsOnly
        operator: Exists
      - effect: NoSchedule
        key: node-role.kubernetes.io/master
        operator: Exists
      volumes:
      - name: lib-modules
        hostPath:
          path: /lib/modules
      - name: cni-conf-dir
        hostPath:
          path: /etc/cni/net.d
      - name: kube-router-cfg
        configMap:
          name: kube-router-cfg
      - name: kubeconfig
        hostPath:
          path: /var/lib/kubelet

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kube-router
  namespace: kube-system

---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: kube-router
  namespace: kube-system
rules:
  - apiGroups:
    - ""
    resources:
      - namespaces
      - pods
      - services
      - nodes
      - endpoints
    verbs:
      - list
      - get
      - watch
  - apiGroups:
    - "networking.k8s.io"
    resources:
      - networkpolicies
    verbs:
      - list
      - get
      - watch
  - apiGroups:
    - extensions
    resources:
      - networkpolicies
    verbs:
      - get
      - list
      - watch
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: kube-router
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: kube-router
subjects:
- kind: ServiceAccount
  name: kube-router
  namespace: kube-system
```
* Deploy the kube-router configuration using the following command. Make sure you are on correct path

```bash
  kubectl create -f /c/Users/PhotonUser/Desktop/kuberouter.yml
```

1. The kube-router will be deployed as a Daemonset in `kube-system` namespace.

2. You can see the kube-router pods using below command.

```bash
kubectl -n kube-system get pods
```
**Output:**
```
NAME                                  READY   STATUS    RESTARTS   AGE
coredns-6c66fc4fcb-9fblt              1/1     Running   0          12m
coredns-6c66fc4fcb-lbvzn              1/1     Running   0          9m36s
coredns-autoscaler-567dc76d66-6s78g   1/1     Running   0          12m
kube-proxy-dzlhl                      1/1     Running   0          10m
kube-router-82tr5                     1/1     Running   0          20s
metrics-server-5695787788-74hmc       1/1     Running   0          12m
tunnelfront-6ff44fd446-4xl8p          1/1     Running   0          12m
```

### Create the Namespace and create a sample Service

1. Create a sample namespace

```bash
kubectl create namespace devteam
```

**Output:**
```
namespace/devteam created
```
2. Create a deployment with 2 replicas using nginx image, Execute the following command in Powershell.

```bash
kubectl -n devteam run nginx --replicas=2 --image=nginx
```

**Output:**
```
deployment.apps/nginx created
```

3. Verify whether the pods are created or not, using the following command.

```bash
kubectl -n devteam get pods
```

4. Create a service and expose it with port 80.

```bash
kubectl expose -n devteam deployment nginx --port=80
```

5. You can see the service using the below command.

```bash
kubectl -n devteam get services
```

**Network Policies**

By default, Kubernetes has an open network where every pod can talk to every pod.

Create network policies that control traffic from one pod to another or from an IP outside of the cluster. Enable this to control your network using network policies.

### Verify Access - Allowed All Ingress and Egress

* Open up a `Powershell window` create a busybox pod to test policy access. This pod will be used throughout this lab to test policy access.

```bash
kubectl run --namespace=devteam access --rm -ti --image busybox /bin/sh
```

**Output:**
```
If you don't see a command prompt, try pressing enter.

/ #
```
Now from within the busybox â€œaccessâ€ pod execute the following command to test access to the nginx service.

```bash
wget -q --timeout=5 nginx -O -
```
* It should return the HTML of the nginx welcome page.

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
* Still within the busybox â€œaccessâ€ pod, issue the following command to test access to google.com.

```bash
wget -q --timeout=5 google.com -O -
```
* It should return the HTML of the google.com home page.

### Deny all ingress traffic

* Enable ingress isolation on the namespace by deploying a default deny all ingress traffic policy.

* Save the following yaml configuration code save it in a file `default-deny-ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: devteam
spec:
  podSelector:
    matchLabels: {}
  policyTypes:
  - Ingress
```
* Make sure that you are in correct path of yaml file and deploy it in Git bash window

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/default-deny-ingress.yml
```

### Verify Access - Denied All Ingress and Allowed All Egress

Because all pods in the namespace are now selected, any ingress traffic which is not explicitly allowed by a policy will be denied.

We can see that this is the case by switching over to `Powershell` our `access` pod in the namespace and attempting to access the nginx service.
* if session ended re-run the following command to get into it.

```bash
kubectl run --namespace=devteam access --rm -ti --image busybox /bin/sh
```

```bash
wget -q --timeout=5 nginx -O -
```
* It should return the following output

**Output:**
```
wget: can't connect to remote host (10.96.229.109): Connection refused
```
* Next, try to access `google.com`

```bash
wget -q --timeout=5 google.com -O -
```
* It should return the following output

**Output:**

```
<!doctype html><html itemscope="" itemtype="http://schema.org/WebPage" lang="en"><head><meta content="Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for." name="description"><meta content="noodp" name="robots"><meta content="text/html; charset=UTF-8" http-equiv="Content-Type"><meta content="/images/branding/googleg/1x/googleg_standard_co

```
We can see that the ingress access to the nginx service is denied while egress access to outbound internet is still allowed.

## Allow ingress traffic to Nginx

* Run the followingto create a NetworkPolicy which allows traffic to nginx pods from any pods in the devteam namespace.

* Save the following the configuration code in a file with a file name `access-nginx.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: access-nginx
  namespace: devteam
spec:
  podSelector:
    matchLabels:
      run: nginx
  ingress:
    - from:
      - podSelector:
          matchLabels: {}
```

* Make sure that you are in correct path of yaml file and deploy it in Git bash window

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/access-nginx.yml
```

**Output:**
```
networkpolicy.networking.k8s.io/access-nginx created
```
### Verify Access - Allowed Nginx Ingress

Now ingress traffic to nginx will be allowed. We can see that this is the case by switching over to `Powershell` window our `access` pod in the namespace and attempting to access the nginx service.

```bash
wget -q --timeout=5 nginx -O -
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
* After creating the policy, we can now access the nginx Service.

### Deny all egress traffic

* Enable egress isolation on the namespace by deploying a default deny all egress traffic policy.

* Save the following the configuration code in a file with a file name `default-deny-egress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
  namespace: devteam
spec:
  podSelector:
    matchLabels: {}
  policyTypes:
  - Egress
```
* Make sure that you are in correct path of yaml file and deploy it in Git bash

```bash
kubectl create -f default-deny-egress
```

**Output:**
```
networkpolicy.networking.k8s.io/default-deny-egress created
```
### Verify Access - Denied All Egress

Now any ingress or egress traffic which is not explicitly allowed by a policy will be denied.

We can see that this is the case by switching over to Powershell window to our `access` pod in the namespace and attempting to nslookup nginx or wget google.com.

```bash
nslookup nginx
```

* It should return something like the following.

**Output:**
```
nslookup: write to '10.96.5.5': Connection refused
 connection timed out; no servers could be reached
```
* Next, try to access google.com.

```bash
wget -q --timeout=5 google.com -O -
```
* It should return

**Output:**
```
wget: bad address 'google.com'
```
### Allow DNS egress traffic

Run the following to create a label of `name: kube-system` on the `kube-system` namespace and a `NetworkPolicy` which allows DNS egress traffic from any pods in the `devteam` namespace to the `kube-system` namespace.

* Label the namespace of kube-system using the following command in Git bash

```bash
kubectl label namespace kube-system name=kube-system
```
* Save the following the configuration code in a file with a file name `allow-dns-access.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-dns-access
  namespace: devteam
spec:
  podSelector:
    matchLabels: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          name: kube-system
    ports:
    - protocol: UDP
      port: 53
```

* Make sure that you are in correct path of yaml file and deploy it Gitbash

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/allow-dns-access.yml
```

**Output:**
```
networkpolicy.networking.k8s.io/allow-dns-access created
```
### Verify Access - Allowed DNS access

Now egress traffic to DNS will be allowed.

We can see that this is the case by switching over to **Powershell window**  our `access` pod in the namespace and attempting to lookup nginx and google.com.

```bash
nslookup nginx
```
* It should return something like the following.

**Output:**

```
Server:         10.96.5.5
Address:        10.96.5.5:53

Name:   nginx.devteam.svc.cluster.local
Address: 10.96.229.109
```
* Next, try to look up google.com

```bash
nslookup google.com
```
**Output:**
```
Server:         10.96.5.5
Address:        10.96.5.5:53

Non-authoritative answer:
Name:   google.com
Address: 172.217.7.238
```
Even though DNS egress traffic is now working, all other egress traffic from all pods in the `devteam` namespace is still blocked. Therefore the HTTP egress traffic from the wget calls will still fail.

### Allow egress traffic to nginx

Run the following to create a NetworkPolicy which allows egress traffic from any pods in the devteam namespace to pods with labels matching `run: nginx` in the same namespace.

* Save the following the configuration code in a file with a file name `allow-egress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-egress-to-advance-policy-ns
  namespace: devteam
spec:
  podSelector:
    matchLabels: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          run: nginx
```

* Make sure that you are in correct path of yaml file and deploy it using Gitbash

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/allow-egress-access.yml
```

* We can see that this is the case by switching over to **Powershell window** to our `access` pod in the namespace and attempting to access nginx.

```bash
wget -q --timeout=5 nginx -O -
```

* It should return the HTML of the nginx welcome page.

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
* Next, try to retrieve the home page of google.com.

```bash
wget -q --timeout=5 google.com -O -
```

**Output:**
```
wget: can't connect to remote host (172.217.7.238): Connection refused
```

* Access to `google.com `times out because it can resolve DNS but has no egress access to anything other than pods with labels matching run: nginx in the devteam namespace.

### Verify the internet access

1. List-out the pods in a namespace using the following command.

```bash
kubectl -n devteam get pods
```

2. Exec into the pod using one of the pod name. Replace the Pod name with yours 

```
kubectl -n devteam exec -it allow-nginx-3968820950-9dxs8 bash
```

3. Verify the internet access to the nginx pod, use the following command in Powershell.

```bash
apt-get update
```

* It should return the following output.

**Output:**
```
    Get:1 http://security-cdn.debian.org/debian-security stretch/updates InRelease [94.3 kB]
    Get:4 http://security-cdn.debian.org/debian-security stretch/updates/main amd64 Packages [487 kB]
    Ign:2 http://cdn-fastly.deb.debian.org/debian stretch InRelease
    Get:3 http://cdn-fastly.deb.debian.org/debian stretch-updates InRelease [91.0 kB]
```

* You can see all the network policies which you applied using the below command.

```bash
kubectl -n devteam get networkpolicies
```

* Check the logs of the pod using the following command

```bash
kubectl -n devteam logs allow-nginx-3968820950-9dxs8
```
## Exercises

1. Create a namespace `test`, create a networkpolicy to Deny all ingress traffic in the namespace

<details><summary>show</summary>
<p>

``` Yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  namespace: devte
  name: deny-ingress
spec:
  podSelector: 
    matchLabels: {}
  policyTypes:
  - Ingress
```
```
kubectl create ns test
```
</p>
</details>

2. Deny all egress traffic in the namespace

<details><summary>show</summary>
<p>

``` Yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  namespace: test
  name: deny-egress
spec:
  podSelector: 
    matchLabels: {}
  policyTypes:
  - Egress
```
deploy the yaml configfile into the cluster

`kubectl -n test create -f <file path>`

</p>
</details>

3. Create a label kube-sytem on kube-system namespace allow DNS egress traffic to any pods in namespace to kube-system 

<details><summary>show</summary>
<p>

`kubectl label ns kube-system kubesystem=kubesystem`

``` Yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  namespace: test
  name: allow-dns
spec:
  podSelector: 
    matchLabels: {}
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          kube-system: kube-system
    - podSelector:  
        matchLabels:
          k8s-app: kube-dns
```
</p>
</details>

4. How to verify Access to allowed DNS access to the pod

<details><summary>show</summary>
<p>

```bash
kubectl -n test run busybox --rm -ti --image=busybox /bin/sh  # use powershell

nslookup nginx
```

</p>
</details>

5. Create a egress and ingress traffic within the namespace

<details><summary>show</summary>
<p>

``` Yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  namespace: test
  name: allow-from-same-namespace-and-ingress
spec:
  podSelector:
    matchLabels: {}
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          run: nginx
    - podSelector: {}
```

``` Yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  namespace: test
  name: allow-from-same-namespace-and-egress
spec:
  podSelector:
    matchLabels: {}
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          run: nginx
    - podSelector: {}
```
</p>
</details>

6. create a  policy to requires services access through internet access 

<details><summary>show</summary>
<p>

``` Yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  namespace: test
  name: allow-nginx
spec:
  podSelector:
    matchLabels:
      run: nginx
  egress:
  - {} 
  policyTypes: 
  - Egress
```
</p>
</details>

7. How to verify the internet access to the pod

<details><summary>show</summary>
<p>

```bash
kubectl -n test get pods

kubectl -n test exec -it <podname> bash

apt-get update
```
</p>
</details>

8. Get the Networkpolices in a namespace

<details><summary>show</summary>
<p>

```bash
kubectl -n test get networkpolicies
```
</p>
</details>

**Conclusion:** Congratulations! You have successfully completed the Network Policies which Kube-router addon comes with a Network Policy controller that watches Kuberentes API server for any NetworkPolicy and pods updated configure to allow or block traffic as directed by the policies! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
