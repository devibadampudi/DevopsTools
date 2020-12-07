  # Deploy Windows Virtual Desktop 

  # Table of Contents

  [Overview](#overview)

  [Pre-Requisites](#pre-requisites)

  [Login to Azure Portal and Deploy a Hostpool](#login-to-azure-portal-and-deploy-a-hostpool)

 [Adding Users to Hostpool](#adding-users-to-hostpool)
 
  [Access WVD Hostpool Session Host](#access-wvd-hostpool-session-host)

  ## Overview

 Host pools are a collection of one or more identical virtual machines (VMs) within Windows Virtual Desktop environments. Each host pool can contain an app group that users can interact with as they would on a physical desktop.

This lab will walk you through the setup process for creating a host pool for a Windows Virtual Desktop environment through the Azure portal. This method provides a browser-based user interface to create a host pool in Windows Virtual Desktop, create a resource group with VMs in an Azure subscription, join those VMs to the Azure Active Directory (AD) domain, and register the VMs with Windows Virtual Desktop.

  ## Pre-Requisites
  You'll need to enter the following parameters to create a host pool:

  * The VM image name<br>
  * VM configuration<br>
  * Domain and network properties
  * Windows Virtual Desktop host pool properties

You'll also need to know the following things:

  * Where the source of the image you want to use is. Is it from Azure Gallery or is it a custom image?
   * Your domain join credentials.

Also, make sure you've registered the Micro cdsl'[\soft.DesktopVirtualization resource provider. If you haven't already, go to Subscriptions, select the name of your subscription, and then select Azure resource providers.
  ## Login to Azure Portal and Deploy a Hostpool

  In this section we will login to the Azure Portal and deploy Hostpool
 
 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}<br>
 **Resource group Name:** {{resource-group-name}} <br>
 **location:** {{azure-rg-location}}
 
  **Step 1.** Sign in to your Azure account using your credentials https://portal.azure.com/ 
              
  **Step 2.** Enter **Windows Virtual Desktop** into the search bar, then find and select Windows Virtual Desktop under Services.

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/1.png)

  **Step 3.** In the Windows Virtual Desktop overview page, select **Create a host pool**.
![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/2.png)

  **Step 4.** In the **Basics** tab,<br>
  * Select the correct subscription under Project details.
  * Select an existing resource group from the drop-down menu.
  * Enter a unique name for your host pool.
  * In the Location field, select the region where you want to create the host pool 
  * Under Host pool type, select Pooled.
  * For **Max session limit** enter the maximum number of users you want load-balanced to a single session host.
  * For **Load balancing algorithm** choose breadth-first 
  * Select **Next: VM details.**

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/3.png) 

  **Step 5.** In the **Virtual Machines** tab
  * Under **Add virtual machines** select **yes** radio button
  * Under Resource Group, choose the resource group where you want to create the virtual machines. This can be a different resource group than the one you used for the host pool
  * Choose the Virtual machine region where you want to create the virtual machines. They can be the same or different from the region you selected for the host pool.
  * Next, choose the size of the virtual machine D2s V3.You can either keep the default size as-is or select Change Size to change the size. If you select Change Size, in the window that appears, choose the size of the virtual machine suitable for your workload.
  * Under Number of VMs, provide the number of VMs you want to create for your host pool. For now choose 1 VM
  * After that, provide a Name prefix as **demohost** to name the virtual machines the setup process creates. The suffix will be - with numbers starting from 0.
  * Next, choose the image that needs to be used to create the virtual machine. You can choose either Gallery or Storage Blob.For now choose Gallery
  * Next, choose **windows 10 Enterprise multi-session** image from select image dropdown list.
  * Choose Standard SSD OS disks
![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/4.png)

  * **Under Network and security** select the virtual network **"Vnet Name"**and subnet **"subnet name"**. This Virtual network is connected to domain controller. since you'll need to join the virtual machines inside the virtual network to the domain. 
  * Next, select whether or not you want a public IP for the virtual machines. We recommend you select No
  * Select **Basic** security group 
  * Under Administrator account, enter the Domain admin credentials **Username: Password:**
  * Select **Next:Workspace>**

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/5.png)

  **Step 6.** **Workspace information**<br>
  The host pool setup process creates a desktop application group by default. For the host pool to work as intended, you'll need to publish this app group to users or user groups, and you must register the app group to a workspace.
  To register the desktop app group to a workspace:
  * Select **Yes**. If you select No, you can register the app group later, but we recommend you get the workspace registration done as soon as you can so your host pool works properly.
  * Next, choose whether you want to create a new workspace or select from existing workspaces. Only workspaces created in the same location as the host pool will be allowed to register the app group to.
  * Next, choose create a new workspace enter Workspace name and click Ok
  * Optionally, you can select Tags.
  * When you're done, select Review + create.

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/6.png)

  * Review the information about your deployment to make sure everything looks correct. When you're done, select Create. This starts the deployment process, which creates the following objects:
![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/7.png)

Demployment takes 20 minutes after successful deplyment you can see the below screen. Click Goto resouce which takes to you to your resource group.

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/8.png)

## Adding Users to Hostpool

  **Step 1.** Go to your resource group and click on hostpool

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/9.png)

  **Step 2.** Select **Application groups** from left pan

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/10.png)

  **Step 3.** Next select Application group (demohost-DAG) and then click mange as shown on below screen.

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/11.png)

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/12.png)

 **Step 4.** Next, Click **+ Add** and enter your id on search box then click select. 

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/13.png)

 Now you are added to hostpool users list. you can access the hostpool with your azure credentials 

  ## Access WVD Hostpool Session Host

  In this section, we will know how to conect WVD session host using web client.The web client lets you access your Windows Virtual Desktop resources from a web browser without the lengthy installation process. Any HTML5-capable browser should work.

  **Step 1.** In a browser, navigate to the Azure Resource Manager-integrated version of the Windows Virtual Desktop web client at https://rdweb.wvd.microsoft.com/arm/webclient and sign in with your user account.


![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/14.png)

  **Step 2.** After signing in, you should now see a list of resources. You can access resources by selecting the resouce.
  

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/15.png)

  **Step 3.** Select SessionDesktop and click Allow and enter your Azure credentials to login to WVD session host.

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/16.png)
  

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/17.png)

**Step 4.** After successful login you can see the windows 10 musti-session.

![alt text](https://raw.githubusercontent.com/sysgain/tl-scripts/master/wvd/18.png)

We can downnload and install WVD RDP client in your personal systems also refer the below link for better understanding.
https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients
