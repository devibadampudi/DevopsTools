
# Implement Data Protection

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Provision the lab environment](#provision-the-lab-environment)

[Create a Recovery Services vault](#create-a-Recovery-Services-vault)

[Implement Azure virtual machine-level backup](#implement-Azure-virtual-machine-level-backup)

[Implement File and Folder backup](#implement-File-and-Folder-backup)

[Perform file recovery by using Azure Recovery Services agent](#perform-file-recovery-by-using-Azure-Recovery-Services-agent)

[Perform file recovery by using Azure virtual machine snapshots](#perform-file-recovery-by-using-Azure-virtual-machine-snapshots)

[Review the Azure Recovery Services soft delete functionality](#review-the-Azure-Recovery-Services-soft-delete-functionality)

[Clean up resources](#clean-up-resources)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to evaluate the use of Azure Recovery Services for backup and restore of files hosted on Azure virtual machines and on-premises computers. 

**Scenario & Objectives**

You have been tasked with evaluating the use of Azure Recovery Services for backup and restore of files hosted on Azure virtual machines and on-premises computers. In addition, you want to identify methods of protecting data stored in the Recovery Services vault from accidental or malicious data loss.

In this lab, you will learn:

1. Provision the lab environment

2. Create a Recovery Services vault

3. Implement Azure virtual machine-level backup

4. Implement File and Folder backup

5. Perform file recovery by using Azure Recovery Services agent

6. Perform file recovery by using Azure virtual machine snapshots (optional)

7. Review the Azure Recovery Services soft delete functionality (optional)

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console

## Pre-Requisites

* Azure fundamentals

## Provision the lab environment

In this task, you will deploy two virtual machines that will be used to test different backup scenarios.

1. Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID** : {{azure-login-id}}

**Azure login_Password** : {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

3. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

> **Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab and click **Create storage**. 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)

* **cloud shell region:** {{location}}
* **Resource group:** {{resource-group-name}} <br>

* **Storage Account Name:** Create new Storage <br>

* **File Share Name:** Create new file share

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a41.PNG?st=2019-09-18T04%3A58%3A12Z&se=2022-09-19T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zQJmfYNONwPRTvZ3mdfA6ZtkxKIjh%2FCTdGu9oNPOe%2FE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/21.png?st=2019-09-16T06%3A57%3A56Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JMFKFtYFry1nNVFUWtQOewXhh1ZDMSXBuR%2BXc4szLxk%3D)

4. Open below one in chrome and save it in folder as **az104-10-vms-parameters.json** file

https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/ImplimentDataProtection/az104-10-vms-parameters.json?st=2020-10-27T07%3A44%3A29Z&se=2025-10-28T07%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VT5jj%2Fe4c5xkjeU%2Ffp25g6UzVeblI8OgeIwyFXNvYUM%3D

5. Open below one in chrome and save it in folder as **az104-10-vms-template.json** file

https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/ImplimentDataProtection/az104-10-vms-template.json?st=2020-10-27T07%3A49%3A42Z&se=2025-10-28T07%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cjYSpw%2Fm%2F%2BAM%2BfmHK6lexFSJEQTHkyqva5O1pTImg%2Fs%3D

6. Press **ctrl+s** and save it in folder

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/download.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

7. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **az104-10-vms-template.json** and **az104-10-vms-parameters.json** into the Cloud Shell home directory.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/uploadfiles.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

8. From the Cloud Shell pane, run the following to create the resource group that will be hosting the virtual machines (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy Azure virtual machines):

$location = {{location}}
  
$rgName = {{resource-group-name}}
  
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/location.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D) 
 
9. From the Cloud Shell pane, run the following to create the first virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-10-vms-template.json `
      -TemplateParameterFile $HOME/az104-10-vms-parameters.json `
      -AsJob
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/runningasjob.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

10. Minimize Cloud Shell (but do not close it).

> **Note**: Do not wait for the deployment to complete but instead proceed to the next task. The deployment should take about 5 minutes.

## Create a Recovery Services vault

In this task, you will create a recovery services vault.

1. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/recoveryservices.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/add-recovery.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

2. On the **Create Recovery Services vault** blade, specify the following settings:

> **Settings** 
    
* **Subscription** - the name of the Azure subscription you are using in this lab 
* **Resource group** - {{resource-group-name}}
* **Name** - az104-10-rsv1
* **Region** - {{location}}
    
> **Note**: Make sure that you specify the same region into which you deployed virtual machines in the previous task.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/recovery1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

3.  Click **Review + Create** and then click **Create**.

> **Note**: Wait for the deployment to complete. The deployment should take less than 1 minute.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/create.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)    

4. When the deployment is completed, click **Go to Resource**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/gotoresource.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)  

> **Note**:set you screen resolution to 1280*720

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/screen-resolution.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)  

5. On the **az104-10-rsv1** Recovery Services vault blade, in the **Settings** section, click **Properties**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/settings.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)  

6. On the **az104-10-rsv1 - Properties** blade, click the **Update** link under **Backup Configuration** label. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backupblade.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)  

7. On the **Backup Configuration** blade, note that you can set the **Storage replication type** to either **Locally-redundant** or **Geo-redundant**. Leave the default setting of **Geo-redundant** in place and close the blade.

> **Note**: This setting can be configured only if there are no existing backup items.
      
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backupconfiguration.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)  

