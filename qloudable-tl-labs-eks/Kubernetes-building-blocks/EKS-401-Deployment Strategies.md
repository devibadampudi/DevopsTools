# Deployment Strategies

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Rolling Update with Kubernetes Deployments](#rolling-update-with-kubernetes-deployments)

[Canary Deployment using the Nginx-ingress Controller](#canary-deployment-using-the-nginx-ingress-controller)

## Overview

This lab shows you various Kubernetes deployments, users expect applications to be available all the time and developers are expected to deploy new versions of them several times a day. In Kubernetes this is done with rolling updates. Rolling updates allow Deployments update to take place with zero down time.

Introducing new versions of a service, it is often helpful to shift a controlled percentage of user traffic to a newer version of the service in the process of phasing out the older version, by using the functionality of `Canary Deployments` can be done using two Deployments with common pod labels. 

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up fundamental Kubernetes objects -- rolling update, canary deployment. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Cloud Infrastructure, then move into actually creating, editing, and managing objects as you would in a real Kubernetes environment. There are also some helpful exercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn about **Rolling Update** and **Canary Deployment** using the Nginx-Ingress controller.

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

* Once you were provided all those information correctly you will be able to see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >


* In the navigation bar, on the top-right, change region accordingly to provided in above.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

* Click Apps icon in the toolbar and select **Powershell** to open a terminal window.

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

```
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```

## Rolling Update with Kubernetes Deployments

### Rolling Update

A Kubernetes deployment owns and manages one or more **Replica Sets**, and **Replica Set** manages the basic units in Kubernetes Pods. Kubernetes creates a new Replica Set each time after the new deployment config is deployed and keeps the old Replica Set. So that we can rollback to the previous state with old Replica Set. And there is only one Replica Set in active state, which means DESIRED > 0. Kuberentes Deployments also supports rollback support.

### Create a sample Kubernetes Deployment

* Create a namespace using the following command in PowerShell.

```bash
kubectl create ns devteam
```

**Output:**

```bash
devteam namespace created
```

* Create a deployment that creates a replicaset to bring up three **deployment-sample** pods. You can create the deployment in a particular namespace with specification of -n <namespace-name >, if you don't mention namespace while deploying into cluster, the default namespace is used.
 
 * Open the notepad, copy the configuration of the deployment, then paste and save it in a file **deployment-sample.yml**.
 
 * Please make sure "All Files" is selected for "Save as Type" option. Choose the path you want to save the **deployment-sample.yml**    file.

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

`kubectl -n devteam create -f /D/PhotonUser/Desktop/deployment-sample.yaml`

**Output:**

```bash
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
```bash
NAME                                 READY     STATUS    RESTARTS   AGE
deployment-sample-6b44657b4f-5vdnk   1/1       Running   0          6m
deployment-sample-6b44657b4f-gz2dv   1/1       Running   0          6m
deployment-sample-6b44657b4f-xwlpt   1/1       Running   0          6m
```

* Now get the Replica Sets, that got created as part of the deployment using the command.

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

* So we add following part into **spec**

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

1. **minReadySeconds** is the bootup time of your application, Kuberentes waits specific time till the next pod creation.
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

* We have already added to the spec section the final deployment yaml file will look like shown below. Save it in a file `rolling-update.yaml`.

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

* Now use the command `kubectl -n devteam apply -f D/Photonuser/rolling-update.yaml` to apply the Rolling Update change to the Deployment.

### Editing the deployment

* Now, for example, if we want to update the docker image, There are  three ways to perform the rolling update. You can choose any one way to update docker image.

#### CLI

* One can update the docker image of a deployment using the command in PowerShell

E.g. `kubectl -n <namespace-name> set image deployment <deployment> <container>=<image> --record`

```bash
kubectl -n devteam set image deployment deployment-sample deployment-sample=ashorg/sample:v2 --record
```

**Output:**
```
deployment.apps "deployment-sample" image updated
```

* Or you can update the image as following ways.

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

```bash
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

```bash
deployment "deployment-sample" successfully rolled out
```

### Pause Rolling Update

* To pause a rolling update use the followig command shown below.

```bash
kubectl -n devteam rollout pause deployment deployment-sample
```

### Resume Rolling Update

* To resume a rolling update use the command the following command in Powershell.

```bash
kubectl -n devteam rollout resume deployment deployment-sample

```

### Rollback the changes to previous revision

* To Rollback the changes use the following command in Powershell.

```bash
kubectl -n devteam rollout undo deployment deployment-sample
```

**Output:**

```bash
deployment.extensions/deployment-sample rolled back
```

## Canary Deployment using the Nginx-Ingress Controller

In the following example, we shift traffic between 2 applications using the canary annotations of the Nginx ingress controller.

### Steps to follow

* Version 1 is serving traffic
* Deploy version 2
* Create a new "canary" ingress with traffic splitting enabled
* Wait enought time to confirm that version 2 is stable and not throwing unexpected errors
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

* In a different `Gitbash`terminal you can check that requests are responding with version 1

`nginx_service=$(replace with Ingress-nginx loadbalancer service EXTERNAL-IP)`

* Click Apps icon in the toolbar and select **Gitbash** to open a terminal window execute the following commands.

 ```bash
 nginx_service=13.68.129.203
 ```

* Run the following command to check the version of application is routing, use the following command in `Gitbash`

```bash
$ while sleep 0.1; do curl "$nginx_service" -H "Host: my-app.com"; done
```

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

```bash
kubectl get ing
```

**Output:**
```
NAME            HOSTS        ADDRESS         PORTS     AGE
my-app          my-app.com   13.68.129.203   80        6m
my-app-canary   my-app.com   13.68.129.203   80        1m
```

* Now you should see that the traffic is being splitted, run the following command using `Gitbash` terminal

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

```bash
kubectl delete ing my-app-canary
```

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

```bash
$ while sleep 0.1; do curl "$nginx_service" -H "Host: my-app.com"; done
```

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

**Conclusion:** Congratulations! You have successfully completed the Kubernetes Deployment Strategies ! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!


