# Implement Traffic Management

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Provision the lab environment](#provision-the-lab-environment)

[Configure the hub and spoke network topology](#configure-the-hub-and-spoke-network-topology)

[Test transitivity of virtual network peering](#test-transitivity-of-virtual-network-peering)

[Configure routing in the hub and spoke topology](#configure-routing-in-the-hub-and-spoke-topology)

[Implement Azure Load Balancer](#implement-azure-load-balancer)

[Implement Azure Application Gateway](#implement-azure-application-gateway)

[cleanup resources](#cleanup-resources)

## Overview

The main Aim of this lab is, managing network traffic targeting Azure virtual machines in the hub and spoke network topology, which Contoso considers implementing in its Azure environment. This testing needs to include implementing connectivity between spokes by relying on user defined routes that force traffic to flow via the hub, as well as traffic distribution across virtual machines by using layer 4 and layer 7 load balancers. For this purpose, you intend to use Azure Load Balancer (layer 4) and Azure Application Gateway (layer 7).

> **Note**: This lab, by default, requires total of 8 vCPUs available in the Standard_Dsv3 series in the region you choose for deployment, since it involves deployment of four Azure VMs of Standard_D2s_v3 SKU. If your students are using trial accounts, with the limit of 4 vCPUs, you can use a VM size that requires only one vCPU (such as Standard_B1s). 

**Scenario & Objectives**

In this lab, you will:

1. Provision the lab environment

2. Configure the hub and spoke network topology

3. Test transitivity of virtual network peering

4. Configure routing in the hub and spoke topology

5. Implement Azure Load Balancer

6. Implement Azure Application Gateway

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the Azure Console.

## Pre-Requisites

* Azure fundamentals

* An Azure account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

Note: Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch

## Provision the lab environment

In this task, you will deploy four virtual machines into the same Azure region. The first two will reside in a hub virtual network, while each of the remaining to will reside in a separate spoke virtual network.

1. Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

**Azure Location:** {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

3. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-92.PNG?st=2020-10-19T07%3A05%3A25Z&se=2025-10-20T07%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YSdhRYMEkyfvKP6jtQEw41W79PJaLj6Qd2fKIa9s58w%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-93.PNG?st=2020-10-19T07%3A07%3A00Z&se=2025-10-20T07%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wZvqq68LNNJpsMOeuq4ijdda3nV%2BlO%2FSfK4XZ8iLUiA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-94.PNG?st=2020-10-19T07%3A08%3A26Z&se=2025-10-20T07%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=D4VbST66SILI37da3QsmOa2AHaQ22whHtYdKvf9NnNs%3D)

> **Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

4. In the toolbar of the Cloud Shell pane, Run the below commands to Download the files.

`curl "https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Templates/Implement%20Traffic%20Management/az104-06-vms-template.json?st=2020-10-19T07%3A38%3A09Z&se=2025-10-20T07%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=U2TWA7yQWX3eI8YnW77lGpUHmiF8ZS4w%2F8sIkV%2Bt11k%3D" -o z104-06-vms-template.json`

`curl "https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Templates/Implement%20Traffic%20Management/az104-06-vm-template.json?st=2020-10-19T07%3A43%3A48Z&se=2025-10-20T07%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=571uUkEFl0I%2FIgqHlo%2FrW7xJ1eZbA3CIhVwh%2BG5x%2F2A%3D" -o az104-06-vm-template.json`

`curl "https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Templates/Implement%20Traffic%20Management/az104-06-vm-parameters.json?st=2020-10-19T07%3A45%3A09Z&se=2025-10-20T07%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=I6xx52g%2Bam8jMS5I8BaFN1cBb6F2XKeJraHkKEyNJGk%3D" -o az104-06-vm-parameters.json`

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-96.PNG?st=2020-10-19T07%3A13%3A23Z&se=2025-10-20T07%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wBN1OhGl1ZYqGDFO13JjKnUqf2vLdb136l9xVsm1Wk8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-97.PNG?st=2020-10-19T07%3A14%3A53Z&se=2025-10-20T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3HMZwGqL9xxFdyACNgwYrZRsgRRjZcvboawZbShKI9A%3D)

5. From the Cloud Shell pane, run the following to create the first resource group that will be hosting the first virtual network and the pair of virtual machines (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy Azure virtual machines)(you can use the "(Get-AzLocation).Location" cmdlet to get the region list):

   ```pwsh
   $location = '[Azure_region]'

   $rgName = 'az104-06-rg1'

   New-AzResourceGroup -Name $rgName -Location $location
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-95.PNG?st=2020-10-19T07%3A11%3A03Z&se=2025-10-20T07%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VkP7aqfkhTQLUildzpv7SvF7KmO9wCoa5EA7T%2FZal4s%3D)
   
6. From the Cloud Shell pane, run the following to create the first virtual network and deploy a pair of virtual machines into it by using the template and parameter files you uploaded:

   ```pwsh
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-06-vms-template.json `
      -TemplateParameterFile $HOME/az104-06-vm-parameters.json `
      -AsJob
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-98.PNG?st=2020-10-19T07%3A16%3A07Z&se=2025-10-20T07%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fG3JFcqlmIhrZs5%2FdDhyG6LHZefSWGfdjbJ5bVsAJyc%3D)

7. From the Cloud Shell pane, run the following to create the second resource group that will be hosting the second virtual network and the third virtual machine

   ```pwsh
   $rgName = 'az104-06-rg2'

   New-AzResourceGroup -Name $rgName -Location $location
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-99.PNG?st=2020-10-19T07%3A18%3A08Z&se=2025-10-20T07%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TQJPIeL%2FJ3MJYGjGHMXuk5ocHEFXJQt5d0uIzmc9Yzw%3D)
   
8. From the Cloud Shell pane, run the following to create the second virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```pwsh
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-06-vm-template.json `
      -TemplateParameterFile $HOME/az104-06-vm-parameters.json `
      -nameSuffix 2 `
      -AsJob
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-100.PNG?st=2020-10-19T07%3A19%3A42Z&se=2025-10-20T07%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VIWolcuj5sDsNUBoFcgvZFp6QKn1XJegDq7aKVB%2Fcv4%3D)
   
9. From the Cloud Shell pane, run the following to create the third resource group that will be hosting the third virtual network and the fourth virtual machine:

   ```pwsh
   $rgName = 'az104-06-rg3'

   New-AzResourceGroup -Name $rgName -Location $location
   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-101.PNG?st=2020-10-19T07%3A20%3A47Z&se=2025-10-20T07%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BMc%2Bdd0UerWeQRVMAXzOuHGWVZSaohTNuRWnO0PbjU0%3D)
   
10. From the Cloud Shell pane, run the following to create the third virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```pwsh
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-06-vm-template.json `
      -TemplateParameterFile $HOME/az104-06-vm-parameters.json `
      -nameSuffix 3 `
      -AsJob
   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-102.PNG?st=2020-10-19T07%3A22%3A15Z&se=2025-10-20T07%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZQzUPtd8rIU836SX2%2BwlzOY9vD6BN56zc63iDtKqpBs%3D)
      
> **Note**: Wait for the deployments to complete before proceeding to the next task. This should take about 5 minutes.

>**Note**: To verify the status of the deployments, you can examine the properties of the resource groups you created in this task.

11. Close the Cloud Shell pane.

## Configure the hub and spoke network topology

In this task, you will configure local peering between the virtual networks you deployed in the previous tasks in order to create a hub and spoke network topology.

1. In the Azure portal, search for and select **Virtual networks**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-103.PNG?st=2020-10-19T07%3A23%3A07Z&se=2025-10-20T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yfWMWXFtYnNQS9gOr5olltxrFVrl02QvFQZsD51AEqg%3D)

2. Review the virtual networks you created in the previous task. 

> **Note**: The template you used for deployment of the three virtual networks ensures that the IP address ranges of the three virtual networks do not overlap.

3. In the list of virtual networks, click **az104-06-vnet01**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/powershell-104.PNG?st=2020-10-19T07%3A24%3A25Z&se=2025-10-20T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fHrGqvE%2FDozBejNMeLBpu7KUwiZt%2BK%2BneaCc3CSVXfQ%3D)

4. On the **az104-06-vnet01** virtual network blade, in the **Settings** section, click **Peerings** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-1.PNG?st=2020-10-14T11%3A45%3A48Z&se=2025-10-15T11%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OK79pPAVfEuFsL2hE33CsXY9%2BnhEo8AWCivYCmszLV0%3D)

