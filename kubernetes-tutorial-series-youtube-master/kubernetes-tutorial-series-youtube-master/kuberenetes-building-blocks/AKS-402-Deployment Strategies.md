# Deployment Strategies
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#Pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Rolling Update with Kubernetes Deployments](#rolling-update-with-kubernetes-deployments)

[Canary Deployment using the Nginx-Ingress Controller](#canary-deployment-using-the-nginx-ingress-controller)


## Overview

This lab shows you various Kubernetes deployments, users expect applications to be available all the time and developers are expected to deploy new versions of them several times a day. In Kubernetes this is done with rolling updates. Rolling updates allow Deployments update to take place with zero down time.

Introducing new versions of a service, it is often helpful to shift a controlled percentage of user traffic to a newer version of the service in the process of phasing out the older version, by using the functionality of `Canary Deployments` can be done using two Deployments with common pod labels. 

Using pre-provisioned AKS cluster, this lab will walk you through the basics of setting up fundamental Kubernetes objects -- rolling update, canary deployment. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing objects as you would in a real Kubernetes environment. There are also some helpful exercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn about **Rolling Update** and **Canary Deployment** using the Nginx-Ingress controller.

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

3. Click Apps icon in the toolbar and select PowerShell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the PowerShell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Execute the following command to access cluster for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the environment, Get the all nodes using `kubectl get nodes` command to list-out nodes in a k8's cluster.

```bash
kubectl get nodes
```

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

## Rolling Update with Kubernetes Deployments

### Rolling Update

A Kubernetes deployment owns and manages one or more **Replica Sets**, and **Replica Set** manages the basic units in Kubernetes Pods. Kubernetes creates a new Replica Set each time after the new deployment config is deployed and keeps the old Replica Set. So that we can rollback to the previous state with old Replica Set. And there is only one Replica Set in active state, which means DESIRED > 0. Kuberentes Deployments also supports rollback support.

### Create a sample Kubernetes Deployment

* Create a namespace using the following command in PowerShell.

`kubectl create ns devteam`

**Output:**
```
devteam namespace created
```

* Save the following yaml configuration code in file, deploy it using the following command shown below.

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-sample
  labels:
    service-name: deployment-sample
    environment: deployment-sample
spec:
  replicas: 3
  selector:
    matchLabels:
      service-name: deployment-sample
      environment: deployment-sample
  template:
    metadata:
      labels:
        service-name: deployment-sample
        environment: deployment-sample
    spec:
      containers: 
        - image:  ashorg/sample:v1
          name: deployment-sample
          resources:
          ports:
            - containerPort: 8089
```

* You can use the following command to deploy configuration of deployment object was provided in previous step.

`kubectl -n devteam create -f deployment-sample.yaml`

**Output:**
```
deployment.apps "deployment-sample" created
```

* Get the deployment using the command 

E.g. `kubectl -n <namespace-name> get deployment`

`kubectl -n devteam get deployment`

**Output:**
```
NAME                DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deployment-sample   3         3         3            3           20s
```

* Now get the pods, that got created as part of this deployment using the command

E.g. `kubectl -n <namespace-name> get pods`

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME                                 READY     STATUS    RESTARTS   AGE
deployment-sample-6b44657b4f-5vdnk   1/1       Running   0          6m
deployment-sample-6b44657b4f-gz2dv   1/1       Running   0          6m
deployment-sample-6b44657b4f-xwlpt   1/1       Running   0          6m
```

* Now get the Replica Sets, that got created as part of the deployment using the command in Powershell.

```bash
kubectl -n devteam get replicaset
```

**Output:**
```
NAME                           DESIRED   CURRENT   READY     AGE
deployment-sample-6b44657b4f   3         3         3         17m
```

### Apply Rolling Update

* In order to support rolling update, we need to configure the update strategy first.

* So, you need to add following configuration part into **spec** section.

```yaml
minReadySeconds: 5
strategy:
  # indicate which strategy we want for rolling update
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 1
```

#### minReadySeconds

1. **minReadySeconds** is the bootup time of your application, kubernetes waits specific time till the next pod creation.
2. Kubernetes assumes that your application is available once the pod is created by default.
3. If you leave this field empty, the service may be unavailable after the update process because all the application pods are not ready yet.

#### maxSurge

1.  **maxSurge** is number of pods that can get provisioned more than the desired number of Pods. 
2. This field can be an absolute number or the percentage.
3. For instance, if **maxSurge: 1** means that there will be at most 4 pods during the update process if replicas is set to 3

#### maxUnavailable

1. **maxUnavailable** is the amount of pods that can be unavailable during the update process
2. This fields can be a absolute number or the percentage.
3. This field cannot be zero if **maxSurge** is set to 0
4. For instance, if **maxUnavailable: 1** means that there will be at most 1 pod unavailable during the update process.

* The final deployment yaml file will looks like shown below. Save it in a file `rolling-update.yaml`.

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-sample
  labels:
    service-name: deployment-sample
    environment: deployment-sample
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5
  selector:
    matchLabels:
      service-name: deployment-sample
      environment: deployment-sample
  template:
    metadata:
      labels:
        service-name: deployment-sample
        environment: deployment-sample
    spec:
      containers: 
        - image:  ashorg/sample:v1
          name: deployment-sample
          resources:
          ports:
            - containerPort: 8089
```

* Now use the command `kubectl -n devteam apply -f rolling-update.yaml` to apply the Rolling Update change to the Deployment.

### Editing the deployment

* Now, for example, if we want to update the docker image, we have three ways to perform the rolling update.

#### CLI

* One can update the docker image of a deployment using the command in Powershell

E.g. `kubectl -n <namespace-name> set image deployment <deployment> <container>=<image> --record`

```bash
kubectl -n devteam set image deployment deployment-sample deployment-sample=ashorg/sample:v2 --record
```

**Output:**
```
deployment.apps "deployment-sample" image updated
```

#### Replace

* One can update the docker image by directly modifying the YAML file

```yaml 
 containers: 
    # newer image version
  - image:  ashorg/sample:v2
    name: deployment-sample
    resources:
    ports:
      - containerPort: 8089
```

* Use the command to replace  the configuration code `kubectl -n devteam replace -f rolling-update.yaml --record`

#### Edit 

* One can edit the docker image in the currently running deployment by using the command.

```bash
kubectl -n devteam edit deployment deployment-sample --record
```

* This will open the current deployment in a text editor, change the image and save the file. Make sure you follow the YAML syntax properly.

### Checking the Status of the Rolling Update

Check the list of pods for that deployment using the command `kubectl -n devteam get pods` after you edit the deployment. As you can see below it has created extra pods as mentioned in maxSurge.

```bash
kubectl -n devteam get pods
```

**Output:**
```
NAME                                 READY     STATUS        RESTARTS   AGE
deployment-sample-6b44657b4f-89mn6   1/1       Running       0          15s
deployment-sample-6b44657b4f-pzs7b   1/1       Running       0          15s
deployment-sample-b4db4bc54-hpswc    1/1       Running       0          14m
deployment-sample-b4db4bc54-v9z5j    1/1       Running       0          14m
deployment-sample-b4db4bc54-x2ll2    0/1       Terminating   0          13m
```

* Now Let's check the status of the Rolling Update, we use the command.

```bash
kubectl -n devteam rollout status deployment deployment-sample
```
**Output:**

```
deployment "deployment-sample" successfully rolled out
```

### Pause Rolling Update

* To pause a rolling update use the following command shown below.

```bash
kubectl -n devteam rollout pause deployment deployment-sample
```

### Resume Rolling Update

* To resume a rolling update use the command the following command in PowerShell.

`kubectl -n devteam rollout resume deployment deployment-sample`

### Rollback the changes to previous revision

* To Rollback the changes use the following command in PowerShell.

```bash
kubectl -n devteam rollout undo deployment deployment-sample
```

**Output:**
```
deployment.apps "deployment-sample"
```

## Canary Deployment using the Nginx-Ingress Controller

In the following example, we shift traffic between 2 applications using the canary annotations of the Nginx ingress controller.

### Steps to follow

* Version 1 is serving traffic
* Deploy version 2
* Create a new "canary" ingress with traffic splitting enabled
* Wait enough time to confirm that version 2 is stable and not throwing unexpected errors
* Delete the canary ingress
* Point the main application ingress to send traffic to version 2
* Shutdown version 1

* Deploy the ingress-nginx controller using the following yaml configuration code.

``` yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: nginx-configuration
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: tcp-services
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: udp-services
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: nginx-ingress-serviceaccount
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx

---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: nginx-ingress-clusterrole
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
rules:
  - apiGroups:
      - ""
    resources:
      - configmaps
      - endpoints
      - nodes
      - pods
      - secrets
    verbs:
      - list
      - watch
  - apiGroups:
      - ""
    resources:
      - nodes
    verbs:
      - get
  - apiGroups:
      - ""
    resources:
      - services
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - "extensions"
    resources:
      - ingresses
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - ""
    resources:
      - events
    verbs:
      - create
      - patch
  - apiGroups:
      - "extensions"
    resources:
      - ingresses/status
    verbs:
      - update

---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: Role
metadata:
  name: nginx-ingress-role
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
rules:
  - apiGroups:
      - ""
    resources:
      - configmaps
      - pods
      - secrets
      - namespaces
    verbs:
      - get
  - apiGroups:
      - ""
    resources:
      - configmaps
    resourceNames:
      # Defaults to "<election-id>-<ingress-class>"
      # Here: "<ingress-controller-leader>-<nginx>"
      # This has to be adapted if you change either parameter
      # when launching the nginx-ingress-controller.
      - "ingress-controller-leader-nginx"
    verbs:
      - get
      - update
  - apiGroups:
      - ""
    resources:
      - configmaps
    verbs:
      - create
  - apiGroups:
      - ""
    resources:
      - endpoints
    verbs:
      - get

---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: RoleBinding
metadata:
  name: nginx-ingress-role-nisa-binding
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: nginx-ingress-role
subjects:
  - kind: ServiceAccount
    name: nginx-ingress-serviceaccount
    namespace: ingress-nginx

---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: nginx-ingress-clusterrole-nisa-binding
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: nginx-ingress-clusterrole
subjects:
  - kind: ServiceAccount
    name: nginx-ingress-serviceaccount
    namespace: ingress-nginx

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress-controller
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: ingress-nginx
      app.kubernetes.io/part-of: ingress-nginx
  template:
    metadata:
      labels:
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/part-of: ingress-nginx
      annotations:
        prometheus.io/port: "10254"
        prometheus.io/scrape: "true"
    spec:
      serviceAccountName: nginx-ingress-serviceaccount
      containers:
        - name: nginx-ingress-controller
          image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.22.0
          args:
            - /nginx-ingress-controller
            - --configmap=$(POD_NAMESPACE)/nginx-configuration
            - --tcp-services-configmap=$(POD_NAMESPACE)/tcp-services
            - --udp-services-configmap=$(POD_NAMESPACE)/udp-services
            - --publish-service=$(POD_NAMESPACE)/ingress-nginx
            - --annotations-prefix=nginx.ingress.kubernetes.io
          securityContext:
            allowPrivilegeEscalation: true
            capabilities:
              drop:
                - ALL
              add:
                - NET_BIND_SERVICE
            # www-data -> 33
            runAsUser: 33
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          ports:
            - name: http
              containerPort: 80
            - name: https
              containerPort: 443
          livenessProbe:
            failureThreshold: 3
            httpGet:
              path: /healthz
              port: 10254
              scheme: HTTP
            initialDelaySeconds: 10
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
          readinessProbe:
            failureThreshold: 3
            httpGet:
              path: /healthz
              port: 10254
              scheme: HTTP
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
```
* Save it in a file `nginxingress.yml` and deploy using the following command shown below.

```bash
kubectl apply -f /D/Users/PhotonUser/Desktop/nginxingress.yml
```

**Output:**
```
namespace "ingress-nginx" created
configmap "nginx-configuration" created
configmap "tcp-services" created
configmap "udp-services" created
serviceaccount "nginx-ingress-serviceaccount" created
clusterrole.rbac.authorization.k8s.io "nginx-ingress-clusterrole" configured
role.rbac.authorization.k8s.io "nginx-ingress-role" created
rolebinding.rbac.authorization.k8s.io "nginx-ingress-role-nisa-binding" created
clusterrolebinding.rbac.authorization.k8s.io "nginx-ingress-clusterrole-nisa-binding" configured
deployment.apps "nginx-ingress-controller" created
```
* Expose the ingress-nginx using the command shown below.

```bash
kubectl expose deployment -n ingress-nginx nginx-ingress-controller --port 80 --type LoadBalancer --name ingress-nginx
```

**Output:**
```
ingress-nginx exposed
```

* Deploy version 1 and expose the service via an ingress, save the following `application version1` configuration yaml file.

``` yaml 
apiVersion: v1
kind: Service
metadata:
  name: my-app-v1
  labels:
    app: my-app
spec:
  ports:
  - name: http
    port: 80
    targetPort: http
  selector:
    app: my-app
    version: v1.0.0
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-v1
  labels:
    app: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
      version: v1.0.0
  template:
    metadata:
      labels:
        app: my-app
        version: v1.0.0
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9101"
    spec:
      containers:
      - name: my-app
        image: containersol/k8s-deployment-strategies
        ports:
        - name: http
          containerPort: 8080
        - name: probe
          containerPort: 8086
        env:
        - name: VERSION
          value: v1.0.0
        livenessProbe:
          httpGet:
            path: /live
            port: probe
          initialDelaySeconds: 5
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /ready
            port: probe
          periodSeconds: 5
```
* Deploy the version-1 configuration code using the following command in PowerShell.

```bash
kubectl apply -f /D/Users/PhotonUser/Desktop/APP-v1.yaml
```

**Output:**
```
service "my-app-v1" created
deployment.apps "my-app-v1" created
```

* Save the following Ingress.yaml configuration file for nginx with a file name `ingress-nginx-v1.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: my-app
  labels:
    app: my-app
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: my-app.com
    http:
      paths:
      - backend:
          serviceName: my-app-v1
          servicePort: 80

```
* Deploy Ingress configuration code using the following command in PowerShell.

```
kubectl apply -f /D/Users/PhotonUser/Desktop/ingress-nginx-v1.yml
```

**Output:**
```
ingress.extensions "my-app" created
```

* Deploy version 2 and expose the service via an ingress, save the following `application version2` configuration yaml file.

``` yaml 
apiVersion: v1
kind: Service
metadata:
  name: my-app-v2
  labels:
    app: my-app
spec:
  ports:
  - name: http
    port: 80
    targetPort: http
  selector:
    app: my-app
    version: v2.0.0
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-v2
  labels:
    app: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
      version: v2.0.0
  template:
    metadata:
      labels:
        app: my-app
        version: v2.0.0
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9101"
    spec:
      containers:
      - name: my-app
        image: containersol/k8s-deployment-strategies
        ports:
        - name: http
          containerPort: 8080
        - name: probe
          containerPort: 8086
        env:
        - name: VERSION
          value: v2.0.0
        livenessProbe:
          httpGet:
            path: /live
            port: probe
          initialDelaySeconds: 5
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /ready
            port: probe
          periodSeconds: 5
```

* Deploy configuration code of app-version2 using the following command in PowerShell.

```
kubectl apply -f /D/Users/PhotonUser/Desktop/APP-v2.yml
```

**Output:**
```
service "my-app-v2" created
deployment.apps "my-app-v2" created
```

* Get the services in `ingress-nginx` namespace using this command.

```bash
kubectl -n ingress-nginx get svc
```

**Output:**
```
NAME            TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)        AGE
ingress-nginx   LoadBalancer   10.0.1.59    13.68.129.203   80:32758/TCP   7m
```

* In a different terminal you can check that requests are responding with version 1

`nginx_service=$(minikube service ingress-nginx -n ingress-nginx --url)`

`while sleep 0.1; do curl "$nginx_service" -H "Host: my-app.com"; done`

`nginx_service=13.68.129.203`

**Output:**
```
 Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
