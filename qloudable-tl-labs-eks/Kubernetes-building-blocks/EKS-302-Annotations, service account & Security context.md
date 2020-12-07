# Annotations, Service Account & Security Context

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-eks-cluster)

[Annotations](#annotations)

[Service Account](#Service-account)

[Security Context](#securitycontext)

[Exercises](#exercises)

## Overview

Kubernetes **Annotations** are used as metadata to objects, metadata that is often arbitrary and non-identifying. This metadata can be retrieved by tools and libraries. 

**Service Account** provides an identity for processes that run in a pod. 

**Security Context** sets the privileges and access control parameters for pods and containers.

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up these objects. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS Management console, then move into actually creating, editing, and managing annotations, Service Accounts, and security contexts as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

By the end of this lab, you'll learn how to create Annotations, Service Accounts, and Security Contexts.

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

* Using this command you get the default namespaces `kubectl get ns`

`kubectl get ns`

**Output:**

```
NAME          STATUS    AGE
default       Active    8m
kube-public   Active    8m
kube-system   Active    8m

```
## Annotations

Just like labels, annotations can be used to enrich your metadata
with key value pairs, which most applications may use to process in additional 
parameters or customized settings.
Unlike labels there are no restrictions on what characters can be used.

```
"metadata": {
  "annotations": {
    "key1" : "value1",
    "key2" : "value2"
  }
}
```

* Build, release, or image information like timestamps, release IDs, git branch, PR numbers, image hashes, and registry address.

* Pointers to logging, monitoring, analytics, or audit repositories.

* Client library or tool information that can be used for debugging purposes: for example, name, version, and build information.

* User or tool/system provenance information, such as URLs of related objects from other ecosystem components.

* Lightweight rollout tool metadata: for example, config or checkpoints.

Instead of using annotations, you could store this type of information in an external database or directory, but that would make it much harder to produce shared client libraries and tools for deployment, management, introspection, and the like.


## Service Account

A Service Account is just like any other user with respect to the cluster. Every pod runs in the cluster with the identity of the service account. If no service account is provided the default service account is used. The default service account is created when the namespace is created. If the pod needs to access any of the kubernetes api then it needs to have higher privileges in the cluster level.

* Just like a users privileges are determined by the role which the rolebinding binds them to. The service account can also be assigned a role using its own role binding.

* In this account it is assigned the role of edit.

* In this way the access of the pods to Kubernetes API can be controlled

* First create a service account using the following yaml configuration code, Save the following **ServiceAccount** YAML file with a filename extension (e.g. .yml), open a notepad copy configuration of **ServiceAccount**, paste and save it in a file (e.g.ServiceAccount.yml). Please make sure "All Files" is selected for "Save as Type" option.

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: account
```

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/ServiceAccount.yml
```

```bash
ServiceAccount account created 
```


* Then create a deployment by using the following configuration code, Save the following **Deployment** YAML file with a filename extension (e.g. .yml), open a notepad copy configuration of **Deployment**, paste and save it in a file (e.g.ubuntu.yml). Please make sure "All Files" is selected for "Save as Type" option.

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: ubuntu
  name: ubuntu
spec:
  replicas: 1
  selector:
    matchLabels:
      run: ubuntu
  template:
    metadata:
      labels:
        run: ubuntu
    spec:
      serviceAccountName: account
      containers:
      - image: ubuntu
        imagePullPolicy: Always
        command: ["sleep"]
        args: ["30d"]
        name: ubuntu
      restartPolicy: Always
      securityContext: 
         runAsUser: 0
```

* Deploy a yaml configuration code, using the following command in Powershell

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/ubuntu.yml
```

* Execute the following command to list-out the pods.

```bash
kubectl get pods
```

**Output:**
```
NAME                      READY     STATUS    RESTARTS   AGE
ubuntu-7b94cb6fd6-p69tg   1/1       Running   0          52s
```
* Get a shell into a running Container.

```bash
kubectl exec -it ubuntu-7b94cb6fd6-p69tg bash
```

### Without Rolebinding

* serviceccounts can be added when required. Each pod is associated with exactly one serviceAccount but multiple pods can use the same serviceaccount.

* a pod can only use a serviceaccount from the same namespace.

* You can assign a serviceaccount to a pod by specifying the account’s name in the pod manifest. If you don’t assign it explicitly the pod will use the default serviceaccount in the namespace

* The default permissions for a ServiceAccount dont allow it to list or modify any resources. The default Service- Account isnt allowed to view cluster state let alone modify it in any way

* By default, the default serviceAccount in a namespace has no permissions other than those of an unauthenticated user.

* Therefore pods by default can’t even view cluster state. Its up to you to grant them appropriate permissions to do that.

**installing curl using the following command**

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# apt-get update && apt-get install -y curl
```

**Output:**
```
Get:1 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
Get:2 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
Get:3 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [721 kB]
Get:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:5 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
```

#### Here is where the serviceaccount token is created

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
```

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# echo $TOKEN
```

**Output:**
```
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImFjY291bnQtdG9rZW4tMng4dzIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjhiMDI2YWNhLTlkNjEtMTFlOS1iYzZhLWIyN2YxYWMwNWE2OSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmFjY291bnQifQ.QOFGcLdALd8PU2CLAByc56oTcBuFt6it5PSwna8FiUZLy0Dz_An0JhILO-o9gyjMvoeniOIzinPN-6M8oavAKxxgSYar3sKu7Qf1efw8EIUwi8uSXE2sd9xco98TswZz0-G45GmIrlo7qeYz1LBapGd2s5i8Rd_AOkF_0TP8m1H6hRPMrtzxPb8pDiXowQ-YvGZrXAAYjVUfG16Sg648dOnlFPJN7uGqmiGsjQX8ZqUb54VmDU5eedyCMFr4zDnwDp7coyN5_v42v-E23iAD1AGkeSrhrjU3UnPnGOwgY-maOfdX854fiUpmET8aq7tvu_F9bMNWuhWRp52BXz6v8v0EsP9ZCHcOVA27fFLKLZQdxbIazeUiUaCh0nypHjbAJFo1sInHhXpekJOfjb8aROkR41-DFoWA4L6wQD3kpC0J4rHMTVdTpu0LHCm-uDJdzdJuQzb8cwgzMWAs2O36wC0YbESuvia0BLbBlUlcVRPy5BZhIllqwYjTy-8QFPtibkkz6FS5euMEPpJlVsKZlO5LVZG3TiV-rJrMTdSz_eG41W8-huEQu0qrd7gdp51t2quKRrnYfEtEO8Ol9PPSTmDCgIRJu3Cv7D4JMZuGNjxTfWvM26_wBCnoSrfUgQ3VuzTuP5XtnbO9lw8UCWmNfYASSA9CvxSDFOA1iHEdL_Y
```
#### This is the default service in the default namespace for kubernetes API

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# API_SVC="https://kubernetes.default" ns=default
```

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# echo $API_SVC
```

**Output:**
```
https://kubernetes.default
```

#### This is setting the url to get all pods in the namespace

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# ns=default
```

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# API_POD_URL="$API_SVC"/api/v1/namespaces/default/pods/
```

```bash
root@ubuntu-7b94cb6fd6-p69tg:/# curl -s -X GET --header "Authorization: Bearer $TOKEN" --insecure $API_POD_URL
```

**Output:**
```
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {

  },
  "status": "Failure",
  "message": "pods is forbidden: User \"system:serviceaccount:default:account\" cannot list resource \"pods\" in API group \"\" in the namespace \"default\"",
  "reason": "Forbidden",
  "details": {
    "kind": "pods"
  },
  "code": 403
}
```

* as can be seen above "pods is forbidden: User \"system:serviceaccount:default:account\" cannot list resource \"pods\" in API group \"\" in the namespace \"default\"",.

* Type `exit` to exit out of the container.

### with Rolebinding

* Save the following configuration code in a yaml file and Deploy the Rolebinding configuration using the following command.

* when given proper role and role binding like below.

``` yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: account
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: edit
subjects:
- kind: ServiceAccount
  name: account
  namespace: default
```
* Apply the rolebinding, by executing the following command.

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/rolebinding.yml
```
**Output:**

```bash
RoleBinding account created

```

* Giving all your serviceAccounts the clusteradmin clusterrole is a bad idea its best to give everyone only the permissions they need to do their job and not a single permission more

* It’s a good idea to create a specific serviceAccount for each pod and then associate it with a tailor-made role or a clusterrole through a rolebinding

* If one of your pods only needs to read pods while the other also needs to modify them then create two different serviceaccounts and make those pods use them by specifying the serviceaccountName property in the pod spec


* Retry the commands in the pods was used in previous steps, you will see the commands are successful

* Exec into the contaier using the following command, Replace podname with yours

```bash
kubectl exec -it ubuntu-7b94cb6fd6-p69tg bash
```
* You can also try to get all services in default namespace

```bash
API_SVC_URL="$API_SVC"/api/v1/namespaces/"$ns"/services/
```

```bash
curl -s -X GET --header "Authorization: Bearer $TOKEN" --insecure $API_SVC_URL
```

```bash
API_DEP_URL="$API_SVC"/api/v1/namespaces/"$ns"/deployments/
```

```bash
curl -s -X GET --header "Authorization: Bearer $TOKEN" --insecure $API_DEP_URL
```

```bash
bashroot@ubuntu-7b94cb6fd6-7v2x6:/# apt-get update && apt-get install -y curl
```

**Output:**
```
Hit:1 http://archive.ubuntu.com/ubuntu bionic InRelease
Get:2 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:3 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
Get:4 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
Fetched 252 kB in 1s (308 kB/s)
Reading package lists... Done
Reading package lists... Done
Building dependency tree
Reading state information... Done
curl is already the newest version (7.58.0-2ubuntu3.7).
0 upgraded, 0 newly installed, 0 to remove and 7 not upgraded.
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
```
```bash
root@ubuntu-7b94cb6fd6-7v2x6:/#  echo $TOKEN
```

**Output:**
```
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImFjY291bnQtdG9rZW4tMng4dzIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjhiMDI2YWNhLTlkNjEtMTFlOS1iYzZhLWIyN2YxYWMwNWE2OSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmFjY291bnQifQ.QOFGcLdALd8PU2CLAByc56oTcBuFt6it5PSwna8FiUZLy0Dz_An0JhILO-o9gyjMvoeniOIzinPN-6M8oavAKxxgSYar3sKu7Qf1efw8EIUwi8uSXE2sd9xco98TswZz0-G45GmIrlo7qeYz1LBapGd2s5i8Rd_AOkF_0TP8m1H6hRPMrtzxPb8pDiXowQ-YvGZrXAAYjVUfG16Sg648dOnlFPJN7uGqmiGsjQX8ZqUb54VmDU5eedyCMFr4zDnwDp7coyN5_v42v-E23iAD1AGkeSrhrjU3UnPnGOwgY-maOfdX854fiUpmET8aq7tvu_F9bMNWuhWRp52BXz6v8v0EsP9ZCHcOVA27fFLKLZQdxbIazeUiUaCh0nypHjbAJFo1sInHhXpekJOfjb8aROkR41-DFoWA4L6wQD3kpC0J4rHMTVdTpu0LHCm-uDJdzdJuQzb8cwgzMWAs2O36wC0YbESuvia0BLbBlUlcVRPy5BZhIllqwYjTy-8QFPtibkkz6FS5euMEPpJlVsKZlO5LVZG3TiV-rJrMTdSz_eG41W8-huEQu0qrd7gdp51t2quKRrnYfEtEO8Ol9PPSTmDCgIRJu3Cv7D4JMZuGNjxTfWvM26_wBCnoSrfUgQ3VuzTuP5XtnbO9lw8UCWmNfYASSA9CvxSDFOA1iHEdL_Y
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# API_SVC="https://kubernetes.default" ns=default
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# echo $API_SVC
```

**Output:**
```
https://kubernetes.default
```
* Run the following commands

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# ns=default
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# API_POD_URL="$API_SVC"/api/v1/namespaces/default/pods/
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# API_POD_URL="$API_SVC"/api/v1/namespaces/default/pods/
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# echo $API_POD_URL
```

**Output:**
```
https://kubernetes.default/api/v1/namespaces/default/pods/
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# curl -s -X GET --header "Authorization: Bearer $TOKEN" --insecure $API_POD_URL
```

**Output:**

```
{
  "kind": "PodList",
  "apiVersion": "v1",
  "metadata": {
    "selfLink": "/api/v1/namespaces/default/pods/",
    "resourceVersion": "4186125"
  },
  "items": [
    {
      "metadata": {
        "name": "ubuntu-7b94cb6fd6-7v2x6",
        "generateName": "ubuntu-7b94cb6fd6-",
        "namespace": "default",
        "selfLink": "/api/v1/namespaces/default/pods/ubuntu-7b94cb6fd6-7v2x6",
        "uid": "e950bace-9e10-11e9-bc6a-b27f1ac05a69",
        "resourceVersion": "4176556",
        "creationTimestamp": "2019-07-04T04:05:08Z",
        "labels": {
          "pod-template-hash": "7b94cb6fd6",
          "run": "ubuntu"
        },
        "ownerReferences": [
          {
            "apiVersion": "apps/v1",
            "kind": "ReplicaSet",
            "name": "ubuntu-7b94cb6fd6",
            "uid": "e94605a4-9e10-11e9-bc6a-b27f1ac05a69",
            "controller": true,
            "blockOwnerDeletion": true
          }
        ]
      },
      "spec": {
        "volumes": [
          {
            "name": "account-token-2x8w2",
            "secret": {
              "secretName": "account-token-2x8w2",
              "defaultMode": 420
            }
          }
        ],
        "containers": [
          {
            "name": "ubuntu",
            "image": "ubuntu",
            "command": [
              "sleep"
            ],
            "args": [
              "30d"
            ],
            "env": [
              {
                "name": "KUBERNETES_PORT_443_TCP_ADDR",
                "value": "oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io"
              },
              {
                "name": "KUBERNETES_PORT",
                "value": "tcp://oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io:443"
              },
              {
                "name": "KUBERNETES_PORT_443_TCP",
                "value": "tcp://oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io:443"
              },
              {
                "name": "KUBERNETES_SERVICE_HOST",
                "value": "oke-cluste-oke-rbac-cluster-05246c-30e0f23f.hcp.westus2.azmk8s.io"
              }
            ],
            "resources": {

            },
            "volumeMounts": [
              {
                "name": "account-token-2x8w2",
                "readOnly": true,
                "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount"
              }
            ],
            "terminationMessagePath": "/dev/termination-log",
            "terminationMessagePolicy": "File",
            "imagePullPolicy": "Always"
          }
        ],
        "restartPolicy": "Always",
        "terminationGracePeriodSeconds": 30,
        "dnsPolicy": "ClusterFirst",
        "serviceAccountName": "account",
        "serviceAccount": "account",
        "nodeName": "oke-nodepool1-18284211-0",
        "securityContext": {
          "runAsUser": 0
        },
        "schedulerName": "default-scheduler",
        "tolerations": [
          {
            "key": "node.kubernetes.io/not-ready",
            "operator": "Exists",
            "effect": "NoExecute",
            "tolerationSeconds": 300
          },
          {
            "key": "node.kubernetes.io/unreachable",
            "operator": "Exists",
            "effect": "NoExecute",
            "tolerationSeconds": 300
          }
        ],
        "priority": 0
      },
      "status": {
        "phase": "Running",
        "conditions": [
          {
            "type": "Initialized",
            "status": "True",
            "lastProbeTime": null,
            "lastTransitionTime": "2019-07-04T04:05:08Z"
          },
          {
            "type": "Ready",
            "status": "True",
            "lastProbeTime": null,
            "lastTransitionTime": "2019-07-04T04:05:11Z"
          },
          {
            "type": "ContainersReady",
            "status": "True",
            "lastProbeTime": null,
            "lastTransitionTime": "2019-07-04T04:05:11Z"
          },
          {
            "type": "PodScheduled",
            "status": "True",
            "lastProbeTime": null,
            "lastTransitionTime": "2019-07-04T04:05:08Z"
          }
        ],
        "hostIP": "10.240.0.4",
        "podIP": "10.240.0.5",
        "startTime": "2019-07-04T04:05:08Z",
        "containerStatuses": [
          {
            "name": "ubuntu",
            "state": {
              "running": {
                "startedAt": "2019-07-04T04:05:11Z"
              }
            },
            "lastState": {

            },
            "ready": true,
            "restartCount": 0,
            "image": "ubuntu:latest",
            "imageID": "docker-pullable://ubuntu@sha256:9b1702dcfe32c873a770a32cfd306dd7fc1c4fd134adfb783db68defc8894b3c",
            "containerID": "docker://a55615124dadcc8addb0bd80c9f4da747ae91c5ad3b682c71404e01df1cd2e9b"
          }
        ],
        "qosClass": "BestEffort"
      }
    }
  ]
}
```
* Now you able to list the resurce service.

* The following commands should fail since you are limited to this namespace by the rolebinding and not in **kube-system** namespace.

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# ns=kube-system
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/#API_POD_URL="$API_SVC"/api/v1/namespaces/kube-system/pods/
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/#API_POD_URL="$API_SVC"/api/v1/namespaces/kube-system/pods/
```

```bash
root@ubuntu-7b94cb6fd6-7v2x6:/# curl -s -X GET --header "Authorization: Bearer $TOKEN" --insecure $API_POD_URL
```

**Output:**
```
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {

  },
  "status": "Failure",
  "message": "pods is forbidden: User \"system:serviceaccount:default:account\" cannot list resource \"pods\" in API group \"\" in the namespace \"kube-system\"",
  "reason": "Forbidden",
  "details": {
    "kind": "pods"
  },
  "code": 403
}root@ubuntu-7b94cb6fd6-7v2x6:/#
```
* Type `exit` to get out of the container.

* as can be seen above "pods is forbidden: User \"system:serviceaccount:default:account\" cannot list resource \"pods\" in API group \"\" in the namespace \"kube-system\"",.

## Security Context

* A Security Context defines the operating system security settings (uid, gid, capabilities, SELinux role, etc applied to a container).

* Both pods and containers can have securityContext field in their spec.

* If both are set then escalation privileges field determines whether the container privileges are escalated or not.

* The value of this field determines the privileges on the host vm, of the user that is running the container/pods

* By default most containers start as root user, but this is not good for production systems where a malicious actor can obtain access to underlying vm. There is a difference in the root user in the container and root user on the host machine, the root user can only become complete root user on the host if privileged is set to true or escalation of privileges is set to true.

* Deploy the following yaml configuration code save it in a file with name of `ubuntu-privilage.yaml`

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: ubuntu
  name: ubuntuprivileged
spec:
  replicas: 1
  selector:
    matchLabels:
      run: ubuntu
  template:
    metadata:
      labels:
        run: ubuntu
    spec:
      containers:
      - image: ubuntu
        imagePullPolicy: Always
        command: ["sleep"]
        args: ["30d"]
        name: ubuntu
        volumeMounts:
        - name: all
          mountPath: /host
        securityContext:
          runAsUser: 0
          privileged: true
      volumes:
      - name: all
        hostPath: 
         path: /    
      restartPolicy: Always
      securityContext: 
         runAsUser: 0
```

* Deploy the yaml configuration code using the following command.

```bash
kubectl create -f /D/Users/PhotonUser/Desktop/ubuntu-privilage.yaml
```

* List-out the the pods using the following command.

```bash
kubectl get pods
```

**Output:**

```
NAME                                       READY   STATUS    RESTARTS   AGE
ubuntu0wvolprivileged-7475f6df7c-4lbqf     1/1     Running   0          9m45
```

* The `runAsUser` field defines which users a container can run as. Most commonly, it is used to prevent pods from running as the root user.

* Get a shell into the container using the following command

`kubectl exec -it ubuntu0wvolprivileged-7475f6df7c-4lbqf bash`

* Run the following command `id`

```bash
root@ubuntuprivileged-7475f6df7c-j5vnd:/# id
```

**Output:**

```
uid=0(root) gid=0(root) groups=0(root)
```
* Now you will see that gid is 0 which is same as `runAsGroup` specified in a yaml configuration file, the primary group ID of the containers will be root(0).

```bash
root@ubuntuprivileged-7475f6df7c-j5vnd:/# ls -ltr /host/proc/1/map_files
```

**Output:**
```
total 0
lr-------- 1 root root 64 Jul  3 04:22 7f9472496000-7f9472497000 -> /lib/x86_64-linux-gnu/ld-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9472495000-7f9472496000 -> /lib/x86_64-linux-gnu/ld-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9472270000-7f9472296000 -> /lib/x86_64-linux-gnu/ld-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f947226d000-7f947226e000 -> /lib/x86_64-linux-gnu/libselinux.so.1
lr-------- 1 root root 64 Jul  3 04:22 7f947226c000-7f947226d000 -> /lib/x86_64-linux-gnu/libselinux.so.1
lr-------- 1 root root 64 Jul  3 04:22 7f947206d000-7f947226c000 -> /lib/x86_64-linux-gnu/libselinux.so.1
lr-------- 1 root root 64 Jul  3 04:22 7f947204e000-7f947206d000 -> /lib/x86_64-linux-gnu/libselinux.so.1
lr-------- 1 root root 64 Jul  3 04:22 7f947204d000-7f947204e000 -> /lib/x86_64-linux-gnu/libcap.so.2.24
lr-------- 1 root root 64 Jul  3 04:22 7f947204c000-7f947204d000 -> /lib/x86_64-linux-gnu/libcap.so.2.24
lr-------- 1 root root 64 Jul  3 04:22 7f9471e4c000-7f947204c000 -> /lib/x86_64-linux-gnu/libcap.so.2.24
lr-------- 1 root root 64 Jul  3 04:22 7f9471e48000-7f9471e4c000 -> /lib/x86_64-linux-gnu/libcap.so.2.24
lr-------- 1 root root 64 Jul  3 04:22 7f9471e47000-7f9471e48000 -> /lib/x86_64-linux-gnu/librt-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9471e46000-7f9471e47000 -> /lib/x86_64-linux-gnu/librt-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9471c47000-7f9471e46000 -> /lib/x86_64-linux-gnu/librt-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9471c40000-7f9471c47000 -> /lib/x86_64-linux-gnu/librt-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9471c3f000-7f9471c40000 -> /lib/x86_64-linux-gnu/libseccomp.so.2.4.1
lr-------- 1 root root 64 Jul  3 04:22 7f9471c28000-7f9471c3f000 -> /lib/x86_64-linux-gnu/libseccomp.so.2.4.1
lr-------- 1 root root 64 Jul  3 04:22 7f9471a28000-7f9471c28000 -> /lib/x86_64-linux-gnu/libseccomp.so.2.4.1
lr-------- 1 root root 64 Jul  3 04:22 7f94719f9000-7f9471a28000 -> /lib/x86_64-linux-gnu/libseccomp.so.2.4.1
lr-------- 1 root root 64 Jul  3 04:22 7f94719f8000-7f94719f9000 -> /lib/x86_64-linux-gnu/libpam.so.0.83.1
lr-------- 1 root root 64 Jul  3 04:22 7f94719f7000-7f94719f8000 -> /lib/x86_64-linux-gnu/libpam.so.0.83.1
lr-------- 1 root root 64 Jul  3 04:22 7f94717f8000-7f94719f7000 -> /lib/x86_64-linux-gnu/libpam.so.0.83.1
lr-------- 1 root root 64 Jul  3 04:22 7f94717eb000-7f94717f8000 -> /lib/x86_64-linux-gnu/libpam.so.0.83.1
lr-------- 1 root root 64 Jul  3 04:22 7f94717e0000-7f94717e1000 -> /lib/x86_64-linux-gnu/libaudit.so.1.0.0
lr-------- 1 root root 64 Jul  3 04:22 7f94717df000-7f94717e0000 -> /lib/x86_64-linux-gnu/libaudit.so.1.0.0
lr-------- 1 root root 64 Jul  3 04:22 7f94715e0000-7f94717df000 -> /lib/x86_64-linux-gnu/libaudit.so.1.0.0
lr-------- 1 root root 64 Jul  3 04:22 7f94715c4000-7f94715e0000 -> /lib/x86_64-linux-gnu/libaudit.so.1.0.0
lr-------- 1 root root 64 Jul  3 04:22 7f94715c3000-7f94715c4000 -> /lib/x86_64-linux-gnu/libkmod.so.2.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94715c2000-7f94715c3000 -> /lib/x86_64-linux-gnu/libkmod.so.2.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94713c3000-7f94715c2000 -> /lib/x86_64-linux-gnu/libkmod.so.2.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94713ad000-7f94713c3000 -> /lib/x86_64-linux-gnu/libkmod.so.2.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94713ac000-7f94713ad000 -> /lib/x86_64-linux-gnu/libapparmor.so.1.4.0
lr-------- 1 root root 64 Jul  3 04:22 7f94713ab000-7f94713ac000 -> /lib/x86_64-linux-gnu/libapparmor.so.1.4.0
lr-------- 1 root root 64 Jul  3 04:22 7f94711ac000-7f94713ab000 -> /lib/x86_64-linux-gnu/libapparmor.so.1.4.0
lr-------- 1 root root 64 Jul  3 04:22 7f947119d000-7f94711ac000 -> /lib/x86_64-linux-gnu/libapparmor.so.1.4.0
lr-------- 1 root root 64 Jul  3 04:22 7f947119b000-7f947119c000 -> /lib/x86_64-linux-gnu/libmount.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f947119a000-7f947119b000 -> /lib/x86_64-linux-gnu/libmount.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f9470f9a000-7f947119a000 -> /lib/x86_64-linux-gnu/libmount.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f9470f56000-7f9470f9a000 -> /lib/x86_64-linux-gnu/libmount.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f9470f51000-7f9470f52000 -> /lib/x86_64-linux-gnu/libpthread-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9470f50000-7f9470f51000 -> /lib/x86_64-linux-gnu/libpthread-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9470d51000-7f9470f50000 -> /lib/x86_64-linux-gnu/libpthread-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9470d39000-7f9470d51000 -> /lib/x86_64-linux-gnu/libpthread-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9470d33000-7f9470d35000 -> /lib/x86_64-linux-gnu/libc-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9470d2f000-7f9470d33000 -> /lib/x86_64-linux-gnu/libc-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f9470b2f000-7f9470d2f000 -> /lib/x86_64-linux-gnu/libc-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f947096f000-7f9470b2f000 -> /lib/x86_64-linux-gnu/libc-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f947096e000-7f947096f000 -> /lib/x86_64-linux-gnu/libpcre.so.3.13.2
lr-------- 1 root root 64 Jul  3 04:22 7f947096d000-7f947096e000 -> /lib/x86_64-linux-gnu/libpcre.so.3.13.2
lr-------- 1 root root 64 Jul  3 04:22 7f947076d000-7f947096d000 -> /lib/x86_64-linux-gnu/libpcre.so.3.13.2
lr-------- 1 root root 64 Jul  3 04:22 7f94706ff000-7f947076d000 -> /lib/x86_64-linux-gnu/libpcre.so.3.13.2
lr-------- 1 root root 64 Jul  3 04:22 7f94706fe000-7f94706ff000 -> /lib/x86_64-linux-gnu/libdl-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f94706fd000-7f94706fe000 -> /lib/x86_64-linux-gnu/libdl-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f94704fe000-7f94706fd000 -> /lib/x86_64-linux-gnu/libdl-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f94704fb000-7f94704fe000 -> /lib/x86_64-linux-gnu/libdl-2.23.so
lr-------- 1 root root 64 Jul  3 04:22 7f94704f9000-7f94704fa000 -> /lib/x86_64-linux-gnu/libblkid.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f94704f5000-7f94704f9000 -> /lib/x86_64-linux-gnu/libblkid.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f94702f6000-7f94704f5000 -> /lib/x86_64-linux-gnu/libblkid.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f94702ba000-7f94702f6000 -> /lib/x86_64-linux-gnu/libblkid.so.1.1.0
lr-------- 1 root root 64 Jul  3 04:22 7f94702b9000-7f94702ba000 -> /lib/x86_64-linux-gnu/libuuid.so.1.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94702b8000-7f94702b9000 -> /lib/x86_64-linux-gnu/libuuid.so.1.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94700b9000-7f94702b8000 -> /lib/x86_64-linux-gnu/libuuid.so.1.3.0
lr-------- 1 root root 64 Jul  3 04:22 7f94700b5000-7f94700b9000 -> /lib/x86_64-linux-gnu/libuuid.so.1.3.0
lr-------- 1 root root 64 Jul  3 04:22 564297d0f000-564297d10000 -> /lib/systemd/systemd
lr-------- 1 root root 64 Jul  3 04:22 564297ceb000-564297d0f000 -> /lib/systemd/systemd
lr-------- 1 root root 64 Jul  3 04:22 564297b8d000-564297cea000 -> /lib/systemd/system
```
* Type `exit` to get out of the container

```bash
root@ubuntuprivileged-7475f6df7c-j5vnd:/# exit
```
* Save the following deployment yaml configuration code with a file `ubuntunosec.yaml`

``` yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: ubuntu
  name: ubuntunosecuritycontext
spec:
  replicas: 1
  selector:
    matchLabels:
      run: ubuntu
  template:
    metadata:
      labels:
        run: ubuntu
    spec:
      containers:
      - image: ubuntu
        imagePullPolicy: Always
        command: ["sleep"]
        args: ["30d"]
        name: ubuntu
        volumeMounts:
        - name: all
          mountPath: /host
      volumes:
      - name: all
        hostPath: 
         path: /    
      restartPolicy: Always
```
* Deploy a yaml configuration code using the following command.

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/ubuntunosecuritycontext.yaml
```
* Get the pods using the command 

```bash
kubectl get pods
```

**Output:**
```
NAME                                       READY   STATUS    RESTARTS   AGE
ubuntu0wvolprivileged-7475f6df7c-4lbqf     1/1     Running   0          9m45
ubuntunosecuritycontext-7ddff8d96c-749lb   1/1     Running   0          3m31
```

* Get a shell into the container using the following command.

```bash
kubectl exec -it ubuntunosecuritycontext-7ddff8d96c-ppxlk bash
```
* Run `id` command to view the details of user
```bash
root@ubuntunosecuritycontext-7ddff8d96c-ppxlk:/# id
```

**Output:**
```
uid=0(root) gid=0(root) groups=0(root)
```
* Run the following command `ls -ltr /host/proc/1/map_files`

```bash
root@ubuntunosecuritycontext-7ddff8d96c-ppxlk:/#  ls -ltr /host/proc/1/map_files
```

**Output:**
```
ls: reading directory '/host/proc/1/map_files': Permission denied
total 0
root@ubuntunosecuritycontext-7ddff8d96c-ppxlk:/#
```
* Type `exit` to get out of the container

* Save the following yaml configuration code in file `ubuntuuser-1000.yaml`

``` yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: ubuntu
  name: ubuntuwuser1000
spec:
  replicas: 1
  selector:
    matchLabels:
      run: ubuntu
  template:
    metadata:
      labels:
        run: ubuntu
    spec:
      containers:
      - image: ubuntu
        imagePullPolicy: Always
        command: ["sleep"]
        args: ["30d"]
        name: ubuntu
        volumeMounts:
        - name: all
          mountPath: /host
      volumes:
      - name: all
        hostPath: 
         path: /    
      restartPolicy: Always
      securityContext: 
         runAsUser: 1000
```
* In the configuration file, the `runAsUser` field specifies that for any Containers in the Pod, all processes run with user ID 1000.

* Deploy the configuration code using the following command.

```bash
kubectl create -f /c/Users/PhotonUser/Desktop/ubuntuuser-1000.yaml.yaml
```

* List-out the pods using the following command.

```bash
kubectl get pods
```

**Output:**
```
NAME                                       READY   STATUS    RESTARTS   AGE
ubuntu0wvolprivileged-7475f6df7c-4lbqf     1/1     Running   0          9m45
ubuntunosecuritycontext-7ddff8d96c-749lb   1/1     Running   0          3m31
ubuntuwuser1000-7798964455-84x6d           1/1     Running   0          34s
```

* Get a shell into the container using the following commnad in Powershell.

```bash
kubectl exec -it ubuntuwuser1000-7798964455-s9bsh bash
```

```bash
@ubuntuwuser1000-7798964455-s9bsh:/$ id
```

**Output:**
```
uid=1000 gid=0(root) groups=0(root)
```

* Run the `ls -ltr /host/proc/1/map_files` command

```
I have no name!@ubuntuwuser1000-7798964455-s9bsh:/$  ls -ltr /host/proc/1/map_files
ls: cannot open directory '/host/proc/1/map_files': Permission denied
```
* Type `exit` to get out of the Container

`I have no name!@ubuntuwuser1000-7798964455-s9bsh:/$ exit`

## Exercises

1. Create 3 pods with names nginx1,nginx2,nginx3. All of them should have the label app=v1

<details><summary>show</summary>
<p>

```powershell
kubectl run nginx1 --image=nginx --restart=Never --labels=app=v1  # use powershell
kubectl run nginx2 --image=nginx --restart=Never --labels=app=v1
kubectl run nginx3 --image=nginx --restart=Never --labels=app=v1
```

</p>
</details>

2. Show all labels of the pods

<details><summary>show</summary>
<p>

```bash
kubectl get po --show-labels
```
</p>
</details>

3. Change the labels of pod 'nginx2' to be app=v2

<details><summary>show</summary>
<p>

```bash
kubectl label po nginx2 app=v2 --overwrite
```

</p>
</details>

4. Get the label of pod

<details><summary>show</summary>
<p>

```bash
kubectl get po -L app
```
</p>
</details>

5. Get only the 'app=v2' pods

<details><summary>show</summary>
<p>

```bash
kubectl get po -l app=v2
```

</p>
</details>

6. Annotate pods nginx1, nginx2, nginx3 with "description='hello annotation'" value

<details><summary>show</summary>
<p>

```bash
kubectl annotate po nginx1 nginx2 nginx3 description='hello annotation'
```

</p>
</details>

7. Check the annotations for pod nginx1

<details><summary>show</summary>
<p>

```bash
kubectl describe po nginx1 | grep -i 'annotations' 

As an alternative to using | grep you can use jsonPath like -o jsonpath='{.metadata.annotations}{"\n"}'
```
```
Annotations:        description: hello annotation
```
</p>
</details>

8. Remove these pods to have a clean state in your cluster

<details><summary>show</summary>
<p>

```bash
kubectl delete po nginx{1..3}
```
</p>
</details>

9. Create a service account using template file and deploy it to cluster.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: account
```
`kubectl create -f <service-account-file.yaml>`

</p>
</details>

10. Create a deployment which uses 'account' as a service account

<details><summary>show</summary>
<p>

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: ubuntu
  name: ubuntu
spec:
  replicas: 1
  selector:
    matchLabels:
      run: ubuntu
  template:
    metadata:
      labels:
        run: ubuntu
    spec:
      serviceAccountName: account
      containers:
      - image: ubuntu
        imagePullPolicy: Always
        command: ["sleep"]
        args: ["30d"]
        name: ubuntu
      restartPolicy: Always
      securityContext: 
         runAsUser: 0
```
</p>
</details>

11. List-out all the service accounts of the cluster in all namespaces

<details><summary>show</summary>
<p>

```bash
kubectl get sa --all-namespaces

```
</p>
</details>

12. Inspect the pod details

<details><summary>show</summary>
<p>

```bash
kubectl describe pod <pod-name> 
```
</p>
</details>

13. Create the YAML for an nginx pod that runs with the UID 101, No need to create the pod

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  securityContext: # insert this line
    runAsUser: 101 # UID for the user
  containers:
  - image: nginx
    imagePullPolicy: IfNotPresent
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
```
</p>
</details>


**Conclusion:** Congratulations! You have successfully completed the Annotations, Service account, and Securitycontext lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
