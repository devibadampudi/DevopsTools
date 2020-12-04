
# Manage Governance via Azure Policy

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Assign tags via the Azure portal](#assign-tags-via-the-azure-portal)

[Enforce tagging via an Azure policy](#enforce-tagging-via-an-azure-policy)

[Apply tagging via an Azure policy](#apply-tagging-via-an-azure-policy)

[Clean up resources](#clean-up-resources)

[Conclusion](#conclusion)



## Overview

In order to improve management of Azure resources in Contoso, you have been tasked with implementing the following functionality:

- tagging resource groups that include only infrastructure resources (such as Cloud Shell storage accounts)

- ensuring that only properly tagged infrastructure resources can be added to infrastructure resource groups

- remediating any non-compliant resources 

**Scenario & Objectives**

In this lab, we will learn

1. Create and assign tags via the Azure portal

2. Enforce tagging via an Azure policy

3. Apply tagging via an Azure policy

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* Azure fundamentals

## Assign tags via the Azure portal

In this task, you will create and assign a tag to an Azure resource group via the Azure portal.

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
If this is the first time you are starting Cloud Shell and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)


* **Resource group:** `{{resource-group-name}}` <br>

* **Storage Account Name:** `Create new Storage` <br>

* **File Share Name:** `Create new file share`


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-3.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-3-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


4. From the Cloud Shell pane, run the following to identify the name of the storage account used by Cloud Shell:

   ```pwsh
   df
   ```
   
   ![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-4.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

5. In the output of the command, note the first part of the fully qualified path designating the Cloud Shell home drive mount (marked here as `xxxxxxxxxxxxxx`:

   ```
   //xxxxxxxxxxxxxx.file.core.windows.net/cloudshell   (..)  /usr/csuser/clouddrive
   ```
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-5.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


6. In the Azure portal, search and select **Storage accounts** and, in the list of the storage accounts, click the entry representing the storage account you identified in the previous step.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-6.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


7. On the storage account blade, click the link representing the name of the resource group containing the storage account.
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-7.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

  >**Note**: if you cant see tags set your screen resolution

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-7-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

8. On the resource group blade, click **Tags**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-8.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

9. Create a tag with the following settings and save your change:

    Setting -  **Value**
    
    Name :  **Role** 
    
    Value : **Infra** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-9.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

10. Navigate back to the storage account blade. Review the **Overview** information and note that the new tag was not automatically assigned to the storage account. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/1-10.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

## Enforce tagging via an Azure policy

In this task, you will assign the built-in *Require a tag and its value on resources* policy to the resource group and evaluate the outcome. 

1. In the Azure portal, search for and select **Policy**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)



2. In the **Authoring** section, click **Definitions**. Take a moment to browse through the list of built-in policy definitions that are available for you to use. List all built-in policies that involve the use of tags by selecting the **Tags** entry (and de-selecting all other entries) in the **Category** drop-down list. 


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-2.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)



![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-2-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)



3. Click the entry representing the **Require a tag and its value on resources** built-in policy and review its definition.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-3.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-3-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

4. On the **Require a tag and its value on resources** built-in policy definition blade, click **Assign**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-4.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

5. Specify the **Scope** by clicking the ellipsis button and selecting the following values:

    Setting - **Value**
    
    Subscription : **the name of the Azure subscription you are using in this lab**
    
    Resource Group :  **the name of the resource group containing the Cloud Shell account you identified in the previous task**

    >**Note**: A scope determines the resources or resource groups where the policy assignment takes effect. You could assign policies on the management group, subscription, or resource group level. You also have the option of specifying exclusions, such as individual subscriptions, resource groups, or resources (depending on the assignment scope). 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-5.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-5-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

6. Configure the **Basics** properties of the assignment by specifying the following settings (leave others with their defaults):

    Setting - **Value**
    
    Assignment name : **Require Role tag with Infra value**
    
    Description : **Require Role tag with Infra value for all resources in the Cloud Shell resource group**
    
    Policy enforcement : **Enabled**

    >**Note**: The **Assignment name** is automatically populated with the policy name you selected, but you can change it. You can also add an optional **Description**. **Assigned by** is automatically populated based on the user name creating the assignment. 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-6.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


7. Click **Next** and set **Parameters** to the following values:

    Setting - **Value**
    
    Tag Name- **Role** 
    
    Tag Value -**Infra**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-7.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

8. Click **Next** and review the **Remediation** tab. Leave the **Create a Managed Identity** checkbox unchecked. 

    >**Note**: This setting can be used when the policy or initiative includes the **deployIfNotExists** or **Modify** effect.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-8.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

9. Click **Review + Create** and then click **Create**.


    >**Note**: Now you will verify that the new policy assignment is in effect by attempting to create another Azure Storage account in the resource group without explicitly adding the required tag. 
    
    >**Note**: It might take between 5 and 15 minutes for the policy to take effect.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-9.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

10. Navigate back to the blade of the resource group hosting the storage account used for the Cloud Shell home drive, which you identified in the previous task.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage_Governance_via_Azure_Policy/2-10.png?st=2020-11-19T07%3A49%3A53Z&se=2025-11-20T07%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9xVX5gPVuLPsRosVQlRLzqXu4uUqszPzs%2FXFMugI5Xw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-10.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

11. On the resource group blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-11.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

12. On the **New** blade, search for and select **Storage account**, and click **Create**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-12.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-12-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

13.  On the **Basics** tab of the **Create storage account** blade, specify the following settings (leave others with their defaults) and click **Review + create**:

     Setting - **Value**
     
     Storage account name- **any globally unique combination of between 3 and 24 lower case letters and digits, starting with a letter**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-13.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

14. Note that the validation failed. Click the link **Validation failed. Click here to view details** to display the **Errors** blade and identify the reason for the failure. 

    >**Note**: The error message states that the resource deployment was disallowed by the policy. 

    >**Note**: By clicking the **Raw Error** tab, you can find more details about the error, including the name of the role definition **Require Role tag with Infra value**. The deployment failed because the storage account you attempted to create did not have a tag named **Role** with its value set to **Infra**.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-14.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/2-14-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

## Apply tagging via an Azure policy

In this task, we will use a different policy definition to remediate any non-compliant resources. 

1. In the Azure portal, search for and select **Policy**. 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

2. In the **Authoring** section, click **Assignments**. 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-2.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

3. In the list of assignments, right click the ellipsis icon in the row representing the **Require Role tag with Infra value** policy assignment and use the **Delete assignment** menu item to delete the assignment. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-3.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-3-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-3-2.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

4. Click **Assign policy** and specify the **Scope** by clicking the ellipsis button and selecting the following values:

    Setting - **Value**
    
    Subscription- **the name of the Azure subscription you are using in this lab**
    
    Resource Group- **the name of the resource group containing the Cloud Shell account you identified in the first task**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-4.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-4-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)



5. To specify the **Policy definition**, click the ellipsis button and then search for and select **Inherit a tag from the resource group if missing**.


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-5.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

6. Configure the remaining **Basics** properties of the assignment by specifying the following settings (leave others with their defaults):

    Setting- **Value**
    
    Assignment name - **Inherit the Role tag and its Infra value from the Cloud Shell resource group if missing**
    
    Description -  **Inherit the Role tag and its Infra value from the Cloud Shell resource group if missing**
    
   Policy enforcement- **Enabled**
   

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-6.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)
   
7. Click **Next** and set **Parameters** to the following values:

     Setting- **Value**
     
     Tag Name-  **Role**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-7.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

8.  Click **Next** and, on the **Remediation** tab, configure the following settings (leave others with their defaults):

    Setting- **Value**
    
    Create a remediation task -**enabled**
    
    Policy to remediate- **Inherit a tag from the resource group if missing** 

    >**Note**: This policy definition includes the **Modify** effect.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-8.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

9.Click **Review + Create** and then click **Create**.

   >**Note**: To verify that the new policy assignment is in effect, you will create another Azure Storage account in the same resource group without explicitly adding the required tag. 
    
   >**Note**: It might take between 5 and 15 minutes for the policy to take effect.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-9.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

10. Navigate back to the blade of the resource group hosting the storage account used for the Cloud Shell home drive, which you identified in the first task.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-10.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-10-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

11.On the resource group blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-11.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


12. On the **New** blade, search for and select **Storage account**, and click **Create**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-12.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-12-1.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

13. On the **Basics** tab of the **Create storage account** blade, specify the following settings (leave others with their defaults) and click **Review + create**:

    Setting- **Value**
    
    Storage account name- **any globally unique combination of between 3 and 24 lower case letters and digits, starting with a letter**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/3-13.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

14. Verify that this time the validation passed and click **Create**.

![alt text]()

15. Once the new storage account is provisioned, click **Go to resource** button and, on the **Overview** blade of the newly created storage account, note that the tag **Role** with the value **Infra** has been automatically assigned to the resource.

![alt text]()

## Clean up resources

   >**Note**: Remember to remove any newly created Azure resources that you no longer use. 

   >**Note**: Removing unused resources ensures you will not see unexpected charges, although keep in mind that Azure policies do not incur extra cost.


1. In the portal, search for and select **Policy**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage_Governance_via_Azure_Policy/4-1.png?st=2020-11-18T04%3A25%3A52Z&se=2025-11-19T04%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=hngtPa2R80LcVvLtFIWd4eBY9d%2FcMq%2BGByHf5ycOJEI%3D)

2. In the **Authoring** section, click **Assignments**, click the ellipsis icon to the right of the assignment you created in the previous task and click **Delete assignment**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage_Governance_via_Azure_Policy/4-2.png?st=2020-11-18T04%3A25%3A52Z&se=2025-11-19T04%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=hngtPa2R80LcVvLtFIWd4eBY9d%2FcMq%2BGByHf5ycOJEI%3D)

