# Manage Virtual Machines

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Provision the lab environment](#provision-the-lab-environment)

[Deploy zone resilient Azure virtual machines by using the Azure portal and an Azure Resource Manager template](#deploy-zone-resilient-azure-virtual-machines-by-using-the-azure-portal-and-an-azure-resource-manager-template)

[Configure Azure virtual machines by using virtual machine extensions](#configure-azure-virtual-machines-by-using-virtual-machine-extensions)

[Scale compute and storage for Azure virtual machines](#scale-compute-and-storage-for-azure-virtual-machines)

[Register the Microsoft Insights and Microsoft AlertsM anagement resource providers](#register-the-microsoft-insights-and-microsoft-alerts-management-resource-providers)

[Deploy zone resilient Azure virtual machine scale sets by using the Azure portal](#deploy-zone-resilient-azure-virtual-machine-scale-sets-by-using-the-azure-portal)

[Configure Azure virtual machine scale sets by using virtual machine extensions](#configure-azure-virtual-machine-scale-sets-by-using-virtual-machine-extensions)

[Scale compute and storage for Azure virtual machine scale sets](#scale-compute-and-storage-for-azure-virtual-machine-scale-sets)

[Clean up resources](#clean-up-resources)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to identify the different options for deploying and configuring Azure virtual machines and also explore the ability to automatically configure virtual machines and virtual machine scale sets by using the Azure Virtual Machine Custom Script extension.. 

**Scenario & Objectives**

In this lab, we will determine different compute and storage resiliency and scalability options we can implement when using Azure virtual machines. Next, we need to investigate compute and storage resiliency and scalability options that are available when using Azure virtual machine scale sets. We also explore the ability to automatically configure virtual machines and virtual machine scale sets by using the Azure Virtual Machine Custom Script extension.

In this lab, you will learn:

1. Deploy zone-resilient Azure virtual machines by using the Azure portal and an Azure Resource Manager template

2. Configure Azure virtual machines by using virtual machine extensions

3. Scale compute and storage for Azure virtual machines

4. Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers

5. Deploy zone-resilient Azure virtual machine scale sets by using the Azure portal

6. Configure Azure virtual machine scale sets by using virtual machine extensions

7. Scale compute and storage for Azure virtual machine scale sets (optional)

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the Azure Console.

## Pre-Requisites

* Azure fundamentals

## Provision the lab environment

1. Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

**Azure Location:** {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

## Deploy zone resilient Azure virtual machines by using the Azure portal and an Azure Resource Manager template

In this task, you will deploy Azure virtual machines into different availability zones by using the Azure portal and an Azure Resource Manager template.

1. In the Azure portal, search for and select **Virtual machines** and, on the **Virtual machines** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/1.png?st=2020-11-15T03%3A46%3A03Z&se=2025-11-16T03%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Zx4ACFo5eigwBneVuc3ylnCGJYfljEmUGbGXFCsOzAk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/2.png?st=2020-11-15T03%3A47%3A48Z&se=2025-11-16T03%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s05YmB%2FLtDCs1ofIi%2FfGYTMtpNPYKXo7nutHi1FGsZc%3D)

2. On the **Basics** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

    **Settings**
    
    * Subscription: **the name of the Azure subscription you will be using in this lab**
    
    * Resource group: the name of a new resource group **az104-08-rg01**
    
    * Virtual machine name: **az104-08-vm0**
    
    * Region: {{location}}
    
    * Availability options: **Availability zone**
    
    * Availability zone: **1**
    
    * Image: **Windows Server 2019 Datacenter - Gen1**
    
    * Azure Spot instance: **No**
    
    * Size: **Standard D2s v3** 
    
    * Username: **Student**
    
    * Password: **Pa55w.rd1234**
    
    * Public inbound ports: **None**
    
    * Would you like to use an existing Windows Server license?: **No**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/3.png?st=2020-11-15T03%3A48%3A45Z&se=2025-11-16T03%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FD4it0RhKlcJm9SkXgGsOj9qLM4uZhWDsvhdH3bkUGA%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/4.png?st=2020-11-15T03%3A50%3A08Z&se=2025-11-16T03%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lO%2BzXd6lIk02kARZW8aAmDjBjNjHEGwswV4Yk6c6q2A%3D)

3. Click **Next: Disks >** and, on the **Disks** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/5.png?st=2020-11-15T03%3A50%3A47Z&se=2025-11-16T03%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HBym5pxa56s0eHPTDcjSPLqhdtJDpVqQmOKQ0o4vy6A%3D)   

   **Settings**
   
   * OS disk type: **Standard HDD**
    
   * Enable Ultra Disk compatibility: **No**

4. Click **Next: Networking >** and, on the **Networking** tab of the **Create a virtual machine** blade, click **Create new** below the **Virtual network** textbox.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/6.png?st=2020-11-15T03%3A53%3A24Z&se=2025-11-16T03%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mZGwV3hE5aag7NB6GSr1Vg2IVjjwm%2BWzMAVqLa7dMn4%3D)

5. On the **Create virtual network** blade, specify the following settings (leave others with their default values):

    **Settings:**
    
    * Name: **az104-08-rg01-vnet**
    
    * Address range: **10.80.0.0/20**
    
    * Subnet name: **subnet0**
    
    * Subnet range: **10.80.0.0/24**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/7.png?st=2020-11-16T14%3A06%3A49Z&se=2025-11-17T14%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iHDxLOoy7diiEvymSRp4Kvwj5Wd0yrg%2BKp1pOhiXbts%3D)

>**Note**: Select the created subnet in drop down list.
 
6. Click **OK** and, back on the **Networking** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

    **Settings**
    
    * Public IP: **None**
    
    * NIC network security group: **None**
    
    * Accelerated networking: **Off**
    
    * Place this virtual machine behind an existing load balancing solution?: **No**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/128.png?st=2020-11-16T14%3A12%3A57Z&se=2025-11-17T14%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=F9hcJjpBywzQVZGW7s%2FxilG45zJQCqF7yGywrXZo%2BYY%3D)

7. Click **Next: Management >** and, on the **Management** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/123.png?st=2020-11-15T04%3A10%3A02Z&se=2025-11-16T04%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aYPM3hNld20UPBZqQjLa21WQtlskM6Vjbm9yz6ExjEU%3D)

   **Settings**
    
   * Boot diagnostics: **Enable with custom storage account**
    
   * Diagnostics storage account: **Create new**
    
   * Create storage account: Enter a globally unique name all in lower case > Click **OK**
   
   >**Note**: Identify the name of diagnostics storage account. You will use it in the next task.
    
8. Click **Next: Advanced >**, on the **Advanced** tab of the **Create a virtual machine** blade, review the available settings without modifying any of them, and click **Review + Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/9.png?st=2020-11-15T04%3A05%3A28Z&se=2025-11-16T04%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aQon%2BpjpRa9tS0v4yI5OJDFU1LcCEOuRDvl%2BLRJEGqk%3D)

9. On the **Review + Create** blade, click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/10.png?st=2020-11-15T04%3A06%3A35Z&se=2025-11-16T04%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=a5JeihTaHAQaOIG1o1ElSczaDke6TOkWomOX3LND3uk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/11.png?st=2020-11-15T04%3A14%3A22Z&se=2025-11-16T04%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7kqnd%2F2AcsLoDy9Pt3Ex%2FyjS8vDw6DNqByQHJ2Y%2FCIY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/12.png?st=2020-11-15T04%3A28%3A57Z&se=2026-11-16T04%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LnIVQudPzfchbgKQNJwN8ZNudtDyXyoan8R0f3L%2Bduc%3D)

10. On the deployment blade, click **Template**.

11. Review the template representing the deployment in progress and click **Deploy**.

>**Note**: You will use this option to deploy the second virtual machine with matching configuration except for the availability zone.  

12. On the **Custom deployment** blade, specify the following settings (leave others with their default values):

    **Settings:**
    
   * Resource group: **az104-08-rg01** 
    
   * Network Interface Name: **az104-08-vm1-nic1**
    
   * Virtual Machine Name: **az104-08-vm1**
   
   * Virtual Machine Computer Name: **az104-08-vm1**
   
   * Admin Username: **Student**
   
   * Admin Password: **Pa55w.rd1234**
   
   * Zone: **2**
   
   >**Note**: You need to modify parameters corresponding to the properties of the distinct resources you are deploying by using the template, including the virtual machine and its network interface. You also need to specify a different availability zone if you want your deployment consisting of two virtual machines to be zone redundant.

13. Enable the checkbox **I agree to the terms and conditions stated above** and click **Purchase**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/132.png?st=2020-11-16T14%3A33%3A43Z&se=2025-11-17T14%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pxZIC3GAz967bnwc4Y7oB2YTBGZtmKlycND%2FwDWXhLo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/133.png?st=2020-11-16T14%3A34%3A57Z&se=2025-11-17T14%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=whK3XrAHKhUZapbx0tQh50%2B%2Fj2VzjyxUXv2gwudrzek%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/134.png?st=2020-11-16T14%3A36%3A49Z&se=2025-11-17T14%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HonW77eJq3PnUqWicLujApWjFAkRVwX%2Bb9hDedvLIto%3D)