5. Add a peering with the following settings (leave others with their default values):

   **Settings**
    
    * Name of the peering from az104-06-vnet01 to remote virtual network: **az104-06-vnet01_to_az104-06-vnet2**
    
    * Virtual network deployment model:  **Resource manager** 
    
    * Subscription:  the name of the Azure subscription you are using in this lab
    
    * Virtual network:  **az104-06-vnet2 (az104-06-rg2)**
    
    * Name of the peering from az104-06-vnet2 to az104-06-vnet01:  **az104-06-vnet2_to_az104-06-vnet01** 
    
    * Allow virtual network access from az104-06-vnet01 to az104-06-vnet2:  **Enabled**
   
    * Allow virtual network access from az104-06-vnet2 to az104-06-vnet01:  **Enabled**
   
    * Allow forwarded traffic from az104-06-vnet2 to az104-06-vnet01:  **Disabled**
   
    * Allow forwarded traffic from az104-06-vnet01 to az104-06-vnet2:  **Enabled**
   
    * Allow gateway transit:  **(Uncheck Box)** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-2.PNG?st=2020-10-14T11%3A48%3A33Z&se=2025-10-15T11%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eNcwyr4M67Tlxp84gke97PLjmFaBCdUPBUS8oOfLXx0%3D)
  
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-3.PNG?st=2020-10-14T11%3A49%3A31Z&se=2025-10-15T11%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aaTGalYULFlEnstNypfCdvU58m4EqkEYbiuhmgp2Xu0%3D)

> **Note**: Wait for the operation to complete.

> **Note**: This step establishes two local peerings - one from az104-06-vnet01 to az104-06-vnet2 and the other from az104-06-vnet2 to az104-06-vnet01.

> **Note**: **Allow forwarded traffic** needs to be enabled in order to facilitate routing between spoke virtual networks, which you will implement later in this lab.
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-4.PNG?st=2020-10-14T11%3A50%3A16Z&se=2025-10-15T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7grZX8yy%2BIE%2FiFrgt%2B3tc1VIxb%2F7pmN0vVF7lyae%2Bk8%3D)

6. On the **az104-06-vnet01** virtual network blade, in the **Settings** section, click **Peerings** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-5.PNG?st=2020-10-14T11%3A53%3A59Z&se=2025-10-15T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fJ4ISEWpRJlRx%2FZTENkuCp1mBvMuF9NmSHrIGISHV6U%3D)

7. Add a peering with the following settings (leave others with their default values):

    **Settings**
    
     * Name of the peering from az104-06-vnet01 to remote virtual network: **az104-06-vnet01_to_az104-06-vnet3**
   
     * Virtual network deployment model: **Resource manager**
   
     * Subscription: the name of the Azure subscription you are using in this lab
   
     * Virtual network: **az104-06-vnet3 (az104-06-rg3)** 
   
     * Name of the peering from az104-06-vnet3 to az104-06-vnet01: **az104-06-vnet3_to_az104-06-vnet01** 
   
     * Allow virtual network access from az104-06-vnet01 to az104-06-vnet3: **Enabled**
   
     * Allow virtual network access from az104-06-vnet3 to az104-06-vnet01: **Enabled**
   
     * Allow forwarded traffic from az104-06-vnet3 to az104-06-vnet01: **Disabled** 
   
     * Allow forwarded traffic from az104-06-vnet01 to az104-06-vnet3: **Enabled** 
   
     * Allow gateway transit: **(Uncheck Box)**
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-6.PNG?st=2020-10-14T11%3A54%3A35Z&se=2025-10-15T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=glS7qs3q1QnZMmgpGqyJfrmpACvQuAG1apx%2F3sb3Sm4%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-7.PNG?st=2020-10-14T11%3A55%3A24Z&se=2025-10-15T11%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Ef%2BDBLS7BPDY76m3EIz2sg0KgyTvwlBr6Vi8TeIWkTM%3D)

