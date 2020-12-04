# Deploy an Azure kubernetes service \(AKS\) cluster using the Azure Portal

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Introduction](#introduction)

[Create a Service Principal](#create-a-service-principal)

[Sign in to Azure Portal and Create an AKS Cluster](#sign-in-to-azure-portal-and-create-an-aks-cluster)

[Connect to the Cluster](#connect-to-the-cluster)

[Deploy Sample Voting Application](#deploy-sample-voting-application)

[Test the Application](#test-the-application)

[Appendix](#appendix)

## Overview

Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.

Azure Kubernetes Service \(AKS\) is a managed container orchestration service to deploy and manage containerized applications. It is based on the open source Kubernetes system and is available on the Azure public cloud. The Kubernetes master nodes are managed by Azure and the agent nodes are managed by the users. As it is a managed service, AKS is free, you only need to pay for agent nodes. Azure Kubernetes Service  can be created in the Azure Portal, with the Azure CLI, using ARM Templates and Terraform.

This lab will provide a step by step guide to deploy an AKS cluster, connect to it and run a sample application all using Azure Portal.

## Pre-Requisites

None required

## Introduction 

Azure Kubernetes Service \(AKS\) manages your hosted Kubernetes environment, making it quick and easy to deploy and manage containerized applications without container orchestration expertise. It also eliminates the burden of ongoing operations and maintenance by provisioning, upgrading, and scaling resources on demand, without taking your applications offline.

Following are some of the ways which can be used to create an AKS Cluster in Azure.

* Azure Portal using the GUI.
* Azure CLI on your local or remote machine.
* Azure CLI using Azure Cloud Shell.
* Using Azure Resource Manager Templates.
* Using Terraform Templates.

In this lab, you will learn \(by doing\) 

* Series of steps needed to setup an AKS Cluster using Azure CLI on remote machine \( Same applies for your local machine\).
* Connect to your AKS Cluster using Azure CLI.
* Deploy a sample multi-container application thats includes a web front end and a Redis instance
* Monitor health of your cluster and pods
* Delete the cluster

Lets get started...


## Create a Service Principal

**Sign in to Azure portal**

* Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

* **Azure Login ID :** {{azure_login}}

* **Azure Password :** {{azure_password}}

* Navigate to the `resource-groups` you should see one resource group already exist. 

* **azure-resourcegroup :** {{azure-resourcegroup}}

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/landingpage.PNG?st=2019-10-16T09%3A58%3A17Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CUJ%2B2tK4s25F%2BL88voMTtzpAM8obbAYafLnFYsuYOzc%3D" alt="image-alt-text">

A Kubernetes cluster on AKS , referred to as AKS cluster, consists of two main components

* A cluster master provides the core Kubernetes services and orchestration of application workloads. This is provided as a managed Azure resource and there is no cost for this component.
* Nodes that run the application workloads.

The first step to creating a AKS cluster in Azure is to ensure that an Azure Active Directory _Service Principal_ is created or available for use. The AKS Cluster interacts with Azure resources using Azure APIs to create Kubernetes Nodes and Node Pools. It may also need to dynamically create and manage other Azure resources such as an Azure Load Balancer or Azure Container Registry etc.  In order to allow this functionality, a Service Principal object is mandatory.

{% hint style="info" %}
To create an Azure AD service principal, you must have the permissions to register an application with your Azure AD tenant as well as to assign the application created to a role in your subscription. If you do not  have necessary permissions, you might need to ask your Azure AD and subscription administrator to assign required permissions.
{% endhint %}

Following are the steps to create the Service Principal in your accounts. _These steps are not available to implement in this lab and provided here for reference._

1. Go to **Azure Active Directory**, Click on **App Registrations** and **New Registration** to start the app registration process


<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/service-principal-app-registration.gif?st=2019-08-26T05%3A59%3A32Z&se=2022-08-27T05%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=r3o0OnbpZ3D24J%2FJAPe10WMUnsoxUM0xn6HGhUGCiUY%3D" alt="image-alt-text">



2. Fill in the name of the service principal and access details to single tenant and click **Register.** This will create an application with Application\(client\) ID. Note down the Client ID.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/service-principal-app-registration%202.gif?st=2019-08-26T06%3A01%3A03Z&se=2022-08-27T06%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LaE4G75J66Qcx9Pt%2BbtyObXMqguZZuWmcIRDckODzc4%3D" alt="image-alt-text">

3. Once the App is registered, a secret has to be created. Click on **Certificates & secrets**, ****then **New client secret** , provide a name for the secret and its validity period and then click Add. A new secret is created once this step is completed.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/sp-create-secret.png?st=2019-08-26T06%3A29%3A04Z&se=2022-08-27T06%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YzXDunIjg7v4fjlRveJjZPiqacDqG3ppN5zYAm%2BBT90%3D" alt="image-alt-text">

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/add-sp-createsecret.PNG?st=2019-08-26T06%3A29%3A51Z&se=2022-08-27T06%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v8sLLRC%2FcZIIi2mt4PkZ6KlMY7qdmu791j6izIk7EPo%3D" alt="image-alt-text">

4.  The newly created secret description, expiry and value can be seen in the client secrets section of the page. Copy the client value and store it for future reference. 

{% hint style="danger" %}
Once you navigate away from the screen, the client secret value is never show again. It is important to note this down before you proceed. In case, you have not made a copy of this, please delete this secret and create a new secret.
{% endhint %}

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/add-sp-copy.PNG?st=2019-08-26T06%3A30%3A21Z&se=2022-08-27T06%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vBqDGg07FFTajasAoJiy5nb3AInYqckEp7fiO3N5%2B2I%3D" alt="image-alt-text">


As creation of Service Principal requires Read/Write permission on Azure Active Directory at the tenant, for security purposes, we have generated all required Service Principles for this lab. 

Following is the unique Service Principal generated for you for the duration of this lab.

Key: {{key}}

Secret: {{secret}}

Now that service principal is available, let us proceed to the next step.

## **Sign in to Azure Portal and Create an AKS Cluster**

This lab covers deployment of an AKS cluster using Azure Portal

1. Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

```text
Azure Login ID :{{azure_login}}
Azure Password : {{azure_password}}
```

2. Click **Create a resource** and search for the _Kubernetes_. Select _Kubernetes Service_

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/5.png?st=2019-08-26T06%3A08%3A26Z&se=2022-08-27T06%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pIgmAgU5jWtTYJFTZs0hZANuwK43SiZ5BWgu8pJ%2BliA%3D" alt="image-alt-text" >

3. Click **Create**.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/6.png?st=2019-08-26T06%3A08%3A56Z&se=2022-08-27T06%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IPfN3wqYh%2BbX8g4GWmSFwuIXpCoViVKYkiOUKHJJkbo%3D" alt="image-alt-text" >

4. Fill in all the required fields for the **Basics** tab as instructed. In this tab, you provide the basic details to setup your AKS Cluster.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/7.png?st=2019-08-26T06%3A09%3A29Z&se=2022-08-27T06%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5jdOBA83LrPQKHYEfspw4U8ZxsgaCDcOL2oWs%2Bxi194%3D" alt="image-alt-text" >

    4.1 Select the specified resource group  - {{resource\_group}} -  from the **Resource group** dropdown.

```text
Subscription : {{subscription_name}}
Resource Group : {{resource_group}}
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/8.png?st=2019-08-26T06%3A09%3A55Z&se=2022-08-27T06%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=g81VH6Gg0PYXPl55XW0U2QQCIfEFY4SWxTh6TR6RtGc%3D" alt="image-alt-text" >

   4.2 Input values for **Cluster Details** & **Primary Node Pool** Sections

```text
Kubernetes cluster name : provide name for your cluster. Example: aks-cluster-1
Region : {{region}}
Kubernetes version : select default
DNS name prefix : this will be autoselected based on kubernetes cluster name.
Node size : This is where you would select the VM size of node in your cluster
Node count : Move the slider to select 1 node count.The lab subscription quotas
have been set to allow only 1 node per cluster. 
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/10.png?st=2019-08-26T06%3A10%3A27Z&se=2022-08-27T06%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=50jGZX7UBJbiVwVF4qhqAwRLf19IlwTS12GChyyJipw%3D" alt="image-alt-text" >

   4.3 Leaving the **Scale** options to their defaults, proceed to the next step: **Authentication**. These settings are not needed for basic AKS cluster setup.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/s1.PNG?st=2019-08-26T06%3A10%3A59Z&se=2022-08-27T06%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0AgPd1zdi%2FMX6203Qa1NSLBQvV30Ek0ui5Xv3ITj9aM%3D" alt="image-alt-text" >

   4.4 Click **configure service principal**, select the radio button **use existing** and provide the service principal details as below. Leave the **Enable RBAC** option to **Yes**

```text
Service principal client ID : {{service_principal_client_id}}
Service principal client secret : {{service_principal_client_secret}}
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/12.png?st=2019-08-26T06%3A11%3A52Z&se=2022-08-27T06%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nytugtUTF0N2hJ7DS3XeZ9uRtSfLxPoAoU5kVwtQfWA%3D" alt="image-alt-text">

   4.5 In **Networking** tab, select **Yes** for **http allocation routing** and **Basic** for **Network configuration**.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/13.png?st=2019-08-26T06%3A12%3A18Z&se=2022-08-27T06%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9KtShmSXBRQIbb%2FoyxMxfXnY9Y%2FXTkE%2BCMnOPceOzjo%3D" alt="image-alt-text">

  4.6 In **Monitoring** tab, Choose **Yes** for the **Enable container monitoring**. Azure provides native container monitoring as a service. 

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/14.png?st=2019-08-26T06%3A12%3A42Z&se=2022-08-27T06%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FLepA8OFGHzYcYZY5kLkz8BFDoZenHQmRLOkh2yVdsY%3D" alt="image-alt-text">

   4.7 In **Tags** tab, Enter the **tags** for AKS cluster. It is always a good practice to tag your resources so that you can categorize resources and view consolidated billing.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/15.png?st=2019-08-26T06%3A13%3A07Z&se=2022-08-27T06%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2iKjj477jqGyC7TOQj1GYhQk64Q1dVgiQWmQOzKXe44%3D" alt="image-alt-text">

   4.8 Click **review + create** and wait for the validation pass and click **Create**.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/16.png?st=2019-08-26T06%3A13%3A31Z&se=2022-08-27T06%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sO%2Bb8bwFruDYFi4sqTB%2BW4wB8k87efI9ws4OB6sUTrA%3D" alt="image-alt-text">

5. The deployment typically takes few minutes. 

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/17.png?st=2019-08-26T06%3A13%3A55Z&se=2022-08-27T06%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WffrMTcKhOY%2FE0aTfk7JRAimlAQa6g1YDrv%2B52FEpiA%3D" alt="image-alt-text">

While the deployment is underway, lets learn about few concepts of Kubernetes specific to Azure Kubernetes service.

### Azure Kubernetes Service Architecture

{{ _Provide inforamtion about Kubernetes}}_

6. At this stage, the deployment should be completed and the AKS cluster should be ready to use.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/18.png?st=2019-08-26T06%3A14%3A23Z&se=2022-08-27T06%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OwF4MJyJ5v98NH396%2BzwMm%2BAIZGMxqsjXTueYsy%2BdcQ%3D" alt="image-alt-text">

     6.1 Click the created **AKS cluster** to land on the overview page.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/19.png?st=2019-08-26T06%3A14%3A51Z&se=2022-08-27T06%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VBsS45cJgX9JZbu%2FFh3tErS8PflvKcHA6yHcP7qALp8%3D" alt="image-alt-text">

   6.2 On this page, you will find all the details related to your cluster. On the left pane, under **Settings**, you will find different options to manage your cluster. AKS provides an integrated experience in the portal so that you can perform basic operations on the cluster without using _kubectl_. Explore these options for few minutes.

* **Node pools** Setting:  to view all the nodes that are part of your cluster. 
* **Upgrade** Setting:  This provide access from Portal to upgrade your cluster to a newer version of Kubernetes if available. 
* **Scale** Setting : this allows you to scale up/down your nodes
* Explore other settings on the left pane.

   

## Connect to the Cluster

You can connect to the newly created Kubernetes cluster using _kubectl_ from Azure CLI or Azure Cloud Shell integrated into the Azure Portal. As this lab's focus is to deploy and manage the cluster using Azure Portal, we will use Azure Cloud Shell option. _kubectl_ comes pre-installed on Azure Cloud Shell.

To manage a Kubernetes cluster, use _kubectl_, the Kubernetes command-line tool, pre-installed on Azure Cloud Shell.

1. Open Cloud Shell from the top right corner of Azure portal.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/23.PNG?st=2019-08-26T06%3A15%3A31Z&se=2022-08-27T06%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SGkBmN3%2BEhKmVAcMQO14qDwmxH%2FnLwp8FCiRMSubw0M%3D" alt="image-alt-text">

   1.1 Azure Cloud Shell provides both PowerShell and Bash options. For this lab select, **Bash** option. The same steps should also work for **PowerShell** option.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/aks-cluster-2%20-%20connect-bash.png?st=2019-08-26T06%3A16%3A49Z&se=2022-08-27T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JmXJZHFChdzps0CbgeUxkx9GbYRtKFxJWvlUUiJzZeE%3D" alt="image-alt-text">

   1.2 Azure Cloud Shell requires a storage account in your subscription to store data. For this lab ,  you do not have access to create storage accounts at the subscription level. However, we have provided storage account access at your resource group level - {{azure\_rg}}. In order to configure Azure Cloud Shell inside your resource group, select advanced settings and fill in the following details

```text
Subscription: {{azure-sub}}. This should already be preselected
Cloud Shell region : South Central US
Resource Group : Use existing and select your resource group ({{azure_rg}})
Storage Account : Create new and provide a name for storage account. Ex: qlazsa1
File share: Select Create new and provide a new for Azure File Share. Ex: qlazfs1
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/cloud-shell-storage.gif?st=2019-08-26T06%3A17%3A44Z&se=2022-08-27T06%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T9KvJDoLXDgoigvL2bwERnQ0iXvMM5BH8gJeYs3YomA%3D" alt="image-alt-text">

   1.3 It takes few seconds to setup the storage account and Azure Cloud Shell. Once it is setup, you should see the Bash command prompt for further use. You do not need to install _az cli_ and _kubectl_ on Azure Cloud Shell as they come pre-installed.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/cloudshell.png?st=2019-08-26T06%3A18%3A22Z&se=2022-08-27T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qXubaIjaQKEjt5kyIM4pAuBJRH9e9cD5c8LepV0wvxk%3D" alt="image-alt-text">

2. To configure _kubectl_ to connect to Kubernetes cluster, use the az aks get-credentials command. This command downloads credentials and configures the Kubernetes CLI into the current environment \( Azure Cloud Shell\).

```text
az aks get-credentials --resource-group {{azure-resourcegroup}} --name [replace_with_cluster_name]
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/azcs-aks-get-creds.png?st=2019-08-26T06%3A18%3A55Z&se=2022-08-27T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wLSfCHQGjEXKpeFRtOAouP5iYKKvLpdVNCQkpvKf%2BAQ%3D" alt="image-alt-text">

3. To verify the connection, use the following command to list out the nodes and their status.

`$ Kubectl get nodes`

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/aks-get-nodes.png?st=2019-08-26T06%3A20%3A06Z&se=2022-08-27T06%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aWmU5IsmhbIyVjWyHU7wnKbflKEdCm6A4R8Nc0jNXQk%3D" alt="image-alt-text">

You have successfully created an AKS cluster and connected _kubectl_, the Kubernetes command line tool, to your cluster. In the next section, you will deploy a sample application!

## Deploy Sample Voting Application

Primary way to deploy an application on Kubernetes is to use a manifest file. Kubernetes is declarative, meaning, you provide the desired state of your application to Kubernetes and the cluster's repressibility to get your application to the desired state described in the manifest file. 

Below is an example of a manifest file that creates two deployments, one for the python applications and one for Redis.

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

1.. In the Azure Cloud Shell, use nano or vi to create a file name azure-vote.yaml and copy the above provided content and save the file

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/create-yaml-using-vi.gif?st=2019-08-26T06%3A20%3A52Z&se=2022-08-27T06%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KD41ole14ipUbN%2BLi9OCKP6rGTgkv0Qg4wab%2FNeU2RI%3D" alt="image-alt-text">

2. Deploy the application using kubectl apply command and provide the name of the YAML file as input parameter. 

```text
kubectl apply -f azure-vote.yaml
```

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/aks-cluster-2%20-%20Microsoft%20Azure%202019-08-19%2013-59-36.png?st=2019-08-26T06%3A21%3A37Z&se=2022-08-27T06%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GhYEta4Ad%2FUQsEAt8I%2BS7aatHY6kHx2L5%2FMrNuGAPXY%3D" alt="image-alt-text">

## Test the Application

1. Once the application is deployed, AKS exposes the application front end to the internet. This may take few minutes to complete. Use the following command to monitor the progress.

```text
kubectl get service azure-vote-front --watch
```

The EXTERNAL-IP for the azure-vote-front is in a pending state. Once it is ready it will change to the public IP address

2. Now that the public IP is available, copy the public IP and paste it in the chrome broswer on the qloudable console. This should open up the voting application. Vote your favorite pet and see the results change!

**Conclusion:** Congratulations! You have successfully completed the cluster creation using Azure Portal and deployed your first application! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!

## Appendix 

### References

1. Azure tagging best practices : [https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/)
2. Azure Kubernetes Service Architecture : Azure tagging best practices : [https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/)