```

`$ while sleep 0.1; do curl "$nginx_service" -H "Host: my-app.com"; done`

**Output:**
```
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
```

* Create a Canary ingress in order to split traffic: 90% to app v1, 10% to app v2

* Save and deploy the following yaml configuration code, using the following command shown below.

``` yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: my-app-canary
  labels:
    app: my-app
  annotations:
    kubernetes.io/ingress.class: "nginx"

    # Enable canary and send 10% of traffic to version 2
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-weight: "10"
spec:
  rules:
  - host: my-app.com
    http:
      paths:
      - backend:
          serviceName: my-app-v2
          servicePort: 80
```
* Deploy Ingress-configuration code using the following command.

`kubectl create -f /D/Users/PhotonUser/Desktop/ingressnginxcanary-v2.yml`

**Output:**
```
ingress.extensions "my-app-canary" created
```

* Get the ingress using this command `kubectl get ing`, see here address will be the same. 

`kubectl get ing`

**Output:**
```
NAME            HOSTS        ADDRESS         PORTS     AGE
my-app          my-app.com   13.68.129.203   80        6m
my-app-canary   my-app.com   13.68.129.203   80        1m
```

* Now you should see that the traffic is being splitted, run the following command

`$ while sleep 0.1; do curl "$nginx_service" -H "Host: my-app.com"; done`

**Output:**
```
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v1-7496f6b5bc-l77n9, Version: v1.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
```
* When you are happy, delete the Canary ingress, use the following command

`kubectl delete ing my-app-canary`

**Output:**
```
ingress.extensions "my-app-canary" deleted
```

* Then finish to rollout, set 100% traffic to version 2, save the following configuration code and deploy it using the command shown below.

``` yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: my-app
  labels:
    app: my-app
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: my-app.com
    http:
      paths:
      - backend:
          serviceName: my-app-v2
          servicePort: 80
```
* Deploy the Ingress configuration by using the following command.

```bash
kubectl apply -f  /D/Users/PhotonUser/Desktop/ingressv2.yml
```

**Output:**
```
ingress.extensions "my-app" configured
```

* Run the following command, now you should see the traffic goes to version 2

`$ while sleep 0.1; do curl "$nginx_service" -H "Host: my-app.com"; done`

**Output:**
```
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
Host: my-app-v2-6c65ddd65c-th85z, Version: v2.0.0
```

**Conclusion:** Congratulations! You have successfully completed the Kubernetes Deployment Strategies using Rolling updates and Canary Deployments ! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