>**Note**: Wait for both deployments to complete before you proceed to the next task. This might take about 5 minutes.

## Configure Azure virtual machines by using virtual machine extensions

In this task, you will install Windows Server Web Server role on the two Azure virtual machines you deployed in the previous task by using the Custom Script virtual machine extension. 

1. In the Azure portal, search for and select **Storage accounts** and, on the **Storage accounts** blade, click the entry representing the diagnostics storage account you created in the previous task. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/15.png?st=2020-11-15T04%3A34%3A47Z&se=2025-11-16T04%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tDPFErE1%2Buw0lCANuy6eJUeY1QdfCxXiPk7L7gZt5p4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/16.png?st=2020-11-15T04%3A36%3A14Z&se=2025-11-16T04%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RF%2F%2FI31QaG1Jc%2B7BMEcwZ6gHgknb%2BCcl5rm50AXffGE%3D)

2. On the storage account blade, click **Containers** and then click **+ Container**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/17.png?st=2020-11-15T04%3A36%3A50Z&se=2025-11-16T04%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=THRNbwZRN10DNGRZS9Zz00L3%2Bf28NC4G%2B2vCT3HlSKA%3D)

3. On the **New container** blade, specify the following settings (leave others with their default values) and click **Create**:

    **Settings** 
    
    * Name: **scripts**
    
    * Public access level: **Private (no anonymous access**)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/18.PNG?st=2020-11-15T04%3A37%3A35Z&se=2025-11-16T04%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eZQaX%2F0n5R%2B6%2F3JMCtrp7CtN3V4LFv6hrHoIGTtJ%2B2g%3D)
    
4. Back on the storage account blade displaying the list of containers, click **scripts**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/19.png?st=2020-11-15T04%3A38%3A27Z&se=2025-11-16T04%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cjoEOmbClIipsksDTM9cAwKsX3lCu%2BCArj2YRBf8cf4%3D)

5. Copy the below URL and Paste it in the browser then save it in your local computer. 

https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Manage%20Virtual%20Machines/az104-08-install_IIS.ps1?st=2020-11-15T04%3A42%3A33Z&se=2025-11-16T04%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yWYE4Y%2BIVlPQgqIpjkh7qp3ZC84SEeodwXvqN35mSO0%3D

6. On the **scripts** blade, click **Upload**.

7. On the **Upload blob** blade, Upload it from earler saved path. click **Upload**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/20.png?st=2020-11-15T04%3A39%3A04Z&se=2025-11-16T04%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wAIAnuX94wiSefkO5b8ItKZMwBxdxdvFMJ2aOxBljE8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/21.png?st=2020-11-15T04%3A39%3A53Z&se=2025-11-16T04%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=11JbvN7zhiaPm0e%2B8p3UUlZgDGeCy5RX%2BuH9Vhc5ZAo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/22.png?st=2020-11-15T04%3A52%3A39Z&se=2025-11-16T04%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=b5cJPjMNQzDvP%2Bi9OBazFp51bw1vV5nGi6Gxa2MAmmU%3D)

8. In the Azure portal, search for and select **Virtual machines** and, on the **Virtual machines** blade, click **az104-08-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/23.png?st=2020-11-15T04%3A54%3A29Z&se=2025-11-16T04%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wiCR1DxTUDlnLRClhU6AARd1qSWr5Y5y%2FXvZGr844c0%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/24.png?st=2020-11-15T04%3A55%3A18Z&se=2025-11-16T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GpYUKUvmWtA6RJBme0jv4oZ4oInJS5mSVc9xh59j5gw%3D)

9. On the **az104-08-vm0** virtual machine blade, in the **Settings** section, click **Extensions**, and the click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/25.png?st=2020-11-15T04%3A55%3A46Z&se=2025-11-16T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZA5aCQKPGHRqXzLR%2FuMhBBCq1rz98zMj71x7Q7QSVSs%3D)

10. On the **New resource** blade, click **Custom Script Extension** and then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/26.png?st=2020-11-15T04%3A56%3A19Z&se=2025-11-16T04%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2K2qKZgLk7oU5A%2BfmLAfYprByq%2BGjbaEzolJ5MLRdrc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/27.png?st=2020-11-15T04%3A57%3A18Z&se=2025-11-16T04%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8r1mROou2MSizDiSVDdvJy6UY8E36mNh1Qie0zPQIms%3D)

11. From the **Install extension** blade, click **Browse**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/28.png?st=2020-11-15T04%3A58%3A11Z&se=2025-11-16T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FiOro8VmWjTxk93V0uyzNA8Z9OH%2BnRzo2kQn2pv3S2o%3D)

12. On the **Storage accounts** blade, click the name of the storage account into which you uploaded the **az104-08-install_IIS.ps1** script, on the **Containers** blade, click **scripts**, on the **scripts** blade, click **az104-08-install_IIS.ps1**, and then click **Select**. 

