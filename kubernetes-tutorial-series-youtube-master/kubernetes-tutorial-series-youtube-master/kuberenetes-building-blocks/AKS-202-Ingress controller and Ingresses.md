# Ingress controller and Ingresses

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[Ingress Controllers and Ingresses](#ingress-controllers-and-ingresses)

[Exercises](#exercises)

## Overview

An Ingress is a Kubernetes object that lets you access Kubernetes services from outside of a Kubernetes cluster. Using Ingresses, your routing rules can be consolidated. In order to control the access, you can create rules that define the connections between inbound sources and services. Implementing these objects via a third party proxy is know as an Ingress controller.

Using the pre-provisioned AKS cluster, this lab will walk you through the basics of setting up ingresses. You'll start off by learning how to setup the provided remote desktop to connect to your AKS cluster environment on Azure Cloud Infrastructure, then move into actually creating, editing, and managing ingresses and an ingress controller as you would in a real Kubernetes environment. There are also some helpful exercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn how to create, update, describe, edit, delete a few Kubernetes objects like Ingress controller & Ingresses.

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

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like MC_myResourceGroup_myAKSCluster_eastus. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select PowerShell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the PowerShell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.


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

5. Using this command you get the default namespaces K8's `kubectl get ns`

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

Now that you are able to connect to your cluster successfully, lets start learning about Ingress controller & Ingresses.

## Ingress Controllers and Ingresses

**Ingress Controller**

Ingress controller is a necessary Kuberentes feature which plays a vital role in functioning of **Ingress** resource. The Ingress resources deployed in the cluster are controlled by the ingress controller. 

Unlike other types of controllers which run as part of the **kube-controller-manager** binary, Ingress controller are not started automatically when a cluster is created. It must be deployed into the cluster manually and configured as per one's requirements.

 **Use of multiple Ingress controllers**

One can deploy any number of ingress controllers within a cluster. When one creates an Ingress resource, one must annotate each Ingress resource with the appropriate **ingress.class** to indicate which Ingress Controller to use that exists within your cluster.

**NGINX Ingress Controller for Kubernetes**

The NGINX Ingress Controller for Kubernetes provides enterprise‑grade delivery of services for Kubernetes applications, with benefits of using open source NGINX. 

### Deploying a NGINX Ingress Controller

1. Create a YAML file with the code given below and deploy the Ingress controller and its associated Kuberentes objects. These resources will get created in a separate namespace know as **ingress-nginx**.

2. Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of ingress-controller resources such as service, deployment, along with the Kubernetes RBAC roles and bindings, paste and save it in a file (e.g. ingrctrl.yml). Please make sure `All Files` is selected for `Save as Type` option.

3. Use `---` in a configuration yaml to add multiple Kuberentes objects like services, deployments, configmaps and Service account etc.

``` Yaml
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
      - ""
    resources:
      - events
    verbs:
      - create
      - patch
  - apiGroups:
      - "extensions"
      - "networking.k8s.io"
    resources:
      - ingresses
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - "extensions"
      - "networking.k8s.io"
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
          image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.25.1
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
            timeoutSeconds: 10
          readinessProbe:
            failureThreshold: 3
            httpGet:
              path: /healthz
              port: 10254
              scheme: HTTP
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 10
---
kind: Service
apiVersion: v1
metadata:
  name: ingress-nginx
  namespace: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
spec:
  type: LoadBalancer
  selector:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
  ports:
    - name: http
      port: 80
      targetPort: http
    - name: https
      port: 443
      targetPort: https
```

6. Run the following command to create the nginx-ingress-controller service, deployment, along with the Kubernetes RBAC roles and bindings. Make sure you are in correct path where you saved yaml file. 

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/ingrctrl.yml
```

* Thus one has successfully deployed the Ingress Controller and associated resources on your cluster in the **ingress-nginx** namespace

### Get the pods of the Ingress Controller

7. The pods in **ingress-nginx** namespace belongs to the Ingress Controller deployments. One can view these pods using the command

```bash
kubectl -n ingress-nginx get pods
```

**Output:**
```
NAME                                        READY   STATUS    RESTARTS   AGE
nginx-ingress-controller-7d8c646bc5-cqhrd   1/1     Running   0          66m
```

### Get the services of the Ingress Controller

8. The ingress controller services in ingress-nginx namespace must be of type LoadBalancer so that it uses public Cloud specific Load Balancer resource and Internet traffic enters the cluster through it. One can view the ingress controller service using the command.

```bash
  kubectl -n ingress-nginx  get service
```

**Output:**
```
  NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE
  ingress-nginx          LoadBalancer   10.96.127.87   <pending>   80:30735/TCP,443:30314/TCP   39d
```

The `EXTERNAL-IP` for the ingress-nginx ingress controller service is shown as `<pending>` until the load balancer has been fully created in OCI.

9. Repeat the `kubectl get svc command` until an `EXTERNAL-IP` is shown for the ingress-nginx ingress controller service.

```bash
kubectl get svc -n ingress-nginx
```

**Output:**
```
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE
  ingress-nginx          LoadBalancer   10.96.127.87   129.146.214.219      80:30735/TCP,443:30314/TCP   39d
```

Notice that the **ingress-nginx service** is of type **LoadBalancer** and has an External IP which is the IP associated to the Load Balancer resource that gets deployed in the public cloud.

**Ingresses**

Ingress is a Kuberentes object that allows access to your Kuberentes services from the outside of the Kuberentes cluster. You can configure access by creating a set of rules that defines which inbound internet traffic must reach which Kuberentes service in the cluster.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/ingress.png?st=2019-08-26T09%3A08%3A00Z&se=2022-08-27T09%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=r1r6UtT8yyNgxYA6NtugDv08iwDtvfETKRq%2Bg4DyGXU%3D" alt="image-alt-text" >

10. In this lab deploy a simple web application and then configure load balancing for that application using the Ingress resource.

11. Ingress resources to work within a cluster you must deploy an Ingress Controller prior to deploying an Ingress. The Ingress controller allows the Internet traffic to enter in the Kuberentes cluster.

12. Once ingress-controller setup correctly, you create Ingress resources in the cluster and route internet traffic to the services. Note that Ingress resources are namespace specific.

### Create an Ingress

First let's create a service and deployment to demonstrate how the Ingress resource routes the request to the service. Sample nginx service and deployment configuration as shown below.

* First let's create a namespace `devteam` in order to deploy all the resources related to ingress,  use the following command to create a namespace.

```bash
kubectl create ns devteam
```
**Output:**
```
namespace/devteam created
```

Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of nginx service and deployment configuration, paste and save it in a file (e.g. nginx.yml). Please make sure `All Files` is selected for `Save as Type` option.

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: test-svc
  namespace: devteam
spec:
  selector:
    app: nginx
  ports:
  - port: 8088
    targetPort: 80
  type: ClusterIP  
---
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

13. Deploy a sample nginx serivce and deployment application using the following command. Make sure you are on correct path.

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/nginx.yml
```

14. Now, Let's create an Ingress to route traffic to `test-svc` was created above step while deploying a service. Use the following code to create a Ingress yaml and deploy the Ingress into the cluster. 

15. Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of nginx ingress configuration, paste and save it in a file (e.g. nginx-ing.yml). Please make sure `All Files` is selected for `Save as Type` option.

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ngnix-ing
  namespace: devteam
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
 rules:
  - http:
      paths:
      - backend:
          serviceName: test-svc
          servicePort: 8088
```

**Note:** Make sure you have created serviceName (test-svc)and serviceport(8088) in earlier step.

15. Deploy a sample nginx ingress resource using the following command.

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/nginx-ing.yml
```

**Output:**
```
ingress.extensions/ngnix-ing created
```

### Get the list of Ingress

16. To get the list of Ingress resources in a namespace use the command.

```bash
kubectl -n devteam get ingress
```

**Output:**
```
NAME             HOSTS            ADDRESS          PORTS     AGE
nginx-ing     *                     129.213.181.186   80        5d
```

17. Use the IP address of the nginx-ing resource (e.g. 129.213.181.186) copy and paste it in browser you should get nginx application shown below

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/nginx-output.PNG?st=2019-09-14T07%3A02%3A04Z&se=2022-09-15T07%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5nDv1RB%2Bk805mUS1jC8PpBylh94LzyLzc%2B8iZOBux94%3D" alt="image-alt-text" >

18. Now let's deploy ingress with a hostname , deploy a sample web application then configure load balancing for that application using the Ingress resource.

19. Save the public IP address of the Ingress controller into a shell variable, use the following command to get nginx ingress-controller service `External-IP`.

```bash
kubectl -n ingress-nginx get svc
```
**Output:**
```
NAME            TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)                      AGE
ingress-nginx   LoadBalancer   10.96.47.130   129.213.181.186   80:30551/TCP,443:31798/TCP   65m
```
* Copy the External-IP of `ingress-nginx` service and assign it to variable. Run the following command in `Git bash` terminal. Make sure replace `External-IP` with yours

```bash
IC_IP=XXX.YYY.ZZZ.III 
```

20. Save the HTTPS port of the Ingress controller into a shell variable. Run the following command in `Git bash` terminal.

```bash
IC_HTTPS_PORT=443
```

21. Deploy the Cafe Application using following configuration code contains coffee, tea services and deployments.

22. Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of cafe application(tea and coffee) service and deployment configuration, paste and save it in a file (e.g. cafe.yml). Please make sure `All Files` is selected for `Save as Type` option.

``` Yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: coffee
spec:
  replicas: 1
  selector:
    matchLabels:
      app: coffee
  template:
    metadata:
      labels:
        app: coffee
    spec:
      containers:
      - name: coffee
        image: nginxdemos/hello:plain-text
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: coffee-svc
spec:
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    app: coffee
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tea
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tea 
  template:
    metadata:
      labels:
        app: tea 
    spec:
      containers:
      - name: tea 
        image: nginxdemos/hello:plain-text
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: tea-svc
  labels:
spec:
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    app: tea
```

23. Create the coffee, tea deployments and services using the following command.

```bash
kubectl -n devteam create -f /c/Users/PhotonUser/Desktop/cafe.yml
```
24. Configure Load Balancing

* Create a secret with an SSL certificate and a key, copy keys, open a notepad paste and save it in a file (e.g.cafe-secret.yaml). Please make sure `All Files` is selected for `Save as Type` option.

```Yaml
apiVersion: v1
kind: Secret
metadata:
  name: cafe-secret
type: Opaque
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURMakNDQWhZQ0NRREFPRjl0THNhWFdqQU5CZ2txaGtpRzl3MEJBUXNGQURCYU1Rc3dDUVlEVlFRR0V3SlYKVXpFTE1Ba0dBMVVFQ0F3Q1EwRXhJVEFmQmdOVkJBb01HRWx1ZEdWeWJtVjBJRmRwWkdkcGRITWdVSFI1SUV4MApaREViTUJrR0ExVUVBd3dTWTJGbVpTNWxlR0Z0Y0d4bExtTnZiU0FnTUI0WERURTRNRGt4TWpFMk1UVXpOVm9YCkRUSXpNRGt4TVRFMk1UVXpOVm93V0RFTE1Ba0dBMVVFQmhNQ1ZWTXhDekFKQmdOVkJBZ01Ba05CTVNFd0h3WUQKVlFRS0RCaEpiblJsY201bGRDQlhhV1JuYVhSeklGQjBlU0JNZEdReEdUQVhCZ05WQkFNTUVHTmhabVV1WlhoaApiWEJzWlM1amIyMHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDcDZLbjdzeTgxCnAwanVKL2N5ayt2Q0FtbHNmanRGTTJtdVpOSzBLdGVjcUcyZmpXUWI1NXhRMVlGQTJYT1N3SEFZdlNkd0kyaloKcnVXOHFYWENMMnJiNENaQ0Z4d3BWRUNyY3hkam0zdGVWaVJYVnNZSW1tSkhQUFN5UWdwaW9iczl4N0RsTGM2SQpCQTBaalVPeWwwUHFHOVNKZXhNVjczV0lJYTVyRFZTRjJyNGtTa2JBajREY2o3TFhlRmxWWEgySTVYd1hDcHRDCm42N0pDZzQyZitrOHdnemNSVnA4WFprWldaVmp3cTlSVUtEWG1GQjJZeU4xWEVXZFowZXdSdUtZVUpsc202OTIKc2tPcktRajB2a29QbjQxRUUvK1RhVkVwcUxUUm9VWTNyemc3RGtkemZkQml6Rk8yZHNQTkZ4MkNXMGpYa05MdgpLbzI1Q1pyT2hYQUhBZ01CQUFFd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFLSEZDY3lPalp2b0hzd1VCTWRMClJkSEliMzgzcFdGeW5acS9MdVVvdnNWQTU4QjBDZzdCRWZ5NXZXVlZycTVSSWt2NGxaODFOMjl4MjFkMUpINnIKalNuUXgrRFhDTy9USkVWNWxTQ1VwSUd6RVVZYVVQZ1J5anNNL05VZENKOHVIVmhaSitTNkZBK0NuT0Q5cm4yaQpaQmVQQ0k1ckh3RVh3bm5sOHl3aWozdnZRNXpISXV5QmdsV3IvUXl1aTlmalBwd1dVdlVtNG52NVNNRzl6Q1Y3ClBwdXd2dWF0cWpPMTIwOEJqZkUvY1pISWc4SHc5bXZXOXg5QytJUU1JTURFN2IvZzZPY0s3TEdUTHdsRnh2QTgKN1dqRWVxdW5heUlwaE1oS1JYVmYxTjM0OWVOOThFejM4Zk9USFRQYmRKakZBL1BjQytHeW1lK2lHdDVPUWRGaAp5UkU9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
  tls.key: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBcWVpcCs3TXZOYWRJN2lmM01wUHJ3Z0pwYkg0N1JUTnBybVRTdENyWG5LaHRuNDFrCkcrZWNVTldCUU5semtzQndHTDBuY0NObzJhN2x2S2wxd2k5cTIrQW1RaGNjS1ZSQXEzTVhZNXQ3WGxZa1YxYkcKQ0pwaVJ6ejBza0lLWXFHN1BjZXc1UzNPaUFRTkdZMURzcGRENmh2VWlYc1RGZTkxaUNHdWF3MVVoZHErSkVwRwp3SStBM0kreTEzaFpWVng5aU9WOEZ3cWJRcCt1eVFvT05uL3BQTUlNM0VWYWZGMlpHVm1WWThLdlVWQ2cxNWhRCmRtTWpkVnhGbldkSHNFYmltRkNaYkp1dmRySkRxeWtJOUw1S0Q1K05SQlAvazJsUkthaTAwYUZHTjY4NE93NUgKYzMzUVlzeFR0bmJEelJjZGdsdEkxNURTN3lxTnVRbWF6b1Z3QndJREFRQUJBb0lCQVFDUFNkU1luUXRTUHlxbApGZlZGcFRPc29PWVJoZjhzSStpYkZ4SU91UmF1V2VoaEp4ZG01Uk9ScEF6bUNMeUw1VmhqdEptZTIyM2dMcncyCk45OUVqVUtiL1ZPbVp1RHNCYzZvQ0Y2UU5SNThkejhjbk9SVGV3Y290c0pSMXBuMWhobG5SNUhxSkpCSmFzazEKWkVuVVFmY1hackw5NGxvOUpIM0UrVXFqbzFGRnM4eHhFOHdvUEJxalpzVjdwUlVaZ0MzTGh4bndMU0V4eUZvNApjeGI5U09HNU9tQUpvelN0Rm9RMkdKT2VzOHJKNXFmZHZ5dGdnOXhiTGFRTC94MGtwUTYyQm9GTUJEZHFPZVBXCktmUDV6WjYvMDcvdnBqNDh5QTFRMzJQem9idWJzQkxkM0tjbjMyamZtMUU3cHJ0V2wrSmVPRmlPem5CUUZKYk4KNHFQVlJ6NWhBb0dCQU50V3l4aE5DU0x1NFArWGdLeWNrbGpKNkY1NjY4Zk5qNUN6Z0ZScUowOXpuMFRsc05ybwpGVExaY3hEcW5SM0hQWU00MkpFUmgySi9xREZaeW5SUW8zY2czb2VpdlVkQlZHWTgrRkkxVzBxZHViL0w5K3l1CmVkT1pUUTVYbUdHcDZyNmpleHltY0ppbS9Pc0IzWm5ZT3BPcmxEN1NQbUJ2ek5MazRNRjZneGJYQW9HQkFNWk8KMHA2SGJCbWNQMHRqRlhmY0tFNzdJbUxtMHNBRzR1SG9VeDBlUGovMnFyblRuT0JCTkU0TXZnRHVUSnp5K2NhVQprOFJxbWRIQ2JIelRlNmZ6WXEvOWl0OHNaNzdLVk4xcWtiSWN1YytSVHhBOW5OaDFUanNSbmU3NFowajFGQ0xrCmhIY3FIMHJpN1BZU0tIVEU4RnZGQ3haWWRidUI4NENtWmlodnhicFJBb0dBSWJqcWFNWVBUWXVrbENkYTVTNzkKWVNGSjFKelplMUtqYS8vdER3MXpGY2dWQ0thMzFqQXdjaXowZi9sU1JxM0hTMUdHR21lemhQVlRpcUxmZVpxYwpSMGlLYmhnYk9jVlZrSkozSzB5QXlLd1BUdW14S0haNnpJbVpTMGMwYW0rUlk5WUdxNVQ3WXJ6cHpjZnZwaU9VCmZmZTNSeUZUN2NmQ21mb09oREN0enVrQ2dZQjMwb0xDMVJMRk9ycW40M3ZDUzUxemM1em9ZNDR1QnpzcHd3WU4KVHd2UC9FeFdNZjNWSnJEakJDSCtULzZzeXNlUGJKRUltbHpNK0l3eXRGcEFOZmlJWEV0LzQ4WGY2ME54OGdXTQp1SHl4Wlp4L05LdER3MFY4dlgxUE9ucTJBNWVpS2ErOGpSQVJZS0pMWU5kZkR1d29seHZHNmJaaGtQaS80RXRUCjNZMThzUUtCZ0h0S2JrKzdsTkpWZXN3WEU1Y1VHNkVEVXNEZS8yVWE3ZlhwN0ZjanFCRW9hcDFMU3crNlRYcDAKWmdybUtFOEFSek00NytFSkhVdmlpcS9udXBFMTVnMGtKVzNzeWhwVTl6WkxPN2x0QjBLSWtPOVpSY21Vam84UQpjcExsSE1BcWJMSjhXWUdKQ2toaVd4eWFsNmhZVHlXWTRjVmtDMHh0VGwvaFVFOUllTktvCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==
```

* Use the following command to deploy secrets into the cluster. Make sure you are on correct path

```bash
kubectl -n devteam create -f cafe-secret.yaml
```
25. Create an Ingress resource using the following configuration code and deploy using the following command as shown below.

26. Save the following YAML file with a  filename extension (e.g. .yml), open a notepad copy configuration of cafe ingress resource , paste and save it in a file (e.g. cafe-ingress.yml). Please make sure "All Files" is selected for `Save as Type` option.

``` Yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: cafe-ingress
spec:
  tls:
  - hosts:
    - cafe.example.com
    secretName: cafe-secret
  rules:
  - host: cafe.example.com
    http:
      paths:
      - path: /tea
        backend:
          serviceName: tea-svc
          servicePort: 80
      - path: /coffee
        backend:
          serviceName: coffee-svc
          servicePort: 80
```
* Make sure you are on correct path while deploy the following command.

```bash
kubectl -n devteam create -f cafe-ingress.yaml
```

27. Test the application using the following commands.

To access the application, curl the coffee and the tea services. We will use curl's --insecure option to turn off certificate verification of our self-signed certificate and the --resolve option to set the Host header of a request with cafe.example.com

**To get coffee**

* Execute the following command using `Git bash` terminal

```bash
curl --resolve cafe.example.com:$IC_HTTPS_PORT:$IC_IP https://cafe.example.com:$IC_HTTPS_PORT/coffee --insecure
```

**Output:**

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   160  100   160    0     0    108      0  0:00:01  0:00:01 --:--:--   108Server address: 10.244.4.231:80
Server name: coffee-56668d6f78-mdz9t
Date: 14/Sep/2019:06:11:53 +0000
URI: / coffee
Request ID: 32803242567e73676b8dbc258ff7d022
```

**If your prefer tea**

* Execute the following command using `Git bash` terminal

```bash
curl --resolve cafe.example.com:$IC_HTTPS_PORT:$IC_IP https://cafe.example.com:$IC_HTTPS_PORT/tea --insecure
```

**Output:**
```
 % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   153  100   153    0     0    112      0  0:00:01  0:00:01 --:--:--   113Server address: 10.244.3.30:80
Server name: tea-85f8bf86fd-cxnjj
Date: 14/Sep/2019:06:12:15 +0000
URI: / tea
Request ID: e32c26c3211edb05524c82275ce85ec9
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20oke/usermanual%20images/withhost-outputs.PNG?st=2019-09-14T07%3A34%3A12Z&se=2022-09-15T07%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=f28GYQF6Y9US5zQTYehDHKBHeiVgwMiFundC1NGB%2F0I%3D" alt="image-alt-text" >

### Describe an Ingress

* To describe an Ingress resource in a namespace use the command shown below

```bash
kubectl -n devteam describe ing cafe-ingress
```

**Output:**
```
Name:             cafe-ingress
Namespace:        devteam
Address:          129.213.181.186
Default backend:  default-http-backend:80 (<none>)
TLS:
  cafe-secret terminates cafe.example.com
Rules:
  Host              Path  Backends
  ----              ----  --------
  cafe.example.com
                    /tea      tea-svc:80 (10.244.3.30:80,10.244.4.232:80,10.244.5.62:80)
                    /coffee   coffee-svc:80 (10.244.3.29:80,10.244.4.231:80)
Annotations:
  field.cattle.io/publicEndpoints:                   [{"addresses":["129.213.181.186"],"port":443,"protocol":"HTTPS","serviceName":"devteam:tea-svc","ingressName":"devteam:cafe-ingress","hostname":"cafe.example.com","path":"/tea","allNodes":false},{"addresses":["129.213.181.186"],"port":443,"protocol":"HTTPS","serviceName":"devteam:coffee-svc","ingressName":"devteam:cafe-ingress","hostname":"cafe.example.com","path":"/coffee","allNodes":false}]
  kubectl.kubernetes.io/last-applied-configuration:  {"apiVersion":"extensions/v1beta1","kind":"Ingress","metadata":{"annotations":{},"name":"cafe-ingress","namespace":"devteam"},"spec":{"rules":[{"host":"cafe.example.com","http":{"paths":[{"backend":{"serviceName":"tea-svc","servicePort":80},"path":"/tea"},{"backend":{"serviceName":"coffee-svc","servicePort":80},"path":"/coffee"}]}}],"tls":[{"hosts":["cafe.example.com"],"secretName":"cafe-secret"}]}}

Events:
  Type    Reason  Age                  From                      Message
  ----    ------  ----                 ----                      -------
  Normal  UPDATE  8s (x581 over 145m)  nginx-ingress-controller  Ingress devteam/cafe-ingress
  Normal  UPDATE  8s (x581 over 145m)  nginx-ingress-controller  Ingress devteam/cafe-ingress                        
```

### Edit an Ingress

* Use **PowerShell**, To edit an Ingress resource in a namespace use the command

```bash
kubectl -n devteam edit ingress cafe-ingress
```

The currently deployed Ingress resource YAML will be opened in a text editor and you can edit as per the requirement then save the file, this will update the Ingress resource successfully. Make sure the YAML syntax is followed.

### Delete an Ingress

* To delete an Ingress resource in a namespace use the command

```bash
kubectl -n devteam delete ingress cafe-ingress
```

This will delete the ingress resource.

### Clean up resources

* To clean up a resources in a namespace `devteam`, delete the namespace using the following command

```bash
kubectl delete ns devteam
```

## Exercises


1. List-out the ingress with specified namespace

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam get ing
```

</p>
</details>

2. Describe the ingress with specified namespace

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam describe ing ngnix-ing
```
</p>
</details>

3. Edit a ingress to update more resources

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam edit ing ngnix-ing

```
</p>
</details>

4. Delete the ingress resource 

<details><summary>show</summary>
<p>

```bash
kubectl -n devteam delete ing ngnix-ing

```
</p>
</details>

 **Conclusion:** Congratulations! You have successfully completed the Ingress controller and Ingresses  ! . Feel free to continue exploring or start a new lab.

**References**

1. https://github.com/nginxinc/kubernetes-ingress/tree/master/examples/complete-example

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