> **Note**: This step establishes two local peerings - one from az104-06-vnet01 to az104-06-vnet3 and the other from az104-06-vnet3 to az104-06-vnet01. This completes setting up the hub and spoke topology (with two spoke virtual networks).

> **Note**: **Allow forwarded traffic** needs to be enabled in order to facilitate routing between spoke virtual networks, which you will implement later in this lab.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-8.PNG?st=2020-10-14T11%3A56%3A03Z&se=2025-10-15T11%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sW2sd3jvIHzKFsWQa648n4KxDumyhQzvcf9UdNSAB84%3D)

## Test transitivity of virtual network peering

In this task, you will test transitivity of virtual network peering by using Network Watcher.

1. In the Azure portal, search for and select **Network Watcher**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-10.PNG?st=2020-10-14T12%3A04%3A56Z&se=2025-10-15T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yLNJf23pbLGBV%2BCTTVMAfogRVkovLlTK4ZtxFRp5hlg%3D)

2. On the **Network Watcher** blade, expand the listing of Azure regions and verify that the service is enabled in the Azure into which you deployed resources in the first task of this lab.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-11.PNG?st=2020-10-14T12%3A05%3A28Z&se=2025-10-15T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aTPzc4dPpAiirgMYval1YFElesenXbTdg%2FkZNeoRLFQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-12.PNG?st=2020-10-14T12%3A06%3A30Z&se=2025-10-15T12%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GZuAEGklrVwb5SrSz5vzzXg9ngn%2BRnNnaqJRlgsWpxU%3D)

3. On the **Network Watcher** blade, navigate to the **Connection troubleshoot**.

4. On the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings (leave others with their default values):

    **Settings** 
 
    * Subscription: the name of the Azure subscription you are using in this lab
    
    * Resource group: **az104-06-rg1** 
    
    * Source type: **Virtual machine** 
    
    * Virtual machine: **az104-06-vm0**
    
    * Destination: **Specify manually**
    
    * URI, FQDN or IPv4:  **10.62.0.4**
    
    * Protocol: **TCP**
    
    * Destination Port:  **3389**
    
 5. Click **Check** and wait until results of the connectivity check are returned. Verify that the status is **Reachable**. Review the network path and note that the connection was direct, with no intermediate hops in between the VMs.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-13.PNG?st=2020-10-14T12%3A07%3A52Z&se=2025-10-15T12%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aMlsGbAd0IBHyR1KWrLQSj8ZiEAOopuVYoHyjlKfGUI%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/deploy1-14.PNG?st=2020-10-14T12%3A08%3A34Z&se=2025-10-15T12%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZRYL2A%2FZx4Q8u7BzHK5dKx90sQx5nJPc5UcV8xc7nJM%3D)

> **Note**: **10.62.0.4** represents the private IP address of **az104-06-vm2**

> **Note**: This is expected, since the hub virtual network is peered directly with the first spoke virtual network.

> **Note**: The initial check can take about 2 minutes because it requires installation of the Network Watcher Agent virtual machine extension on **az104-06-vm0**.

6. On the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings (leave others with their default values):

    **Settings**
    
   * Subscription:  the name of the Azure subscription you are using in this lab 
   
   * Resource group:  **az104-06-rg1** 
   
   * Source type:  **Virtual machine** 
   
   * Virtual machine: **az104-06-vm0** 
   
   * Destination: **Specify manually** 
   
   * URI, FQDN or IPv4: **10.63.0.4** 
   
   * Protocol: **TCP** 
   
   * Destination Port:  **3389** 

> **Note**: **10.63.0.4** represents the private IP address of **az104-06-vm3**
    
 7. Click **Check** and wait until results of the connectivity check are returned. Verify that the status is **Reachable**. Review the network path and note that the connection was direct, with no intermediate hops in between the VMs.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/watcher2-15.PNG?st=2020-10-14T12%3A10%3A45Z&se=2025-10-15T12%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DEwx1HYLc5whNLtEkbrgpMTf9QoS8AGrJFkhikvY7to%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/watcher2-16.PNG?st=2020-10-14T12%3A11%3A57Z&se=2025-10-15T12%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4gm3m6r%2FQw8bkiVocjVkrXfokpTtQECafdRs5H34EDk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/watcher2-17.PNG?st=2020-10-14T12%3A12%3A40Z&se=2025-10-15T12%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CQIeHxky3NghrfNdJG2yfc5iuu2JYwArQMcESIUmhnQ%3D)

> **Note**: This is expected, since the hub virtual network is peered directly with the second spoke virtual network.

8. On the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings (leave others with their default values):

    **Settings**
    
    * Subscription: the name of the Azure subscription you are using in this lab 
    
    * Resource group: **az104-06-rg2** 
    
    * Source type: **Virtual machine**
    
    * Virtual machine: **az104-06-vm2**
    
    * Destination: **Specify manually**
    
    * URI, FQDN or IPv4: **10.63.0.4**
    
    * Protocol: **TCP** 
    
    * Destination Port: **3389** 
    
 9. Click **Check** and wait until results of the connectivity check are returned. Note that the status is **Unreachable**.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/watcher3-18.PNG?st=2020-10-14T12%3A14%3A40Z&se=2025-10-15T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JVK8qWPJ8rIFnkHFD9QqvlvzBHUKWNc2FEFRPXs%2BI7I%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/watcher3-19.PNG?st=2020-10-14T12%3A15%3A08Z&se=2025-10-15T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BXpFE7WqOFgYhup5gXh2pWtV%2BX3po%2F%2BHGWX%2Fs8xqU80%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/watcher3-20.PNG?st=2020-10-14T12%3A15%3A45Z&se=2025-10-15T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HXmhCPCSbrsAnkN9vHF8bCcAFWeLvuKDd1tPQuQVA2I%3D)