13. Back on the **Install extension** blade, click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/29.png?st=2020-11-15T04%3A58%3A57Z&se=2025-11-16T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cLrCyz%2Bdawa2bWqLM1G8Yn8APV4nPy4uJwX2SsEj4FM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/30.png?st=2020-11-15T04%3A59%3A22Z&se=2025-11-16T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6SRLEt2XykIGpJIl%2FYwwXElI6Ovd07YGOZTEnb160Qc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/31.png?st=2020-11-15T04%3A59%3A59Z&se=2025-11-16T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=29N4G%2BP4bVHw1HXPT5uyw7%2FZYzBNYluqeInLSPAY96A%3D)

14. In the Azure portal, search for and select **Virtual machines** and, on the **Virtual machines** blade, click **az104-08-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/32.png?st=2020-11-15T05%3A00%3A24Z&se=2025-11-16T05%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=maX8wdl8azDTQIgF1XgMa69ojogDvnBdrbBKDD4hNo8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/33.png?st=2020-11-15T05%3A01%3A11Z&se=2025-11-16T05%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZXmXQL4DkEk6Pc%2F9Oj3Rfxa%2FS5E7CKWfGV2nAqyEJIU%3D)

15. On the **az104-08-vm1** blade, in the **Settings** section, click **Export template**.

16. On the **az104-08-vm1 - Export template** blade, click **Deploy**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/34.png?st=2020-11-15T05%3A02%3A06Z&se=2025-11-16T05%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FuHFOmpVxkTH4i4gRaSvzGHZSH3LUM7Ef60t%2FGdA5Ew%3D)

17. On the **Custom deployment** blade, click **Edit template**.

18. On the **Edit template** blade, in the section displaying the content of the template, insert the following code starting with line **20** (directly underneath the `    "resources": [` line):

>**Note**: If you are using a tool that pastes the code in line by line intellisense may add extra brackets causing validation errors. You may want to paste the code into notepad first and then paste it into line 20. 

   ```json
        {
            "type": "Microsoft.Compute/virtualMachines/extensions",
            "name": "az104-08-vm1/customScriptExtension",
            "apiVersion": "2018-06-01",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "az104-08-vm1"
            ],
            "properties": {
                "publisher": "Microsoft.Compute",
                "type": "CustomScriptExtension",
                "typeHandlerVersion": "1.7",
                "autoUpgradeMinorVersion": true,
                "settings": {
                    "commandToExecute": "powershell.exe Install-WindowsFeature -name Web-Server -IncludeManagementTools && powershell.exe remove-item 'C:\\inetpub\\wwwroot\\iisstart.htm' && powershell.exe Add-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value $('Hello World from ' + $env:computername)"
              }
            }
        },   

   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/35.png?st=2020-11-15T05%3A08%3A22Z&se=2025-11-16T05%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GkJ9L1aKy6gRNYYDxEEAOlny7mrp7LIYwxihIrFLcm0%3D)  
   
  >**Note**: This section of the template defines the same Azure virtual machine custom script extension that you deployed earlier to the first virtual machine via Azure PowerShell.
 
19. Click **Save** and, back on the **Custom template** blade, enable the checkbox **I agree to the terms and conditions stated above** and click **Purchase**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/136.png?st=2020-11-16T15%3A13%3A29Z&se=2025-11-17T15%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5%2BkycsIeskMfnB8SLR4r2Pz0Zmj59xdIuq14znQiHMI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/137.png?st=2020-11-16T15%3A15%3A27Z&se=2025-11-17T15%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Vx%2Fc%2F6mVbpi7yXMB56LIfx7JTSOyJWeUWdHv93lPO5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/138.png?st=2020-11-16T15%3A16%3A02Z&se=2025-11-17T15%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oOoMhw2gYXuib55ZazMElTX4ta4TZnRbPpkE%2B9YYj1Y%3D)

 >**Note**: Disregard the message stating **The resource group is in a location that is not supported by one or more resources in the template. Please choose a different resource group**. This is expected and can be ignored in this case.

 >**Note**: Wait for the template deployment to complete. You can monitor its progress from the **Extensions** blade of the **az104-08-vm0** and **az104-08-vm1** virtual machines. This should take no more than 3 minutes.

20. To verify that the Custom Script extension-based configuration was successful, navigate back on the **az104-08-vm1** blade, in the **Operations** section, click **Run command**, and, in the list of commands, click **RunPowerShellScript**.

21. On the **Run Command Script** blade, type the following and click **Run** to access the web site hosted on **az104-08-vm0**:

   ```
   Invoke-WebRequest -URI http://10.80.0.4 -UseBasicParsing
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/139.png?st=2020-11-16T15%3A28%3A32Z&se=2025-11-17T15%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7sqV1irxdo6HH3tJuAeRzoW9fk3rQ2m5v3G3Ae%2FIIEM%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/140.png?st=2020-11-16T15%3A29%3A02Z&se=2025-11-17T15%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bX3HhfgXF7rbkfAHNstVHRVF2AtZnfRShsdJoiTWXDA%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/141.png?st=2020-11-16T15%3A29%3A26Z&se=2025-11-17T15%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cIcEDsfuUSPMO0aeGGaMPyNK9ponfy1sDlbpJe9erqw%3D) 

  >**Note**: The **-UseBasicParsing** parameter is necessary to eliminate dependency on Internet Explorer to complete execution of the cmdlet

  >**Note**: You can also connect to **az104-08-vm0** and run `Invoke-WebRequest -URI http://10.80.0.5` to access the web site hosted on **az104-08-vm1**.

## Scale compute and storage for Azure virtual machines

In this task you will scale compute for Azure virtual machines by changing their size and scale their storage by attaching and configuring their data disks.

1. In the Azure portal, search for and select **Virtual machines** and, on the **Virtual machines** blade, click **az104-08-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/37.png?st=2020-11-15T05%3A27%3A57Z&se=2025-11-16T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yZfYPgmcuiLuFniyqWZ975POGoZaBl14JFpbyfvUXS8%3D)    

2. On the **az104-08-vm0** virtual machine blade, click **Size** and set the virtual machine size to **Standard DS1_v2** and click **Resize**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/38.png?st=2020-11-15T05%3A29%3A01Z&se=2025-11-16T05%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gPv4xKNHAbbzJqPnTnR%2FbhwZ9%2BeQ%2FtOHDI8ssAlWYiI%3D)

>**Note**: Choose another size if **Standard DS1_v2** is not available.

3. On the **az104-08-vm0** virtual machine blade, click **Disks**, Under **Data disks** click **+ Create and attach a new disk**. 

4. Create a managed disk with the following settings (leave others with their default values):

    **Settings**
   
   * Disk name: **az104-08-vm0-datadisk-0**
    
   * Source type: **None**
    
   * Account type: **Premium SSD**
    
   * Size: **1024 GiB**
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/39.png?st=2020-11-15T05%3A30%3A25Z&se=2025-11-16T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=83v6G0oofqFaRw1EqCjj1lfyQNywx%2FqKn7AEiPhG4f4%3D)

5. Back on the **az104-08-vm0 - Disks** blade, Under **Data disks** click **+ Create and attach a new disk**. 

6. Create a managed disk with the following settings (leave others with their default values):

    **Settings**
    
    Disk name: **az104-08-vm0-datadisk-1**
    
    Source type: **None**
    
    Account type: **Premium SSD**
    
    Size: **1024 GiB**
    
