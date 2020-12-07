# Deploy an EKS(Elastic Kubernetes Service) cluster using the Management console

## Table of Contents

[Overview](#overview)

[Pre-requisites](#pre-requisites) 

[Introduction](#introduction)

[Sign in to AWS Management console](#sign-in-to-aws-management-console)

[Creation of Amazon EKS using management console](#creation-of-amazon-eks-using-management-console)

[Accessing the EKS cluster](#accessing-the-eks-cluster)

[Deploy a sample applicaation on Kubernetes](#deploy-a-sample-application-on-Kubernetes)

[Appendix](#Appendix)


## Overview

The aim of the lab about to get started with Amazon EKS using manageemnt console, a simple command line utility for creating and managing Kubernetes clusters on Amazon EKS. At the end of this lab, you will have a running Amazon EKS cluster with worker nodes and the kubectl command line utility will be configured to use your new cluster.

## Introduction

Amazon EKS (Elastic Container Service for Kubernetes) is a managed Kubernetes service that allows you to run Kubernetes on AWS without the hassle of managing the Kubernetes control plane.

The Kubernetes control plane plays a crucial role in a Kubernetes deployment as it is responsible for how Kubernetes communicates with your cluster — starting and stopping new containers, scheduling containers, performing health checks, and many more management tasks.

The big benefit of EKS, and other similar hosted Kubernetes services, is taking away the operational burden involved in running this control plane. You deploy cluster worker nodes using defined AMIs and with the help of CloudFormation, and EKS will provision, scale, and manage the Kubernetes control plane for you to ensure high availability, security, and scalability.

You will need to make sure you have the following components installed and set up before you start with Amazon EKS:

## Pre-requisites

None Required

## Sign in to AWS Management console

* Before creation of EKS cluster using management console, Navigate to the chrome-browser, sign-in to the AWS management console from the following url.

`https://console.aws.amazon.com`

* Credentials will be provided here, copy these information and paste corresponding values in the AWS Management console.

* Account ID: {{Account ID}}
* user name: {{user name}}
* password: {{password}}
* region: {{region}}

* Mention account-id from the above information, then click on `Next`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in.png?st=2019-09-09T09%3A36%3A43Z&se=2022-09-10T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rkLZ0wwcYQdKbOea5VgPSlzS46FaE8u3plAwptI5nf4%3D" alt="image-alt-text" >

* Mention Username and password from the above information

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/acc-log-in-usrpass.png?st=2019-09-09T10%3A20%3A15Z&se=2022-09-10T10%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KrcF1fH7XzP9H5LPSqrcPgZV3TDNzB6%2FCv6wSxbXN0o%3D" alt="image-alt-text" >

* Once you were provided all those information correctly you will be able to see the AWS-managemnt console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/homepage-aws-console.png?st=2019-09-09T09%3A48%3A34Z&se=2022-09-10T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PnSb99bn8RcnrD8mh6w7CkE1oFJscEriBXKpLvKDc4A%3D" alt="image-alt-text" >

* In the navigation bar, on the top-right, change region accordingly to provided in above.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/region.png?st=2019-09-09T09%3A50%3A51Z&se=2022-09-10T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qhSGKx7a%2BhYJxoZoPwe8Vu1ya%2BrzqGDXoTIlV4VHCEM%3D" alt="image-alt-text" >

## Creation of Amazon EKS using management console

1. Step 1: Creating an EKS Role

2. First step is to set up a new IAM role with EKS permissions.

3. Open the IAM console, select Roles on the left and then click the Create Role button at the top of the page.

4. From the list of AWS services, select EKS and then Next: Permissions at the bottom of the page.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/iam-roles-creation.png?st=2019-09-09T05%3A31%3A16Z&se=2022-09-10T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tKYGUKmuQG1Kgr1pnmI8GBtR%2Bx6%2B8vNpDfJsjwrRH1g%3D" image="alt-txt-image" >

5. Enter a name for the role (e.g. eksrole) and hit the Create role button at the bottom of the page to create the IAM role.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/role-created.png?st=2019-09-09T06%3A07%3A06Z&se=2022-09-10T06%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HY8pvkEoHVDwAxj9%2FC%2B1qmqTXZ1CBRGj%2FqMNkP7oE%2Fk%3D" image="alt-txt-image" >

6. Leave the selected policies as-is, and proceed to the Review page

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/role-arn.png?st=2019-09-09T10%3A53%3A32Z&se=2022-09-10T10%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qtwKdHoFLbZJFSFOIx66KVtmTVgwPByv3cyH%2BxgS%2FQw%3D" image="alt-txt-image" >

7. Be sure to note the Role ARN. You will need it when creating the Kubernetes cluster in the steps below.

### Creating a VPC for EKS

1. Create a separate VPC for our EKS cluster. To do this,

* search VPC----> VPC's---->

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/create-vpc-network.png?st=2019-09-09T05%3A33%3A44Z&se=2022-09-10T05%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=w0jIoaqBxGmDTcjnLtq%2B0OdV8tPcMi04XxD4TCESpbg%3D" image="alt-txt-image" >


2. Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS. For more information,

3. This lab guides through creating a VPC for your cluster with either 3 public subnets, or two public subnets and two private subnets, which are provided with internet access through a NAT gateway. You can use this VPC for your Amazon EKS cluster. We recommend a network architecture that uses private subnets for your worker nodes, and public subnets for Kubernetes to create public load balancers within.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/creation-of-VPC.png?st=2019-09-09T05%3A34%3A16Z&se=2022-09-10T05%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HJX80J%2FtDXdVUHmr0Ig%2BBj3HL%2FljiYYoko3F4NFOSlI%3D" image="alt-txt-image" >

4. On the Review page, choose Create.

5. When your stack is created, select it in the console and choose Outputs.

6. Create two public subnets with vpc to use for EKS cluster

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/subnet.png?st=2019-09-09T05%3A35%3A00Z&se=2022-09-10T05%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yRndEcl2M03nDn%2FP1LVAMZ7xbWZ3d30cOcmGEzz2Nso%3D" image="alt-txt-image" >

**Note:** create another subnet like above, choose different Availability zone for each subnets.


7. Record the SecurityGroups value for the security group that was created. You need this when you create your EKS cluster; this security group is applied to the cross-account elastic network interfaces that are created in your subnets that allow the Amazon EKS control plane to communicate with your worker nodes.

8. Record the `VpcId` for the VPC that was created. You need this when you launch your worker node group template.

9. Record the SubnetIds for the subnets that were created. You need this when you create your EKS cluster; these are the subnets that your worker nodes are launched into



### Create EKS cluster using management console

1. Open the Amazon EKS console at https://console.aws.amazon.com/eks/home#/clusters

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-cluster-dashboard.png?st=2019-09-09T05%3A35%3A35Z&se=2022-09-10T05%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=B2xKaXQo1Ab5HIDGXIeX4YBY4WXptNgVyURIvHc0nh4%3D" image="alt-txt-image" >

2. On the Create cluster page, fill in the following fields and then choose Create:

3. `Cluster name` – A unique name for your cluster.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-cluster-2.png?st=2019-09-09T05%3A36%3A38Z&se=2022-09-10T05%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JLJSFBco38V5PLa41%2FogHMdNu8Pog9%2Fy7%2BC7TPQOems%3D" image="alt-txt-image" >

4. `Kubernetes version` – The version of Kubernetes to use for your cluster. Unless you require a specific Kubernetes version for your application, we recommend that you use the latest version available in Amazon EKS.

**Note**

Kubernetes version 1.10 is no longer supported on Amazon EKS. You can no longer create new 1.10 clusters, and all existing Amazon EKS clusters running Kubernetes version 1.10 will eventually be automatically updated to the latest available platform version of Kubernetes version 1.11. For more information

**Role name** – Choose the Amazon EKS service role to allow Amazon EKS and the Kubernetes control plane to manage AWS resources on your behalf, that was created in earlier section.

**VPC** – The VPC to use for your cluster.

**Subnets** – The subnets within the preceding VPC to use for your cluster. By default, the available subnets in the VPC are preselected. Specify all subnets that will host resources for your cluster (such as private subnets for worker nodes and public subnets for load balancers). Your subnets must meet the requirements for an Amazon EKS cluster. For more information, see Cluster VPC Considerations.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-cluster-3.png?st=2019-09-09T05%3A37%3A11Z&se=2022-09-10T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SvRnhynPe69eeEIwBxa8hPVgDaYmv4534lTcOCzrN4A%3D" image="alt-txt-image" >

**Security Groups** – Specify one or more (up to a limit of five) security groups within the preceding VPC to apply to the cross-account elastic network interfaces for your cluster

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-cluster-4.png?st=2019-09-09T05%3A37%3A56Z&se=2022-09-10T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MKOBQNLq1PuAKMmWtJballFGy2jKYHj8GjbBzDkvCcU%3D" image="alt-txt-image" >

**Logging** – For each individual log type, choose whether the log type should be Enabled or Disabled. By default, each log type is Disabled.

* On the Clusters page, choose the name of your new cluster to view the cluster information.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-cluster-6.png?st=2019-09-09T05%3A42%3A42Z&se=2022-09-10T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pM2LMvr3JZcNzZ9Xv0oSfi5BxOQjNf6FaC7qTTiR%2B3o%3D" image="alt-txt-image" >

The Status field shows `CREATING` until the cluster provisioning process completes. When your cluster provisioning is complete (usually between 10 and 15 minutes)

Wait for your cluster status to show as `ACTIVE` If you launch your worker nodes before the cluster is active, the worker nodes will fail to register with the cluster and you will have to relaunch them.

### Launching amazon EKS Worker Nodes

1. Open the AWS CloudFormation console at https://console.aws.amazon.com/cloudformation.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-stack-1.png?st=2019-09-09T05%3A43%3A22Z&se=2022-09-10T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vqP0Djjy7nxdEwUentNsSQAOex5vKrGGfZvrx5rZnvA%3D" image="alt-txt-image" >

2. From the navigation bar, select a Region that supports Amazon EKS.

3. Choose Create stack.

4. For Choose a template, select Specify an Amazon S3 template URL.

5. Paste the following URL into the text area and choose Next.

`https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/amazon-eks-nodegroup.yaml`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-stack-2.png?st=2019-09-09T05%3A43%3A53Z&se=2022-09-10T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SFCZLyn7AsVbzQk6PK4tkqp1FTK2Tq%2BGWmf3ktIdDaQ%3D" image="alt-txt-image" >

**Note:**

If you intend to only deploy worker nodes to private subnets, you should edit this template in the AWS CloudFormation designer and modify the AssociatePublicIpAddress parameter in the NodeLaunchConfig to be false.

On the `Specify Details` page, fill out the following parameters accordingly, and choose Next:

* `Stack name` – Choose a stack name for your AWS CloudFormation stack. For example, you can call it <cluster-name>-worker-nodes.

* `ClusterName` – Enter the name that you used when you created your Amazon EKS cluster.

`ClusterControlPlaneSecurityGroup` – Enter the security group or groups that you used when you created your Amazon EKS cluster. This AWS CloudFormation template creates a worker node security group that allows traffic to and from the cluster control plane security group specified.


**Important**

The worker node AWS CloudFormation template modifies the security group that you specify here, so Amazon EKS strongly recommends that you use a dedicated security group for each cluster control plane (one per cluster). If this security group is shared with other resources, you might block or disrupt connections to those resources.

`NodeGroupName` – Enter a name for your node group. This name can be used later to identify the Auto Scaling node group that is created for your worker nodes.

`NodeAutoScalingGroupMinSize` – Enter the minimum number of nodes to which your worker node Auto Scaling group can scale in.

`NodeAutoScalingGroupDesiredCapacity` – Enter the desired number of nodes to scale to when your stack is created.

`NodeAutoScalingGroupMaxSize` – Enter the maximum number of nodes to which your worker node Auto Scaling group can scale out. This value must be at least one node greater than your desired capacity so that you can perform a rolling update of your worker nodes without reducing your node count during the update.

`NodeInstanceType` – Choose an instance type for your worker nodes. The instance type and size that you choose determines how many IP addresses are available per worker node for the containers in your pods. For more information.

`NodeImageId` – Enter the current Amazon EKS worker node AMI ID for your Region. The AMI IDs for the latest Amazon EKS-optimized AMI (with and without GPU support) are shown in the following table. Be sure to choose the correct AMI ID for your desired Kubernetes version and AWS region.

  for kubernetes version 1.13.8 choose correct ami id.
```
Region                      Amazon EKS-optimized AMI          with GPU support

US East (Ohio) (us-east-2)	ami-027683840ad78d833	            ami-0af8403c143fd4a07
US East (N. Virginia) (us-east-1)	ami-0d3998d69ebe9b214	    ami-0484012ada3522476
US West (Oregon) (us-west-2)	ami-00b95829322267382	        ami-0d24da600cc96ae6b
Asia Pacific (Hong Kong) (ap-east-1)	ami-03f8634a8fd592414	ami-080eb165234752969
Asia Pacific (Mumbai) (ap-south-1)	ami-0062e5b0411e77c1a	    ami-010dbb7183ab64b39
Asia Pacific (Tokyo) (ap-northeast-1)	ami-0a67c71d2ab43d36f	ami-069303796840f8155
Asia Pacific (Seoul) (ap-northeast-2)	ami-0d66d2fefbc86831a	ami-04f71dc710ff5baf4
Asia Pacific (Singapore) (ap-southeast-1) ami-06206d907abb34bbc   ami-0213fc532b1c2e05f
Asia Pacific (Sydney) (ap-southeast-2)	ami-09f2d86f2d8c4f77d	ami-01fc0a4c67f82532b
EU (Frankfurt) (eu-central-1)	ami-038bd8d3a2345061f	        ami-07b7cbb235789cc31
EU (Ireland) (eu-west-1)	ami-0199284372364b02a	            ami-00bfeece5b673b69f
EU (London) (eu-west-2)	ami-0f454b09349248e29	                ami-0babebc79dbf6016c
EU (Paris) (eu-west-3)	ami-00b44348ab3eb2c9f	                ami-03136b5b83c5b61ba
EU (Stockholm) (eu-north-1)	ami-02218be9004537a65	            ami-057821acea15c1a98
```


`KeyName` – Enter the name of an Amazon EC2 SSH key pair that you can use to connect using SSH into your worker nodes with after they launch. If you don't already have an `Amazon EC2 keypair`, you can create one in the AWS Management Console.

### To create your key pair using the Amazon EC2 console

1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.

2. In the navigation pane, under NETWORK & SECURITY, choose Key Pairs.

**Note**

3. The navigation pane is on the left side of the Amazon EC2 console. If you do not see the pane, it might be minimized; choose the arrow to expand the pane.

4. Choose `Create Key Pair`

5. For Key pair name, enter a name for the new key pair, and then choose Create.

6. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is .pem. Save the private key file in a safe place.

`BootstrapArguments` – Specify any optional arguments to pass to the worker node bootstrap script, such as extra kubelet arguments. For more information, view the bootstrap script usage information

`VpcId` – Enter the ID for the VPC that your worker nodes should launch into.

`Subnets` – Choose the subnets within the preceding VPC that your worker nodes should launch into. If you are launching worker nodes into only private subnets, do not include public subnets here

7. On the Options page, you can choose to tag your stack resources. Choose Next.

8. On the Review page, review your information, acknowledge that the stack might create IAM resources, and then choose Create.

9. When your stack has finished creating, select it in the console and choose Outputs.

10. Record the `NodeInstanceRole` for the node group that was created. You need this when you configure your Amazon EKS worker nodes. Go to output section and copy the `NodeInstanceRole` and will used creation of configmap authorization.

## Accessing the EKS cluster

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


* Run the following command to generate kubeconfig file for cluster.

`aws eks --region regionname update-kubeconfig --name clustername`

```bash
aws eks --region us-east-2 update-kubeconfig --name ekscluster
```
* Run the following command to list-out the nodes in cluster, you should see `no resource found` as doesn't update the nodeinstance role in the AWS iam-authenticator configmap.

```bash
kubectl get nodes
```
```
No resources found
```

### To enable worker nodes to join your cluster

1. Download, edit, and apply the AWS IAM Authenticator configuration map.

2. Use the following command to download the configuration map or use below configmap manifest file

`curl -o aws-auth-cm.yaml https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/aws-auth-cm.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: <>
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
```

3. Open the file with your favorite text editor. Replace the `<ARN of instance role (not instance profile)>` snippet with the NodeInstanceRole value that you recorded in the previous procedure, and save the file.

**Important**

4. Do not modify any other lines in this file.

5. Apply the configuration. This command may take a few minutes to finish.

6. kubectl apply -f aws-auth-cm.yaml

* Verify it using the following command to list-out the nodes. Should created the nodes.

`kubectl get nodes`

```text
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```

## Deploy a sample appliaction on Kubernetes

* Below is an example of a manifest file that creates two deployments, one for the python applications and one for Redis.

```text
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vote-back
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vote-back
  template:
    metadata:
      labels:
        app: vote-back
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: vote-back
        image: redis
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 6379
          name: redis
---
apiVersion: v1
kind: Service
metadata:
  name: vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: vote-back
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vote-front
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vote-front
  template:
    metadata:
      labels:
        app: vote-front
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-front
        image: microsoft/azure-vote-front:v1
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 80
        env:
        - name: REDIS
          value: "azure-vote-back"
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-front
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: azure-vote-front
```

1. Use nano or vi to create a file name `votingapp.yaml` and copy the above provided content and save the file

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/create-yaml-using-vi.gif?st=2019-09-09T06%3A04%3A04Z&se=2022-09-10T06%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wNsJ2eIz3lPoGnik5GNkzQeKE8f%2FIrQinBf8TcqysSc%3D" alt="image-alt-text">

2. Deploy the application using kubectl apply command and provide the name of the YAML file as input parameter. 

```text
kubectl apply -f votingapp.yaml
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/aks-cluster-2%20-%20Microsoft%20Azure%202019-08-19%2013-59-36.png?st=2019-09-09T06%3A04%3A31Z&se=2022-09-10T06%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PKtba3p8xKYSJxGHdgWN3qzGyNIyMxaEjywx6JBw7f8%3D" alt="image-alt-text">

### Test the application

* Once the application is deployed, EKS exposes the application front end to the internet. This may take few minutes to complete. Use the following command to monitor the progress.

 `kubectl get svc`
 
```
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)        AGE
azure-vote-back    ClusterIP      10.100.32.122   <none>                                                                    6379/TCP       13s
azure-vote-front   LoadBalancer   10.100.117.67   af2763c5bc4aa11e98e6f06c85d59362-1062481970.us-east-2.elb.amazonaws.com   80:30280/TCP   12s
kubernetes         ClusterIP      10.100.0.1      <none>                                                                    443/TCP        10d
```
* The `EXTERNAL-IP` for the azure-vote-front is in a pending state. Once it is ready it will change to the public IP address. Now that the public IP is available, copy the public IP and paste it in the chrome broswer on the qloudable console. This should open up the voting application. Vote your favorite pet and see the results change!

`kubectl get service azure-vote-front --watch`

```
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP        PORT(S)        AGE
azure-vote-front   LoadBalancer   10.100.117.67   af2763c5bc4aa...   80:30280/TCP   3m5s
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/testing%20the%20app.PNG?st=2019-09-09T06%3A05%3A11Z&se=2022-09-10T06%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UX87y1ej8WF2xCgb5UjvHhxy7j9kFE8b9NQZkkFF3qk%3D" alt="image-alt-txt" >

**Conclusion:** Congratulations! You have successfully completed the cluster creation using management console and deployed your first application! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/congrats-gif.gif?st=2019-09-09T06%3A05%3A40Z&se=2022-09-10T06%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=J0fDN%2FGbfyC72nZ%2FB9W8D46GBgBbx%2BfRZ2BX4aQwQwQ%3D" alt="image-alt-text">


Thank you for taking this training lab!

## Appendix 

### References

1. Eks best practices : [https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html]

2. Elastic Kubernetes Service Architecture : [https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html]
