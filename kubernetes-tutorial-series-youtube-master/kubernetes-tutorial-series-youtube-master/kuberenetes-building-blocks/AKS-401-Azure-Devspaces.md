
# Azure Devspaces(AZDS)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#Pre-requisites)

[Access the kubernetes cluster](#access-the-kubernetes-cluster)

[Get the application code from the github repository](#get-the-application-code-from-the-github-repository)

[Build and run code in kubernetes](#build-and-run-code-in-kubernetes)

## Overview

In this lab users will learn about Azure Devspaces. It is an Azure developer service that helps teams to develop with speed on kubernetes. 

## Pre-Requisites

1. Azure Cloud Infrastructure account credentials (User, Password, ResourceGroup, and Subscription).
2. Basic Linux Commands.
3. Docker Fundamentals.
4. Basic Azure Cloud Knowledge.

## Access the kubernetes cluster

**Sign in to Azure portal**

1.	Using the Chrome browser provided in the Qloudable Console on the right, sign into Azure portal using the following credentials generated for you:

* **Azure Login ID :** {{azure_login}}

* **Azure Password :** {{azure_password}}

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/aks%20images/landingpage.PNG?st=2019-10-16T09%3A58%3A17Z&se=2022-10-17T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CUJ%2B2tK4s25F%2BL88voMTtzpAM8obbAYafLnFYsuYOzc%3D" alt="image-alt-text">

2. Navigate to the `resource-groups` you should see a two resource groups deployed one contains aks-cluster resource, The second resource group, known as the node resource group, contains all of the infrastructure resources associated with the cluster. These resources include the Kubernetes node VMs, virtual networking, and storage. By default, the node resource group has a name like E.g. MC_myResourceGroup_myAKSCluster_eastus. AKS automatically deletes the node resource whenever the cluster is deleted, so it should only be used for resources which share the cluster's lifecycle.

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

### Enable Azure dev spaces on AKS cluster

* Use the use-dev-spaces command to enable Dev Spaces on your AKS cluster and follow the prompts. 

* The below command enables Dev Spaces on the MyAKS cluster in the ResourceGroupgroup and creates a default dev space. Below command popups a new window i.e Azure Dev Spaces CLI, basically by default this will install a kubectl command-line tool.

```
az aks use-dev-spaces -g {{rg-name}} -n {{cluster-name}}
```

After dev-spaces installed, it will ask to create a dev space name or use existing namespace.

* Select a dev space or Kubernetes namespace to use as a dev space.
* type a number to use existing dev space or mention a name to create a new dev name.
* In this lab will let you create the dev name as aks-dev.

```
  [1] default
Type a number or a new name: aks-dev

dev-space `aks-dev` doesn't exist and will be created.
select a parent dev space or kubernetes to use a parent dev space

[0] none
[1] aks-dev

Type number:1

create a name:test
created aks-dev/test

```
* This will creates a own space(child-space) derived from `aks-dev/test`.
* suppose if anyone newly joins into a company, they may not be compatible with application properly in that case child-devspaces works properly without affecting code.
* Azure dev-spaces is space for developers.

## Get the application code from the github repository

* Clone the application code from the github and navigate to correct working directory.

`git clone "https://github.com/Azure/dev-spaces"`

`cd dev-spaces/samples/nodejs/getting-started/webfrontend`

### Prepare the application

* Generate the Docker and Helm chart assets for running the application in Kubernetes using the `azds prep` command.

* `-- public` flag will genarate public endpoint url accessible through internet.

`azds prep –- public`

* CLI's azds prep command generates Docker and Kubernetes assets with default settings.

  * azds prep command generates following files
  * Dockerfile
  * Charts folder describes how to deploy the container to kubernetes.
  * ./azds.yaml is also generated by the prep command, and it is the configuration file for Azure Dev Spaces. It complements the Docker     and Kubernetes additional configuration.
  
## Build and run code in kubernetes
 
 * Run the below command from root directory to build and deploy it into kubernetes.
 * azds up command will gives you two endpoints i.e public url and localhost ssh tunnel.
 
  `azds up`
  
```
  Using dev space 'aks-dev' with target 'MyAKS'
Synchronizing files...2s
Installing Helm chart...2s
Waiting for container image build...2m 25s
Building container image...
Step 1/8 : FROM node
Step 2/8 : ENV PORT 80
Step 3/8 : EXPOSE 80
Step 4/8 : WORKDIR /app
Step 5/8 : COPY package.json .
Step 6/8 : RUN npm install
Step 7/8 : COPY . .
Step 8/8 : CMD ["npm", "start"]
Built container image in 6m 17s
Waiting for container...13s
Service 'webfrontend' port 'http' is available at http://webfrontend.851nvpxf6j.eus.azds.io/
Service 'webfrontend' port 80 (http) is available at http://localhost:53962   
```

### Update and Debugging through VS Code
 
 * Open the visual studio code, Click `File` then `Add folder to workspace` choose the service directory which you are going to change.
 * open server.js file add some changes and re-run the `azds up` command to changes file reflected in the server.
 * Open the visual studio code, Click `File` then `Add folder to workspace` choose the service directory which are going to be debug.
 
 * Open the Command Palette in Visual Studio Code, click `View` then `Command Palette`. Begin typing Azure Dev Spaces and click on
 
  `Azure Dev Spaces: Prepare configuration files for Azure Dev Space`
  
 * This command prepares on your service folder directory to run Azure devspaces directly from visual studio code, this will generate a `.vscode` in service root directory, this will gives debugging configuration at the root of the project.
 
 * Click debug icon on the left and click Launch Server(AZDS) at the top. Launch Server(AZDS) will runs in a debug mode.
 * The terminal window bottom shows the build output and URL's of services running in a azure devspaces.
 * Open server.js and click somewhere on line 10 to put your cursor there. To set a breakpoint hit F9 or click Debug then Toggle Breakpoint.
 
 
referenced from https://docs.microsoft.com/en-us/azure/dev-spaces/quickstart-nodejs  
 
 
 **Conclusion:**

Congratulations! You have successfully completed the Kubernetes Azure devspaces lab. In this lab, you created Enable Azure dev spaces on AKS cluster, Prepare the application, Build and run code in kubernetes, Updating and Debugging through VS Code 

Feel free to continue exploring or start a new lab.

Thank you for taking this training lab!
  