> **Note**: This is expected, since the two spoke virtual networks are not peered with each other (virtual network peering is not transitive).

## Configure routing in the hub and spoke topology

In this task, you will configure and test routing between the two spoke virtual networks by enabling IP forwarding on the network interface of the **az104-06-vm0** virtual machine, enabling routing within its operating system, and configuring user-defined routes on the spoke virtual network.

1. In the Azure portal, search and select **Virtual machines**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-21.PNG?st=2020-10-14T12%3A18%3A05Z&se=2025-10-15T12%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VT1WmuwYydHe%2F%2BPXW4bmoynlt3sfAd%2FdRon6XQnoIhM%3D)

2. On the **Virtual machines** blade, in the list of virtual machines, click **az104-06-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-22.PNG?st=2020-10-14T12%3A19%3A03Z&se=2025-10-15T12%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BlPe0XY5l%2FRdxAyZTLdU6yPp77pYxOvHBnzXR3FtMrs%3D)

3. On the **az104-06-vm0** virtual machine blade, in the **Settings** section, click **Networking**.

4. Click the **az104-06-nic0** link next to the **Network interface** label, and then, on the **az104-06-nic0** network interface blade, in the **Settings** section, click **IP configurations**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-22.PNG?st=2020-10-14T12%3A19%3A03Z&se=2025-10-15T12%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BlPe0XY5l%2FRdxAyZTLdU6yPp77pYxOvHBnzXR3FtMrs%3D)

5. Set **IP forwarding** to **Enabled** and save the change. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-24.PNG?st=2020-10-14T12%3A21%3A52Z&se=2025-10-15T12%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FZRh0xNuCipKv7lFkZRU9X1SJaGQb4unj0URU8NmR5o%3D)

> **Note**: This setting is required in order for **az104-06-vm0** to function as a router, which will route traffic between two spoke virtual networks.

> **Note**: Now you need to configure operating system of the **az104-06-vm0** virtual machine to support routing.

6. In the Azure portal, navigate back to the **az104-06-vm0** Azure virtual machine blade and click **Overview**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-25.PNG?st=2020-10-14T12%3A22%3A58Z&se=2025-10-15T12%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZRrH4heZ0fVuhUg8n%2Bm4kT451KpHzbze5tl9960lrpc%3D)

7. On the **az104-06-vm0** blade, in the **Operations** section, click **Run command**, and, in the list of commands, click **RunPowerShellScript**.
8. On the **Run Command Script** blade, type the following and click **Run** to install the Remote Access Windows Server role.

   ```pwsh
   Install-WindowsFeature RemoteAccess -IncludeManagementTools
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-26.PNG?st=2020-10-14T12%3A24%3A08Z&se=2025-10-15T12%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mwm%2FCH79T1ji4VDxfh1tfRCw7MPrQSPe%2F61dny0AR7w%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-27.PNG?st=2020-10-14T12%3A25%3A00Z&se=2025-10-15T12%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gd9nW5aG8lqwoliBPyMWAXOmUZCfK%2F9imLuTdgG2Qps%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-28.PNG?st=2020-10-14T12%3A25%3A58Z&se=2025-10-15T12%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9oAdmQF7OD%2Bas3i1JQzE7dr1bsJFLF%2F9DfpGnhObZ%2Fg%3D)

> **Note**: Wait for the confirmation that the command completed successfully.

9. On the **Run Command Script** blade, type the following and click **Run** to install the Routing role service.

   ```pwsh
   Install-WindowsFeature -Name Routing -IncludeManagementTools -IncludeAllSubFeature

   Install-WindowsFeature -Name "RSAT-RemoteAccess-Powershell"

   Install-RemoteAccess -VpnType RoutingOnly

   Get-NetAdapter | Set-NetIPInterface -Forwarding Enabled
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-29.PNG?st=2020-10-14T12%3A27%3A09Z&se=2025-10-15T12%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=50Xb%2FgLbo2yVM0dx2MEjbqTMxYoMORPz7HaezIx2tdU%3D)

> **Note**: Run all commands in *Run Command Script** blade.
   
> **Note**: Wait for the confirmation that the command completed successfully.

> **Note**: Now you need to create and configure user defined routes on the spoke virtual networks.

10. In the Azure portal, search and select **Route tables** and, on the **Route tables** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-30.PNG?st=2020-10-14T12%3A27%3A50Z&se=2025-10-15T12%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iD%2BxTu52uM9NbyUhvBg4Zaj1aLV2n%2F%2FouBaz1x%2FvrGg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-31.PNG?st=2020-10-14T12%3A31%3A12Z&se=2025-10-15T12%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=j2gEa32sQT1m0Pjijf7wY%2FSIXOl12v3rZLYiijQm5JE%3D)

11. Create a route table with the following settings (leave others with their default values):

    **Settings**
    
    * Name: **az104-06-rt23**
    
    * Subscription: the name of the Azure subscription you are using in this lab
    
    * Resource group: **az104-06-rg2** 
    
    * Location: the name of the Azure region in which you created the virtual networks
    
    * Virtual network gateway route propagation: **Disabled** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-32.PNG?st=2020-10-14T12%3A32%3A02Z&se=2025-10-15T12%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=m14s%2FVfgz3N0nQMpdcmtykxHt1ReC2rPRKvGI8XJz%2BY%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-33.PNG?st=2020-10-14T12%3A32%3A28Z&se=2025-10-15T12%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=j5f0t1oSy8Dskd9kGN7PfMq%2BKUv5TFMyzSSmB%2BKVy3w%3D)

> **Note**: Wait for the route table to be created. This should take about 3 minutes.

12. Back on the **Route tables** blade, click **Refresh** and then click **az104-06-rt23**.

