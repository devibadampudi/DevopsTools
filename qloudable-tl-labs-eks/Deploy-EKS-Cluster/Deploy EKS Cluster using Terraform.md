# Deploy EKS Cluster using Terraform

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Introduction](#introduction)

[Configuration](#configuration)

[Accessing the EKS cluster](#accessing-the-eks-cluster)

[Deploy a sample app on Kubernetes](#deploy-a-sample-app-on-kubernetes)

[Appendix](#appendix)

## Overview

Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.

Azure Kubernetes Service (EKS) is a managed container orchestration service to deploy and manage containerized applications. It is based on the open source Kubernetes system and is available on the Azure public cloud. The Kubernetes master nodes are managed by Azure and the agent nodes are managed by the users. As it is a managed service, AKS is free, you only need to pay for agent nodes. Azure Kubernetes Service can be created in the Aws Portal, with the Aws CLI, using Terraform.

This lab will provide a step by step guide to deploy an AKS cluster, connect to it and run a sample application all using terraform.


## Pre-Requisites

None required

## Introduction 

Elastic Kubernetes Service \(EKS\) manages your hosted Kubernetes environment, making it quick and easy to deploy and manage containerized applications without container orchestration expertise. It also eliminates the burden of ongoing operations and maintenance by provisioning, upgrading, and scaling resources on demand, without taking your applications offline.

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


## Configuration

In order to follow this guide you will need an AWS account and to have Terraform installed. Configure your credentials so that Terraform is able to act on your behalf.

For simplicity here, we will assume you are already using a set of IAM credentials with suitable access to create AutoScaling, EC2, EKS, and IAM resources. If you are not sure and are working in an AWS account used only for development, the simplest approach to get started is to use credentials with full administrative access to the target AWS account.

If you are planning to locally use the standard Kubernetes client, kubectl, it must be at least version 1.10 to support exec authentication with usage of aws-iam-authenticator. For additional information about installation and configuration of these applications, see their official documentation.

### Variables

The below sample Terraform configurations reference a variable called cluster-name (var.cluster-name) which is used for consistency. Feel free to substitute your own cluster name or create the variable configuration.

* **Access_keyid:** {{Access_keyid}}

* **Access_secret:** {{Access_secret}}

* **Cluster-region:** {{Region}}

``` .tf

variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "region" {
  default = "us-east-1"
}

variable "location" {
  description = "Respected location with the region"
  type        = "map"

  default = {
    us-east-1      = "US East (N. Virginia)"
    us-east-2      = "US East (Ohio)"
    us-west-1      = "US West (N. California)"
    us-west-2      = "US West (Oregon)"
    ap-east-1      = "Asia Pacific (Hong Kong)"
    ap-south-1     = "Asia Pacific (Mumbai)"
    ap-northeast-3 = "Asia Pacific (Osaka-Local)"
    ap-northeast-2 = "Asia Pacific (Seoul)"
    ap-southeast-1 = "Asia Pacific (Singapore)"
    ap-southeast-2 = "Asia Pacific (Sydney)"
    ap-northeast-1 = "Asia Pacific (Tokyo)"
    ca-central-1   = "Canada (Central)"
    cn-north-1     = "China (Beijing)"
    cn-northwest-1 = "China (Ningxia)"
    eu-central-1   = "EU (Frankfurt)"
    eu-west-1      = "EU (Ireland)"
    eu-west-2      = "EU (London)"
    eu-west-3      = "EU (Paris)"
    eu-north-1     = "EU (Stockholm)"
    me-south-1     = "Middle East (Bahrain)"
    sa-east-1      = "South America (São Paulo)"
    us-gov-east-1  = "AWS GovCloud (US-East)"
    us-gov-west-1  = "AWS GovCloud (US-West)"
  }
}

variable "group_name" {
description = "name for the group"
default     = "tl_users_group"
}

variable "policy_name" {
  description = "name for the policy"
  default     = "tl_users_policy"
}

variable "role_name" {
  description = "name for the policy"
  default     = "tl_users_role"
}

variable "username" {
  description = "Desired name for the IAM user"
  default     = "qldtluser"
}

variable "group_membership_name" {
  default = "tl_users_membership"
}

// ================== EKS variables ==============================

variable "cluster_name" {
  default = "eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = "string"
  default     = "1.13"
}

variable "ami_id" {
  description = "Respected location with the region"
  type        = "map"

  default = {
    us-east-1      = "ami-08198f90fe8bc57f0"
    us-east-2      = "ami-0355b5edf93d47112"
    us-west-2      = "ami-0dc5bf48daa40eb35"
    ap-south-1     = "ami-00f4cff050d28ee2d"
    ap-northeast-2 = "ami-0d9a543e7c4279c11"
    ap-southeast-1 = "ami-0013f4890e2ce167b"
    ap-southeast-2 = "ami-01cd15b342b7edf5e"
    ap-northeast-1 = "ami-0262013b4d50142a2"
    eu-central-1   = "ami-01ffee931e45bb6bf"
    eu-west-1      = "ami-00ea6211202297fe8"
    eu-west-2      = "ami-0ef7099142dae7023"
    eu-west-3      = "ami-00cc28b5bcb9dc724"
    eu-north-1     = "ami-01d7a7c38f882ef68"
  }
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
  default     = {}
}

```

### Provider.tf
```
# Configure the AWS Provider
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

```
### Base VPC Networking

EKS requires the usage of Virtual Private Cloud to provide the base for its networking configuration.

The below will create a 10.0.0.0/16 VPC, two 10.0.X.0/24 subnets, an internet gateway, and setup the subnet routing to route external traffic through the internet gateway:

```

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
      "Name", "eks-node${random_id.unique_string.hex}",
      "kubernetes.io/cluster/${var.cluster_name}${random_id.unique_string.hex}", "shared",
    )
  }"
}

resource "aws_subnet" "eks_subnets" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.eks_vpc.id}"
  map_public_ip_on_launch = "true"
  tags = "${
    map(
      "Name", "eks-node${random_id.unique_string.hex}",
      "kubernetes.io/cluster/${var.cluster_name}${random_id.unique_string.hex}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags = {
    Name = "eks-cluster"
  }
}

resource "aws_route_table" "eks_routetable" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eks_igw.id}"
  }
}

resource "aws_route_table_association" "rt_asstn" {
  count = 2

  subnet_id      = "${aws_subnet.eks_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.eks_routetable.id}"
}
```

### Kubernetes Masters

This is where the EKS service comes into play. It requires a few operator managed resources beforehand so that Kubernetes can properly manage other AWS services as well as allow inbound networking communication from your local workstation (if desired) and worker nodes.

**EKS Master Cluster IAM Role**

The below is an example IAM role and policy to allow the EKS service to manage or retrieve data from other AWS services. It is also possible to create these policies with the aws_iam_policy_document data source

For the latest required policy, see the EKS User Guide.

```
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster${random_id.unique_string.hex}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks_role.name}"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks_role.name}"
}

```
### EKS Master Cluster Security Group

This security group controls networking access to the Kubernetes masters. We will later configure this with an ingress rule to allow traffic from the worker nodes.
```
data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Override with variable or hardcoded value if necessary
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "aws_security_group" "cluster_sg" {
  name        = "eks-cluster${random_id.unique_string.hex}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.eks_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster"
  }
}

resource "aws_security_group_rule" "eks-cluster-ingress-workstation-https" {
  cidr_blocks       = ["${local.workstation-external-cidr}"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cluster_sg.id}"
  to_port           = 443
  type              = "ingress"
}

```

### EKS Master Cluster

This resource is the actual Kubernetes master cluster. It can take a few minutes to provision in AWS.
```
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.eks_role.arn}"
  version  = "${var.cluster_version}"

  vpc_config {
    security_group_ids = ["${aws_security_group.cluster_sg.id}"]
    subnet_ids         = "${aws_subnet.eks_subnets.*.id}"
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy",
  ]
}
```
### Configuring kubectl for EKS

If you are planning on using kubectl to manage the Kubernetes cluster, now might be a great time to configure your client. After configuration, you can verify cluster access via kubectl version displaying server version information in addition to local client version information.

The AWS CLI eks update-kubeconfig command provides a simple method to create or update configuration files.

If you would rather update your configuration manually, the below Terraform output generates a sample kubectl configuration to connect to your cluster. This can be placed into a Kubernetes configuration file, e.g. ~/.kube/config.
```

locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks_cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks_cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

```

### Kubernetes Worker Nodes

The EKS service does not currently provide managed resources for running worker nodes. Here we will create a few operator managed resources so that Kubernetes can properly manage other AWS services, networking access, and finally a configuration that allows automatic scaling of worker nodes.

**Worker Node IAM Role and Instance Profile**
The below is an example IAM role and policy to allow the worker nodes to manage or retrieve data from other AWS services. It is used by Kubernetes to allow worker nodes to join the cluster. It is also possible to create these policies with the aws_iam_policy_document data source

For the latest required policy, see the EKS User Guide.
```
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.eks_node_role.name}"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.eks_node_role.name}"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.eks_node_role.name}"
}

resource "aws_iam_instance_profile" "eks_node_profile" {
  name = "eks-node"
  role = "${aws_iam_role.eks_node_role.name}"
}

```

### Worker Node Security Group

This security group controls networking access to the Kubernetes worker nodes.

```
resource "aws_security_group" "eks_node_sg" {
  name        = "eks-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.eks_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
      "Name", "eks-node",
      "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "eks_node_ingress_self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.eks_node_sg.id}"
  source_security_group_id = "${aws_security_group.eks_node_sg.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_node_ingress_cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks_node_sg.id}"
  source_security_group_id = "${aws_security_group.cluster_sg.id}"
  to_port                  = 65535
  type                     = "ingress"
}


```

### Worker Node Access to EKS Master Cluster

Now that we have a way to know where traffic from the worker nodes is coming from, we can allow the worker nodes networking access to the EKS master cluster.
```
resource "aws_security_group_rule" "eks_cluster_ingress_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.cluster_sg.id}"
  source_security_group_id = "${aws_security_group.eks_node_sg.id}"
  to_port                  = 443
  type                     = "ingress"
}

```

### Worker Node AutoScaling Group

Now we have everything in place to create and manage EC2 instances that will serve as our worker nodes in the Kubernetes cluster. This setup uses an EC2 AutoScaling Group (ASG) rather than manually working with EC2 instances. This offers flexibility to scale up and down the worker nodes on demand when used in conjunction with AutoScaling policies (not implemented here).

First, let us create a data source to fetch the latest Amazon Machine Image (AMI) that Amazon provides with an EKS compatible Kubernetes baked in. It will filter for and select an AMI compatible with the specific Kubernetes version being deployed.


Next, lets create an AutoScaling Launch Configuration that uses all our prerequisite resources to define how to create EC2 instances using them.
```
data "aws_region" "current" {}

locals {
  eks-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks_cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks_cluster.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}


resource "aws_launch_configuration" "node_launch" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.eks_node_profile.name}"
  image_id                    = "${var.ami_id[var.region]}"
  instance_type               = "t3.small"
  name_prefix                 = "eks-nodes"
  security_groups             = ["${aws_security_group.eks_node_sg.id}"]
  user_data_base64            = "${base64encode(local.eks-node-userdata)}"
  

  lifecycle {
    create_before_destroy = true
  }
}
```

Finally, we create an AutoScaling Group that actually launches EC2 instances based on the AutoScaling Launch Configuration.
```
resource "aws_autoscaling_group" "node_auto_scaling" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.node_launch.id}"
  max_size             = 2
  min_size             = 1
  name                 = "eks-nodes"
  vpc_zone_identifier  = "${aws_subnet.eks_subnets.*.id}"

  tag {
    key                 = "Name"
    value               = "eks-nodes"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
```

Required Kubernetes Configuration to Join Worker Nodes

The EKS service does not provide a cluster-level API parameter or resource to automatically configure the underlying Kubernetes cluster to allow worker nodes to join the cluster via AWS IAM role authentication.

To output an example IAM Role authentication ConfigMap from your Terraform configuration.
```
locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks_node_role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}
```
### Terraform Intialization,Plan and Apply

The first command to run on a new configuration is terraform init which downloads all the required plugins. Place the aks.tf file in a folder, navigate to that folder and run terraform init. The terraform init command will automatically download and install any Provider binary for the providers in use within the configuration, which in this case is just the Azure provider. The azure provider plugin is downloaded and installed in a subdirectory of the current working directory, along with various other book-keeping files.

After initializing the terraform code run terraform plan, this validates entire configuration in the aks.tf file. Now run terraform apply to deploy the configuration into the azure cloud. This output shows the execution plan, describing which actions Terraform will take in order to change real infrastructure to match the configuration. If the plan was created successfully, Terraform will now pause and wait for approval before proceeding. If anything in the plan seems incorrect or dangerous, it is safe to abort here with no changes made to your infrastructure. In this case the plan looks acceptable, so type "yes" at the confirmation prompt to proceed.

It will take few minutes to deploy the code, after which, you can see your configuration.

Once everything is done, you can destroy the infrastructure using terraform destroy.

## Accessing the EKS cluster

* Configure Your AWS CLI Credentials

Both eksctl and the AWS CLI require that you have AWS credentials configured in your environment. The aws configure command is the fastest way to set up your AWS CLI installation for general use.

* **Access_keyid:** {{Access_keyid}}

* **Access_secret:** {{Access_secret}}

* **Cluster-region:** {{Cluster-region}}

* **Output-format:** json

* Need to configure the AWS credentials for accessing the cluster run the command `aws configure` then enter the  specified credentials as you get previous step.

`aws configure` 


```bash
aws configure
```

* **AWS Access Key ID [None]:**{{Access_keyid}}
* **AWS Secret Access Key [None]:**{{Access_secret}}
* **Default region name [None]:** {{Region}}
* **Default output format [None]:** json

```
* Run the following command to generate kubeconfig file for cluster.

```bash
aws eks --region us-east-1 update-kubeconfig --name ekscluster
```
* Run the following command to list-out the nodes in cluster, you should see `no resource found` as doesn't update the nodeinstance role in the AWS iam-authenticator configmap.

```bash
kubectl get nodes
```
```
No resources found
```

### To enable worker nodes to join your cluster

you  get the aws-auth-cm.yaml  file in output.

**Important**

 Do not modify any other lines in this file.

 Apply the configuration. This command may take a few minutes to finish.

 `kubectl apply -f aws-auth-cm.yaml`

* Verify it using the following command to list-out the nodes. Should created the nodes.

`kubectl get nodes`

```text
NAME                                      STATUS   ROLES    AGE    VERSION
ip-10-0-0-77.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0
ip-10-0-1-91.us-east-2.compute.internal   Ready    <none>   4h3m   v1.13.8-eks-cd3eb0

```

## Deploy a sample app on Kubernetes

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

1. Once the application is deployed, EKS exposes the application front end to the internet. This may take few minutes to complete. Use the following command to monitor the progress.

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

2. Elastic Kubernetes Service Architecture : [https://learn.hashicorp.com/terraform/aws/eks-intro]



