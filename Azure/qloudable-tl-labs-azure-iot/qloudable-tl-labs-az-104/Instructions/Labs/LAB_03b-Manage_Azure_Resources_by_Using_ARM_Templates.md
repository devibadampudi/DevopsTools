# Manage Azure resources by Using ARM Templates

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Review an ARM template for deployment of an Azure managed disk](#review-an-arm-template-for-deployment-of-an-azure-managed-disk)

[Create an Azure managed disk by using an ARM template](#create-an-azure-managed-disk-by-using-an-arm-template)

[Review the ARM template-based deployment of the managed disk](#review-the-arm-template-based-deployment-of-the-managed-disk)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to provision the resources and organizing them based on resource groups by using Azure Resource Manager templates.

**Scenario & Objectives**

Now you will explore the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups by using the Azure Resource Manager templates.

In this lab, you will learn:

1. Review the ARM template for deployment of an Azure managed disk

2. Creating an Azure managed disk by using an ARM template

3. Review the ARM template-based deployment of the managed disk

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* Azure fundamentals

## Review an ARM template for deployment of an Azure managed disk

In this task, you will create an Azure disk resource by using an Azure Resource Manager template.

1. Using the Chrome browser, login into [Azure portal](https://portal.azure.com) with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2. Open the below Urls in Chrome browser and save them as **az104-03b-md-template.json** and **az104-03b-md-parameters.json** files in the **Downloads** folder on your lab computer.

**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/az104-03b-md-template.json?st=2020-10-27T06%3A59%3A44Z&se=2025-10-28T06%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5W3lbm%2FEIZbEEi7455PHC5OVHM%2FgXuR6Je2SQr9sj5I%3D**

**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/az104-03b-md-parameters.json?st=2020-10-27T07%3A01%3A05Z&se=2025-10-28T07%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=I8sY%2BM%2FmNPpwd44VWV1oiRM%2B81PFHt0zgf%2FxUqHbQuk%3D**

## Create an Azure managed disk by using an ARM template

1. In the Azure portal, click on **+ Create a resource**, search for and select **Template deployment (Deploy a custom template)**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/1.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/2.png?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/3.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

2. On the **Custom deployment** blade, click **Build your own template in the editor**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/4.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

3. On the **Edit template** blade, click **Load file** and upload the **az104-03b-md-template.json** template file you downloaded in the previous step.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/5.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

4. Within the editor pane, remove the following lines:

   ```json
   "sourceResourceId": {
       "type": "String"
   },
   "sourceUri": {
       "type": "String"
   },
   "osType": {
       "type": "String"
   },
   ```

   ```json
   },
   "hyperVGeneration": {
       "defaultValue": "V1",
       "type": "String"
   ```

   ```json
   "osType": "[parameters('osType')]"
   "networkAccessPolicy": "[parameters('networkAccessPolicy')]"

   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/6.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/7.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

<p class="note-container">
These parameters are removed since they are not applicable to the current deployment. In particular, sourceResourceId, sourceUri, osType, and hyperVGeneration parameters are applicable to creating an Azure disk from an existing VHD file.
</p>

5. In addition, remove the trailing comma from the following line:

   ```json
   "diskSizeGB": "[parameters('diskSizeGb')]",
   ```
<p class="note-container">
This is necessary to account for the syntax rules of JSON-based ARM templates.
</p>

6. Save the changes.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/8.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

7. Back on the **Custom deployment** blade, click **Edit parameters**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/9.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

8. On the **Edit parameters** blade, click **Load file** and upload the parameters file **az104-03b-md-parameters.json** and save the changes.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/10.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/11.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

9. Back on the **Custom deployment** blade, specify the following settings:

* Subscription: the name of the Azure subscription you are using in this lab 

* Resource Group: `{{resource-group-name}}`

* Location: `{{Location}}`

* Disk Name: **az104-03b-disk1**
    
* Location: accept the default value 
  
* Sku: **Standard_LRS**
  
* Disk Size Gb: **32**
  
* Create Option: **empty**
  
* Disk Encryption Set Type: **EncryptionAtRestWithPlatformKey**
  
* Network Access Policy: **AllowAll**

10. Select **Review + Create** and then select **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/12.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/13.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

11. Verify that the deployment completed successfully.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/14.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

## Review the ARM template-based deployment of the managed disk

1. In the Azure portal, search for and select **Resource groups**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/15.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

2. In the list of resource groups, click `{{resource-group-name}}`.

3. On the **az104-03b-rg1** resource group blade, in the **Settings** section, click **Deployments**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/16.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

4. From the **{{resource-group-name}} - Deployments** blade, click the first entry in the list of deployments and review the content of the **Input** and **Template** blades.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/17.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20ARM%20Templates/18.PNG?st=2020-10-27T07%3A14%3A51Z&se=2025-10-28T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=adqFdYTW1J4hrpfkPNrgFIWIo6M5Km8%2B6RVsdbR2keU%3D)

### Review

In this lab, you have:

* Reviewed an ARM template for deployment of an Azure managed disk

* Created an Azure managed disk by using an ARM template

* Reviewed the ARM template-based deployment of the managed disk

## Conclusion 

Congratulations! You have successfully completed the lab **Manage Azure resources by Using ARM Templates**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
