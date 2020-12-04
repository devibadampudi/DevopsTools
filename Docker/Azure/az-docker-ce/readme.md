# Docker CE

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to the Azure portal](#login-to-the-azure-portal)

[Launch Instance for Docker CE ](#launch-instance-for-docker-ce )

[Login to the Instance and Install Docker CE](#login-to-the-instance-and-install-docker-ce)

[Initialize Docker Swarm and Deploy Cats and Dogs Application](#initialize-docker-swarm-and-deploy-cats-and-dogs-application)


## Overview

About Docker CE:
Docker Community Edition (CE) is ideal for developers and small teams looking to get started with Docker and experimenting with container-based apps. Docker CE has three types of update channels, **stable, test, and nightly**

- **Stable** gives you latest releases for general availability.
- **Test** gives pre-releases that are ready for testing before general availability.
- **Nightly** gives you latest builds of work in progress for the next major release.

For more information about Docker CE, see Docker Community Edition.


## Pre-Requisites

- Linxu basics
- Docer basics

## Login to the Azure portal

In the lab console window, use the web browser and go to https://portal.azure.com

Azure login_ID: {{azure-login-id}}<br>
Azure login_Password: {{azure-login-password}}<br>
Resource group Name: {{resource-group-name}}<br>
location: {{azure-rg-location}}

For login credentials click on access info left top of context window. Click on required value To copy to clip board and past it on worksapace window.

Enter the username provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Enter the password Provided in the lab credentials.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The dashboard of the Azure portal will Appear after a successful login.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Launch Instance for Docker CE 

In this section we will create a Ubuntu server to install Docker CE on it.


Launching a VM:

Step 1: On Azure portal (https://portal.azure.com), click on **"Create a resource"** from the navigation pane.

Step 2: Search for "Ubuntu Server", select Canonical "Ubuntu 16.04 LTS" from the dropdown and click on create.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 3: Leaving the default values untouched, Fill the form as below.
Resource group: Select the name of RG shared with your login credentials.<br>
Virtual Machine Name: Any name (dockerce)<br>
Authentication type: Password <br>
Username: dockerce<br>
Password: Password@1234<br>
size: Standard Ds1 v2<br>
Public inbound ports: Check the radio button "Allow selected ports" and allow ports 22 from the dropdown.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4: On the next steps "Disks and Networking", Leave all fields to defaults and proceed to the Management tab.

Step 5: Set the "Boot Diagnostics" to 'Off' and proceed over to the final step "Review and Create" and click on create after you see that the validation succeeds.

Step 6: Afeter completion of deployment goto your resource group and clik on Virtual machine. Do copy  server ip for future use.

## Login to the Instance and Install Docker CE

In this section we will SSH into the Created instance and Configure the Docker CE. 

**Step 1.** Open putty from applications drop-down at top-left corner of the workspace.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Connect using the IP of "Docker CE VM" and use the credentials you provided when creating the VM.
 
Server setup:

**Login as: dockerce**<br>
**Password: Password@1234**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

### Install Docker CE

You can install Docker CE in different ways, depending on your needs:

- Most users set up Docker’s repositories and install from them, for ease of installation and upgrade tasks. This is the recommended approach.

- Some users download the deb package and install it manually and manage upgrades completely manually. This is useful in situations such as installing Docker on air-gapped systems with no access to the internet.

In this lab, we are going with Docker's repositories.

Bring up git bash already login to ubuntu in the previous section.


Run: 

```sh
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update 
sudo apt-get install -y docker-ce
sudo usermod -a -G docker $USER
exit
 ```
Now re login to docker CE and Verify that Docker CE is installed correctly by running hello-world image.

```sudo docker run hello-world```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/9.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

To check the images, present in docker run: ```sudo docker images```

To check the containers 

run: ```sudo docker ps -a```

## Initialize Docker Swarm and Deploy Cats and Dogs Application

Docker Swarm Environment:

Initialize a swarm. The docker engine targeted by this command becomes a manager in the newly created single-node swarm.

-  To start docker swarm run: ```sudo docker swarm init```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/10.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

- To check the nodes connected to swarm run:  ``` docker node ls```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/11.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

### Deploying Cats & Dogs application:

Now deploy a simple app in Docker swarm. You can get sample cats & dogs app from docker site.

Run below command to get docker-stak.yml file.

```curl -O https://raw.githubusercontent.com/docker/example-voting-app/master/docker-stack.yml```

 
- Run below command to deploy the application on docker swarm.

``` docker stack deploy -c docker-stack.yml vote```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/12.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

If u got any failures while deploying the app run the same command after few seconds.

- This app will deploy six services, to check services run:

```docker service ls```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/13.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
- To check the app run : 

 ```curl localhost:5000```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/14.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

-  You can browse the app in your browser, for that first you need open **port 5000** in your network security group’s inbound rule on Azure portal
- Go back to azure portal, slect VM and click on Networking from left menu and add Inbound rule as shown below

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/15.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/16.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
- On browser enter ```<dackerswarm_publicip>:5000```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/dockerce/images/17.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)