13. On the **az104-06-rt23** route table blade, click **Routes** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-34.PNG?st=2020-10-14T12%3A33%3A10Z&se=2025-10-15T12%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HmLZUUKxClV%2BvIRR2PEYOyU%2FG4DdSeIo%2Fnhhzbn1fpY%3D)

14. Add a new route with the following settings (leave others with their default values):

     **Settings**
    
      * Route name: **az104-06-route-vnet2-to-vnet3** 
    
      * Address prefix: **10.63.0.0/20** 
    
      * Next hop type: **Virtual appliance** 
    
      * Next hop address: **10.60.0.4** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-35.PNG?st=2020-10-14T12%3A34%3A16Z&se=2025-10-15T12%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ASp8wMoVOnF5TaT8bKFAq7NbjUa581NdzA4U1zcXp3U%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-36.PNG?st=2020-10-14T12%3A35%3A08Z&se=2025-10-15T12%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5W5VIiakSfI2KhudDR9baHGTsvevQlHmqSlB8ajQfBw%3D)

15. Back on the **az104-06-rt23** route table blade, click **Subnets** and then click **+ Associate**.

16. Associate the route table **az104-06-rt23** with the following subnet:

    **Settings**
    
    * Virtual network: **az104-06-vnet2**
    
    * Subnet: **subnet0** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-38.PNG?st=2020-10-14T12%3A36%3A10Z&se=2025-10-15T12%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Fjt5eMjFkbaFQ4MLKYOphrV4XuCmHkFxrH9NNT7pIsU%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route1-39.PNG?st=2020-10-14T12%3A37%3A01Z&se=2025-10-15T12%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DI%2FLNEExpGF4JxG5kjZMo7B6jC20loc%2BSSWc4VB%2FXxE%3D)

17. Navigate back to **Route tables** blade and click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-40.PNG?st=2020-10-14T12%3A37%3A28Z&se=2025-10-15T12%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0trlXZid3MpXyfR%2BrZmk75r3UrGUfU0RXsbeI4cXDaY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-41.PNG?st=2020-10-14T12%3A38%3A25Z&se=2025-10-15T12%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bzNCd4IVr18tk10eFYPOyPxLBqhHHUiRvzXG%2B6iOxxU%3D)

18. Create a route table with the following settings (leave others with their default values):

    **Settings**
   
     * Name: **az104-06-rt32** 
    
     * Subscription: the name of the Azure subscription you are using in this lab
    
     * Resource group: **az104-06-rg3** 
    
     * Location: the name of the Azure region in which you created the virtual networks 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-42.PNG?st=2020-10-14T12%3A40%3A16Z&se=2025-10-15T12%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eQoLOtvsxbeT1kQcmrF1cQ5Xrq%2BvDbBP4tROmbEo%2Bg4%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-43.PNG?st=2020-10-14T12%3A40%3A43Z&se=2025-10-15T12%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PT2o%2F80nN8FB0ZFfnPh%2Bfe2NQXriOxugD6XsK0VfV%2FU%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-44.PNG?st=2020-10-14T12%3A41%3A39Z&se=2025-10-15T12%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fmTsQPKB05ZofFSjFAZxjVoWeHafAoBnZCDi7blECu0%3D)

> **Note**: Wait for the route table to be created. This should take about 3 minutes.

19. Back on the **Route tables** blade, click **Refresh** and then click **az104-06-rt32**.

20. On the **az104-06-rt32** route table blade, click **Routes** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-45.PNG?st=2020-10-14T12%3A43%3A01Z&se=2025-10-15T12%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jwUZBiyprevqjwXVeIzkOMtiqPIl9hoe3zY5e7Uhz9w%3D)

21. Add a new route with the following settings (leave others with their default values):

    **Settings**
    
      * Route name: **az104-06-route-vnet3-to-vnet2** 
      * Address prefix: **10.62.0.0/20** 
      * Next hop type: **Virtual appliance** 
      * Next hop address: **10.60.0.4** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-46.PNG?st=2020-10-14T12%3A44%3A12Z&se=2025-10-15T12%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uR5jXHH5Zi%2BmmARNvVuPdSFRWJufzvCqgAefhXMZl5U%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-47.PNG?st=2020-10-14T12%3A45%3A08Z&se=2025-10-15T12%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mqxu2yRr3FsAcfK2R2rkX058jtS0oWt6fVQBSyn2Afc%3D)

22. Back on the **az104-06-rt32** route table blade, click **Subnets** and then click **+ Associate**.

23. Associate the route table **az104-06-rt32** with the following subnet:

    **Settings**
    
     * Virtual network: **az104-06-vnet3** 
   
     * Subnet: **subnet0** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-49.PNG?st=2020-10-14T12%3A45%3A47Z&se=2025-10-15T12%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mlUHUYvOvozzeltTIOwIkbTM9KNWd2UzjFvD5Upa8x4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-50.PNG?st=2020-10-14T12%3A46%3A37Z&se=2025-10-15T12%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fZszbl93Ufxs8yGGtQfom8OO6x4Yav2eU2Mfb0BA4fk%3D)

24. In the Azure portal, navigate back to the **Network Watcher - Connection troubleshoot** blade.

25. On the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings (leave others with their default values):

    **Setting**
    
     * Subscription: the name of the Azure subscription you are using in this lab
   
     * Resource group: **az104-06-rg2** 
   
    * Source type: **Virtual machine**
   
    * Virtual machine: **az104-06-vm2** 
   
    * Destination: **Specify manually**
   
    * URI, FQDN or IPv4: **10.63.0.4**
   
    * Protocol: **TCP**
   
    * Destination Port: **3389** 
    
