# Implement Virtual Networking

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Create and configure a virtual network](#create-and-configure-a-virtual-network)

[Deploy virtual machines into the virtual network](#deploy-virtual-machines-into-the-virtual-network)

[Configure private and public IP addresses of Azure VMs](#configure-private-and-public-ip-addresses-of-azure-vms)

[Configure network security groups](#configure-network-security-groups)

[Configure Azure DNS for internal name resolution](#configure-azure-dns-for-internal-name-resolution)

[Configure Azure DNS for external name resolution](#configure-azure-dns-for-external-name-resolution)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to create and explore virtual network with multiple subnets by using the Azure portal and deploy virtual machines into the virtual network.

**Scenario & Objectives**

You need to explore Azure virtual networking capabilities. To start, you plan to create a virtual network in Azure that will host a couple of Azure virtual machines. Since you intend to implement network-based segmentation, you will deploy them into different subnets of the virtual network. You also want to make sure that their private and public IP addresses will not change over time. To comply with Contoso security requirements, you need to protect public endpoints of Azure virtual machines accessible from Internet. Finally, you need to implement DNS name resolution for Azure virtual machines both within the virtual network and from Internet.

In this lab, you will learn:

1. Create and configure a virtual network

2. Deploy virtual machines into the virtual network

3. Configure private and public IP addresses of Azure VMs

4. Configure network security groups

5. Configure Azure DNS for internal name resolution

6. Configure Azure DNS for external name resolution

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the Azure Console.

## Pre-Requisites

* Azure Fundamentals

* Docker Fundamentals

## Create and configure a virtual network

In this task, you will create a virtual network with multiple subnets by using the Azure portal

1.  Using the Chrome browser, login into Azure portal with the below details.

> **Azure login_ID:** {{azure-login-id}}

> **Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2. In the Azure portal, search for and select **Virtual networks**, and on the **Virtual networks** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/1.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/2.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

3. Create a virtual network with the following settings (leave others with their default values):

> **Settings:**

* **Subscription:** the name of the Azure subscription you will be using in this lab 

* **Resource Group:** {{ResourceGroup}} 

* **Name** az104-04-vnet1

* **Region:** {{region}}

* **IPv4 address space:** 10.40.0.0/20

* **Subnet name:** subnet0

* **Subnet address range:** 10.40.0.0/24

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/3.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/4.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/5.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/6.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note:** Wait for the virtual network to be provisioned. This should take less than a minute.

4. On the **Virtual networks** blade, click **Refresh** and click **az104-04-vnet1**.

5. On the **az104-04-vnet1** virtual network blade, click **Subnets** and then click **+ Subnet**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/7.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

6. Create a subnet with the following settings (leave others with their default values):

> **Settings**

* **Name:** subnet1

* **Address range (CIDR block):** 10.40.1.0/24

* **Network security group:** None

* **Route table:** None

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/8.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/9.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

## Deploy virtual machines into the virtual network

In this task, you will deploy Azure virtual machines into different subnets of the virtual network by using an ARM template

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

2. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

    > **Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/10.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

* **Cloud Shell region:** {{region}} 

* **Resource group:** {{resource-group-name}} <br>

* **Storage Account:** Create new Storage <br>

* **File Share:** Create new file share

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/11.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/12.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/13.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

**Note:** Open the below Urls in Chrome browser and **save** them as **az104-04-vms-template.json** and **az104-04-vms-parameters.json** files in the Downloads folder on your lab computer.

**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Implement%20Virtual%20Networking/az104-04-vms-template.json?st=2020-11-09T09%3A21%3A35Z&se=2025-11-10T09%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RLDFQEOIqRY9MLYpB0W7f%2BZSU6Si8ccYhus97%2Biako4%3D**

**https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Implement%20Virtual%20Networking/az104-04-vms-parameters.json?st=2020-11-09T09%3A22%3A41Z&se=2025-11-10T09%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dDIjYVekSqryFwCxsVl8uOCrI5Gb%2FDFrDVsee%2BBSqys%3D**

3. In the toolbar of the Cloud Shell pane, click the **Upload/Download** files icon, in the drop-down menu, click **Upload** and upload the files **az104-04-vms-template.json** and **az104-04-vms-parameters.json** into the Cloud Shell home directory.

   > **Note**: You might need to upload each file separately.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/14.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

4. From the Cloud Shell pane, run the following to deploy two virtual machines by using the template and parameter files you uploaded:


   $rgName = {{ResourceGroup}}

  ```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-04-vms-template.json `
      -TemplateParameterFile $HOME/az104-04-vms-parameters.json
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/15.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: This method of deploying ARM templates uses Azure PowerShell. You can perform the same task by running the equivalent Azure CLI command **az deployment create** (for more information, refer to [Deploy resources with Resource Manager templates and Azure CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-cli).

   > **Note**: Wait for the deployment to complete before proceeding to the next task. This should take about 2 minutes.

5. Close the Cloud Shell pane.

## Configure private and public IP addresses of Azure VMs

In this task, you will configure static assignment of public and private IP addresses assigned to network interfaces of Azure virtual machines.

   > **Note**: Private and public IP addresses are actually assigned to the network interfaces, which, in turn are attached to Azure virtual machines, however, it is fairly common to refer to IP addresses assigned to Azure VMs instead.

1. In the Azure portal, search for and select **Resource groups**, and, on the **Resource groups** blade, click **{{ResourceGroup}}**.

2. On the **{{ResourceGroup}}** resource group blade, in the list of its resources, click **az104-04-vnet1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/16.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

3. On the **az104-04-vnet1** virtual network blade, review the **Connected devices** section and verify that there are two network interfaces **az104-04-nic0** and **az104-04-nic1** attached to the virtual network.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/17.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

4. Click **az104-04-nic0** and, on the **az104-04-nic0** blade, click **IP configurations**. 

    > **Note**: Verify that **ipconfig1** is currently set up with a dynamic private IP address.

5. In the list IP configurations, click **ipconfig1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/18.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

6. On the **ipconfig1** blade, set **Assignment** to **Static**, leave the default value of **IP address** set to **10.40.0.4**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/19.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

7. On the **ipconfig1** blade, in the **Public IP address settings** section, select **Associate** and then click **IP address - Configure required settings**. 

8. On the **Choose public IP address blade**, click **+ Create new** and create a new public IP address with the following settings:

> **Settings:**

* **Name:** az104-04-pip0

* **SKU:** Standard

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/20.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

9. Back on the **ipconfig1** blade, save the changes.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/21.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

10. Navigate back to the **az104-04-vnet1** blade and repeat the previous six steps to change the IP address assignment of **ipconfig1** of **az104-04-nic1** to **Static** and associate **az104-04-nic1** with a new Standard SKU public IP address named **az104-04-pip1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/22.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/23.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/24.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

11. Navigate back to the **{{ResourceGroup}}** resource group blade, in the list of its resources, click **az104-04-vm0**, and from the **az104-04-vm0** virtual machine blade, note the public IP address entry.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/25.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

12. Navigate back to the **{{ResourceGroup}}** resource group blade, in the list of its resources, click **az104-04-vm1**, and from the **az104-04-vm1** virtual machine blade, note the public IP address entry.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/26.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: You will need both IP addresses in the last task of this lab. 

## Configure network security groups

In this task, you will configure network security groups in order to allow for restricted connectivity to Azure virtual machines.

1. In the Azure portal, navigate back to the **{{ResourceGroup}}** resource group blade, and in the list of its resources, click **az104-04-vm0**.

2. On the **az104-04-vm0** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/27.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/28.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/29.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

3. Note that the connection attempt fails.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/30.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: This is expected, because public IP addresses of the Standard SKU, by default, require that the network interfaces to which they are assigned are protected by a network security group. In order to allow Remote Desktop connections, you will create a network security group explicitly allowing inbound RDP traffic from Internet and assign it to network interfaces of both virtual machines.

4. In the Azure portal, search for and select **Network security groups**, and, on the **Network security groups** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/31.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/32.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

5. Create a network security group with the following settings (leave others with their default values):

> **Setting:**

* **Subscription:** the name of the Azure subscription you are using in this lab

* **Resource Group:** {{ResourceGroup}}

* **Name:** az104-04-nsg01

* **Region:** {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/33.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/34.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: Wait for the deployment to complete. This should take about 2 minutes.

6. On the deployment blade, click **Go to resource** to open the **az104-04-nsg01** network security group blade. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/35.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

7. On the **az104-04-nsg01** network security group blade, in the **Settings** section, click **Inbound security rules**. 

8. Add an inbound rule with the following settings (leave others with their default values):

> **Settings:**

* **Source:** Any

* **Source port ranges:**  * 

* **Destination:** Any

* **Destination port ranges:** 3389

* **Protocol:** TCP

* **Action:** Allow

* **Priority:** 300

* **Name:** AllowRDPInBound

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/36.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

9. On the **az104-04-nsg01** network security group blade, in the **Settings** section, click **Network interfaces** and then click **+ Associate**.

10. Associate the **az104-04-nsg01** network security group with the **az104-04-nic0** and **az104-04-nic1** network interfaces.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/37.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/38.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/2394.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: It may take up to 5 minutes for the rules from the newly created Network Security Group to be applied to the Network Interface Card.

11. Navigate back to the **az104-04-vm0** virtual machine blade.

    > **Note**: Now verify that you can successfully connect to the target virtual machine and sign in by using the **Student** username and **Pa55w.rd1234** password.

12. On the **az104-04-vm0** blade, click **Connect**, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

    > **Note**: This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.

    > **Note**: You can ignore any warning prompts when connecting to the target virtual machines.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/40.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

13. When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/41.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: Leave the Remote Desktop session open. You will need it in the next task.

## Configure Azure DNS for internal name resolution

In this task, you will configure DNS name resolution within a virtual network by using Azure private DNS zones.

1. In the Azure portal, search for and select **Private DNS zones** and, on the **Private DNS zones** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/42.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/43.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

2. Create a private DNS zone with the following settings (leave others with their default values):

> **Setting:** 

* **Subscription:** the name of the Azure subscription you are using in this lab

* **Resource Group:** {{ResourceGroup}}

* **Name:** contoso.org

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/44.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/45.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: Wait for the private DNS zone to be created. This should take about 2 minutes.

3. Click **Go to resource** to open the **contoso.org** DNS private zone blade.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/46.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

4. On the **contoso.org** private DNS zone blade, in the **Settings** section, click **Virtual network links**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/47.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

5. Add a virtual network link with the following settings (leave others with their default values):

> **Settings:**

* **Link name:** az104-04-vnet1-link

* **Subscription:** the name of the Azure subscription you are using in this lab 

*  **Virtual network:** az104-04-vnet1

* **Enable auto registration:** enabled

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/48.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note:** Wait for the virtual network link to be created. This should take less than 1 minute.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/49.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

6. On the **contoso.org** private DNS zone blade, in the sidebar, click **Overview**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/50.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

7. Verify that the DNS records for **az104-04-vm0** and **az104-04-vm1** appear in the list of record sets as **Auto registered**.

    > **Note:** You might need to wait a few minutes and refresh the page if the record sets are not listed.

8. Switch to the Remote Desktop session to **az104-04-vm0**, right-click the **Start** button and, in the right-click menu, click **Windows PowerShell (Admin)**.

9. In the Windows PowerShell console window, run the following to test internal name resolution of the **az104-04-vm1** DNS record set in the newly created private DNS zone:

   ```
   nslookup az104-04-vm1.contoso.org
   ```
10. Verify that the output of the command includes the private IP address of **az104-04-vm1** (**10.40.1.4**).

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/52.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

## Configure Azure DNS for external name resolution

In this task, you will configure external DNS name resolution by using Azure public DNS zones.

1. In the web browser, open a new tab and navigate to https://www.godaddy.com/domains/domain-name-search.

2. Use the domain name search to identify a domain name which is not in use. 

3. In the Azure portal, search for and select **DNS zones** and, on the **DNS zones** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/53.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

4. Create a DNS zone with the following settings (leave others with their default values):

> **Settings:**

* **Subscription:** the name of the Azure subscription you are using in this lab

* **Resource Group:** {{ResourceGroup}}

* **Name:** the DNS domain name you identified earlier in this task

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/54.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/55.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

   > **Note**: Wait for the DNS zone to be created. This should take about 2 minutes. 

5. Click **Go to resource** to open the blade of the newly created DNS zone.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/56.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

6. On the DNS zone blade, click **+ Record set**.

7. Add a record set with the following settings (leave others with their default values):

> **Settings:**

* **Name:** az104-04-vm0

* **Type:** A

* **Alias record set:** No

* **TTL:** 1

* **TTL unit:** Hours

* **IP address:** the public IP address of **az104-04-vm0** which you identified in the third exercise of this lab

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/57.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

8. Add a record set with the following settings (leave others with their default values):

> **Setting:**

* **Name:** az104-04-vm1

* **Type:** A

* **Alias record set:** No

* **TTL:** 1

* **TTL unit:** Hours

* **IP address:** the public IP address of **az104-04-vm1** which you identified in the third exercise of this lab

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/58.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

9. On the DNS zone blade, note the name of the **Name server 1** entry.

10. In the Azure portal, open the **PowerShell** session in **Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

11. From the Cloud Shell pane, run the following to test external name resolution of the **az104-04-vm0** DNS record set in the newly created DNS zone (replace the placeholder `[Name server 1]` including the [] brackets, with the name of **Name server 1** you noted earlier in this task and the `[domain name] placeholder with the name of the DNS domain you created earlier in this task):

   ```
   nslookup az104-04-vm0.[domain name] [Name server 1]
   ```

**Ex:** nslookup az104-04-vm0.az104lab4.com ns1-08.azure-dns.com.

12. Verify that the output of the command includes the public IP address of **az104-04-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/59.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

13. From the Cloud Shell pane, run the following to test external name resolution of the **az104-04-vm1** DNS record set in the the newly created DNS zone (replace the placeholder `[Name server 1]` with the name of **Name server 1** you noted earlier in this task and the `[domain name] placeholder with the name of the DNS domain you created earlier in this task):

   ```
   nslookup az104-04-vm1.[domain name] [Name server 1]
   ```

**Ex:** nslookup az104-04-vm1.az104lab4.com ns1-08.azure-dns.com.

14. Verify that the output of the command includes the public IP address of **az104-04-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/vnet/60.PNG?st=2020-11-09T08%3A27%3A57Z&se=2025-11-10T08%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=MyzEHZROvUxTMyKNZD5BCB8XMccilPJM8YPSVH%2BjNnk%3D)

### Review

In this lab, you have:

* Created and configured a virtual network

* Deployed virtual machines into the virtual network

* Configured private and public IP addresses of Azure VMs

* Configured network security groups

* Configured Azure DNS for internal name resolution

* Configured Azure DNS for external name resolution

## Conclusion

Congratulations! You have successfully completed the **Implement Virtual Networking**! lab. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