7. Back on the **az104-08-vm0 - Disks** blade, click **Save**.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/40.png?st=2020-11-15T05%3A31%3A04Z&se=2025-11-16T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YxWUVno0gxy4CMW1UENfPe9Vulg8qHW6i6H4tRuFX3E%3D)

8. On the **az104-08-vm0** blade, in the **Operations** section, click **Run command**, and, in the list of commands, click **RunPowerShellScript**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/41.png?st=2020-11-15T05%3A37%3A35Z&se=2025-11-16T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jfSTHQlBc31E9mrgICSCbT2HCqUL9NJbOQLyGGCh%2BoY%3D)

9. On the **Run Command Script** blade, type the following and click **Run** to create a drive Z: consisting of the two newly attached disks with the simple layout and fixed provisioning:

   ```
   New-StoragePool -FriendlyName storagepool1 -StorageSubsystemFriendlyName "Windows Storage*" -PhysicalDisks (Get-PhysicalDisk -CanPool $true)

   New-VirtualDisk -StoragePoolFriendlyName storagepool1 -FriendlyName virtualdisk1 -Size 2046GB -ResiliencySettingName Simple -ProvisioningType Fixed

   Initialize-Disk -VirtualDisk (Get-VirtualDisk -FriendlyName virtualdisk1)

   New-Partition -DiskNumber 4 -UseMaximumSize -DriveLetter Z
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/144.PNG?st=2020-11-16T16%3A00%3A51Z&se=2025-11-17T16%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SJV8r1F9DU156kE8fnKpObg5SInIVwCy3J3HTIHwd%2FQ%3D)

>**Note**: Wait for the confirmation that the commands completed successfully.

10. In the Azure portal, search for and select **Virtual machines** and, on the **Virtual machines** blade, click **az104-08-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/43.png?st=2020-11-15T05%3A40%3A02Z&se=2025-11-16T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CnRxpabMoGo0FxW8GDSaupmhy9QgVVE4U2zx0iucU4E%3D)

11. On the **az104-08-vm1** blade, in the **Settings** section, click **Export template**.

12. On the **az104-08-vm1 - Export template** blade, click **Deploy**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/44.png?st=2020-11-15T05%3A40%3A56Z&se=2025-11-16T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1ZIJ0EJHz7j4kRrQBT9d%2B02K3avhNUrVZcN%2BvcQ94Mg%3D)

13. On the **Custom deployment** blade, click **Edit template**.

>**Note**: Disregard the message stating **The resource group is in a location that is not supported by one or more resources in the template. Please choose a different resource group**. This is expected and can be ignored in this case.

14. On the **Edit template** blade, in the section displaying the content of the template, replace the line **30** "vmSize": "Standard_D2s_v3"` with the following line):

   ```json
   "vmSize": "Standard_DS1_v2"

   ```
15. Click **Save** and, back on the **Custom template** blade, enable the checkbox **I agree to the terms and conditions stated above** and click **Purchase**.   
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/46.png?st=2020-11-15T05%3A42%3A08Z&se=2025-11-16T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jCBeb2v7tugLG5U0m%2BMSrxhrFcvK1b04MizaaWVr8jA%3D)   

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/45.png?st=2020-11-15T05%3A41%3A48Z&se=2025-11-16T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OoMWq1%2BrK63FModR9NiURF53ocujgapG2xkxp3Cap3k%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/47.png?st=2020-11-15T05%3A47%3A12Z&se=2025-11-16T05%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SN%2B4sfTrpKq3578%2Bi2JatjZLMQAaxIX4U1V%2BzRj3rpc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/48.png?st=2020-11-15T05%3A47%3A41Z&se=2025-11-16T05%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cA%2Fz%2BUj7oSBF7KJXIlcf2I046l4aUfHDKQVIAU7n504%3D)
   
 >**Note**: This section of the template defines the same Azure virtual machine size as the one you specified for the first virtual machine via the Azure portal.
    
16. On the **Edit template** blade, in the section displaying the content of the template, replace line **49** ( "dataDisks": [ ]` line) with the following code :

   ```json
                    "dataDisks": [
                      {
                        "lun": 0,
                        "name": "az104-08-vm1-datadisk0",
                        "diskSizeGB": "1024",
                        "caching": "ReadOnly",
                        "createOption": "Empty"
                      },
                      {
                        "lun": 1,
                        "name": "az104-08-vm1-datadisk1",
                        "diskSizeGB": "1024",
                        "caching": "ReadOnly",
                        "createOption": "Empty"
                      }
                    ]
   ```
   
 17. Click **Save** and, back on the **Custom template** blade, enable the checkbox **I agree to the terms and conditions stated above** and click **Purchase**.
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/49.png?st=2020-11-15T05%3A47%3A59Z&se=2025-11-16T05%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NGZoUG%2FnCHPs7584GY6qIQY28klh5Ldmy2ZhDqNrzzg%3D)
  
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/49.png?st=2020-11-15T05%3A47%3A59Z&se=2025-11-16T05%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NGZoUG%2FnCHPs7584GY6qIQY28klh5Ldmy2ZhDqNrzzg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/50.png?st=2020-11-15T05%3A50%3A13Z&se=2025-11-16T05%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=coGEVBeH%2FIvHSVKh6alMpUhKohtlhERo8CIzI1mmFuc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/51.png?st=2020-11-15T05%3A50%3A49Z&se=2025-11-16T05%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kqdZyx2mYCurRE0sMq9RTpuPNMboPUnWuhGXlrz%2BOJE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/52.png?st=2020-11-15T05%3A51%3A16Z&se=2025-11-16T05%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Ck1gjzOHKnz3eLQGrDTzT8OKbLCK0Nf2uZgNkwBj6Dg%3D)

>**Note**: If you are using a tool that pastes the code in line by line intellisense may add extra brackets causing validation errors. You may want to paste the code into notepad first and then paste it into line 49. 

>**Note**: This section of the template creates two managed disks and attaches them to **az104-08-vm1**, similarly to the storage configuration of the first virtual machine via the Azure portal.

>**Note**: Wait for the template deployment to complete. You can monitor its progress from the **Extensions** blade of the **az104-08-vm1** virtual machine. This should take no more than 3 minutes.

18. Back on the **az104-08-vm1** blade, in the **Operations** section, click **Run command**, and, in the list of commands, click **RunPowerShellScript**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/53.png?st=2020-11-15T05%3A55%3A30Z&se=2025-11-16T05%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HTOcjGLoVytuL5%2BjQ0fnFPESvCVvslXXpCYILC0ZN2U%3D)

19. On the **Run Command Script** blade, type the following and click **Run** to create a drive Z: consisting of the two newly attached disks with the simple layout and fixed provisioning:

   ```
   New-StoragePool -FriendlyName storagepool1 -StorageSubsystemFriendlyName "Windows Storage*" -PhysicalDisks (Get-PhysicalDisk -CanPool $true)

   New-VirtualDisk -StoragePoolFriendlyName storagepool1 -FriendlyName virtualdisk1 -Size 2046GB -ResiliencySettingName Simple -ProvisioningType Fixed

   Initialize-Disk -VirtualDisk (Get-VirtualDisk -FriendlyName virtualdisk1)

   New-Partition -DiskNumber 4 -UseMaximumSize -DriveLetter Z
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/145.PNG?st=2020-11-16T16%3A06%3A10Z&se=2025-11-17T16%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Hsq2y9BGL7pFeW%2BO%2F0QUz1UFB0HjVYDNVn8tCPlNtic%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/146.png?st=2020-11-16T16%3A06%3A53Z&se=2025-11-17T16%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hpEFirCM%2BU0GrYoT3b%2F4LegXR9FV%2F%2Fu99Xa0YcM311E%3D) 