26. Click **Check** and wait until results of the connectivity check are returned. Verify that the status is **Reachable**. Review the network path and note that the traffic was routed via **10.60.0.4**, assigned to the **az104-06-nic0** network adapter. If status is **Unreachable**, you should restart az104-06-vm0.    
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-51.PNG?st=2020-10-14T12%3A47%3A42Z&se=2025-10-15T12%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=40VW%2FVKAYOAjB2tZyJRJAwZmjkvNITUVpFlZgpd7sMU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-52.PNG?st=2020-10-14T12%3A48%3A29Z&se=2025-10-15T12%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WvAHT8gp99vAqMmueIIgZWGTTzpT1FAidK0bEIurwxA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/route2-53.PNG?st=2020-10-14T12%3A49%3A07Z&se=2025-10-15T12%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=29%2Fjgx7dBf7exkNpFDyTwsxAadqLgR7TjgYseKlSCqE%3D)

> **Note**: This is expected, since the traffic between spoke virtual networks is now routed via the virtual machine located in the hub virtual network, which functions as a router. 

> **Note**: You can use **Network Watcher** to view topology of the network.

## Implement Azure Load Balancer

In this task, you will implement an Azure Load Balancer in front of the two Azure virtual machines in the hub virtual network

1. In the Azure portal, search and select **Load balancers** and, on the **Load balancers** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-54.PNG?st=2020-10-14T16%3A09%3A02Z&se=2025-10-15T16%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RXLclefdc2UPbIDxWETjjjBv%2FNRstq2UEpssFD1UFhA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-55.PNG?st=2020-10-14T16%3A10%3A40Z&se=2025-10-15T16%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jPvu6WfM8zTfoqPpGRflwVURuQI3U8cBIDZfqT6Z1t8%3D)

2. Create a load balancer with the following settings (leave others with their default values):

    **Settings**
    
   * Subscription: the name of the Azure subscription you are using in this lab
   
   * Resource group: the name of a new resource group **az104-06-rg4** 
   
   * Name: **az104-06-lb4** 
   
   * Region: name of the Azure region into which you deployed all other resources in this lab 
   
   * Type : **Public** 
   
   * SKU: **Standard** 
   
   * Public IP address: **Create new** 
   
   * Public IP address name: **az104-06-pip4** 
   
   * Availability zone: **Zone-redundant** 
   
   * Add a public IPv6 address: **No** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-56.PNG?st=2020-10-14T16%3A11%3A25Z&se=2025-10-15T16%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ws%2FiMmB4TNi0NU1JJeUZj1LnVj9Asm2thr87%2FT6JpbY%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-57.PNG?st=2020-10-14T16%3A20%3A56Z&se=2025-10-15T16%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=I9NKIgpsMQ69VA1XdwUQxalectYteXO1yYGy5IPf7%2Fo%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-58.PNG?st=2020-10-14T16%3A22%3A43Z&se=2025-10-15T16%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=up76A6OFkedlfbQ3sqyB%2F5wU8tu35daWiH0nwguZT%2Bs%3D)

> **Note**: Wait for the Azure load balancer to be provisioned. This should take about 2 minutes. 

3. On the deployment blade, click **Go to resource**.

4. On the **az104-06-lb4** load balancer blade, click **Backend pools** and click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-59.PNG?st=2020-10-14T16%3A25%3A40Z&se=2025-10-15T16%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xUvLi79iUnouj2k196jlZT%2Bjz1fJIlMYH1nxoMQTx2c%3D)

5. Add a backend pool with the following settings (leave others with their default values):

    **Settings**
   
   * Name: **az104-06-lb4-be1** 
   
   * Virtual network: **az104-06-vnet01**
   
   * IP version:  **IPv4**
   
   * Virtual machine: **az104-06-vm0** 
   
   * Virtual machine IP address: **ipconfig1 (10.60.0.4)**
   
   * Virtual machine: **az104-06-vm1** 
   
   * Virtual machine IP address: **ipconfig1 (10.60.1.4)** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-60.PNG?st=2020-10-14T16%3A27%3A13Z&se=2025-10-15T16%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=c1xIQAihAP2fufIdncrenv%2FBJrRkV%2FpQQdE2B5Nu87E%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-61.PNG?st=2020-10-14T16%3A28%3A32Z&se=2025-10-15T16%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aZ7FzjnZn%2ByRSSnn8wkCbW8yVZHWZJAEpadOFE9m3%2B0%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-62.PNG?st=2020-10-14T16%3A29%3A18Z&se=2025-10-15T16%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SvBApzBFW17Qy0gs%2FnCpToW9iK53dYR%2B0xw5%2BVwEky8%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-63.PNG?st=2020-10-14T16%3A30%3A04Z&se=2025-10-15T16%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BdKkVYapPEfswAHxpth%2FupRikBchummTKlyLXeG6bE8%3D)

6. Wait for the backend pool to be created, click **Health probes**, and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-64.PNG?st=2020-10-14T16%3A30%3A56Z&se=2025-10-15T16%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YGs2IjFs%2F8P9LR3JFsQ%2F9x9Apj4tv7t72Qsu6gP%2B7LU%3D)

7. Add a health probe with the following settings (leave others with their default values):

    **Settings**
    
   * Name: **az104-06-lb4-hp1** 
   
   * Protocol: **TCP** 
   
   * Port: **80**
   
   * Interval: **5** 
   
   * Unhealthy threshold: **2** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-65.PNG?st=2020-10-14T16%3A32%3A11Z&se=2025-10-15T16%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UG0r2GEeBAqkv4y0E5HHxePxCV1j7qM8c5gBcquj%2BuU%3D)

8. Wait for the health probe to be created, click **Load balancing rules**, and then click **+ Add**.