8. Back on the **az104-10-rsv1 - Properties** blade, click the **Update** link under **Security Settings** label. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/securitysettings.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

9. On the **Security Settings** blade, note that **Soft Delete (For Azure Virtual Machines)** is **Enabled**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/softdelete-enabling.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

10. Close the **Security Settings** blade and, back on the **az104-10-rsv1** Recovery Services vault blade, click **Overview**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/recoveryoverview.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

## Implement Azure virtual machine-level backup

In this task, you will implement Azure virtual-machine level backup.

> **Note**: Before you start this task, make sure that the deployment you initiated in the first task of this lab has successfully completed.

1. On the **az104-10-rsv1** Recovery Services vault blade, click **+ Backup**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backup-vault.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

2. On the **Backup Goal** blade, specify the folowing settings:

> **Settings** 

* Where is your workload running - **Azure** 
* What do you want to backup? -  **Virtual machine** 

3. On the **Backup Goal** blade, click **Backup**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backupgoal.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

4. On the **Backup policy**, review the **DefaultPolicy** settings and select **Create a new policy**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/create-new-policy.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

5. Define a new backup policy with the following settings (leave others with their default values):

> **Settings**

* **Policy name** - az104-10-backup-policy
* **Frequency** - Daily
* **Time** - 12:00 AM
* **Timezone** -  the name of your local time zone 
* **Retain instant recovery snapshot(s) for** - 2 Days(s) 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backuppolicy-configuration.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
6. Click **OK** to create the policy and then, in the **Virtual Machines** section, select **Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/add-vms.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

7. On the **Select virtual machines** blade, select **az-104-10-vm0**, click **OK**, and, back on the **Backup** blade, click **Enable backup**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/selectingvms.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
> **Note**: Wait for the backup to be enabled. This should take about 2 minutes. 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/enable-backup.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
     
8. Navigate back to the **az104-10-rsv1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**, and then click the **Azure virtual machines** entry.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/protecteditems.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

9. On the **Backup Items (Azure Virtual Machine)** blade of **az104-10-vm0**, review the values of the **Backup Pre-Check** and **Last Backup Status** entries, and click the **az104-10-vm0** entry.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backupentry.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

10. On the **az104-10-vm0** Backup Item blade, click **Backup now**, accept the default value in the **Retain Backup Till** drop-down list, and click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backupnow.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

> **Note**: Do not wait for the backup to complete but instead proceed to the next task.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/retainbacktill.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/trigger.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
      
## Implement File and Folder backup

In this task, you will implement file and folder backup by using Azure Recovery Services.

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-10-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/vms.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

