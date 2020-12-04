# Implement Azure Container Instances

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Provision the lab environment](#provision-the-lab-environment)

[Deploy a Docker image by using the Azure Container Instance](#deploy-a-docker-image-by-using-the-azure-container-instance)

[Review the functionality of the Azure Container Instance](#review-the-functionality-of-the-azure-container-instance)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to evaluate the use of Azure Container Instances for the deployment of Docker images.

**Scenario & Objectives**

This lab provides a way to find a new platform for virtualized workloads. You identified a number of container images that can be leveraged to accomplish this objective. Since you want to minimize container management, you plan to evaluate the use of Azure Container Instances for deployment of Docker images.

In this lab, you will learn:

1. Deploying a Docker image by using the Azure Container Instance

2. Review the functionality of the Azure Container Instance

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the Azure Console.

## Pre-Requisites

* Azure Fundamentals

* Docker Fundamentals

## Provision the lab environment

1.  Using the Chrome browser, login into Azure portal with the below details.

> **Azure login_ID:** {{azure-login-id}}

> **Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

## Deploy a Docker image by using the Azure Container Instance

In this task, you will create a new container instance for the web application. 

1. In the Azure portal, search for locate **Container instances** and then, on the **Container instances** blade, click **+ Add**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/1.png?st=2020-10-21T11%3A05%3A12Z&se=2025-10-22T11%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PNebamsgSXxTI9zsOgiss5Ra0hi32XO7InrFQYdRJ9o%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/2.png?st=2020-10-21T11%3A06%3A54Z&se=2025-10-22T11%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8%2BA2BbEZxKeBIT1%2BnnuifJC4%2FYiwbC6OBQ76NdDWcnk%3D)

2. On the **Basics** tab of the **Create container instance** blade, specify the following settings (leave others with their default values):

**Settings**
   
> **Subscription:** the name of the Azure subscription you are using in this lab
  
> **Resource group:** {{ResourceGroup}}  (Select the Existing ResourceGroup)
  
> **Container name:** az104-9b-c1
  
> **Region:** {{region}}
  
> **Image Source:** Quickstart images
  
> **Image:** microsoft/aci-helloworld (Linux)

3. Click **Next: Networking >** and, on the **Networking** tab of the **Create container instance** blade, specify the following settings (leave others with their default values):

**Settings**
    
> **DNS name label:** any valid, globally unique DNS host name
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/3.png?st=2020-10-21T11%3A07%3A49Z&se=2025-10-22T11%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2Fw6xLxBKUqthpNt%2FMTQ7PgIQzsyQT%2Fq1xppyZ%2FmIEaE%3D)    
    	
> **Note:** Your container will be publicly reachable at dns-name-label.region.azurecontainer.io. If you receive a DNS name label not available error message, specify a different value.

4. Click **Next: Advanced >**, review the settings on the **Advanced** tab of the **Create container instance** blade without making any changes, click **Review + Create**, and then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/4.png?st=2020-10-21T11%3A09%3A39Z&se=2025-10-22T11%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gLYSVgfPaQDG3fQXLDNkCsoL9QnxtRjpBZE9zeNXAXI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/5.png?st=2020-10-21T11%3A10%3A19Z&se=2025-10-22T11%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AN%2BCPHh7KIxbPMi4QMMtOAqvft2U8d%2BvLUpHavIaMgY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/6.png?st=2020-10-21T11%3A11%3A21Z&se=2025-10-22T11%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0YkOK%2FPoSJxZ8nmxh1i7Sjn3mfdRyV3fOXFzbSJQ27g%3D)

> **Note:** Wait for the deployment to complete. This should take about 3 minutes.

> **Note**: While you wait, you may be interested in viewing the [code behind the sample application](https://github.com/Azure-Samples/aci-helloworld). To view it, browse the \app folder.

## Review the functionality of the Azure Container Instance

In this task, you will review the deployment of the container instance.

1. On the deployment blade, click the **Go to resource** link.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/7.png?st=2020-10-21T11%3A12%3A12Z&se=2025-10-22T11%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wpIV0OiCOW0MNPVyaDOzXMqsdbu9y7OqQH2MVzV%2BPPA%3D)

2. On the **Overview** blade of the container instance, verify that **Status** is reported as **Running**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/8.png?st=2020-10-21T11%3A12%3A45Z&se=2025-10-22T11%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GUAaObiWKtNi28hY2%2Bpi4DF%2BnB%2F0zfEYrqgbzGIu5cM%3D)

3. Copy the value of the container instance **FQDN**, open a new browser tab, and navigate to the corresponding URL.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/9.png?st=2020-10-21T11%3A13%3A42Z&se=2025-10-22T11%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XC6Elejkv3xFH7pkF1tGVFneiMrTXwypZcV%2BUNZFJZY%3D)

4. Verify that the **Welcome to Azure Container Instance** page is displayed.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/10.png?st=2020-10-21T11%3A14%3A45Z&se=2025-10-22T11%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hEEA6XEipeIg1%2FtrLHvUMNW7UJl2HrmRxP86yyLD6io%3D)

5. Close the new browser tab, back in the Azure portal, in the **Settings** section of the container instance blade, click **Containers**, and then click **Logs**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Azure%20Container%20Instances/Images/11.png?st=2020-10-21T11%3A15%3A31Z&se=2025-10-22T11%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7yhO0Z5CggPUY%2BVxY5akydyYY0YcowK3tv2ZZTskNSw%3D)

6. Verify that you see the log entries representing the HTTP GET request generated by displaying the application in the browser.

### Review

In this lab, you have:

* Deployed a Docker image by using the Azure Container Instance

* Reviewed the functionality of the Azure Container Instance

## Conclusion

Congratulations! You have successfully completed the **Implement Azure Container Instances**! lab. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