>**Note**: Wait for the confirmation that the commands completed successfully.

## Register the Microsoft Insights and Microsoft AlertsManagement resource providers

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

2. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/147.png?st=2020-11-16T16%3A19%3A03Z&se=2025-11-17T16%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1P7BGo1Jfo2WFk2h5%2BFqhKM3TR%2BbthYNfaRBl5NmpPc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/148.png?st=2020-11-16T16%3A20%3A01Z&se=2025-11-17T16%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JEyZ88evA3wm8UCX6vc3WLla4WNtoa5BqRw705aNamA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/149.png?st=2020-11-16T16%3A20%3A44Z&se=2025-11-17T16%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=L%2B%2BCrrtzLPTuXWrmq6OXqTvIsnkWL7eVs6aHwFMQXwM%3D)

>**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**.

3. From the Cloud Shell pane, run the following to register the Microsoft.Insights and Microsoft.AlertsManagement resource providers.

   ```
   Register-AzResourceProvider -ProviderNamespace Microsoft.Insights
   
   Register-AzResourceProvider -ProviderNamespace Microsoft.AlertsManagement   ```
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/55.png?st=2020-11-15T05%3A58%3A10Z&se=2025-11-16T05%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QjdqqlSaeQOPNgLJCnphpVpiasav5JSreQEE3IAZ8Ic%3D)  

## Deploy zone resilient Azure virtual machine scale sets by using the Azure portal

In this task, you will deploy Azure virtual machine scale set across availability zones by using the Azure portal.

1. In the Azure portal, search for and select **Virtual machine scale sets** and, on the **Virtual machine scale sets** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/56.png?st=2020-11-15T06%3A00%3A35Z&se=2025-11-16T06%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VGavFxS11TWN21jfE%2F9jaIroUUC6jRauhXorOOXiDzU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/57.png?st=2020-11-15T06%3A02%3A14Z&se=2025-11-16T06%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Ny1mnbYibu14e8B8bpW6hsjXN2pllvPR4kfefc0GxRY%3D)

2. On the **Basics** tab of the **Create a virtual machine scale set** blade, specify the following settings (leave others with their default values) and click **Next : Disks >**:

    **Settings**
    
   * Subscription: **the name of the Azure subscription you are using in this lab**
    
   * Resource group: the name of a new resource group **az104-08-rg02**
    
   * Virtual machine scale set name: **az10408vmss0** 
    
   *  Region: East US 2
    
   * Availability zone: **Zones 1, 2, 3** 
    
   * Image: **Windows Server 2016 Datacenter** 
    
   * Azure Spot instance: **No**
    
   * Size: **Standard D2s_v3** 
    
   * Username: **Student** 
    
   * Password: **Pa55w.rd1234**
    
   * Would you like to use an existing Windows Server license?  **No** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/58.png?st=2020-11-15T06%3A03%3A10Z&se=2025-11-16T06%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3G7V4FIjRu7D5zlmdpwDwL3LUS55Odz%2FFSteBeBWD2Y%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/59.png?st=2020-11-15T06%3A03%3A42Z&se=2025-11-16T06%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xqBdFnq5YIBfueoIs7c8k%2F%2FobnbS91YUEd%2FEB%2FbXRhs%3D)
 
 >**Note**: For the list of Azure regions which support deployment of Windows virtual machines to availability zones, refer to [What are Availability Zones in Azure?](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview)
 
3. On the **Disks** tab of the **Create a virtual machine scale set** blade, accept the default values and click **Next : Networking >**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/60.png?st=2020-11-15T06%3A05%3A08Z&se=2025-11-16T06%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q5CkqWwG8hrjRgXyuK2xZMGmKccl8Nlf%2F71L6PGwhJk%3D)

4. On the **Networking** tab of the **Create a virtual machine scale set** blade, click the **Create virtual network** link below the **Virtual network** textbox and create a new virtual network with the following settings (leave others with their default values):

    **Settings**
    
    * Name: **az104-08-rg02-vnet** 
    
    * Address range: **10.82.0.0/20**
    
    * Subnet name: **subnet0** 
    
    * Subnet range: **10.82.0.0/24**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/61.png?st=2020-11-15T06%3A06%3A23Z&se=2025-11-16T06%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PTFh4LbsZSOEn9jPXKehSZKuoSgIXO4QwqrD93tTALs%3D)

>**Note**: Once you create a new virtual network and return to the **Networking** tab of the **Create a virtual machine scale set** blade, the **Virtual network** value will be automatically set to **az104-08-rg02-vnet**.

>**Note**: Select the created subnet.

5. Back on the **Networking** tab of the **Create a virtual machine scale set** blade, click the **Edit network interface** icon to the right of the network interface entry. 

6. On the **Edit network interface** blade, in the **NIC network security group** section, click **Advanced** and click **Create new** under the **Configure network security group** drop-down list.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/150.png?st=2020-11-16T16%3A43%3A23Z&se=2025-11-17T16%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ch45ZSae1tbLXKQw91FCuEeEo2%2FTFz5gKombq%2F%2BOjYQ%3D)

7. On the **Create network security group** blade, specify the following settings (leave others with their default values):

    **Settings** 
   
   * Name: **az10408vmss0-nsg** 

8. Click **Add an inbound rule** and add an inbound security rule with the following settings (leave others with their default values):

    **Settings:**
    
    * Source: **Any**
    
    * Source port ranges: **\*** 
    
    *  Destination: **Any**
    
    * Destination port ranges: **80**
    
    * Protocol: **TCP** 
    
    * Action: **Allow**
    
    * Priority: **1010** 
    
    * Name: **custom-allow-http**

9. Click **Add** and, back on the **Create network security group** blade, click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/63.png?st=2020-11-15T06%3A09%3A49Z&se=2025-11-15T20%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TvzkbWrzSSUrhzLLcimKAEmaf05dF%2F3RAre%2BLU%2FQP%2Bk%3D)

10. Back on the **Edit network interface** blade, in the **Public IP address** section, click **Enabled** and click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/64.png?st=2020-11-15T06%3A11%3A34Z&se=2025-11-16T06%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3ZXoIZtmps6PIac%2BDKHsZCjYRhvmehqy%2F9kwEgIvf%2Fg%3D)