3. In the portal, search for and select **Storage accounts**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage_Governance_via_Azure_Policy/4-3.png?st=2020-11-18T04%3A25%3A52Z&se=2025-11-19T04%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=hngtPa2R80LcVvLtFIWd4eBY9d%2FcMq%2BGByHf5ycOJEI%3D)

4. In the list of storage accounts, select the resource group corresponding to the storage account you created in the last task of this lab. Select **Tags** and click **Delete** (Trash can to the right) to the **Role:Infra** tag and press **Save**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/4-4.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)

5.  In the portal, again search for and select **Storage accounts** or use the menu at the top to select **Storage accounts**

6. In the list of storage accounts, select the storage account you created in the last task of this lab, click **Delete**, when prompted for the confirmation, in the **Confirm delete** type **yes** and click **Delete**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage-Governance-via-azurepolicy/4-6.png?st=2020-11-20T10%3A54%3A31Z&se=2025-11-21T10%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=x4quSVvQ4CyZ4GnTsOElXsyO7DluaePUSLdsnOzNFbY%3D)


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage_Governance_via_Azure_Policy/4-6-1.png?st=2020-11-18T04%3A25%3A52Z&se=2025-11-19T04%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=hngtPa2R80LcVvLtFIWd4eBY9d%2FcMq%2BGByHf5ycOJEI%3D)

## Conclusion

Congratulations! You have successfully completed the **Manage_Governance_via_Azure_Policy** lab. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab


## Review

In this lab, you have:

- Created and assigned tags via the Azure portal
- Enforced tagging via an Azure policy
- Applied tagging via an Azure policy