9. Add a load balancing rule with the following settings (leave others with their default values):

    **Settings**
    
   *  Name: **az104-06-lb4-lbrule1**
   
   * IP Version: **IPv4** 
    
   * Protocol: **TCP** 
   
   * Port: **80** 
   
   * Backend port: **80**
   
   * Backend pool: **az104-06-lb4-be1**
   
   * Health probe: **az104-06-lb4-hp1**
   
   * Session persistence: **None** 
   
   * Idle timeout (minutes): **4** 
   
   * TCP reset: **Disabled** 
   
   * Floating IP (direct server return): **Disabled** 
   
   * Outbound and inbound use the same IP. SNAT port exhaustion may occur: **Yes**
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-66.PNG?st=2020-10-14T16%3A33%3A46Z&se=2025-10-15T16%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NJOzy%2FjRDo19PYym9egkvw0zy7EupHao%2B2d45KJrx34%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-67.PNG?st=2020-10-14T16%3A34%3A58Z&se=2025-10-15T16%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oqwns0dzJC9rbVblS8EQ06KkOgx3YlXrolvQuYxWhc4%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-68.PNG?st=2020-10-14T16%3A35%3A31Z&se=2025-10-15T16%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=N1eU34B0Q0ZZLbFo6sG7ku8iTkgCxQTvAGIEKKn3qi8%3D)

10. Wait for the load balancing rule to be created, click **Overview**, and note the value of the **Public IP address**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-69.PNG?st=2020-10-14T16%3A36%3A00Z&se=2025-10-15T16%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nDvMPjmB3OjUbENiGgyNcT%2BY2U%2B3Ej2Xeuyh9LhBlLs%3D)

11. Start another browser window and navigate to the IP address you identified in the previous step.

12. Verify that the browser window displays the message **Hello World from az104-06-vm0** or **Hello World from az104-06-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-70.PNG?st=2020-10-14T16%3A36%3A45Z&se=2025-10-15T16%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i6sib6j9XCsKfB7MX%2FiDTf0CIEU6vw7%2BUFiGM2e8gwM%3D)

13. Open another browser window but this time by using InPrivate mode and verify whether the target vm changes (as indicated by the message). 

> **Note**: You might need to refresh the browser window or open it again by using InPrivate mode.

## Implement Azure Application Gateway

In this task, you will implement an Azure Application Gateway in front of the two Azure virtual machines in the spoke virtual networks.

1. In the Azure portal, search and select **Virtual networks**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-71.PNG?st=2020-10-16T03%3A30%3A39Z&se=2025-10-17T03%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xvO79gZwS%2FEJ6smytCyDb50I0FWhhnHWmtWe6%2BGdOCs%3D)

2. On the **Virtual networks** blade, in the list of virtual networks, click **az104-06-vnet01**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-72.PNG?st=2020-10-16T03%3A31%3A28Z&se=2025-10-17T03%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4UhGGZQKlJJEdW7Mx8mq1%2Fu1TeHJcrtzGAyqhnGGTBU%3D)

3. On the  **az104-06-vnet01** virtual network blade, in the **Settings** section, click **Subnets**, and then click **+ Subnet**.

4. Add a subnet with the following settings (leave others with their default values):

    **Settings**
    
    * Name: **subnet-appgw**
    
    * Address range (CIDR block): **10.60.3.224/27** 
    
    * Network security group: **None** 
    
   *  Route table: **None** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-73.PNG?st=2020-10-16T03%3A32%3A47Z&se=2025-10-17T03%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZVcMGLn3BbZtQ9B0%2BQ%2FrVl5SjgEo5B0Qpaku6%2FDie2o%3D)
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/loadbal-74.PNG?st=2020-10-16T03%3A33%3A24Z&se=2025-10-17T03%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HwHyv7UFaiPINmmsSMMDKE4Omr4UdvUdvgZ%2FCL6wI9U%3D)

> **Note**: This subnet will be used by the Azure Application Gateway instances, which you will deploy later in this task. The Application Gateway requires a dedicated subnet of /27 or larger size.

5. In the Azure portal, search and select **Application Gateways** and, on the **Application Gateways** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-75.PNG?st=2020-10-16T03%3A34%3A12Z&se=2025-10-17T03%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lcHOxC0u1fFg2n9%2BfhTjAqVlvy%2FEpMPs%2F24OwxhDdxE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-76.PNG?st=2020-10-16T03%3A35%3A38Z&se=2025-10-17T03%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=G%2BeHiHQ0nwY3kdCWU%2FWfsPog6%2BpdFOQsqA%2F8cOww84o%3D)

6. On the **Basics** tab of the **Create an application gateway** blade, specify the following settings (leave others with their default values):

    **Settings**
    
   * Subscription: the name of the Azure subscription you are using in this lab 
   
   * Resource group: the name of a new resource group **az104-06-rg5**
   
   * Application gateway name: **az104-06-appgw5**
   
   * Region: name of the Azure region into which you deployed all other resources in this lab
   
   * Tier: **Standard V2** 
   
   * Enable autoscaling: **No**
   
   * Scale units: **1** 
   
   * Availability zone:  **1, 2, 3**
   
   * HTTP2: **Disabled** 
   
   * Virtual network: **az104-06-vnet01**
   
   * Subnet: **subnet-appgw** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-77.PNG?st=2020-10-16T03%3A36%3A11Z&se=2025-10-17T03%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q1WO0coCJk0hQsVrViC5IR1c8o%2FNo3uevjGN7hsOxlM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-78.PNG?st=2020-10-16T03%3A36%3A50Z&se=2025-10-17T03%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zsZWeAMy5L%2BFrb77ZxjH3BTk5iOfgXaIQ1oFEqxtB0k%3D)

7. Click **Next: Frontends >** and, on the **Frontends** tab of the **Create an application gateway** blade, specify the following settings (leave others with their default values):

    **Settings**
    
   * Frontend IP address type: **Public** 
   
   * Firewall public IP address: the name of a new public ip address **az104-06-pip5** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-79.PNG?st=2020-10-16T03%3A37%3A59Z&se=2025-10-17T03%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CPNOCPi30V9iwnAmO8p7S9gZBnuW%2BXKg%2BUgYBdPfIEI%3D)

8. Click **Next: Backends >**, on the **Backends** tab of the **Create an application gateway** blade, click **Add a backend pool**, and, on the **Add a backend pool** blade, specify the following settings (leave others with their default values):

    **Settings**
    
   * Name: **az104-06-appgw5-be1** 
   
   * Add backend pool without targets: **No**
   
   * Target type: **IP address or FQDN** 
   
   * Target: **10.62.0.4** 
   
   * Target type: **IP address or FQDN**
   
   * Target: **10.63.0.4**