11. Back on the **Networking** tab of the **Create a virtual machine scale set** blade, specify the following settings (leave others with their default values) and click **Next : Scaling >**:

    **Settings:**
    
   * Use a load balancer: **Yes**
    
   * Load balancing options: **Azure load balancer**
   
   * Select a load balancer: **(new) az10408vmss0-lb**
   
   * Select a backend pool: **(new) bepool**
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/65.png?st=2020-11-15T06%3A12%3A12Z&se=2025-11-16T06%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ziyVCFA2Xv%2BKKMbzTPUzNcn%2Fgw0ma%2BoLvFQ7SEjlSKo%3D)
    
12. On the **Scaling** tab of the **Create a virtual machine scale set** blade, specify the following settings (leave others with their default values) and click **Next : Management >**:

    **Settings**
   
    * Initial instance count: **2**
    
    * Scaling policy: **Manual**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/66.png?st=2020-11-15T06%3A13%3A20Z&se=2025-11-16T06%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2Bbe4BZKPSSwbIWcShSOiWe9pU9AKQMSY9ExNY6DbMqo%3D)

13. On the **Management** tab of the **Create a virtual machine scale set** blade, ensure that the **Boot diagnostics** opton is enabled, select **Create new**, on the **Create storage account** blade, in the **Name** text box, type a unique, valid storage account name, click **OK**, and click **Next : Health >**:

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/67.png?st=2020-11-15T06%3A14%3A06Z&se=2025-11-16T06%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zCa081TmEM3EoiG1w9HNDkyLCvdgDgRHOlkUZ6Fb39E%3D)

>**Note**: You will need the name of this storage account in the next task.

14. On the **Health** tab of the **Create a virtual machine scale set** blade, review the default settings without making any changes and click **Next : Advanced >**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/68.png?st=2020-11-15T06%3A15%3A37Z&se=2025-11-16T06%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=O7BmcpELyxWSZnGA0CRnKMDFCq0tYv8zMRq97auliHg%3D)

15. On the **Advanced** tab of the **Create a virtual machine scale set** blade, specify the following settings (leave others with their default values) and click **Review + create**.

   **Settings**
    
   * Spreading algorithm: **Fixed spreading (not recommended with zones)**
   
   ![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/69.png?st=2020-11-15T06%3A16%3A06Z&se=2025-11-16T06%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iiU8UOb26gIiGbUsPKDtleydsqmVFDQLZ%2B4QJD4dMtk%3D)
   
   >**Note**: The **Max spreading** setting is currently not functional.

16. On the **Review + create** tab of the **Create a virtual machine scale set** blade, ensure that the validation passed and click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/70.png?st=2020-11-15T06%3A18%3A09Z&se=2025-11-16T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=81Q1MndxIGTGm9YLLHg3jnwl7IIwFQnuHDNOCyjbh64%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/71.png?st=2020-11-15T06%3A18%3A41Z&se=2025-11-16T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bloZtwP00C1G8rFNyvvKhkhjgIrkWq%2Boz%2FEf0rghkns%3D)

>**Note**: Wait for the virtual machine scale set deployment to complete. This should take about 5 minutes.

## Configure Azure virtual machine scale sets by using virtual machine extensions

In this task, you will install Windows Server Web Server role on the instances of the Azure virtual machine scale set you deployed in the previous task by using the Custom Script virtual machine extension.

1. In the Azure portal, search for and select **Storage accounts** and, on the **Storage accounts** blade, click the entry representing the diagnostics storage account you created in the previous task. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/72.png?st=2020-11-16T04%3A54%3A04Z&se=2025-11-17T04%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=At0ZWAeqRGr6jRJTRNXZQ83l54j3MxsyGutAgeJpKt0%3D)

2. On the storage account blade, click **Containers** and then click **+ Container**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/73.png?st=2020-11-16T04%3A54%3A53Z&se=2025-11-17T04%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TQMVpvzMdk0SVhgpMFbCu%2BnBVFwa7MaUJvXrmscP1p0%3D)

3. On the **New container** blade, specify the following settings (leave others with their default values) and click **Create**:

    **Settings**
    
    * Name: **scripts**
    
    * Public access level: **Private (no anonymous access**)
    
4. Back on the storage account blade displaying the list of containers, click **scripts**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/74.PNG?st=2020-11-16T04%3A55%3A47Z&se=2025-11-17T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WmMui40Be6Soij03%2FVqBYLnip%2B6Dp0htSRs8vHxkVQQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/75.png?st=2020-11-16T04%3A57%3A08Z&se=2025-11-17T04%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Qdesigr2IPwU1cbZJwT0guKK6Z0oWGQgs%2BIxdTbUFyk%3D)

5. Copy the below URL and Paste it in the browser then save it in your local computer.

https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Manage%20Virtual%20Machines/az104-08-install_IIS.ps1?st=2020-11-16T05%3A03%3A45Z&se=2025-11-17T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=43QVUgRd%2FTB4TUQ3hS7aUZJoHHXQOppeqpoGY19nR%2Bc%3D

6. On the **scripts** blade, click **Upload**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/76.png?st=2020-11-16T04%3A58%3A25Z&se=2025-11-17T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MVYzIoW20Svh42itkHV1ZRxzhGPF%2Bls898FnD6P7kdU%3D)

7. On the Upload blob blade, Upload it from earler saved path. click **Upload.**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/77.png?st=2020-11-16T04%3A59%3A22Z&se=2025-11-17T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BBYPLqq3xkmPJg4FTCQDpACO1WYBnjEzDUe%2F3tgASPo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/78.png?st=2020-11-16T04%3A59%3A54Z&se=2025-11-17T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gLLoiD54YsFoXaGhjeWm7qWBYuOUi%2BDX3gel1lqWMNQ%3D)

8. In the Azure portal, navigate back to the **Virtual machine scale sets** blade and click **az10408vmss0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/79.png?st=2020-11-16T05%3A06%3A38Z&se=2025-11-17T05%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Uw88Tw9LCEmyNFUgVmPVEgkNSbMEa%2F74J6qYW984QIY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/80.png?st=2020-11-16T05%3A07%3A21Z&se=2025-11-17T05%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SUlTWUISbSBWO5V36BcIyBhSibZeyssf79dQCGPZzQc%3D)

9. On the **az10408vmss0** blade, click **Extensions**, and the click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/81.png?st=2020-11-16T05%3A08%3A09Z&se=2025-11-17T05%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9OMvAMk0TyOuWUf81cWJZhgvNNzV0pWuFeNbboQ9DiE%3D)

10. On the **New resource** blade, click **Custom Script Extension** and then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/82.png?st=2020-11-16T05%3A08%3A59Z&se=2025-11-17T05%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fF5qM5YUDC%2F0vJDuiogTQuNxC6PfwalBfw54cfHaZms%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/83.png?st=2020-11-16T05%3A09%3A36Z&se=2025-11-17T05%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=N6mPYyFIOY5TfKri8DAlli%2BdtKX%2FaiVJjgUTFLyaZO8%3D)

