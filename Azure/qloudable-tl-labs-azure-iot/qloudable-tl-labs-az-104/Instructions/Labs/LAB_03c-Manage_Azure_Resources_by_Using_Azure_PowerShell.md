# Manage Azure resources by Using Azure PowerShell

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Start a PowerShell session in Azure Cloud Shell](#start-a-powershell-session-in-azure-cloud-shell)

[Create an Azure managed disk by using Azure PowerShell](#create-an-azure-managed-disk-by-using-azure-powershell)

[Configure the managed disk by using Azure PowerShell](#configure-the-managed-disk-by-using-azure-powershell)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to create resources and organizing them based on resource groups by using Azure PowerShell.

**Scenario & Objectives**

In this lab you will explore the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups by using the Azure PowerShell. To avoid installing Azure PowerShell modules, you will leverage PowerShell environment available in Azure Cloud Shell.

In this lab, you will learn: 

1. Starting a PowerShell session in Azure Cloud Shell

2. Creating an Azure managed disk by using Azure PowerShell

3. Configuring the managed disk by using Azure PowerShell

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* Azure fundamentals

## Start a PowerShell session in Azure Cloud Shell

In this task, you will open a PowerShell session in Cloud Shell. 

1. Using the Chrome browser, login into [Azure portal](https://portal.azure.com) with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2. In the portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

3. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

<p class="note-container">
If this is the first time you are starting Cloud Shell and you are presented with the You have no storage mounted message, select the subscription you are using in this lab, and click Create storage. 
 </p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)

* **Cloud Shell region:** `{{location}}`

* **Resource group:** `{{resource-group-name}}` <br>

* **Storage Account Name:** `Create new Storage` <br>

* **File Share Name:** `Create new file share`


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a41.PNG?st=2019-09-18T04%3A58%3A12Z&se=2022-09-19T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zQJmfYNONwPRTvZ3mdfA6ZtkxKIjh%2FCTdGu9oNPOe%2FE%3D)

4. Ensure **PowerShell** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20Azure%20PowerShell/power_shell_5.jpg?st=2020-10-20T11%3A44%3A45Z&se=2026-10-21T11%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lFR17ZhcsEeiJ2Inz%2BLBO2XUTj3PjT7XF5ze1qW%2FS4I%3D)

## Create an Azure managed disk by using Azure PowerShell

In this task, you will create an Azure managed disk by using Azure PowerShell session within Cloud Shell

1. To create a new managed disk, run the following:

   ```
    $rgName = {{Resource-Group-name}}
   ```
   ```
   $location = {{location}}
   ```

   ```
   $diskConfig = New-AzDiskConfig `
    -Location $location `
    -CreateOption Empty `
    -DiskSizeGB 32 `
    -Sku Standard_LRS

   $diskName = 'az104-03c-disk1'

   New-AzDisk `
    -ResourceGroupName $rgName `
    -DiskName $diskName `
    -Disk $diskConfig
   ```

4. To retrieve properties of the newly created disk, run the following:

   ```
   Get-AzDisk -ResourceGroupName $rgName -Name $diskName
   ```

## Configure the managed disk by using Azure PowerShell

In this task, you will managing configuration of the Azure managed disk by using Azure PowerShell session within Cloud Shell. 

1. To increase the size of the Azure managed disk to **64 GB**, from the PowerShell session within Cloud Shell, run the following:

   ```
   New-AzDiskUpdateConfig -DiskSizeGB 64 | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
   ```

2. To verify that the change took effect, run the following:

   ```
   Get-AzDisk -ResourceGroupName $rgName -Name $diskName
   ```

3. To verify the current SKU as **Standard_LRS**, run the following:

   ```
   (Get-AzDisk -ResourceGroupName $rgName -Name $diskName).Sku
   ```

4. To change the disk performance SKU to **Premium_LRS**, from the PowerShell session within Cloud Shell, run the following:

   ```
   New-AzDiskUpdateConfig -Sku Premium_LRS | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
   ```

5. To verify that the change took effect, run the following:

   ```
   (Get-AzDisk -ResourceGroupName $rgName -Name $diskName).Sku
   ```

### Review

In this lab, you have:

* Started a PowerShell session in Azure Cloud Shell

* Created a resource group and an Azure managed disk by using Azure PowerShell

* Configured the managed disk by using Azure PowerShell

## Conclusion

Congratulations! You have successfully completed the lab **Manage Azure resources by Using Azure PowerShell**! lab. Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
