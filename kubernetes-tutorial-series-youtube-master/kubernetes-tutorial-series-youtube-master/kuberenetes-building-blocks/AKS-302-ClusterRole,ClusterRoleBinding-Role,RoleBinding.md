# ClusterRole, ClusterRoleBinding, Role and RoleBinding

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Accessing the AKS cluster](#accessing-the-aks-cluster)

[ClusterRole ClusterRoleBinding and Role RoleBinding](#clusterrole-clusterrolebinding-and-role-roleBinding)

[Exercises](#exercises)

## Overview

At the end of this lab, you'll learn how to create, access the ClusterRole,ClusterRoleBinding-Role,RoleBinding  .

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

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/landingpage.PNG?st=2019-10-16T09%3A58%3A17Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CUJ%2B2tK4s25F%2BL88voMTtzpAM8obbAYafLnFYsuYOzc%3D" alt="image-alt-text">

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like MC_myResourceGroup_myAKSCluster_eastus. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/resource-group.png?st=2019-10-16T10%3A11%3A16Z&se=2022-10-17T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZ9OfMLVZesJZ%2FWe5PN5Y1cTlpJnZB9HKcM9%2B7k%2F6AI%3D" alt="image-alt-text">

3. Click Apps icon in the toolbar and select Powershell to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-16T10%3A37%3A05Z&se=2022-10-17T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ovJqaeJVkF09fPiC9U3qAw%2Bjgya3oWbPwDeFToeaGQY%3D" alt="image-alt-text">

4. First need to login with azure credentials in the powershell, using the following command.

`az login -u {{azure_login}} -p {{azure_password}}`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/azure-login-using-powershell.PNG?st=2019-10-16T09%3A58%3A53Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0dby1%2FJoiIcxWUdb2QmbnQy%2BGed%2FX5ZNso2dKRPIJ0%3D" alt="image-alt-text">

5. Needs to run access cluster command for kubeconfig file.

`az aks get-credentials --resource-group {{rg-name}} --name {{cluster-name}} --admin`

6. We have initialized the enviornment, Get the all node using `kubectl get nodes` command to list-out nodes in a k8's cluster.

`kubectl get nodes`

```
NAME                        STATUS    ROLES     AGE       VERSION
aks-agentnodepool-24439688   Ready    agent     14m       V1.13.10

```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/getnodes.PNG?st=2019-10-16T10%3A03%3A13Z&se=2022-10-17T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4B0%2B6n1ewyUtcRESuvc3PyYZtprWPe%2FRWtj7%2BwHWchA%3D" alt="image-alt-text">

5. using this command you get the default namespaces `kubectl get ns`

```bash
kubectl get ns
```

```
NAME          STATUS    AGE
default       Active    8m
kube-public   Active    8m
kube-system   Active    8m

```

## ClusterRole ClusterRoleBinding and Role RoleBinding

There are different ways to authenticate with and secure Kubernetes clusters. Using role-based access controls (RBAC), you can grant users or groups access to only the resources they need.

By default AKS(Azure Kubernetes Service) cluster comes with RBAC enabled and the cluster can be configured to use Azure Active Directory (AD) for user authentication.

RBAC (Role Based Access Cluster) is used to restrict the access to the user on Cluster. It only allows admins to configure the policies using Kubernetes API *rbac.authorization.k8s.io*.

With RBAC, you create roles to define permissions, and then assign those roles to users with role bindings.

And to apply these ClusterRole, ClusterRoleBinding, Role, RoleBinding, the cluster must be integrated with Azure Active Directory (AAD) while creating.

In this Lab, the cluster is already integrated with Azure AD and deployed, now create roles and rolebindings to test the RBAC.

### Role and ClusterRole

Role is used to grant access to resources within a single namespace.

ClusterRole is used to grant the same permissions as a role, but it can be applied in the cluster level not just in namespace level.

### RoleBinding and ClusterRoleBinding

Once a role is defined to grant permissions to resources, you can assign those permissions using a rolebinding for a given namespace.

A ClusterRoleBinding works in the same way to bind roles to users, but it can be applied to resources across the entire cluster, not just a specific namespace.

## step 1: Create ClusterRoleBinding using default ClusterRole.

1. Create a ClusterRoleBinding for the user who you want to grant access to the AKS cluster.

2. In this lab, we created one test user to test the RBAC. Below are the test user login credentials

3. Now create a ClusterRoleBinding for the above user with predefined ClusterRole that is available on the cluster.

4. Create a group in AAD(Azure Active Directory) and add the test user to that group who can have cluster-admin access and take the object id from overview.

5. Now assign ClusterRoleBinding to the AAD group by entering the name of the ClusterRoleBinding, ClusterRole(Cluster-admin) and group Object Id in the following ClusterRoleBinding.

``` yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
 name: <Name-of-the-ClusterRoleBinding>
roleRef:
 apiGroup: rbac.authorization.k8s.io
 kind: ClusterRole
 name: cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: <Object-ID-of-the-AAD-group>
```

6. Save the above YAML code in file and Create ClusterRoleBinding using the below command.

    `kubectl create -f <name of the file>`

### step 2: Access cluster with Azure AD

1. Now acces the cluster with non-admin user using az aks get-credentials command.

`az aks get-credentials --resource-group <myResourceGroup> --name <myAKSCluster>`

2. Run any cluster command with kubectl, for example get the nodes using `kubectl get nodes`

3. After you run a kubectl command, you are prompted to authenticate with Azure. Follow the on-screen instructions to complete the process. Here you need to aunthenticate the cluster using test user credntials which are provided in previous steps.

```
kubectl get nodes

To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code BUGHYDGNL to authenticate.

NAME                       STATUS    ROLES     AGE       VERSION
aks-nodepool1-79590246-0   Ready     agent     1h        v1.13.5
```

### step 3: Create Role and RoleBinding

1. Now test the RBAC in namespace level by assigning the role and rolebinding to the user.

2. Here we are restricting the user to a particular namespace in the AKS cluster using role and rolebinding.

3. Use the following test user to test the namespace level RBAC.

4. Create another group in AAD(Azure Active Directory) and add this user to that group who can have only namespace level access and take the object id.

5. Create a sample namespace using `kubectl create ns <namespace name>` and update the namespace name in the below yaml file.

5. Create a role using the below YAML which has only access to pods.

6. Enter the name of the role and namespace.

``` yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: <name-of-the-role>
  namespace: <namespace>
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
  - delete
  - create
- apiGroups:
  - "extensions"
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch
  - delete
  - create

```
4. Once role is defined to grant permissions to resources, assign that role to the AAD group with RoleBinding by specifing the rolebinding name, namespace name and object ID of AAD group.

```  yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: <rolebinding-name>
  namespace: <namespace>
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: kube-dev-role
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: <object ID of AAD group>

```

3. Save the above YAML code in file and Create RoleBinding using the below command.

    `kubectl create -f <name of the file>`

### step 2: Access cluster resources with Azure AD

1. Now acces the cluster with non-admin user using az aks get-credentials command.

`az aks get-credentials --resource-group <myResourceGroup> --name <myAKSCluster>`

2. Now run any command in the specified namespace which user has access.Example `kubectl -n <namespace name> get po`

3. After you run a kubectl command, you are prompted to authenticate with Azure. Follow the on-screen instructions to complete the process. Here you need to aunthenticate the cluster using test user credntials which are provided in previous steps.

```
kubectl -n test get pods

To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code BUCFYDGNL to authenticate.

No resources found.

```
4. Now the user got authenticated to the cluster and has only access to namespace which he assigned to.

5. check the other namespace using `kubectl -n sample get po` get this unauthorised error.

```
 kubectl -n sample get po
 
Error from server (Forbidden): pods is forbidden: User "nsuser@sysgain.com" cannot list resource "pods" in API group "" in the namespace "sample"

```
## Exercises

### Create the ClusterRoleBinding using default ClusterRole.

<details><summary>show</summary>
<p>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
 name: <Name-of-the-ClusterRoleBinding>
roleRef:
 apiGroup: rbac.authorization.k8s.io
 kind: ClusterRole
 name: cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: <Object-ID-of-the-AAD-group>

```
`kubectl create -f <name of the file>`

</p>
</details>

### How to get all pods in a cluster

<details><summary>show</summary>
<p>

```bash
kubectl get pods --all-namespaces
```
</p>
</details>

### How to access cluster with the Azure Active Directory

<details><summary>show</summary>
<p>

```bash
az aks get-credentials --resource-group <myResourceGroup> --name <myAKSCluster>
```

</p>
</details>

### How to check worker nodes configured on cluster

<details><summary>show</summary>
<p>

```bash
kubectl get nodes
```

</p>
</details>

### List-out the clusterroles in the cluster

<details><summary>show</summary>
<p>

```bash
kubectl get clusterroles
```
</p>
</details>

### Inspect the specific clusterrole

<details><summary>show</summary>
<p>

```bash
kubectl describe clusterroles <name-of-the-clusterrole>
```

</p>
</details>


### List-out the clusterrolebindings in a cluster

 <details><summary>show</summary>
<p>

```bash
kubectl get clusterrolebindings
```

</p>
</details>


### Inspect the clusterrolebindings in a cluster

<details><summary>show</summary>
<p>

```bash
kubectl describe clusterrolebindings <name-of-the-clusterrolebindings>
```
</p>
</details>

### Create a role and rolebinding to the user namespace level

<details><summary>show</summary>
<p>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: <name-of-the-role>
  namespace: <namespace>
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
  - delete
  - create
- apiGroups:
  - "extensions"
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch
  - delete
  - create
```

</p>
</details>

### Create a role which user access to only pods 

<details><summary>show</summary>
<p>

```bash
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: <name-of-the-role>
  namespace: <namespace>
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
  - delete
  - create
- apiGroups:
  - "extensions"
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch
  - delete
  - create
```
</p>
</details>


### How to grant permission to resources, assign role to AAD group specific rolebinding name, namespace name and objectID of AAD


<details><summary>show</summary>
<p>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: <rolebinding-name>
  namespace: <namespace>
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: kube-dev-role
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: <object ID of AAD group>
```

`kubectl create -f <name of the file>`

</p>
</details>


**Conclusion:** Congratulations! You have successfully completed the ClusterRole,ClusterRoleBinding-Role,RoleBindings ! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