11. From the **Install extension** blade, **Browse** to and **Select** the **az104-08-install_IIS.ps1** script that was uploaded to the **scripts** container in the storage account earlier in this task, and then click **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/84.png?st=2020-11-16T05%3A10%3A16Z&se=2025-11-17T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Dqy1%2FGMaF60EUCwtyPcod7Q85dqpx9f9I%2Ff1VYE%2FNsY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/85.png?st=2020-11-16T05%3A10%3A56Z&se=2025-11-17T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0aEJDyWYXCtsLybJAKu9dv%2FuFk0uM11HitZDkta%2F5tY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/86.png?st=2020-11-16T05%3A11%3A23Z&se=2025-11-17T05%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iifocvUM6ZBPfPUYMiSuWkTSWgL6vDPt%2FmgIMAlvinM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/87.png?st=2020-11-16T05%3A12%3A00Z&se=2025-11-17T05%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ltTyUgRZkty9rxcjoo5y5GGGoRAHWw7%2BikRqP2ggaes%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/88.png?st=2020-11-16T05%3A12%3A37Z&se=2025-11-17T05%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FSawcdlQC0KRu6pWmYlztB3fbVsd%2B8ZhZy%2Fgz9rzHGI%3D)

>**Note**: Wait for the installation of the extension to complete before proceeding to the next step.

12. In the **Settings** section of the **az10408vmss0** blade, click **Instances**, select the checkboxes next to the two instances of the virtual machine scale set, click **Upgrade**, and then, when prompted for confirmation, click **Yes**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/89.png?st=2020-11-16T05%3A13%3A25Z&se=2025-11-17T05%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=r4xzISJF%2BjulhmA1jNOgGZ9iNXvVvx6tYibbw0jkuX4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/90.png?st=2020-11-16T05%3A15%3A25Z&se=2025-11-17T05%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=K7J0r8XIydGMRTAMEK4spoOJ5FTWBVq1TBUY7JAanYc%3D)

>**Note**: Wait for the upgrade to complete before proceeding to the next step.

13. In the Azure portal, search for and select **Load balancers** and, in the list of load balancers, click **az10408vmss0lb**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/91.png?st=2020-11-16T05%3A16%3A19Z&se=2025-11-17T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xOSK%2FvnAldN5unHbv4x5ucQHsyIhb79lNDZEbldCGbY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/92.png?st=2020-11-16T05%3A17%3A18Z&se=2025-11-17T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Bfq4upkkF09gTkdHQgm7H3WmPRRn0t07PxuRW5usP78%3D)

14. On the **az10408vmss0lb** blade, note the value of the **Public IP address** assigned to the frontend of the load balancer, open an new browser tab, and navigate to that IP address.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/93.png?st=2020-11-16T05%3A17%3A53Z&se=2025-11-17T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YSusrxpeClHSZQIaKeaiKIx0WWQVeT4A8z0OwVC8j4Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/94.png?st=2020-11-16T05%3A18%3A46Z&se=2025-11-17T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EBUNHq1SefD1xAtS3PV0G6L12wa0ZYyGcGqFOO%2FA%2BoA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/95.png?st=2020-11-16T05%3A19%3A20Z&se=2025-11-17T05%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LdviiucUtlv1BkEvvcgZjRs0bRM9uvWfs6XklwWQQgg%3D)

>**Note**: Verify that the browser page displays the name of one of the instances of the Azure virtual machine scale set **az10408vmss0**.

## Scale compute and storage for Azure virtual machine scale sets

In this task, you will change the size of virtual machine scale set instances, configure their autoscaling settings, and attach disks to them.

1. In the Azure Portal, on the **az10408vmss0** blade, click **Size**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/96.png?st=2020-11-16T05%3A19%3A44Z&se=2025-11-17T05%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lck0w8ydWJEkIhWaUCrxnCqHC5eLggBpsozClVzNWrQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/97.png?st=2020-11-16T05%3A23%3A07Z&se=2025-11-17T05%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wa0hkWmMAOamQk87UKHposHOPikgVsJjoPOnN69GLzw%3D)

2. In the list of available sizes, select **Standard DS1_v2** and click **Resize**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/98.png?st=2020-11-16T05%3A23%3A51Z&se=2025-11-17T05%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RcGnfDiEBmT1vuE4abCIQb2hsVsIFkBN10h9CnuipkA%3D)

3. In the **Settings** section, click **Instances**, select the checkboxes next to the two instances of the virtual machine scale set, click **Upgrade**, and then, when prompted for confirmation, click **Yes**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/99.png?st=2020-11-16T05%3A24%3A53Z&se=2025-11-17T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eElMiUwkt%2BfUkEwoNb5pHEZ5kFzpi%2FziKI4k1Lca5Vs%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/100.png?st=2020-11-16T05%3A25%3A52Z&se=2025-11-17T05%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h%2F46E%2B70cA%2FQAx7yluUAZq6Ufeyr9FiCf5t4Qk5ieaY%3D)

4. In the list of instances, click the entry representing the first instance and, on the scale set instance blade, note its **Location** (it should be one of the zones in the target Azure region into which you deployed the Azure virtual machine scale set). 

5. Return to the **az10408vmss0 - Instances** blade, click the entry representing the second instance and, on the scale set instance blade, note its **Location** (it should be one of the other two zones in the target Azure region into which you deployed the Azure virtual machine scale set). 

6. Return to the **az10408vmss0 - Instances** blade and click **Scaling**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/101.png?st=2020-11-16T05%3A26%3A27Z&se=2025-11-17T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2Vks5AYC53Uy6Zr9Rs0snOGN0HsRFX4cDlrTmZjEUYo%3D)

7. On the **az10408vmss0 - Scaling** blade, select the **Custom autoscale** option and configure autoscale with the following settings (leave others with their default values):

    **Settings**
    
    * Scale mode: **Scale based on a metric** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/102.png?st=2020-11-16T05%3A27%3A37Z&se=2025-11-17T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rMUXpO%2BTbGj3hq2SELkUn1JD7hlgLz%2BL6LC%2BFbmDXUQ%3D)

8. Click the **+ Add a rule** link and, on the **Scale rule** blade, specify the following settings (leave others with their default values):

    **Setting**
    
    * Metric source:  **Current resource (az10480vmss0)**
    
    * Time aggregation: **Average**
    
    * Metric namespace: **Virtual Machine Host**
    
    * Metric name: **Network In Total**
    
    * Operator: **Greater than**
    
    * Metric threshold to trigger scale action: **10**
    
    * Duration (in minutes): **1**
    
    * Time grain statistic: **Average**
    
    * Operation: **Increase count by**
    
    * Instance count:  **1** 
    
    * Cool down (minutes): **5**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/103.PNG?st=2020-11-16T05%3A29%3A35Z&se=2025-11-17T05%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Aohy%2B5Hsjsqw%2BfOcEs69404p7bpGFzDmofTYis%2FdFJI%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/104.PNG?st=2020-11-16T05%3A30%3A06Z&se=2025-11-17T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ITqQtkG7n3ZIfY5%2F%2FjTmF3SiD8gHE4LZmzm85mFbAcA%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/105.png?st=2020-11-16T05%3A31%3A24Z&se=2025-11-17T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=z%2FOPVodOoSvqZgkWpI95ZBYnsp%2B%2B8Tu%2Bb387uPICZnQ%3D)

>**Note**: Obviously these values do not represent a realistic configuration, since their purpose is to trigger autoscaling as soon as possible, without extended wait period. 

