# Manage Azure Storage

## Table of Contents

[Overview](#Overview)

[Pre-Requisites](#Pre-requisites) 

[Provision the lab environment](#Provision-the-lab-environment)

[Create and configure Azure Storage accounts](#Create-and-configure-Azure-Storage-accounts)

[Manage blob storage](#Manage-blob-storage)

[Manage authentication and authorization for Azure Storage](#Manage-authentication-and-authorization-for-Azure-Storage)

[Clean up resources](#Clean-up-resources)

## Overview

The main Aim of this lab is to evaluate the use of Azure storage for storing files residing currently in on-premises data stores. While majority of these files are not accessed frequently, there are some exceptions. You would like to minimize cost of storage by placing less frequently accessed files in lower-priced storage tiers. You also plan to explore different protection mechanisms that Azure Storage offers, including network access, authentication, authorization, and replication. Finally, you want to determine to what extent Azure Files service might be suitable for hosting your on-premises file shares.

**Scenario & Objectives**

You need to evaluate Azure functionality that would provide insight into performance and configuration of Azure resources, focusing in particular on Azure virtual machines. To accomplish this, you intend to examine the capabilities of Azure Monitor, including Log Analytics. 

In this lab, you will learn:

1. Provision the lab environment

2. Create and configure an Azure Log Analytics workspace and Azure Automation-based solutions

3. Review default monitoring settings of Azure virtual machines

4. Configure Azure virtual machine diagnostic settings

5. Review Azure Monitor functionality

6. Review Azure Log Analytics functionality

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console

## Pre-Requisites

* Azure fundamentals

## Provision the lab environment

In this task, you will deploy a virtual machine that will be used to test monitoring scenarios.

1.  Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2. Open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

3. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

<p class="note-container">
If this is the first time you are starting Cloud Shell and you are presented with the You have no storage mounted message, select the subscription you are using in this lab, and click Create storage.
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)

* **Resource group:** `{{resource-group-name}}` <br>

* **Storage Account Name:** `Create new Storage` <br>

* **File Share Name:** `Create new file share`

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a41.PNG?st=2019-09-18T04%3A58%3A12Z&se=2022-09-19T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zQJmfYNONwPRTvZ3mdfA6ZtkxKIjh%2FCTdGu9oNPOe%2FE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/21.png?st=2019-09-16T06%3A57%3A56Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JMFKFtYFry1nNVFUWtQOewXhh1ZDMSXBuR%2BXc4szLxk%3D)

4. Open the below Urls in Chrome and save it in folder as **az104-07-vm-template.json**
 
**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/az104-07-vm-template.json?st=2020-10-01T10%3A53%3A00Z&se=2025-10-02T10%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sl7nuDyDWhTRQzMbrjDaMQSZlzlp7wnUfvedjGpbaFU%3D**
 
5. Open below one in chrome and save it in folder as **az104-07-vm-parameter.json** file
 
**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/az104-07-vm-parameters.json?st=2020-10-01T10%3A54%3A50Z&se=2025-10-02T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1iB0Z1K2lr1urWl%2B8sH0j0cZ%2BHh0W%2BHQzRGNA%2Bx1k1E%3D** 

6. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **az104-07-vm-template.json** and **az104-07-vm-parameters.json** into the Cloud Shell home directory.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/az15.png?st=2020-10-01T07%3A49%3A31Z&se=2025-10-02T07%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RZzUjo1D%2BQsmWmJU7tkx5HCtkHBPBmIIYFa4FU%2FNsRA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/2.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

7. From the Cloud Shell pane, run the following to create the resource group that will be hosting the virtual machines (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy Azure virtual machines):

> **Note**: Make sure to choose one of the regions listed as **Log Analytics Workspace Region** in the referenced in [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings)

$location = {{Location}}

$rgName = {{resource-group-name}}

New-AzResourceGroup -Name $rgName -Location $location

8. From the Cloud Shell pane, run the following to create the first virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-07-vm-template.json `
      -TemplateParameterFile $HOME/az104-07-vm-parameters.json `
      -AsJob
```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azm-6.png?st=2020-10-07T05%3A18%3A02Z&se=2025-10-08T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=S8qCoDqv8IscibbTRYXbY7mdoXzP4X5svpBwKK053GM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azm-6.png?st=2020-10-07T05%3A28%3A07Z&se=2025-10-08T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MeKaLcRkNbKTgZqlkdLwUCjKZXXY6jV2Zz5GmpUMjt0%3D)

<p class="note-container">
Do not wait for the deployment to complete but instead proceed to the next task. The deployment should take about 3 minutes.
</p>
   
9. Close the Cloud Shell pane.
   
## Create and configure Azure Storage accounts 

In this task, you will create and configure an Azure Storage account. 

1. In the Azure portal, search for and select **Storage accounts**, and then click **+ Add**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-st1.png?st=2020-10-07T05%3A31%3A10Z&se=2025-10-08T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fDBFCCUneej%2B3jU5c7Sj1T2t0jtbrcfG2QONcJJjLmI%3D)

2. On the **Basics** tab of the **Create storage account** blade, specify the following settings (leave others with their default values):

* Setting - Value 

* Subscription - the name of the Azure subscription you are using in this lab 

* Resource group - **{{resource-group-name}}**

* Storage account name - any globally unique name between 3 and 24 in length consisting of letters and digits

* Location - the name of an Azure region where you can create an Azure Storage account  

* Performance - **Standard**

* Account kind -  **Storage (general purpose v1)**

* Replication -  **Read-access geo-redundant storage (RA-GRS)** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-st2.png?st=2020-10-07T05%3A37%3A26Z&se=2025-10-08T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pFv4ajGc%2BohFmLi6evTtOtwZJ1PXtfOdLnv3oCW3%2B8A%3D)

3. Click **Next: Networking >**, on the **Networking** tab of the **Create storage account** blade, review the available options, accept the default option **Public endpoint (all networks}** and click **Next: Data protection >**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-st3.png?st=2020-10-07T05%3A45%3A15Z&se=2025-10-08T05%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mvxYdhQV6uMnyBRslJG%2FWc%2BLMjU294QsxEnWS8YqCrA%3D)
 
4. On the **Data protection** tab of the **Create storage account** blade, review the available options, accept the defaults, and click **Next: Advanced >**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-st4.png?st=2020-10-07T05%3A47%3A18Z&se=2025-10-08T05%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3gQBTicS85%2FOB16U1qiH5mEDDuLiMQYn8tAVyZoP%2Bbc%3D)

5. On the **Advanced** tab of the **Create storage account** blade, review the available options, accept the defaults, click **Review + Create**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-st5.png?st=2020-10-07T05%3A49%3A16Z&se=2025-10-08T05%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cB86XjX59vmc%2F4CE05kTa0rCwjKLq1mZRwZAJ3R5%2BQM%3D)

6. Wait for the validation process to complete and click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-st6.png?st=2020-10-07T05%3A52%3A27Z&se=2025-10-08T05%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KtzYmCXx030EUWQArjGOYgabpDb2%2FbS3wKf4J6HLvRU%3D)

<p class="note-container">
Wait for the Storage account to be created. This should take about 2 minutes.
</p>
    
7. On the deployment blade, click **Go to resource** to display the Azure Storage account blade. 
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-resource1.png?st=2020-10-07T06%3A09%3A23Z&se=2025-10-08T06%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KLyyr5A6gGFlSHCqMGJdHTAUYdi6z29SpmDRrqZkwLc%3D)

8. On the Azure Storage account blade, in the **Settings** section, click **Configuration**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-sett-configuration1.png?st=2020-10-07T06%3A11%3A11Z&se=2025-10-08T06%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=f%2FKV5fRrTeP%2BN7rB2Y8oo2flNhZIk8%2FKOME3GYTcvg0%3D)

9. Click **Upgrade** to change the Storage account kind from **Storage (general purpose v1)** to **StorageV2 (general purpose v2)**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-upgrade2.png?st=2020-10-07T06%3A14%3A07Z&se=2025-10-08T06%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sfCVX9KSGStHE8Lua6biWXd%2FBbFEnt5PMvJ4MDQFZtM%3D)

10. On the **Upgrade storage account** blade, review the warning stating that the upgrade is permanent and will result in billing charges, in the **Confirm upgrade** text box, type the name of the storage account, and click **Upgrade**. 

<p class="note-container">
You have the option to set the account kind to StorageV2 (general purpose v2) at the provisioning time. The previous two steps were meant to illustrate that you also have the option to upgrade existing general purpose v1 accounts.
</p>

<p class="note-container">
StorageV2 (general purpose v2) offers a number of features, such as, for example, access tiering, not available in with general purpose v1 accounts.
</p>

<p class="note-container">
Review the other configuration options, including Access tier (default), currently set to Hot, which you can change, the Performance, currently set to Standard, which can be set only during account provisioning, and the Identity-based Directory Service for Azure File Authentication, which requires Azure Active Directory Domain Services.
</p>

11. On the Storage account blade, in the **Settings** section, click **Geo-replication** and note the secondary location. Click the **View all** link under the **Storage endpoints** label and review the **Storage account endpoints** blade.  

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/azms-geo1.png?st=2020-10-07T06%3A24%3A03Z&se=2025-10-08T06%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=g%2F6oo6tO0%2By5%2FfO6N6mzP8VZSVxBzzGeVvcyIQkZUU8%3D)

<p class="note-container">
As expected, the Storage account endpoints blade contains both primary and secondary endpoints.
</p>

12. Switch to the Configuration blade of the Storage account and, in the **Replication** drop-down list, select **Geo-redundant storage (GRS)** and save the change.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/geo2.png?st=2020-10-07T06%3A34%3A26Z&se=2025-10-08T06%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uG%2FPAKnQARZyjPX2AHD56IyJSt3K%2BXWleaLOl4VP%2FH8%3D)

13. Switch back to the **Geo-replication** blade and note that the secondary location is still specified. Click the **View all** link under the **Storage endpoints** label and review the **Storage account endpoints** blade.  

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/geo-primary.png?st=2020-10-07T06%3A37%3A13Z&se=2025-10-08T06%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EwDU2PalM9kaPruF%2BRi7eXGwhSMOZaryu7aMmSUzsLM%3D)

<p class="note-container">
As expected, the Storage account endpoints blade contains only primary endpoints.
</p>

14. Display again the **Configuration** blade of the Storage account, in the **Replication** drop-down list select **Locally redundant storage (LRS)** and save the change.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/LRS.png?st=2020-10-07T06%3A38%3A30Z&se=2025-10-08T06%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zDj22DS1bgww91l2iqgmwEYvJ9wptGYNv%2FrBwRm%2BuWY%3D)

15. Switch back to the **Geo-replication** blade and note that, at this point, the Storage account has only the primary location.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/geo-LRS.png?st=2020-10-07T06%3A41%3A27Z&se=2025-10-08T06%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=x8bbfoH8Bobn%2BjKmXP8ad2utd%2FQu9M0oRyjwiIQpIJk%3D)

16. Display again the **Configuration** blade of the Storage account and set **Access tier (default)** to **Cool**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/configuration-cool.png?st=2020-10-07T06%3A43%3A19Z&se=2025-10-08T06%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SPdrFAQ%2F8MuiiHDpdoQEBg3ilub8PUfXvr1Cf4qzbq0%3D)

<p class="note-container">
The cool access tier is optimal for data which is not accessed frequently.
</p>

## Manage blob storage

In this task, you will create a blob container and upload a blob into it. 

1. On the Storage account blade, in the **Blob service** section, click **Containers**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/blob-1.png?st=2020-10-07T06%3A47%3A30Z&se=2025-10-08T06%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sx4ffpSF3cMrF%2FipGKXHz4qZrjUoG2AL60q6%2FKXeHTY%3D)

2. Click **+ Container** and create a container with the following settings: 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/container1.png?st=2020-10-07T06%3A50%3A07Z&se=2025-10-08T06%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QU6E2XfpJmUK4lqFklrLVB7lo%2BZrMndPAeHCpKxDmlo%3D)

* Name - **az104-07-container** 

* Public access level - **Private (no anonymous access)** 

3. In the list of containers, click **az104-07-container** and then click **Upload**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/az-container.png?st=2020-10-07T06%3A55%3A00Z&se=2025-10-08T06%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0xKGOuKkg2G5Cq4guYAx8vdrSk4w7RSQBvpwcc1cnwY%3D)

4. Browse this file in a chrome save it in folder on your lab computer and click **Open**.

**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/LICENSE?st=2020-10-07T07%3A16%3A59Z&se=2025-10-08T07%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xc9aooTyhOYlYSe1IdElRE5QpgzTeNLyMBbD%2F%2FG0Bjw%3D**
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/LICENSE-upload.png?st=2020-10-07T07%3A18%3A06Z&se=2025-10-08T07%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4%2FM3fXNm0En2i%2BxMR2vF3R7%2FulW5TTWyBGkrJ0UqoAI%3D)
 
5. On the **Upload blob** blade, expand the **Advanced** section and specify the following settings (leave others with their default values):

* Authentication type - **Account key** 

* Blob type -  **Block blob** 

* Block size -  **4 MB** 

* Access tier - **Hot** 

* Upload to folder - **licenses** 
    
<p class="note-container">
Access tier can be set for individual blobs.
</p>
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/upload-advanced.png?st=2020-10-07T07%3A20%3A01Z&se=2025-10-08T07%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CkCvMpne5LLTtSrXtGNfV0UFsQQrM%2FDD92cPofrZh7Y%3D)
    
6. Click **Upload**.

<p class="note-container">
Note that the upload automatically created a subfolder named **license**.
</p>
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/folder-license.png?st=2020-10-07T07%3A21%3A31Z&se=2025-10-08T07%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FHMjWeoy7vjD7emD0vew4rHM5Zn9ik%2FpaFCA%2B4jzZRI%3D)
    
7. Back on the **az104-07-container** blade, click **license** and then click **LICENSE**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/folder-lic1.png?st=2020-10-07T07%3A24%3A19Z&se=2025-10-08T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YBk9VnXqLLEpCenUeEsKwR2QNAlb9RVAKSkX4dcvPlA%3D)

8. On the **license/LICENSE** blade, review the available options. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/download-file.png?st=2020-10-07T07%3A26%3A18Z&se=2025-10-08T07%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pjAOYRIwi4RKflOlbHO45TJyxI05M5B4LdN8Qd4YX7I%3D)

<p class="note-container">
You have the option to download the blob, change its access tier (it is currently set to Hot), acquire a lease, which would change its lease status to Locked (it is currently set to Unlocked) and protect the blob from being modified or deleted, as well as assign custom metadata (by specifying an arbitrary key and value pairs). You also have the ability to Edit the file directly within the Azure portal interface, without downloading it first. You can also create snapshots, as well as generate a SAS token (you will explore this option in the next task).
</p>

## Manage authentication and authorization for Azure Storage

In this task, you will configure authentication and authorization for Azure Storage.

1. On the **license/LICENSE** blade, on the **Overview** tab, click **Copy to clipboard** button next to the **URL** entry.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/copy-clipboard.png?st=2020-10-07T07%3A32%3A00Z&se=2026-10-08T07%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6vlqpuKNuem%2BWelmdDDRPHwIXvNZROuFEyGFUbWKq8M%3D)

2. Open another browser window by using InPrivate mode and navigate to the URL you copied in the previous step. 

3. You should be presented with an XML-formatted message stating **ResourceNotFound** or **PublicAccessNotPermitted**.

<p class="note-container">
This is expected, since the container you created has the public access level set to **Private (no anonymous access)**.
</p>
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/url-opened.png?st=2020-10-07T07%3A35%3A11Z&se=2025-10-08T07%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xvcYX5Ecs1rnlOlLX%2BFZE5os4T0BzcwNAoFhOAPz0zc%3D)

4.  Close the InPrivate mode browser window, return to the browser window showing the **license/LICENSE** blade of the Azure Storage container, and switch to the the **Generate SAS** tab.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/generateSAS.png?st=2020-10-07T07%3A38%3A46Z&se=2025-10-08T07%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GlYptEPc4qkCK7EuxeUTdSUecLZp7xJIbSl7Gmwq6Yo%3D)

5. On the **Generate SAS** tab of the **licenses/LICENSE** blade, specify the following settings (leave others with their default values):

* Permissions - **Read** 

* Start date - yesterday's date

* Start time - current time

* Expiry date - tomorrow's date

* Expiry time - current time 

* Allowed IP addresses - leave blank 

* Allowed protocols -  **HTTP** 

* Signing key - **Key 1** 
  
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/generateSAS-URL.png?st=2020-10-07T07%3A43%3A46Z&se=2025-10-08T07%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B19tUJxpAaV8pMSwlE22lBG2lUZWZeL3gSQKUSLL7EU%3D)

6. Click **Generate SAS token and URL**.

 ![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/generateSASURL1.png?st=2020-10-07T07%3A46%3A04Z&se=2025-10-08T07%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0Kmou75N5%2BqeBrSMJgkremgl60ZWZU1sUV69ZtJCi3g%3D)

7. Click **Copy to clipboard** button next to the **Blob SAS URL** entry.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/BLOBSASURL.png?st=2020-10-07T07%3A48%3A18Z&se=2025-10-08T07%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=murJqmmWeyrJhAe2Y6zhZgBKvGSDK0AMtUCbqsnF1SQ%3D)

8. Open another browser window by using InPrivate mode and navigate to the URL you copied in the previous step. 

<p class="note-container">
If you are using Microsoft Edge or Internet Explorer, you should be presented with the The MIT License (MIT) page. If you are using Chrome, Microsoft Edge (Chromium) or Firefox, you should be able to view the content of the file by downloading it and opening it with Notepad.
</p>

<p class="note-container">
This is expected, since now your access is authorized based on the newly generated the SAS token.
</p>

<p class="note-container">
Save the blob SAS URL. You will need it later in this lab.
</p>

9. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and from there, navigate back to the **az104-07-container** blade.

10. Click the **Switch to the Azure AD User Account** link next to the **Authentication method** label.

<p class="note-container">
At this point, you no longer have access to the container. 
</p>
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/switch-azureAD.png?st=2020-10-07T07%3A53%3A00Z&se=2025-10-08T07%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=k5ye8Vf%2Fm1x2zB%2FRRIUP618XQA%2Bh3QqpqjAlbD5H%2BzE%3D)

11. On the **az104-07-container** blade, click **Access Control (IAM)**.

12.  In the **Add** section, click **Add a role assignment**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/IAM-roleassignments1.png?st=2020-10-07T08%3A00%3A01Z&se=2025-10-08T08%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6zimHqu0iuvZw4uYNfat6PMaI259Om9oAzCM5bUl%2BnI%3D)

13.  On the **Add role assignment** blade, specify the following settings:

* Role - **Storage Blob Data Owner** 

* Assign access to **Azure AD user, group, or service principal**

* Select the name of your user account 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/roleassignmentsave.png?st=2020-10-15T10%3A12%3A15Z&se=2025-10-16T10%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OpzWtM1sM0UNZvWTGg78MCTcvCH8zdHCQTeUmzmxMpA%3D)

14.  Save the change and return to the **Overview** blade of the **az104-07-container** container and verify that you can access to container again.

<p class="note-container">
It might take about 5 minutes for the change to take effect.
</p>
    
## Create and configure an Azure Files shares

In this task, you will create and configure Azure Files shares.

<p class="note-container">
Before you start this task, verify that the virtual machine you provisioned in the first task of this lab is running.
</p>

1. In the Azure portal, navigate back to the blade of the storage account you created in the first task of this lab and, in the **File service** section, click **File shares**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/fileshare.png?st=2020-10-07T08%3A42%3A31Z&se=2025-10-08T08%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OWnDNuIJUd%2Fjued%2FCMvSjLmGNETwRmZU98%2FlsRLV0Bg%3D)
  
2. Click **+ File share** and create a file share with the following settings:

* Name - **az104-07-share** 

* Quota -**1024** 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/filesh1.png?st=2020-10-07T08%3A45%3A24Z&se=2025-10-08T11%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gYBQ%2BSF%2B5f83%2FUE7H9sXkVfeUUSj%2Ftk4Y1ZFlrWHCwA%3D))

3. Click the newly created file share and click **Connect**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/connectingfileshare.png?st=2020-10-07T08%3A47%3A18Z&se=2025-10-08T08%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BpS3rk3aTJbtWl5Q541H9IcuEpPT%2FE%2Bq8RS0rU3RDrA%3D)

4. On the **Connect** blade, ensure that the **Windows** tab is selected, and click **Copy to clipboard**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/windowsconnect.png?st=2020-10-07T08%3A49%3A45Z&se=2025-10-08T08%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4KSf%2Bh1elySCXLiRrdSRgUDlXM9MK8zlBbN4nWEwubE%3D)

5. In the Azure portal, search for and select **Virtual machines**, and, in the list of virtual machines, click **az104-07-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/VM1.png?st=2020-10-07T08%3A51%3A55Z&se=2025-10-08T08%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oaJNrvW0mpqU0of4PBtZbiU8xbtEj60HO2UJOdAMGyk%3D)

6. On the **az104-07-vm0** blade, in the **Operations** section, click **Run command**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/runcommand.png?st=2020-10-07T08%3A53%3A52Z&se=2025-10-08T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=O1XntO7SHEGEi771OWkG2T70HNQFQ5QV1R5NncRkSBM%3D)

7. On the **az104-07-vm0 - Run command** blade, click **RunPowerShellScript**. 
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/runpowershellscript.png?st=2020-10-07T09%3A10%3A34Z&se=2025-10-08T09%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5uJkS2n1R%2F81mRBeI0nSOwp%2F0Col%2B2RtE%2BGfQOhKAE4%3D)

8. On the **Run Command Script** blade, paste the script you copied earlier in this task into the **PowerShell Script** pane and click **Run**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/runscript.png?st=2020-10-07T09%3A13%3A11Z&se=2025-10-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5vPHE8ZM7msZV8ZGSAlz5T1giJSQQZBw%2BC86TVsfH%2F0%3D)

9. Verify that the script completed successfully. 

10. Replace the content of the **PowerShell Script** pane with the following script and click **Run**:

```
New-Item -Type Directory -Path 'Z:\az104-07-folder'

New-Item -Type File -Path 'Z:\az104-07-folder\az-104-07-file.txt'
```
   
11. Verify that the script completed successfully. 

12. Navigate back to the **az104-07-share** file share blade, click **Refresh**, and verify that **az104-07-folder** appears in the list of folders. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/fileshare1.png?st=2020-10-15T10%3A28%3A34Z&se=2025-10-16T10%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nP%2FWGj3Q2HmRVyQXE9y1UkkYkK0Hf8P6S1xlfUJUBiI%3D)

13. Click **az104-07-folder** and verify that **az104-07-file.txt** appears in the list of files.

## Manage network access for Azure Storage

In this task, you will configure network access for Azure Storage.

1. In the Azure portal, navigate back to the blade of the storage account you created in the first task of this lab and, in the **Settings** section, click **Firewalls and virtual networks**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/firewalls.png?st=2020-10-15T10%3A33%3A58Z&se=2025-10-16T10%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B6rEQiN0NtVTOD45sZpBN3%2FRMNa2Put%2FunrwmTfYm0w%3D)

2. Click the **Selected networks** option and review the configuration settings that become available once this option is enabled.

<p class="note-container">
You can use these settings to configure direct connectivity between Azure virtual machines on designated subnets of virtual networks and the storage account by using service endpoints.
</p>

3. Click the checkbox **Add your client IP address** and save the change.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/addIpaddress.png?st=2020-10-15T10%3A37%3A54Z&se=2025-10-16T10%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cgGXQRv2iNwWqiyq7mzYbr750upZ72JJntw56%2FLTpMw%3D)

4. Open another browser window by using InPrivate mode and navigate to the blob SAS URL you generated in the previous task. 

5. You should be presented with the content of **The MIT License (MIT)** page.

<p class="note-container">
This is expected, since you are connecting from your client IP address.
</p>

6. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and open Azure Cloud Shell pane.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/storagelicence.png?st=2020-10-15T10%3A48%3A22Z&se=2025-10-16T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cSLKfJ88BFpp1nOwxpmSCApZnQ5LBfzqz9IGL%2F9t%2Fm4%3D)

7. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/storage-cloudshell.png?st=2020-10-15T10%3A51%3A57Z&se=2025-10-16T10%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SO7WGiOVMv49MEpaYnkZ01K7P5rIAjggDXtZbhVpRwE%3D)

8. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

9. From the Cloud Shell pane, run the following to attempt downloading of the LICENSE blob from the **az104-07-container** container of the storage account (replace the `[blob SAS URL]` placeholder with the blob SAS URL you generated in the previous task):

`Invoke-WebRequest -URI '[blob SAS URL]'`

10. Verify that the download attempt failed. 

<p class="note-container">
You should receive the message stating AuthorizationFailure: This request is not authorized to perform this operation. This is expected, since you are connecting from the IP address assigned to an Azure VM hosting the Cloud Shell instance.
</p>
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/authorizationfailure.png?st=2020-10-15T10%3A55%3A55Z&se=2025-10-16T10%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X6%2BxRXZDcn3F0cNyfAU26F0TlC7Mj9NON9vTYIL%2Fw2g%3D)

11. Close the Cloud Shell pane.

## Clean up resources

<p class="note-container">
Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.
</p>

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. List all resource groups created throughout the labs of this module by running the following command:

`Get-AzResourceGroup -Name 'az104-07*'`

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/cleanup1.png?st=2020-10-15T12%3A10%3A57Z&se=2025-10-16T12%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aIZpxbYmHJYHoweH0sev6Zi2G251%2BEMkWG7sOovxAVg%3D)
 
3. Delete all resource groups you created throughout the labs of this module by running the following command:

`Get-AzResourceGroup -Name 'az104-07*' | Remove-AzResourceGroup -Force -AsJob`
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/manage-azure-storage/cleanup2.png?st=2020-10-15T12%3A16%3A41Z&se=2025-10-16T12%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NcRB4xxHCbAwaEqZccx%2B383dMFAC%2Fu30HaPI2r4HiI8%3D)

<p class="note-container">
The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
 </p>

## Review

In this lab, you have:

- Provisioned the lab environment
- Created and configured Azure Storage accounts 
- Managed blob storage
- Managed authentication and authorization for Azure Storage
- Created and configured an Azure Files shares
- Managed network access for Azure Storage

## Conclusion

Congratulations! You have successfully completed the lab **Manage Azure Storage**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
