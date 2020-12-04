# Manage Azure resources by Using the Azure Portal

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Create resource groups](#create-resource-groups)

[Deploy resources to resource groups](#deploy-resources-to-resource-groups)

[Move resources between resource groups](#move-resources-between-resource-groups)

[Implement and test resource locks](#implement-and-test-resource-locks)

[Clean up resources](#clean-up-resources)

## Overview

The aim of this lab is to explore the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups, including moving resources between resource groups.

**Scenario & Objectives**

You need to explore the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups, including moving resources between resource groups. You also want to explore options for protecting disk resources from being accidentally deleted, while still allowing for modifying their performance characteristics and size.

In this lab, you will learn:

1. Create resource groups and deploy resources to resource groups

2. Move resources between resource groups.

3. Implement and test resource locks.

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* Azure fundamentals

* An Azure account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

Note: Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch

## Create resource groups

In this task, you will use the Azure portal to create resource groups

1. Using the Chrome browser, login into [Azure portal](https://portal.azure.com) with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2.  In the Azure portal, search for and select **Resource groups**  to create the resource group

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg1.jpg?st=2020-10-12T09%3A53%3A00Z&se=2025-10-13T09%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9JGP0KjgeXApQq3IPkxcncd1bqYUykgvpTXC4CBN2Qo%3D)

3. On the Resource groups blade, click **+ Add** and create a resource group with the following settings:
   
    * Subscription : the name of the Azure subscription you will use in this lab
    
    * Resource Group : **az104-03a-rg1**
    
    * Region : the name of any Azure region available in the subscription you will use in this lab
    
4. CLick on **Review + Create** button

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg2.jpg?st=2020-10-12T09%3A56%3A52Z&se=2025-10-13T09%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=prjjh5cnx87dy04ik55KlrMxI7HHTCmRmBUdSdzOjs0%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg3.jpg?st=2020-10-12T10%3A04%3A13Z&se=2025-10-13T10%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IXe4CjiA7OkWLuyKHS%2Bdwgik%2B4DgimYQyB2NnKD2IrY%3D)

5. Click on **Create** Button to create Resource Group.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg4.jpg?st=2020-10-12T10%3A07%3A25Z&se=2025-10-13T10%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UnTRLMA%2BtwScKkCQO7mxmpGpuiT6Mqaih6YxGJimW7c%3D)

> **Note**: repeat two times  above 2 to 5 steps and change the resource group nmae **az104-03a-rg2** and **az104-03a-rg3** to create anthoer two resource groups. 

## Deploy resources to resource groups

In this task, you will use the Azure portal create a disk in the resource group.

1. In the Azure portal, search for and select **Disks**, click **+ Add**, and specify the following settings:

    * Resource groups : `az104-03a-rg1`
    
    * Disk Name : az104-03a-disk1
    
    * Region : {{Location}}
    
    * Availbility zone : None
    
    * Source type : None

> **Note**: When creating a resource, you have the option of creating a new resource group or using an existing one.
    
![alt text]( https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Az_Disk.jpg?st=2020-10-12T10%3A47%3A38Z&se=2025-10-13T10%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KaPK1ULJk786313noG4hEbRioAYRb9hR8b%2FTwyRQ%2F5k%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Disk_add_2.jpg?st=2020-10-12T10%3A50%3A15Z&se=2025-10-13T10%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=J%2FS7HNYFgxBOEf6S1y5bpEgH4xV5tJwNkmMbUjiQWrY%3D)

2. Change the disk type and size to **Standard HDD** and **32 GiB**, respectively.

3. Click **Review + Create** and then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Disk_create_3_1.jpg?st=2020-10-12T10%3A52%3A05Z&se=2025-10-13T10%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PVIiXu1iuB7%2BiEDMbjD7B2T7Ovs6tGX5GKv7q4MexIA%3D)

> **Note**: Wait until the disk is created. This should take less than a minute.

## Move resources between resource groups 

In this task, we will move the disk resource you created in the previous task to a new resource group. 

1. Search for and select **Resource groups**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg1.jpg?st=2020-10-12T09%3A53%3A00Z&se=2025-10-13T09%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9JGP0KjgeXApQq3IPkxcncd1bqYUykgvpTXC4CBN2Qo%3D)

2. On the **Resource groups** blade, click the entry representing the **az104-03a-rg1** resource group.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/move1.jpg?st=2020-10-12T11%3A32%3A07Z&se=2025-10-13T11%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=84HjsSUwZ4dtB%2BVgLrQs19QldI%2FNJSnOOQBNyI0wMZ4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/move2.jpg?st=2020-10-12T11%3A32%3A56Z&se=2025-10-13T11%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6q6YmZ%2Bp79flfPh3FGio21o00smuBoglKF%2F7w5xGC14%3D)

3. From the **Overview** blade of the resource group, in the list of resource group resources, select the entry representing the newly created disk, click **Move** in the toolbar, and, in the drop-down list, select **Move to another resource group**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/move3.jpg?st=2020-10-12T11%3A37%3A07Z&se=2025-10-13T11%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YcHwE2pLU3lAMlMxABSRVebQQNcwf0M3PIOU8ni5svk%3D)

> **Note**: This method allows you to move multiple resources at the same time. 

4. In the **Resource group** text box, type **az104-03a-rg2**, select the checkbox **I understand that tools and scripts associated with moved resources will not work until I update them to use new resource IDs**, and click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/move4.jpg?st=2020-10-12T11%3A39%3A39Z&se=2025-10-13T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yggldrs5apQoxNWTm%2FrOiurfe0GL4C%2FgwLjM4aywYus%3D)