> **Note**: The targets represent the private IP addresses of virtual machines in the spoke virtual networks **az104-06-vm2** and **az104-06-vm3**.
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-80.PNG?st=2020-10-16T03%3A38%3A52Z&se=2025-10-17T03%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UydsH9IlG5GofXLOgSJXwBvQZcgVJ0dM2LiMIyNrQMg%3D)
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-81.PNG?st=2020-10-16T03%3A39%3A35Z&se=2025-10-17T03%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gjG%2Btv22TtcnMjV8MOHtkKAijdpIl5z6nQ8lU2K6Y5E%3D)

9. Click **Add**, click **Next: Configuration >** and, on the **Configuration** tab of the **Create an application gateway** blade, click **+ Add a routing rule**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-82.PNG?st=2020-10-16T03%3A41%3A05Z&se=2025-10-17T03%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rp11QTmmae235furjb4E8ChaVdeJK6XXUbyTogaHeko%3D)

10. On the **Add a routing rule** blade, on the **Listener** tab, specify the following settings (leave others with their default values):

    **Settings**
    
   * Rule name: **az104-06-appgw5-rl1** 
   
   * Listener name: **az104-06-appgw5-rl1l1**
   
   * Frontend IP: **Public** 
   
   * Protocol: **HTTP**
   
   * Port: **80**
   
   * Listener type: **Basic** 
   
   * Error page url: **No** 
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-83.PNG?st=2020-10-16T03%3A41%3A43Z&se=2025-10-17T03%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XoaWhiOG2ErHFfmnYLfqfmshggL4CnoJnsnVtJh%2BwaQ%3D)

11. Switch to the **Backend targets** tab of the **Add a routing rule** blade and specify the following settings (leave others with their default values):

    **Settings**
    
    * Target type: **Backend pool** 
    
    * Backend target: **az104-06-appgw5-be1** 
    
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-84.PNG?st=2020-10-16T03%3A42%3A43Z&se=2025-10-17T03%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=M3OwPy%2BRC6PKaz1byKHWEYQFXkNhn%2FA6SSBu3K0sg%2FY%3D)

12. On the **Backend targets** tab of the **Add a routing rule** blade, click **Add new** next to the **HTTP setting** text box, and, on the **Add an HTTP setting** blade, specify the following settings (leave others with their default values):

    **Settings**
    
   *  HTTP setting name: **az104-06-appgw5-http1**
   
   * Backend protocol: **HTTP** 
   
   * Backend port: **80** 
   
   * Cookie-based affinity: **Disable**
   
   * Connection draining: **Disable** 
   
   * Request time-out (seconds) : **20** 

13. Click **Add** on the **Add an HTTP setting** blade, and back on the **Add a routing rule** blade, clik **Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-85.PNG?st=2020-10-16T03%3A43%3A55Z&se=2025-10-17T03%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0yRCeUMyXnMmMvBKdv5U7lYxue7LnLEkAhGeBI2p7p8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-86.PNG?st=2020-10-16T03%3A45%3A14Z&se=2025-10-17T03%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yeqLYRbnrsiMRgjVT2df2Np11%2B9QvxtNMAOuZwk2CNM%3D)

14. Click **Next: Tags >**, followed by **Next: Review + create >** and then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-87.PNG?st=2020-10-16T03%3A47%3A38Z&se=2025-10-17T03%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=o9SyVaPojLMoTeYQBbjphuxMnf2tw2QqNE%2FzgMeXtck%3D)

> **Note**: Wait for the Application Gateway instance to be created. This might take about 8 minutes.

15. In the Azure portal, search and select **Application Gateways** and, on the **Application Gateways** blade, click **az104-06-appgw5**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-88.PNG?st=2020-10-16T03%3A48%3A42Z&se=2025-10-17T03%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XTlQxAOCdrGxA4VK9JCtKJyJE7k%2BugHDJtHebEwX7Fo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-89.PNG?st=2020-10-16T03%3A49%3A47Z&se=2025-10-17T03%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FxxO8JXqamL4Obl0YBTouHnloJVDcS6VjQJegjG%2BSGs%3D)

16. On the **az104-06-appgw5** Application Gateway blade, note the value of the **Frontend public IP address**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-90.PNG?st=2020-10-16T03%3A50%3A33Z&se=2025-10-17T03%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=A92Z3HE5QggfVSlz%2FCUKHqEwpNGlEN6bxw4BybSlhsY%3D)

17. Start another browser window and navigate to the IP address you identified in the previous step.

18. Verify that the browser window displays the message **Hello World from az104-06-vm2** or **Hello World from az104-06-vm3**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Implement%20Traffic%20Management/Images/applgat-91.PNG?st=2020-10-16T03%3A51%3A27Z&se=2025-10-17T03%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q15%2BQLdZH27eD%2FInZ7JcbehV6VB%2BnciksDSzRwA34B0%3D)

19. Open another browser window but this time by using InPrivate mode and verify whether the target vm changes (based on the message displayed on the web page). 

> **Note**: You might need to refresh the browser window or open it again by using InPrivate mode.

> **Note**: Targeting virtual machines on multiple virtual networks is not a common configuration, but it is meant to illustrate the point that Application Gateway is capable of targeting virtual machines on multiple virtual networks (as well as endpoints in other Azure regions or even outside of Azure), unlike Azure Load Balancer, which load balances across virtual machines in the same virtual network.

## cleanup resources

> **Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. List all resource groups created throughout the labs of this module by running the following command:

   ```pwsh
   Get-AzResourceGroup -Name 'az104-06*'
   ```

3. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```pwsh
   Get-AzResourceGroup -Name 'az104-06*' | Remove-AzResourceGroup -Force -AsJob
   ```

> **Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

**Conclusion:** Congratulations! You have successfully completed the **Implement Traffic Management** lab. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab!
