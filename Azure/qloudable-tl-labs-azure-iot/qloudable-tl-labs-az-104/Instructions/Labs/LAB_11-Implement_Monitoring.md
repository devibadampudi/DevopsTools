# Implement Monitoring

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Provision the lab environment](#provision-the-lab-environment)

[Create and configure an Azure Log Analytics workspace and Azure Automation-based solutions](#create-and-configure-an-azure-log-analytics-workspace-and-azure-automation-based-solutions)

[Review default monitoring settings of Azure virtual machines](#review-default-monitoring-settings-of-azure-virtual-machines)

[Configure Azure virtual machine diagnostic settings](#configure-azure-virtual-machine-diagnostic-settings)

[Review Azure Monitor functionality](#review-azure-monitor-functionality)

[Review Azure Log Analytics functionality](#review-azure-log-analytics-functionality)

[Conclusion](#conclusion)
  
## Overview

The aim of this lab is to evaluate Azure functionality that would provide insight into performance and configuration of Azure resources, focusing in particular on Azure virtual machines.

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/monitoring.png?st=2020-09-28T14%3A08%3A55Z&se=2025-09-29T14%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4FJwUFXOy6nkUf%2Fv5rJjx8rrTELbvtraqSnY7FA88X4%3D)

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

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

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
If this is the first time you are starting Cloud Shell and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)


* **Resource group:** `{{resource-group-name}}` <br>

* **Storage Account Name:** `Create new Storage` <br>

* **File Share Name:** `Create new file share`


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a41.PNG?st=2019-09-18T04%3A58%3A12Z&se=2022-09-19T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zQJmfYNONwPRTvZ3mdfA6ZtkxKIjh%2FCTdGu9oNPOe%2FE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/21.png?st=2019-09-16T06%3A57%3A56Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JMFKFtYFry1nNVFUWtQOewXhh1ZDMSXBuR%2BXc4szLxk%3D)

4. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **az104-11-vm-template.json** and **az104-11-vm-parameters.json** into the Cloud Shell home directory.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/1.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/2.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

5. From the Cloud Shell pane, run the following to create the resource group that will be hosting the virtual machines (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy Azure virtual machines):

    > **Note**: Make sure to choose one of the regions listed as **Log Analytics Workspace Region** in the referenced in [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings)

$location = {{Location}}

$rgName = {{resource-group-name}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/3.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

6. From the Cloud Shell pane, run the following to create the first virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-11-vm-template.json `
      -TemplateParameterFile $HOME/az104-11-vm-parameters.json `
      -AsJob
   ```

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/4.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
Do not wait for the deployment to complete but instead proceed to the next task. The deployment should take about 3 minutes.
</p>
    
### Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers.

1. From the Cloud Shell pane, run the following to register the Microsoft.Insights and Microsoft.AlertsManagement resource providers.

   ```
   Register-AzResourceProvider -ProviderNamespace Microsoft.Insights
   
   Register-AzResourceProvider -ProviderNamespace Microsoft.AlertsManagement
   ```

2. Minimize Cloud Shell pane (but do not close it).

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/5.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

## Create and configure an Azure Log Analytics workspace and Azure Automation-based solutions

In this task, you will create and configure an Azure Log Analytics workspace and Azure Automation-based solutions

1. In the Azure portal, search for and select **Log Analytics workspaces** and, on the **Log Analytics workspaces** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/6.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/7.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

2. On the **Basics** tab of the **Create Log Analytics workspace** blade, the following settings, click **Review + Create** and then click **Create**:

* Subscription : the name of the Azure subscription you are using in this lab 

* Resource group : {{resource-group-name}}

* Log Analytics Workspace : any unique name 

* Region : {{Location}}

<p class="note-container">
Make sure that you specify the same region into which you deployed virtual machines in the previous task.
</p>

<p class="note-container">
Wait for the deployment to complete. The deployment should take about 1 minute.
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/8.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/9.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

3. In the Azure portal, search for and select **Automation Accounts**, and on the **Automation Accounts** blade, click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/10.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/11.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

4. On the **Add Automation Account** blade, specify the following settings, and click **Create**:

* Name : any unique name 

* Subscription : the name of the Azure subscription you are using in this lab 

* Resource group : {{resource-group-name}}

* Location : the name of the Azure region determined based on [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings) 
    
* Create Azure Run As account : **Yes** 

    > **Note**: Make sure that you specify the Azure region based on the [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings)

<p class="note-container">
Wait for the deployment to complete. The deployment might take about 3 minutes.
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/12.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

5. On the **Add Automation Account** blade, click **Refresh** and then click the entry representing your newly created Automation account.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/13.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

6. On the Automation account blade, in the **Configuration Management** section, click **Inventory**.

7. In the **Inventory** pane, in the **Log Analytics workspace** drop-down list, select the Log Analytics workspace you created earlier in this task and click **Enable**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/14.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
Wait for the installation of the corresponding Log Analytics solution to complete. This might take about 3 minutes.
</p>

<p class="note-container">
This automatically installs the **Change tracking** solution as well.
</p>

8. On the Automation account blade, in the **Update Management** section, click **Update management** and click **Enable**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/15.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
Wait for the installation to complete. This might take about 5 minutes. 
</p>

## Review default monitoring settings of Azure virtual machines

In this task, you will review default monitoring settings of Azure virtual machines

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-11-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/16.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/17.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

2. On the **az104-11-vm0** blade, in the **Monitoring** section, click **Metrics**.

3. On the **az104-11-vm0 | Metrics** blade, on the default chart, note that the only available **Metrics Namespace** is **Virtual Machine Host**.

<p class="note-container">
This is expected, since no guest-level diagnostic settings have been configured yet.
</p>

4. In the **Metric** drop-down list, review the list of available metrics.

<p class="note-container">
The list includes a range of CPU, disk, and network-related metrics that can be collected from the virtual machine host, without having access into guest-level metrics. 
</p>

5. In the **Metric** drop-down list, select **Percentage CPU**, in the **Aggregation** drop-down list, select **Avg**, and review the resulting chart. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/18.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

## Configure Azure virtual machine diagnostic settings

In this task, you will configure Azure virtual machine diagnostic settings.

1. On the **az104-11-vm0** blade, in the **Monitoring** section, click **Diagnostic settings**.

2. On the **Overview** tab of the **az104-11-vm0 | Diagnostic settings** blade, click **Enable guest-level monitoring**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/19.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
Wait for the operation to take effect. This might take about 3 minutes. 
</p>

3. Switch to the **Performance counters** tab of the **az104-11-vm0 | Diagnostic settings** blade and review the available counters.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/20.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/20.5.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
By default, CPU, memory, disk, and network counters are enabled. You can switch to the **Custom** view for more detailed listing.
</p>

4. Switch to the **Logs** tab of the **az104-11-vm0 | Diagnostic settings** blade and review the available event log collection options.

<p class="note-container">
By default, log collection includes critical, error, and warning entries from the Application Log and System log, as well as Audit failure entries from the Security log. Here as well you can switch to the Custom view for more detailed configuration settings. 
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/21.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/22.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

5. On the **az104-11-vm0** blade, in the **Monitoring** section, click **Logs** and then click **Enable**. 

6. On the **az104-11-vm0 - Logs** blade, ensure that the Log Analytics workspace you created earlier in this lab is selected in the **Choose a Log Analytics Workspace** drop-down list and click **Enable**.

<p class="note-container">
Do not wait for the operation to complete but instead proceed to the next step. The operation might take about 5 minutes. 
</p>

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/23.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/24.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

7. On the **az104-11-vm0 | Logs** blade, in the **Monitoring** section, click **Metrics**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/25.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

8. On the **az104-11-vm0 | Metrics** blade, on the default chart, note that at this point, the **Metrics Namespace** drop-down list, in addition to the **Virtual Machine Host** entry includes also the **Guest (classic)** entry.

<p class="note-container">
This is expected, since you enabled guest-level diagnostic settings. 
</p>

9. In the **Metric** drop-down list, review the list of available metrics.

<p class="note-container">
The list includes additional guest-level metrics not available when relying on the host-level monitoring only.  
</p>

10. In the **Metric** drop-down list, select **Memory\Available Bytes**, in the **Aggregation** drop-down list, select **Avg**, and review the resulting chart. 

## Review Azure Monitor functionality

1. In the Azure portal, search for and select **Monitor** and, on the **Monitor | Overview** blade, click **Metrics**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/26.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

2. On the **Select a scope** blade, on the **Browse** tab, navigate to the **az104-11-rg0** resource group, expand it, select the **az104-11-vm0** virtual machine within that resource group, and click **Apply**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/27.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
This gives you the same view and options as those available from the az104-11-vm0 - Metrics blade.
</p>

3. In the **Metric** drop-down list, select **Percentage CPU**, in the **Aggregation** drop-down list, select **Avg**, and review the resulting chart.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/28.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

4. On the **Monitor | Metrics** blade, click **New alert rule**.

    > **Note**: Creating an alert rule from Metrics is not supported for metrics from the Guest (classic) metric namespace. This can be accomplished by using Azure Resource Manager templates, as described in the document [Send Guest OS metrics to the Azure Monitor metric store using a Resource Manager template for a Windows virtual machine](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/collect-custom-metrics-guestos-resource-manager-vm)

5. On the **Create alert rule** blade, in the **Condition** section, click the existing condition. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/29.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/30.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/31.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

6. On the **Configure signal logic** blade, in the list of signals, in the **Alert logic** section, specify the following settings (leave others with their default values) and click **Done**:

* Threshold : **Static** 

* Operator : **Greater than** 

* Aggregation type : **Average** 

* Threshold value : **2** 

* Aggregation granularity (Period) : **1 minute** 

* Frequency of evaluation : **Every 1 Minute** 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/32.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/33.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/34.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

7. On the **Create alert rule** blade, in the **Action group** section, click **Select action group** and then click the **+ Create action group** button.

8. On the **Basics** tab of the **Create action group** blade, specify the following settings (leave others with their default values) and select **Next: Notifications >**:

* Action group name : **az104-11-ag1** 

* Display name : **az104-11-ag1** 

* Subscription : the name of the Azure subscription you are using in this lab 

* Resource group : {{resource-group-name}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/35.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/36.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

8. On the **Notifications** tab of the **Create action group** blade, in the **Notification type** drop-down list, select **Email/SMS/Push/Voice**. 

9. On the **Email/SMS/Push/Voice** blade, select the **Email** checkbox, type your email address in the **Email** textbox, leave others with their default values, click **OK**, back on the **Notifications** tab of the **Create action group** blade, in the **Name** text box, type **admin email** and select **Next: Actions>**:

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/37.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/38.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

10. On the **Basics** tab of the **Create action group** blade, review items available in the **Action type** drop-down list and select **Review + create**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/39.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

11. On the **Review + create** tab of the **Create action group** blade, select **Create**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/40.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

12. Back on the **Create alert rule** blade, in the **Alert rule details** section, specify the following settings (leave others with their default values):

* Alert rule name : **CPU Percentage above the test threshold** 

* Description : **CPU Percentage above the test threshold**

* Severity : **Sev 3**

* Enable rule upon creation : **Yes** 

13. Click **Create alert rule** and close the **Create rule** blade.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/41.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
It can take up to 10 minutes for a metric alert rule to become active.
</p>

14. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-11-vm0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/42.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/43.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

15. On the **az104-11-vm0** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/44.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/45.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/46.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.
</p>

<p class="note-container">
You can ignore any warning prompts when connecting to the target virtual machines.
</p>

16. When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.

17. Within the Remote Desktop session, click **OK**, expand the **Windows System** folder, and click **Command Prompt**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/47.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/48.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

18. From the Command Prompt, run the following to copy the restore the **hosts** file to the original location:

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/r1.png?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/r2.png?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

   ```
   for /l %a in (0,0,1) do echo a
   ```

<p class="note-container">
This will initiate the infinite loop that should increase the CPU utilization above the threshold of the newly created alert rule.
</p>

19. Leave the Remote Desktop session open and switch back to the browser window displaying the Azure portal on your lab computer.

20. In the Azure portal, navigate back to the **Monitor** blade and click **Alerts**.

21. Note the number of **Sev 3** alerts and then click the **Sev 3** row.

<p class="note-container">
You might need to wait for a few minutes and click **Refresh**.
</p>

22. On the **All Alerts** blade, review generated alerts.

## Review Azure Log Analytics functionality

1. In the Azure portal, navigate back to the **Monitor** blade, click **Logs**. 

<p class="note-container">
You might need to click **Get Started** if this is the first time you access Log Analytics.
</p>

2. On the **Select a scope** blade, navigate to the **az104-11-rg0** resource group, expand it, select **a104-11-vm0**, and click **Apply**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/49.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/50.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

3. In the query window, paste the following query and click **Run**:

   ```
   // Virtual Machine available memory
   // Chart the VM's available memory over the last hour.
   InsightsMetrics
   | where TimeGenerated > ago(1h)
   | where Name == "AvailableMB"
   | project TimeGenerated, Name, Val
   | render timechart
   ```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/51.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/52.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/53.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

4. Click **Example queries** in the toolbar, in the **Get started with sample queries** pane, review each tab, locate **Track VM availability**, and click **Run**.

5. Review the resulting chart and remove the line containing the following text:

   ```
   | where TimeGenerated > ago(1h)
   ```

<p class="note-container">
As the result, the Time range entry in the toolbar changed from Set in query to Last 24 hours. 
</p>

6. Rerun the query and examine the resulting chart.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/54.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/55.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

7. On the **New Query 1** tab, on the **Tables** tab, review the list of **Virtual machines** tables.

8. In the list of tables in the **Virtual machines** section. 

<p class="note-container">
The names of several tables correspond to the solutions you installed earlier in this lab.
</p>

9. Hover the mouse over the **VMComputer** entry and click the **Preview data** icon.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/56.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

10. If any data is available, in the **Update** pane, click **See in query editor**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/57.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/58.PNG?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

<p class="note-container">
You might need to wait a few minutes before the update data becomes available.
</p>

11. Click **Example queries** in the toolbar, in the **Get started with sample queries** pane, review each tab, locate **Virtual machine free disk space**, and click **Run**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/lab11-Implement_Monitoring/r3.png?st=2020-09-25T09%3A38%3A02Z&se=2025-09-26T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=f3RQ6g35lpqkuMOeASTwE9LGhG6v5f4yPjwl7C8FqMg%3D)

## Conclusion

Congratulations! You have successfully completed the **Implement Monitoring** lab. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

Thank you for taking this training lab