2. On the **az104-10-vm1** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/connect.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/downloadRDP.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
 
> **Note**: This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.

> **Note**: You can ignore any warning prompts when connecting to the target virtual machines.
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/remotedesktop-connection.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

3.  When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/login.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

4. Within the Remote Desktop session to the **az104-10-vm1** Azure virtual machine, in the **Server Manager** window, click **Local Server**, click **IE Enhanced Security Configuration** and turn it **Off** for Administrators.
  
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/servermanager.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/off.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

5. Within the Remote Desktop session to the **az104-10-vm1** Azure virtual machine, start Internet Explorer, browse to the [Azure portal](https://portal.azure.com), and sign in using your credentials. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

6. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-10-rsv1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

7. On the **az104-10-rsv1** Recovery Services vault blade, click **+ Backup**.
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/7.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

8. On the **Backup Goal** blade, specify the following settings:

> **Settings** 

* Where is your workload running? - **On-premises** 
* What do you want to backup? -  **Files and folders** 

>**Note**: Even though the virtual machine you are using in this task is running in Azure, you can leverage it to evaluate the backup capabilities applicable to any on-premises computer running Windows Server operating system.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/8.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

9. On the **Backup Goal** blade, click **Prepare infrastructure**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/9.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

10. On the **Prepare infrastructure** blade, click the **Download Agent for Windows Server or Windows Client** link.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/10.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

11. When prompted, click **Run** to start installation of **MARSAgentInstaller.exe** with the default settings. 

> **Note**: On the **Microsoft Update Opt-In** page of the **Microsoft Azure Recovery Services Agent Setup Wizard**, select the **I do not want to use Microsoft Update** installation option.
       
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/11.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

12. On the **Installation** page of the **Microsoft Azure Recovery Services Agent Setup Wizard**, click **Proceed to Registration**. This will start **Register Server Wizard**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/12.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

13. Switch to the Internet Explorer window displaying the Azure portal, on the **Prepare infrastructure** blade, select the checkbox **Already downloaded or using the latest Recovery Server Agent**, and click **Download**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/13.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

14. When prompted, whether to open or save the vault credentials file, click **Save**. This will save the vault credentials file to the local Downloads folder.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/14.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

15. Switch back to the **Register Server Wizard** window and, on the **Vault Identification** page, click **Browse**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/14.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/15.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/15-1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

16. In the **Select Vault Credentials** dialog box, browse to the **Downloads** folder, click the vault credentials file you downloaded, and click **Open**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/16.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

17. Back on the **Vault Identification** page, click **Next**.

18. On the **Encryption Setting** page of the **Register Server Wizard**, click **Generate Passphrase**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/17.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

19. On the **Encryption Setting** page of the **Register Server Wizard**, click the **Browse** button next to the **Enter a location to save the passphrase** drop-down list.

20. In the **Browse For Folder** dialog box, select the **Documents** folder and click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/encryptbrowse.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

21. Click **Finish**, review the **Microsoft Azure Backup** warning and click **Yes**, and wait for the registration to complete.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/encryptfinish.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

> **Note**: In a production environment, you should store the passphrase file in a secure location other than the server being backed up.

22. On the **Server Registration** page of the **Register Server Wizard**, review the warning regarding the location of the passphrase file, ensure that the **Launch Microsoft Azure Recovery Services Agent** checkbox is selected and click **Close**. This will automatically open the **Microsoft Azure Backup** console.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/serviceregistration.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

23. In the **Microsoft Azure Backup** console, in the **Actions** pane, click **Schedule Backup**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/action-pane.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

24. In the **Schedule Backup Wizard**, on the **Getting started** page, click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/gettingstarted-schedule.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

25. On the **Select Items to Backup** page, click **Add Items**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/select-itemsbackup.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

26. In the **Select Items** dialog box, expand **C:\\Windows\\System32\\drivers\\etc\\**, select **hosts**, and then click **OK**:

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/selecting-hosts.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/26-1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

27.  On the **Select Items to Backup** page, click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/itemsbackup27-1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

28. On the **Specify Backup Schedule** page, ensure that the **Day** option is selected, in the first drop-down list box below the **At following times (Maximum allowed is three times a day)** box, select **4:30 AM**, and then click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/schedule-28.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

29. On the **Select Retention Policy** page, accept the defaults, and then click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/29.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

30. On the **Choose Initial Backup type** page, accept the defaults, and then click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/30.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

31. On the **Confirmation** page, click **Finish**. When the backup schedule is created, click **Close**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/finish-31.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/close31-1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

32. In the **Microsoft Azure Backup** console, in the Actions pane, click **Back Up Now**.

> **Note**: The option to run backup on demand becomes available once you create a scheduled backup.
       
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/backupnow-32.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
33. In the Back Up Now Wizard, on the **Select Backup Item** page, ensure that the **Files and Folders** option is selected and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/33-files.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

34. On the **Retain Backup Till** page, accept the default setting and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/retainbackup-34.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

35. On the **Confirmation** page, click **Back Up**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/confirm-35.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

36.  When the backup is complete, click **Close**, and then close Microsoft Azure Backup.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/36.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

37. Switch to the Internet Explorer window displaying the Azure portal, navigate back to the Recovery Services vault blade and click **Backup items**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/37.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

38. On the **az104-10-rsv1 - Backup items** blade, click **Azure Backup Agent**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/38.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

39.  On the **Backup Items (Azure Backup Agent)** blade, verify that there is an entry referencing the **C:\\** drive of **az104-10-vm1.**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/39.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

## Perform file recovery by using Azure Recovery Services agent

In this task, you will perform file restore by using Azure Recovery Services agent.

1. Within the Remote Desktop session to **az104-10-vm1**, open File Explorer, navigate to the **C:\\Windows\\System32\\drivers\\etc\\** folder and delete the **hosts** file.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/p1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

2. Switch to the Microsoft Azure Backup window and click **Recover data**. This will start **Recover Data Wizard**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/Recoverdata-2.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

3. On the **Getting Started** page of **Recover Data Wizard**, ensue that **This server (az104-10-vm1.)** option is selected and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-3.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

4. On the **Select Recovery Mode** page, ensure that **Individual files and folders** option is selected, and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-4.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

5. On the **Select Volume and Date** page, in the **Select the volume** drop down list, select **C:\\**, accept the default selection of the available backup, and click **Mount**. 

> **Note**: Wait for the mount operation to complete. This might take about 2 minutes.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-5.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
  
6. On the **Browse And Recover Files** page, note the drive letter of the recovery volume and review the tip regarding the use of robocopy.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-6.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

7. Click **Start**, expand the **Windows System** folder, and click **Command Prompt**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/p7.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

8. From the Command Prompt, run the following to copy the restore the **hosts** file to the original location (replace `[recovery_volume]` with the drive letter of the recovery volume you identified earlier):

   ```
   robocopy [recovery_volume]:\Windows\System32\drivers\etc C:\Windows\system32\drivers\etc hosts /r:1 /w:1
   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-8.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

9. Switch back to the **Recover Data Wizard** and, on the **Browse and Recover Files**, click **Unmount** and, when prompted to confirm, click **Yes**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/p9.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-9.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

10. Terminate the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/5-10.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

## Perform file recovery by using Azure virtual machine snapshots

In this task, you will restore a file from the Azure virtual machine-level snapshot-based backup.

1. Switch to the browser window running on your lab computer and displaying the Azure portal.

2. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-10-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/vm0.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

3. On the **az104-10-vm0** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/vm0-connect.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

> **Note**: This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.

> **Note**: You can ignore any warning prompts when connecting to the target virtual machines.

4. When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/vm0-rdpconnect.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
 
5. Within the Remote Desktop session to the **az104-10-vm0** Azure virtual machine, in the **Server Manager** window, click **Local Server**, click **IE Enhanced Security Configuration** and turn it **Off** for Administrators.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-5.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

6. Within the Remote Desktop session to the **az104-10-vm0**, click **Start**, expand the **Windows System** folder, and click **Command Prompt**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp6.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

7. From the Command Prompt, run the following to delete the **hosts** file:

   ```
   del C:\Windows\system32\drivers\etc\hosts
   ```
 
> **Note**: You will restore this file from the Azure virtual machine-level snapshot-based backup later in this task.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp7.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
   
8. Within the Remote Desktop session to the **az104-10-vm0** Azure virtual machine, start Internet Explorer, browse to the [Azure portal](https://portal.azure.com), and sign in using your credentials. 

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-8.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

9. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-10-rsv1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp10.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

10. On the **az104-10-rsv1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp10.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

11. On the **az104-10-rsv1 - Backup items** blade, click **Azure Virtual Machine**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp11.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

12. On the **Backup Items (Azure Virtual Machine)** blade, click **az104-10-vm0**.

13. On the **az104-10-vm0** Backup Item blade, click **File Recovery**.

> **Note**: You have the option of running recovery shortly after backup starts based on the application consistent snapshot.
       
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-13.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

14. On the **File Recovery** blade, accept the default recovery point and click **Download Executable**.

> **Note**: The script mounts the disks from the selected recovery point as local drives within the operating system from which the script is run.
       
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp14.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

15. Click **Download** and, when prompted whether to run or save **IaaSVMILRExeForWindows.exe**, click **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-15.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

16. Start File Explorer, navigate to the **Downloads** folder, right-click the newly downloaded file, select **Properties** in the right-click menu, in the **Properties** dialog box, select the **Unblock** checkbox, and click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-16.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

17. Back in the File Explorer window, double-click the newly downloaded file.

18. When prompted to provide the password from the portal, copy the password from the **Password to run the script** text box on the **File Recovery** blade, paste it at the Command Prompt, and press **Enter**.

> **Note**: This will open a Windows PowerShell window displaying the progress of the mount.

> **Note**: If you receive an error message at this point, refresh the Internet Explorer window and repeat the last three steps.
       
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-16-1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-18-1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
   
19. Wait for the mount process to complete, review the informational messages in the Windows PowerShell window, note the drive letter assigned to the volume hosting **Windows**, and start File Explorer.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp19.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

20. In File Explorer, navigate to the drive letter hosting the snapshot of the operating system volume you identified in the previous step and review its content.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-20.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

21. Switch to the **Command Prompt** window.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-21.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

22. From the Command Prompt, run the following to copy the restore the **hosts** file to the original location (replace `[os_volume]` with the drive letter of the operating system volume you identified earlier):

   ```
   robocopy [os_volume]:\Windows\System32\drivers\etc C:\Windows\system32\drivers\etc hosts /r:1 /w:1
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/pp22.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

23. Switch back to the **File Recovery** blade in the Azure portal and click **Unmount Disks**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/6-23.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

24. Terminate the Remote Desktop session.

## Review the Azure Recovery Services soft delete functionality

1. On the lab computer, in the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-10-rsv1**.

2. On the **az104-10-rsv1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**.

3. On the **az104-10-rsv1 - Backup items** blade, click **Azure Backup Agent**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/azbackupagent.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

4. On the **Backup Items (Azure Backup Agent)** blade, click the entry representing the backup of **az104-10-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/7-4.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

5. On the **C:\\ on az104-10-vm1.** blade, click the **az104-10-vm1.** link.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/openvm0-link.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

6. On the **az104-10-vm1.** Protected Servers blade, click **Delete**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/delete.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

7. On the **Delete** blade, specify the following settings.

> **Settings**

* TYPE THE SERVER NAME  - **az104-10-vm1.** 
* Reason -  **Recycling Dev/Test server** 
* Comments - **az104 10 lab** 

> **Note**: Make sure to include the trailing period when typing the server name

8.  Enable the checkbox next to the label **There is backup data of 1 backup items associated with this server.I understand that clicking "Confirm" will permanently delete all the cloud backup data. This action cannot be undone. An alert may be sent to the administrators of this subscription notifying them of this deletion** and click **Delete**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/delete1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

9. Navigate back to the **az104-10-rsv1 - Backup items** blade and click **Azure Virtual Machines**.

10. On the **az104-10-rsv1 - Backup items** blade, click **Azure Virtual Machine**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/azurevms.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

11. On the **Backup Items (Azure Virtual Machine)** blade, click **az104-10-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/azvm0.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

12. On the **az104-10-vm0** Backup Item blade, click **Stop backup**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/stopbackup.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

13. On the **Stop backup** blade, select **Delete B
ackup Data**, specify the following settings and click **Stop backup**:

> **Settings**

* Type the name of Backup item -  **az104-10-vm0** 
* Reason -  **Others** 
* Comments - **az104 10 lab** 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/stopbackup1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

14. Navigate back to the **az104-10-rsv1 - Backup items** blade and click **Refresh**.

> **Note**: The **Azure Virtual Machine** entry is still lists **1** backup item.
      
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/b1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
15. Click the **Azure Virtual Machine** entry and, on the **Backup Items (Azure Virtual Machine)** blade, click the **az104-10-vm0** entry.

16. On the **az104-10-vm0** Backup Item blade, note that you have the option to **Undelete** the deleted backup. 

> **Note**: This functionality is provided by the soft-delete feature, which is, by default, enabled for Azure virtual machine backups.
       
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/undelete.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
    
17. Navigate back to the **az104-10-rsv1** Recovery Services vault blade, and in the **Settings** section, click **Properties**.

18. On the **az104-10-rsv1 - Properties** blade, click the **Update** link under **Security Settings** label. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/securitysettings1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

19. On the **Security Settings** blade, Disable **Soft Delete (For Azure Virtual Machines)** and click **Save**.

> **Note**: This will not affect items already in soft delete state.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/disable-softdelete.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

20. Close the **Security Settings** blade and, back on the **az104-10-rsv1** Recovery Services vault blade, click **Overview**.

21. Navigate back to the **az104-10-vm0** Backup Item blade and click **Undelete**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/7-22.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

22. On the **Undelete az104-10-vm0** blade, click **Undelete**. 

23. Wait for the undelete operation to complete, refresh the browser page, if needed, navigate back to the **az104-10-vm0** Backup Item blade, and click **Delete backup data**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/deletebackupdata.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

24. On the **Delete Backup Data** blade, specify the following settings and click **Delete**:

>**Settings**

* Type the name of Backup item -  **az104-10-vm0** 
* Reason - **Others** 
* Comments - **az104 10 lab** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/deletebup1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)

## Clean up resources

> **Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. List all resource groups created throughout the labs of this module by running the following command:

   ```
   Get-AzResourceGroup -Name 'az104-10*'

   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/cleanup1.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
  
3. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```
   Get-AzResourceGroup -Name 'az104-10*' | Remove-AzResourceGroup -Force -AsJob
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/ImplimentDataProtection/cleanup2.png?st=2020-11-10T10%3A41%3A11Z&se=2025-11-11T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=9mud%2FCjxSW9vS4v8JmErXNy%2B%2FDA5yclScFkKI8FbGqc%3D)
   
> **Note**: Optionally, you might consider deleting the auto-generated resource group with the prefix **AzureBackupRG_** (there is no additional charge associated with its existence).

> **Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

### Review

In this lab, you have:

* Provisioned the lab environment

* Created a Recovery Services vault

* Implemented Azure virtual machine-level backup

* Implemented File and Folder backup

* Performed file recovery by using Azure Recovery Services agent

* Performed file recovery by using Azure virtual machine snapshots

* Reviewed the Azure Recovery Services soft delete functionality

## Conclusion

Congratulations! You have successfully completed the lab **Impliment Data Protection**!. Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
