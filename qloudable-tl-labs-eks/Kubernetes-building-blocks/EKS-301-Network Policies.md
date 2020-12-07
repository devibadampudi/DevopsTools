# Network Policies

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the EKS cluster](#accessing-the-Eks-cluster)

[Network Policies](#network-Policies)

[Exercises](#exercises)

## Overview

**Network Policies** are used in Kubernetes to specify how groups of pods should communicate with each other, as well as with other Network endpoints.

Network Policy resources use labels to select pods and define rules which specify what traffic is allowed to the selected pods.

Using the pre-provisioned EKS cluster, this lab will walk you through the basics of setting up network policies. You'll start off by learning how to setup the provided remote desktop to connect to your EKS cluster environment on AWS, then move into actually creating, editing, and managing network policies as you would in a real Kubernetes environment. There are also some helpful excercises at the end that you can do to practice these skills and learn how these objects work.

At the end of this lab, you'll learn how to create, update, describe, edit, delete a few Kubernetes Objects like Network Policies.

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
## Network Policies

By default, Kubernetes has an open network where every pod can talk to every pod.
Network policies are implemented by the network plugin, so you must use networking solution which supports NetworkPolicy - simply creating the resource without a controller to implement it will have no effect.

Project Calico is a network policy engine for Kubernetes. With Calico network policy enforcement you can implement network segmentation and tenant isolation. This is useful in multi-tenant environments where you must isolate tenants from each other or when you want to create separate environments for development, staging, and production. Network policies are similar to AWS security groups in that you can create network ingress and egress rules. Instead of assigning instances to a security group, you assign network policies to pods using pod selectors and labels. The following procedure shows you how to install Calico on your Amazon EKS cluster.


### To install Calico on your Amazon EKS cluster

1. Apply the Calico manifest from the following command, manifest creates DaemonSets in the `kube-system` namespace.

```bash
kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.5/config/v1.5/calico.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.5/co
nfig/v1.5/calico.yaml
daemonset.apps/calico-node created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
serviceaccount/calico-node created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
deployment.apps/calico-typha created
poddisruptionbudget.policy/calico-typha created
clusterrolebinding.rbac.authorization.k8s.io/typha-cpha created
clusterrole.rbac.authorization.k8s.io/typha-cpha created
configmap/calico-typha-horizontal-autoscaler created
deployment.apps/calico-typha-horizontal-autoscaler created
role.rbac.authorization.k8s.io/typha-cpha created
serviceaccount/typha-cpha created
rolebinding.rbac.authorization.k8s.io/typha-cpha created
service/calico-typha created

```

2. Watch the kube-system DaemonSets and wait for the calico-node DaemonSet to have the **DESIRED** number of pods in the **READY** state. When this happens, Calico is working.

```bash
kubectl get daemonset calico-node --namespace kube-system
```
**Output:**

```
NAME          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                 AGE
calico-node   2         2         2       2            2           beta.kubernetes.io/os=linux   39s
```

### Stars policy demo

This section walks through the Stars Policy Demo, The demo creates a frontend, backend, and client service on your Amazon EKS cluster. The demo also creates a management GUI that shows the available ingress and egress paths between each service.

Before you create any network policies, all services can communicate bidirectionally. After you apply the network policies, you can see that the client can only communicate with the frontend service, and the backend can only communicate with the frontend.

**To run the Stars Policy demo**

1. Apply the frontend, backend, client, and management UI services using the following commands.

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/00-namespace.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/manifests/00-namespace.yaml
namespace/stars created
```
```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/01-management-ui.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/manifests/01-management-ui.yaml
namespace/management-ui created
service/management-ui created
replicationcontroller/management-ui created
```
```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/02-backend.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/manifests/02-backend.yaml
service/backend created
replicationcontroller/backend created

```

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/03-frontend.yaml
```

**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/manifests/03-frontend.yaml
service/frontend created
replicationcontroller/frontend created
```

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/04-client.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/manifests/04-client.yaml
namespace/client created
replicationcontroller/client created
service/client created
```
2. Wait for all of the pods to reach the `Running` status.

```bash
kubectl get pods --all-namespaces --watch
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl get pods --all-namespaces --watch
NAMESPACE       NAME                                                  READY   STATUS    RESTARTS   AGE
client          client-4cbqk                                          1/1     Running   0          23s
kube-system     aws-node-bm22x                                        1/1     Running   0          21m
kube-system     aws-node-kktjn                                        1/1     Running   0          21m
kube-system     calico-node-tvjkd                                     1/1     Running   0          4m32s
kube-system     calico-node-x9m2t                                     1/1     Running   0          4m32s
kube-system     calico-typha-7fc5958b5b-52dg8                         1/1     Running   0          4m32s
kube-system     calico-typha-horizontal-autoscaler-79d547c5f7-cxs4z   1/1     Running   0          4m32s
kube-system     coredns-69bc49bfdd-g9ml2                              1/1     Running   0          24m
kube-system     coredns-69bc49bfdd-zj4x5                              1/1     Running   0          24m
kube-system     kube-proxy-9ccsn                                      1/1     Running   0          21m
kube-system     kube-proxy-djzwb                                      1/1     Running   0          21m
management-ui   management-ui-wmh2l                                   1/1     Running   0          61s
stars           backend-x7ntn                                         1/1     Running   0          47s
stars           frontend-v6hr8                                        1/1     Running   0          36s

```

3. To connect to the management UI, forward your local port 9001 to the management-ui service running on your cluster, use the following command.

```bash
kubectl port-forward service/management-ui -n management-ui 9001
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl port-forward service/management-ui -n management-ui 9001
Forwarding from 127.0.0.1:9001 -> 9001
Forwarding from [::1]:9001 -> 9001
Handling connection for 9001
Handling connection for 9001
Handling connection for 9001
Handling connection for 9001
Handling connection for 9001
Handling connection for 9001
Handling connection for 9001
```

4. Open a browser on your local system and point it to http://localhost:9001/. You should see the management UI. The **C** node is the client service, the **F** node is the frontend service, and the **B** node is the backend service. Each node has full communication access to all other nodes (as indicated by the bold, colored lines)

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/stars-default.png?st=2019-10-14T07%3A25%3A51Z&se=2022-10-15T07%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JqYdhyUcX%2F5%2FGQqe3tY5gJyC5gNNpMclhLwJ32xo4WI%3D" alt="image-alt-text" >


**Note:** Open a new terminal and run the following commands.


5. Apply the following network policies to isolate the services from each other.

```bash
kubectl apply -n stars -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/policies/default-deny.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -n stars -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes
/tutorials/stars-policy/policies/default-deny.yaml
networkpolicy.networking.k8s.io/default-deny created
```

```bash
kubectl apply -n client -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/policies/default-deny.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -n client -f https://docs.projectcalico.org/v3.3/getting-started/kubernete
s/tutorials/stars-policy/policies/default-deny.yaml
networkpolicy.networking.k8s.io/default-deny created
```

6. Refresh your browser. You see that the management UI can no longer reach any of the nodes, so they don't show up in the UI.

7. Apply the following network policies to allow the management UI to access the services:

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/policies/allow-ui.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/policies/allow-ui.yaml
networkpolicy.networking.k8s.io/allow-ui created
```

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/policies/allow-ui-client.yaml
```

**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/policies/allow-ui-client.yaml
networkpolicy.networking.k8s.io/allow-ui created
```

8. Refresh your browser. You see that the management UI can reach the nodes again, but the nodes cannot communicate with each other.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/stars-no-traffic.png?st=2019-10-14T07%3A26%3A49Z&se=2022-10-15T07%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VlokjFNmRtIhKQZS5k53pWOzZpyXRu%2F%2BzZqdtMNKkew%3D" alt="image-alt-text" >

9. Apply the following network policy to allow traffic from the **frontend service** to the backend service.

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/policies/backend-policy.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/policies/backend-policy.yaml
networkpolicy.networking.k8s.io/backend-policy created
```

10. Apply the following network policy to allow traffic from the **client** namespace to the **frontend service**.

```bash
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/policies/frontend-policy.yaml
```
**Output:**

```bash
PS C:\Users\DefaultProfileUser> kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorial
s/stars-policy/policies/frontend-policy.yaml
networkpolicy.networking.k8s.io/frontend-policy created
```

and then refresh your browser you should see client namespace is communicates with the frontend and backend services.


<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/stars-final%20demo.png?st=2019-10-14T07%3A27%3A14Z&se=2022-10-15T07%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TXj1IvFhQ1xLzQ%2B1fFd7ztKEfqm7n7hOoUBnZOjEJTQ%3D" alt="image-alt-text" >

11. (Optional) When you are done with the demo, you can delete its resources with the following commands.

```bash
kubectl delete -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/04-client.yaml
kubectl delete -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/03-frontend.yaml
kubectl delete -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/02-backend.yaml
kubectl delete -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/01-management-ui.yaml
kubectl delete -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/tutorials/stars-policy/manifests/00-namespace.yaml
```

12. To delete Calico from your Amazon EKS cluster

    If you are done using Calico in your Amazon EKS cluster, you can delete the DaemonSet with the following command.

```
kubectl delete -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.5/config/v1.5/calico.yaml

```

**Conclusion:** Congratulations! You have successfully completed the Network Policies lab! Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
