# Deploy an EKS(Elastic Kubernetes Service) cluster using the eksctl
## Table of Contents

[Overview](#overview)

[Pre-requisites](#pre-requisites) 

[Introduction](#introduction)

[Creation of Amazon EKS using eksctl](#creation-of-amazon-eks-using-eksctl)

[Accessing the EKS cluster](#accessing-the-eks-cluster)

[Deploy a sample application on Kubernetes](#deploy-a-sample-application-on-kubernetes)


## Overview

The aim of the lab about to install all of the required resources to get started with Amazon EKS using eksctl, a simple command line utility for creating and managing Kubernetes clusters on Amazon EKS. At the end of this lab, you will have a running Amazon EKS cluster with worker nodes and the kubectl command line utility will be configured to use your new cluster.

## Pre-requisites

* chocolatey
* Python 2 version 2.6.5+ or Python 3 version 3.3+
* AWS CLI
* Kubectl
* Eksctl

## Introduction

Amazon EKS (Elastic Container Service for Kubernetes) is a managed Kubernetes service that allows you to run Kubernetes on AWS without the hassle of managing the Kubernetes control plane.

The `Kubernetes control plane` plays a crucial role in a Kubernetes deployment as it is responsible for how Kubernetes communicates with your cluster — starting and stopping new containers, scheduling containers, performing health checks, and many more management tasks.

The big benefit of EKS, and other similar hosted Kubernetes services, is taking away the operational burden involved in running this control plane. You deploy cluster worker nodes using defined AMIs and with the help of CloudFormation, and EKS will provision, scale, and manage the Kubernetes control plane for you to ensure high availability, security, and scalability.

## Creation of Amazon EKS using eksctl

* Before installing aws-cli needs to be install chocolatey/choco on Windows 10, using the powershell from windows icon menu.

    * Click Start and type `powershell`
    * Right-click Windows Powershell and choose `Run as Administrator`
    * Paste the following command into Powershell and press enter

```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  ```
  * Answer `Yes` when prompted
  * Close and reopen an PowerShell window to start using choco

* Verify choco installation using the following command.

    `choco -v`
```
0.10.11
```
* To install AWS Command Line Interface (Install), run the following command. Click on windows menu, choose PowerShell.

`choco install awscli`

* To upgrade AWS Command Line Interface (Install), run the following command. Click on windows menu, choose PowerShell.

`choco upgrade awscli`

* Verify aws-cli installation using the following command.

`aws --version`

```
aws-cli/1.16.215 Python/3.6.0 Windows/10 botocore/1.12.205
```

* To install or upgrade `eksctl` on Windows using Chocolatey

* Install or upgrade eksctl and the aws-iam-authenticator

`chocolatey install -y eksctl aws-iam-authenticator`

* If they are already installed, run the following command to upgrade

`chocolatey upgrade -y eksctl aws-iam-authenticator`

* Test that your installation was successful with the following command.

`eksctl version`

```version.Info{BuiltAt:"", GitCommit:"", GitTag:"0.3.1"}
```
### Install and Configure kubectl for Amazon EKS

* you have multiple options to download and install `kubectl` for your operating system.

* The kubectl binary is available in many operating system package managers, and this option is often much easier than a manual download and install process. You can follow the instructions for your specific operating system or package manager in the Kubernetes documentation to install.


### Create Your Amazon EKS Cluster and Worker Nodes

Now you can create your Amazon EKS cluster and a worker node group with the eksctl command line utility.

#### To create your cluster and worker nodes with eksctl

* Make sure that you have installed `eksctl`, and that your `eksctl version` is at least 0.1.37. You can check your version with the following command.

* Kubernetes cluster version 1.13 or higher.

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

* Click Apps icon in the toolbar and select **Powershell** to open a terminal window.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/e1.png?st=2019-10-23T06%3A16%3A39Z&se=2022-10-24T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Gg0Ouxr68ThRowxFznGsXgXiaWWNOTj7kM7gXm34dGs%3D" alt="image-alt-text" >

### Configure Your AWS CLI Credentials

* Both eksctl and the AWS CLI require that you have AWS credentials configured in your environment. The aws configure command is the fastest way to set up your AWS CLI installation for general use.

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
* When you type this command, the AWS CLI prompts you for four pieces of information: access key, secret access key, AWS Region, and output format. This information is stored in a profile (a collection of settings) named default. This profile is used unless you specify another one.

* Create your Amazon EKS cluster and worker nodes with the following command. Substitute values with your own values.

`eksctl create cluster --name <test> --version <1.13> --nodegroup-name standard-workers --node-type <t3.medium> --nodes <3> --nodes-min <1> --nodes-max <4> --node-ami auto`

* Use the following command to more information or available options
`eksctl create cluster --help`

## Accessing the EKS cluster

* Use the AWS CLI `update-kubeconfig` command to create or update your kubeconfig for your cluster.

`aws --region us-east-2 eks update-kubeconfig --name ekswithcmd`

* Cluster provisioning usually takes between 10 and 15 minutes. When your cluster is ready, test that your kubectl configuration is correct

* Test your configuration using following commands

`kubectl get svc`

* verify it using the following command to list-out the all nodes.

`kubectl get nodes`

```
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-29-179.us-east-2.compute.internal   Ready    <none>   14h   v1.13.7-eks-c57ff8
ip-192-168-39-189.us-east-2.compute.internal   Ready    <none>   14h   v1.13.7-eks-c57ff8
ip-192-168-84-210.us-east-2.compute.internal   Ready    <none>   14h   v1.13.7-eks-c57ff8
```

* Verify it by using the aws management console


<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/eks-cluster-dashboard.png?st=2019-10-23T09%3A02%3A07Z&se=2022-10-24T09%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4AsC8e%2BJ9uVQwX%2FHhjcfq%2BEseG%2B8otsNabZHV%2Fh33N4%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/cluster-eks-view.png?st=2019-10-23T09%3A03%3A51Z&se=2022-10-24T09%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B0aVwz1bQVjWuXj6YJURQgNPo58Xs4%2FVXEpXbooXVE4%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/cluster-config-view.png?st=2019-10-23T09%3A03%3A04Z&se=2022-10-24T09%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2Fn96RoWICh1bei70deOCBM%2FbucC6PONdeZEG5NYiPEc%3D" alt="image-alt-text" >

* Verify the status of the eks cluster using following command

`aws --region region eks describe-cluster --name clustername`

`aws --region us-east-2 eks describe-cluster --name ekswithcmd`

```
{
    "cluster": {
        "name": "ekswithcmd",
        "arn": "arn:aws:eks:us-east-2:650549925864:cluster/ekswithcmd",
        "createdAt": 1565537091.43,
        "version": "1.13",
        "endpoint": "https://4937C6176FC1084B1D4E173524633D88.sk1.us-east-2.eks.amazonaws.com",
        "roleArn": "arn:aws:iam::650549925864:role/eksctl-ekswithcmd-cluster-ServiceRole-KMX11B7FCC4S",
        "resourcesVpcConfig": {
            "subnetIds": [
                "subnet-03291c1ff2a6b9122",
                "subnet-0ce1ab25afc79da7b",
                "subnet-0ac6d2be6df7fc09f",
                "subnet-0073cd6c7d37b354c",
                "subnet-049c478e1063b7003",
                "subnet-0bb06c4992a92cbc4"
            ],
            "securityGroupIds": [
                "sg-0986f860e472e9013"
            ],
            "vpcId": "vpc-0faee9517a528d087",
            "endpointPublicAccess": true,
            "endpointPrivateAccess": false
        },
        "logging": {
            "clusterLogging": [
                {
                    "types": [
                        "api",
                        "audit",
                        "authenticator",
                        "controllerManager",
                        "scheduler"
                    ],
                    "enabled": false
                }
            ]
        },
        "status": "ACTIVE",
        "certificateAuthority": {
            "data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNU1EZ3hNVEUxTXpFMU5sb1hEVEk1TURnd09ERTFNekUxTmxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTktqCll0cmU3aG56aXVDMzg2V0U2UTl2d3lFOUd6NnIvUjZwQ0QzTUZDS1U0Q0hFa3VlYndLZWFxNU0yVEk3c0pGeFMKbTB3TmpzS2lqdVh5UDZac3FSL3picmFPT3Arc1BMWkdyc2tqK0F1dUdHMXJOR1BTKzJpS1JpVVVLVGZScTVCbAptOGZOQnBOYjBzOXM4MC8wVUY0dlBuV1RmeGU4ckhqeitKMEJzL2RiNFNsTzBjZm05TGZ2L3NNMDBPMytDUmVrCkRvTGxpYmpTdGlidU1lVEtlajh3YmVaZlhzd2p5SFl5SlF2T1J0WHJsV3RxbFVMdUsySU96V1Z4OEpiK1lTYjkKMmF0YlYwNnFnc0VrcTVFeng1Q2ZFVFdsQ1hzZmZUcTFkMnhUZ2xiSEJlV3RiYUpPU1FLbEd4Ym5QNEZVN0dTNQpzMTlHNmpxWlNhU2xNNE4rclU4Q0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFETU5KT0RRNWVIc291SWpmMDZnWXpCN20vdFYKRFZXTkMyM3hndGU2Sk1zUXVmcVNwanU0eXRFdk9CcmlSOFNsOUdxYXBhWEkyanZmNlBqdGkvbWlrcGd2RldpVApEOXlmNjY5dmxaWkpBUDhuQ1krMlJTWnp1WUNzd3M0c3BkV2Eya3Y5d0pNYktQaVpOcFMzSDd1NzdmYnZNbVQvCkJYNkJRT1d2MEJSVUFIZVB2QWdaM3FlWGFRRWVkdmJuQnFZdjZUNlR5YTRZQTR1RmdpaEpxQnZJSlYvUkIwZHcKbFdlZmoyWVdPK1k1dk0yMU1FK2xydTl1UHRBVUU0TitKZENjTldvRlVmZXJuNklvQ0cyOFI0bnowY0RLSWw1UQpnc05aV0RFTjVVdS9ndThBWkY1NS9CQ1hoMENSMnFjYU5QdHNOeHFGNkMyY2VocmtpdTNaSlpFN1lMTT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
        },
        "platformVersion": "eks.2"
    }
}
```

## Deploy a sample application on Kubernetes

* Congrats! Your Kubernetes cluster is created and set up. Deploy going to deploy a sample voting app.


* Primary way to deploy an application on Kubernetes is to use a manifest file. Kubernetes is declarative, meaning, you provide the desired state of your application to Kubernetes and the cluster's repressibility to get your application to the desired state described in the manifest file. 

* Below is an example of a manifest file that creates two deployments, one for the python applications and one for Redis.

```text
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-back
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-back
  template:
    metadata:
      labels:
        app: azure-vote-back
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-back
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
  name: azure-vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: azure-vote-back
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-front
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-front
  template:
    metadata:
      labels:
        app: azure-vote-front
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

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/create-yaml-using-vi.gif" alt="image-alt-text">

2. Deploy the application using kubectl apply command and provide the name of the YAML file as input parameter. 

```text
kubectl apply -f votingapp.yaml
```

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/aks-cluster-2%20-%20Microsoft%20Azure%202019-08-19%2013-59-36.png" alt="image-alt-text">

## Test the application

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

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs/EKS/EKS%20%20Course/images-eks/testing%20the%20app.PNG?token=AKDZCZ7ACMEEBGOX562666K5M56WM" alt="image-alt-txt" >

**Conclusion:** Congratulations! You have successfully completed the cluster creation using eksctl and deployed your first application! . Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">


Thank you for taking this training lab!

## Appendix 

### References

1. Eks best practices : [https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html]

2. Elastic Kubernetes Service Architecture : [https://eksworkshop.com/introduction/architecture/]

