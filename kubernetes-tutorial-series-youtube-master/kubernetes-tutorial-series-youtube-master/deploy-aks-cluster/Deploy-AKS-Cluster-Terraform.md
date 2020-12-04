# Deploy AKS Cluster using Terraform

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Introduction](#introduction)

[Configuration](#configuration)

[Connect to the Cluster](#connect-to-the-cluster)

[Deploy Nginx application](#deploy-nginx-application)

[Appendix](#appendix)

## Overview

Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.

Azure Kubernetes Service \(AKS\) is a managed container orchestration service to deploy and manage containerized applications. It is based on the open source Kubernetes system and is available on the Azure public cloud. The Kubernetes master nodes are managed by Azure and the agent nodes are managed by the users. As it is a managed service, AKS is free, you only need to pay for agent nodes. Azure Kubernetes Service  can be created in the Azure Portal, with the Azure CLI, using ARM Templates and Terraform.

This lab will provide a step by step guide to deploy an AKS cluster, connect to it and run a sample application.

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


## Create a Service principal
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


## Configuration

The set of files used to describe infrastructure in Terraform is simply known as a Terraform configuration.
Here we are going to write our first configuration to launch AKS cluster in Azure.
Terraform configuration files will be saved with a **.tf** extension.
In the following example, to run or deploy the terraform infrastructure in azure cloud you'll need to have an azure service principal. Please follow the below Azure documentation to create the service principal and provide required details in the following template.

An Azure Active Directory service principal is used to allow an AKS cluster to interact with other Azure resources.
To create a service principal please follow the below azure documentation.
https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal

```

variable "subscription_id" {
  default = ""
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "tenant_id" {
  default = ""
}

variable "aks_client_id" {
  default     = ""
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "aks_client_secret" {
  default     = ""
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "agent_count" {
  default     = 1
  description = "Number of worker nodes to be provisioned"
}

variable "ssh_public_key" {
  default     = ""
  description = "SSH public key for worker nodes"
}

variable "dns_prefix" {
  default     = "akscluster"
  description = "A prefix used for dns name"
}

variable "cluster_name" {
  default     = "aks-cluster"
  description = "AKS cluster name"
}

variable "resource_group_name" {
  default     = "aks-cluster"
  description = "Resource Group name of the cluster"
}

variable "location" {
  default     = "West US 2"
  description = "The Azure Region in which all resources in this project should be provisioned"
}


provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "random_id" "random" {
  byte_length = 2
}

resource "azurerm_resource_group" "aks_resource_group" {
  name     = "${var.resource_group_name}-${random_id.random.hex}"
  location = "${var.location}"
}
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.cluster_name}"
  location            = "${azurerm_resource_group.aks_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.aks_resource_group.name}"
  dns_prefix          = "${var.dns_prefix}-${random_id.random.hex}"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${var.ssh_public_key}"
    }
  }

  agent_pool_profile {
    name            = "agentpool"
    count           = "${var.agent_count}"
    vm_size         = "Standard_DS1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${var.aks_client_id}"
    client_secret = "${var.aks_client_secret}"
  }

  role_based_access_control {
    enabled = false
  }

  tags = {
    Environment = "Training labs"
  }
}

output "access_cluster" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.aks_resource_group.name} --name ${azurerm_kubernetes_cluster.aks_cluster.name} --admin"
}

```

Provide all the required details in the above yaml file and save it as aks.tf.

### Terraform Intialization,Plan and Apply

The first command to run on a new configuration is ``terraform init`` which downloads all the required plugins.
Place the **aks.tf** file in a folder, navigate to that folder and run ``terraform init``.
The terraform init command will automatically download and install any Provider binary for the providers in use within the configuration, which in this case is just the Azure provider.
The azure provider plugin is downloaded and installed in a subdirectory of the current working directory, along with various other book-keeping files.

After initializing the terraform code run ``terraform plan``, this validates entire configuration in the aks.tf file.
Now run ``terraform apply`` to deploy the configuration into the azure cloud. This output shows the execution plan, describing which actions Terraform will take in order to change real infrastructure to match the configuration.
If the plan was created successfully, Terraform will now pause and wait for approval before proceeding. If anything in the plan seems incorrect or dangerous, it is safe to abort here with no changes made to your infrastructure. In this case the plan looks acceptable, so type "yes" at the confirmation prompt to proceed.

It will take few minutes to deploy the code, after which, you can see your configuration.

Once everything is done, you can destroy the infrastructure using ``terraform destroy``.




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

## Deploy Nginx application

1. Create a deployment that creates a replicaset to bring up three nginx pods.

2. You can create the deployment in a particular namespace or it will deploy in the default namespace. Save the YAML file and create using `kubectl create -f <file path>`

3. Create a namespace using `kubectl create ns <namespace-name>`

  ```  yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: nginx-deployment
    namespace: <namespace-name>
    labels:
      app: nginx
  spec:
    replicas: 3
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
          image: nginx:1.7.9
          ports:
          - containerPort: 80
  ```

3. Get the deployment using `kubectl -n <namespace-name> get deployments`

  ```
  NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
  nginx-deployment   3         3         3            3           4m
  ```

4. A Deployment named nginx-deployment is created, indicated by the .metadata.name field.

5. The Deployment creates three replicated Pods, indicated by the replicas field.

6. The selector field defines how the Deployment finds which Pods to manage. In this case, you simply select a label that is defined in the Pod template (app: nginx). However, more sophisticated selection rules are possible, as long as the Pod template itself satisfies the rule.

7. Get the pods in nginx deployment using `kubectl -n <namespace-name> get pods`

  ```
  NAME                                READY     STATUS    RESTARTS   AGE
  nginx-deployment-5c689d88bb-5h7vx   1/1       Running   0          9m
  nginx-deployment-5c689d88bb-mbqzg   1/1       Running   0          9m
  nginx-deployment-5c689d88bb-txdj7   1/1       Running   0          9m
  ```
  
  **Conclusion:** Congratulations! You have successfully completed the cluster creation using Azure terraform and deployed your first application! . Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!

## Appendix 

### References

1. Azure tagging best practices : [https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/)
2. Azure Kubernetes Service Architecture : Azure tagging best practices : [https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/decision-guides/resource-tagging/)