9. Click **Add** and, back on the **az10408vmss0 - Scaling** blade, specify the following settings (leave others with their default values):

    **Settings**
   
    * Instance limits Minimum: **1** 
    
    * Instance limits Maximum: **3**
    
    * Instance limits Default: **1** 

10. Click **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/106.png?st=2020-11-16T05%3A31%3A49Z&se=2025-11-17T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yIQN1oi5ObIsmRsxIg3dogi1B8tpjiKGB8PxCabkB4I%3D)

11. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

12. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

13. From the Cloud Shell pane, run the following to identify the public IP address of the load balancer in front of the Azure virtual machine scale set **az10408vmss0**.

   ```
   $rgName = 'az104-08-rg02'

   $lbpipName = 'az10408vmss0-ip'

   $pip = (Get-AzPublicIpAddress -ResourceGroupName $rgName -Name $lbpipName).IpAddress
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/107.png?st=2020-11-16T07%3A23%3A02Z&se=2025-11-17T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=znI5ACwTe65AXcreAtR%2B9e3%2BQZ8v5cn9VEAv4G66vqk%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/108.png?st=2020-11-16T07%3A25%3A00Z&se=2025-11-17T07%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z1VzjE7L1uGR%2BfpT1VX3gFRf5cv4sS9qG%2F0P3%2FK2z2Q%3D)
   
14. From the Cloud Shell pane, run the following to start and infinite loop that sends the HTTP requests to the web sites hosted on the instances of Azure virtual machine scale set **az10408vmss0**.

   ```
   while ($true) { Invoke-WebRequest -Uri "http://$pip" }
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/151.png?st=2020-11-16T17%3A07%3A33Z&se=2025-11-17T17%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zyhdx9o5W%2FHABEYvc9Lk%2F7YDHyxK8tQ8QdBwknelp98%3D) 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/109.png?st=2020-11-16T07%3A25%3A49Z&se=2025-11-17T07%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lNnO3XiNgMYD3BSz7la7Qt5ERzwfHTEwbli0G%2FNEOls%3D)   

15. Minimize the Cloud Shell pane but do not close it, switch back to the **az10408vmss0 - Instances** blade and monitor the number of instances.

>**Note**: You might need to wait a couple of minutes and click **Refresh**.
 
16. Once the third instance is provisioned, navigate to its blade to determine its **Location** (it should be different than the first two zones you identified earlier in this task. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/110.png?st=2020-11-16T07%3A26%3A52Z&se=2025-11-17T07%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=o1%2Fw9xqTKH%2B3w0CLQvAcqk3uUxtapycFSLUFY%2BXYUpE%3D) 

17. Close Cloud Shell pane. 

18. On the **az10408vmss0** blade, click **Disks**, click **+ Add data disk**, and attach a new managed disk with the following settings (leave others with their default values):

    **Settings**
    
    * LUN: **0**
    
    * Size: **32** 
    
    * Account type: **Standard HDD**
    
    * Host caching: **None**
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/111.png?st=2020-11-16T07%3A33%3A12Z&se=2025-11-17T07%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Nm9iT697%2BLEyhfKuv649%2BnqZ2VgphAZq0uKiq6P8M0k%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/112.png?st=2020-11-16T07%3A35%3A07Z&se=2025-11-17T07%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3xGoqOwj2eeN9gNcndwEGP1wkBGq1Qo1uSqeSKzmMTI%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/113.png?st=2020-11-16T07%3A35%3A54Z&se=2025-11-17T07%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KxtiOGUYa0YpTKk%2FGFQ%2FBCYck0LI0vE9hDWS9C5edUs%3D)

19. Save the change, in the **Settings** section of the **az10408vmss0** blade, click **Instances**, select the checkboxes next to the two instances of the virtual machine scale set, click **Upgrade**, and then, when prompted for confirmation, click **Yes**.

>**Note**: The disk attached in the previous step is a raw disks. Before it can be used, it is necessary to create a partition, create a filesystem, and mount it. To accomplish this, you will use Azure virtual machine Custom Script extension. First, you will need to remove the existing Custom Script Extension.

20. In the **Settings** section of the **az10408vmss0** blade, click **Extensions**, click **CustomScriptExtension**, and then click **Uninstall**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/116.png?st=2020-11-16T07%3A40%3A25Z&se=2025-11-17T07%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=f44b5njQzOFvtwss%2FWUcvtgXlgA16uOvhhElpx%2B6pQ8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/117.png?st=2020-11-16T07%3A41%3A45Z&se=2025-11-17T07%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1V8qp6ngtEzbMvs0GxSsngGuwgJrxYtj09hkbgHcOBs%3D)

>**Note**: Wait for uninstallation to complete.

21. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

22. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/118.png?st=2020-11-16T07%3A42%3A35Z&se=2025-11-17T07%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HkieNDZHeReYHPnsNby4bK0CpieRajGJW19l1%2FO53Fs%3D)

23. In the toolbar of the Cloud Shell pane, Download the **az104-08-configure_VMSS_disks.ps1** by using below command.

curl "https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Templates/Manage%20Virtual%20Machines/az104-08-configure_VMSS_disks.ps1?st=2020-11-16T17%3A12%3A39Z&se=2025-11-17T17%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iviYpAdd4zv4GeHrm9njMbn6vypFB%2BE746sKTua7DVs%3D" -o az104-08-configure_VMSS_disks.ps1

24. From the Cloud Shell pane, run the following to display the content of the script:

   ```
   Set-Location -Path $HOME

   Get-Content -Path ./az104-08-configure_VMSS_disks.ps1
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/119.png?st=2020-11-16T07%3A43%3A54Z&se=2025-11-17T07%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dwIhvEaV1gCPokNgldzgT4oNvNUM%2Fj0mSfxT1R4Jxt8%3D)

>**Note**: The script installs a custom script extension that configures the attached disk.

25. From the Cloud Shell pane, run the following to excecute the script and configure disks of Azure virtual machine scale set:

   ```
   ./az104-08-configure_VMSS_disks.ps1
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Managing%20Virtual%20Machines/120.png?st=2020-11-16T07%3A46%3A03Z&se=2025-11-17T07%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y7fpH%2FGU1rl9n3z70lzy122mVmZIJOdrRQQvQiJyQ4Y%3D)

26. Close the Cloud Shell pane.

27. In the **Settings** section of the **az10408vmss0** blade, click **Instances**, select the checkboxes next to the two instances of the virtual machine scale set, click **Upgrade**, and then, when prompted for confirmation, click **Yes**.

## Clean up resources

<p class="note-container">
Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.
</p>

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. Remove az104-08-configure_VMSS_disks.ps1 by running the following command:

   ```
   rm ~\az104-08-configure_VMSS_disks.ps1
   ```

3. List all resource groups created throughout the labs of this module by running the following command:

   ```
   Get-AzResourceGroup -Name 'az104-08*'
   ```

4. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```
   Get-AzResourceGroup -Name 'az104-08*' | Remove-AzResourceGroup -Force -AsJob
   ```
>**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

## Conclusion

Congratulations! You have successfully completed the **Manage Virtual Machines** lab. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