> **Note**: Do not wait for the move to complete but instead proceed to the next task. The move might take about 10 minutes. You can determine that the operation was completed by monitoring activity log entries of the source or target resource group. Revisit this step once you complete the next task.

## Implement and test resource locks

In this task, you will apply a resource lock to an Azure resource group containing a disk resource.
1. In the Azure portal, search for and select **Disks**, click **+ Add**, and specify the following settings:

    * Resource groups : `az104-03a-rg3`
    
    * Disk Name : az104-03a-disk2
    
    * Region : {{Location}}
    
    * Availbility zone : None
    
    * Source type : None

    > **Note**: When creating a resource, you have the option of creating a new resource group or using an existing one.
    
![alt text]( https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Az_Disk.jpg?st=2020-10-12T10%3A47%3A38Z&se=2025-10-13T10%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KaPK1ULJk786313noG4hEbRioAYRb9hR8b%2FTwyRQ%2F5k%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Disk_add_2.jpg?st=2020-10-12T10%3A50%3A15Z&se=2025-10-13T10%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=J%2FS7HNYFgxBOEf6S1y5bpEgH4xV5tJwNkmMbUjiQWrY%3D)

2. Change the disk type and size to **Standard HDD** and **32 GiB**, respectively.

3. Click **Review + Create** and then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Disk_create_3_1.jpg?st=2020-10-12T10%3A52%3A05Z&se=2025-10-13T10%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PVIiXu1iuB7%2BiEDMbjD7B2T7Ovs6tGX5GKv7q4MexIA%3D)

> **Note**: Wait until the disk is created. This should take less than a minute.


4. In the Azure portal, search for and select **Resource groups**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg1.jpg?st=2020-10-12T09%3A53%3A00Z&se=2025-10-13T09%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9JGP0KjgeXApQq3IPkxcncd1bqYUykgvpTXC4CBN2Qo%3D)

5. In the list of resource groups, click the entry representing the **az104-03a-rg3** resource group.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/rg_select.jpg?st=2020-10-12T11%3A47%3A03Z&se=2025-10-13T11%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=e17UFYITaGUD1S8ZdO9W71khFR%2Be1AMPmBUnTAGTb2M%3D)

6. On the **az104-03a-rg3** resource group blade, click **Locks** and add a lock with the following settings:

    * Lock Name : **az104-03a-delete-lock**
    
    * Lock Type : **Delete**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/lock_add1.jpg?st=2020-10-12T11%3A49%3A21Z&se=2025-10-13T11%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wOfQe4HbHc9VOKOaiERz5ljS0ZB4Wt3stCGsWbBSB8w%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/Add_lock2.jpg?st=2020-10-12T11%3A50%3A18Z&se=2025-10-13T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EPEq%2F0MmaSbtBGITK6tNjHTAdjDRibJEu7SiEncRV5Q%3D)

7. On the **az104-03a-rg3** resource group blade, click **Overview**, in the list of resource group resources, select the entry representing the disk you created earlier in this task, and click **Delete** in the toolbar. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/add_lock3.jpg?st=2020-10-12T11%3A51%3A25Z&se=2025-10-13T11%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2znoHN5fHFexczTxNVvQy202iHxs5YnsIEryjxw7t60%3D)

8. When prompted **Do you want to delete all the selected resources?**, in the **Confirm delete** text box, type **yes** and click **Delete**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/add_lock4.jpg?st=2020-10-12T11%3A52%3A25Z&se=2025-10-13T11%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Ot%2BSD0YiaZ3V%2Fs4TVl7%2FQ5LAqh%2F2u6Vk4edmjTxbSbo%3D)

9. You should see an error message, notifying about the failed delete operation. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/add_lock5.jpg?st=2020-10-12T11%3A53%3A28Z&se=2025-10-13T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nJrNONEprvlFupD4QKLz%2FtHva2u8oicHs6%2FsYzP6H9w%3D)

> **Note**: As the error message states, this is expected due to the delete lock applied on the resource group level.

10. Navigate back to the list of resources of the **az104-03a-rg3** resource group and click the entry representing the **az104-03a-disk2** resource. 

11. On the **az104-03a-disk2** blade, in the **Settings** section, click **Size + Performance**, set the disk type and size to **Premium SSD** and **64 GiB**, respectively, and save the change. Verify that the change was successful.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/nav1.jpg?st=2020-10-12T12%3A00%3A06Z&se=2025-10-13T12%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uEN7YBbXlXNIi4WXDVuDb1op8ulEbaoUZWQlh0LHb3k%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/resize1.jpg?st=2020-10-12T12%3A01%3A54Z&se=2025-10-13T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cJR9C4kNrwdq9gghFA0mo2RU9kDESePTwdArUMgouiU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20the%20Azure%20Portal/resize2.jpg?st=2020-10-12T12%3A02%3A54Z&se=2025-10-13T12%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=A4nRfsKB68X2OG9TC%2Ftr%2BPvoygvh3eIgBJvbmRiPDic%3D)

> **Note**: This is expected, since the resource group-level lock applies to delete operations only. 

## Clean up resources

1. Navigate to the **az104-03a-rg3** resource group blade, display its **Locks** blade, and remove the lock **az104-03a-delete-lock** by clicking the **Delete** link on the right-hand side of the **Delete** lock entry.

#### Review

In this lab, you have:

- Created resource groups and deployed resources to resource groups

- Moved resources between resource groups

- Implemented and tested resource locks

**Conclusion:** Congratulations! You have successfully completed the lab **Manage Azure resources by Using the Azure Portal**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
