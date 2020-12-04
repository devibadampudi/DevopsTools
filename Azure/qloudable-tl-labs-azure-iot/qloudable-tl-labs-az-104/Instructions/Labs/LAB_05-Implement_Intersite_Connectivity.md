# Implement Intersite Connectivity

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Provision the lab environment](#provision-the-lab-environment)

[Configure local and global virtual network peering](#configure-local-and-global-virtual-network-peering)

[Test intersite connectivity](#test-intersite-connectivity)

[Clean up resources](#clean-up-resources)

[Conclusion](#conclusion)

## Overview

The main Aim of this lab is to implement an environment that will reflect the topology of the Contoso's on-premises networks and verify its functionality.

**Scenario & Objectives**

Contoso has its datacenters in Boston, New York, and Seattle offices connected via a mesh wide-area network links, with full connectivity between them. You need to implement a lab environment that will reflect the topology of the Contoso's on-premises networks and verify its functionality. 

In this lab, you will learn:

1. Provision the lab environment

2. Configure local and global virtual network peering

3. Test intersite connectivity 

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

## Provision the lab environment

In this task, you will deploy three virtual machines, each into a separate virtual network, with two of them in the same Azure region and the third one in another Azure region. 

1. Using the Chrome browser, login into [Azure portal](https://portal.azure.com) with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)


2. Click Apps icon in the toolbar and select **Notepad** to open and create a file with below content then save the file as **az104-05-vnetvm-template.json**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/1_1.jpg?st=2020-11-17T13%3A00%3A04Z&se=2026-11-18T13%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CH2DB10pbNFO3oOWUInUeVSGlG0beyCgcZ4tD5jbNbk%3D)

```
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "vmSize": {
        "type": "string",
        "defaultValue": "Standard_D2s_v3",
        "metadata": {
          "description": "Virtual machine size"
        }
      },
      "nameSuffix": {
        "type": "string",
        "allowedValues": [
          "0",
          "1",
          "2"
        ],
        "metadata": {
          "description": "Naming suffix"
        }
      },
      "adminUsername": {
        "type": "string",
        "metadata": {
          "description": "Admin username"
        }
      },
      "adminPassword": {
        "type": "securestring",
        "metadata": {
          "description": "Admin password"
        }
      }
    },
  "variables": {
    "vmName": "[concat('az104-05-vm',parameters('nameSuffix'))]",
    "nicName": "[concat('az104-05-nic',parameters('nameSuffix'))]",
    "virtualNetworkName": "[concat('az104-05-vnet',parameters('nameSuffix'))]",
    "publicIPAddressName": "[concat('az104-05-pip',parameters('nameSuffix'))]",
    "nsgName": "[concat('az104-05-nsg',parameters('nameSuffix'))]",
    "vnetIpPrefix": "[concat('10.5',parameters('nameSuffix'),'.0.0/22')]", 
    "subnetIpPrefix": "[concat('10.5',parameters('nameSuffix'),'.0.0/24')]", 
    "subnetName": "subnet0",
    "subnetRef": "[resourceId('Microsoft.Network/virtualNetworks/subnets', variables('virtualNetworkName'), variables('subnetName'))]",
    "computeApiVersion": "2018-06-01",
    "networkApiVersion": "2018-08-01"
  },
    "resources": [
        {
            "name": "[variables('vmName')]",
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "[variables('computeApiVersion')]",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "[variables('nicName')]"
            ],
            "properties": {
                "osProfile": {
                    "computerName": "[variables('vmName')]",
                    "adminUsername": "[parameters('adminUsername')]",
                    "adminPassword": "[parameters('adminPassword')]",
                    "windowsConfiguration": {
                        "provisionVmAgent": "true"
                    }
                },
                "hardwareProfile": {
                    "vmSize": "[parameters('vmSize')]"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",
                        "offer": "WindowsServer",
                        "sku": "2019-Datacenter",
                        "version": "latest"
                    },
                    "osDisk": {
                        "createOption": "fromImage"
                    },
                    "dataDisks": []
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "properties": {
                                "primary": true
                            },
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]"
                        }
                    ]
                }
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks",
            "name": "[variables('virtualNetworkName')]",
            "apiVersion": "[variables('networkApiVersion')]",
            "location": "[resourceGroup().location]",
            "comments": "Virtual Network",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "[variables('vnetIpPrefix')]"
                    ]
                },
                "subnets": [
                    {
                        "name": "[variables('subnetName')]",
                        "properties": {
                            "addressPrefix": "[variables('subnetIpPrefix')]"
                        }
                    }
                ]
            }
        },
        {
            "name": "[variables('nicName')]",
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "[variables('networkApiVersion')]",
            "location": "[resourceGroup().location]",
            "comments": "Primary NIC",
            "dependsOn": [
                "[variables('publicIpAddressName')]",
                "[variables('nsgName')]",
                "[variables('virtualNetworkName')]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "subnet": {
                                "id": "[variables('subnetRef')]"
                            },
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIpAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIpAddresses', variables('publicIpAddressName'))]"
                            }
                        }
                    }
                ],
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups', variables('nsgName'))]"
                }
            }
        },
        {
            "name": "[variables('publicIpAddressName')]",
            "type": "Microsoft.Network/publicIpAddresses",
            "apiVersion": "[variables('networkApiVersion')]",
            "location": "[resourceGroup().location]",
            "comments": "Public IP for Primary NIC",
            "properties": {
                "publicIpAllocationMethod": "Dynamic"
            }
        },
        {
            "name": "[variables('nsgName')]",
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "[variables('networkApiVersion')]",
            "location": "[resourceGroup().location]",
            "comments": "Network Security Group (NSG) for Primary NIC",
            "properties": {
                "securityRules": [
                    {
                        "name": "default-allow-rdp",
                        "properties": {
                            "priority": 1000,
                            "sourceAddressPrefix": "*",
                            "protocol": "Tcp",
                            "destinationPortRange": "3389",
                            "access": "Allow",
                            "direction": "Inbound",
                            "sourcePortRange": "*",
                            "destinationAddressPrefix": "*"
                        }
                    }
                ]
            }
        }
    ],
    "outputs": {}
}
```
3. Click Apps icon in the toolbar and select **Notepad** to open and create a file  with below content then save the file as **az104-05-vnetvm-parameters.json**.

```
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "vmSize": {
            "value": "Standard_D2s_v3"
        },
        "adminUsername": {
            "value": "Student"
        },
        "adminPassword": {
            "value": "Pa55w.rd1234"
        }
    }
}
```

4. In the portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

5. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 


> **Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted message**, select the **subscription** you are using in this lab, and click **Create storage**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)

* **Cloud Shell region:** {{azure-location}}

* **Resource group:** Create new Storage <br>

* **Storage Account Name:** Create new Storage <br>

* **File Share Name:** Create new file share


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a41.PNG?st=2019-09-18T04%3A58%3A12Z&se=2022-09-19T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zQJmfYNONwPRTvZ3mdfA6ZtkxKIjh%2FCTdGu9oNPOe%2FE%3D)

6. Ensure **PowerShell** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Manage%20Azure%20resources%20by%20Using%20Azure%20PowerShell/power_shell_5.jpg?st=2020-10-20T11%3A44%3A45Z&se=2026-10-21T11%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lFR17ZhcsEeiJ2Inz%2BLBO2XUTj3PjT7XF5ze1qW%2FS4I%3D)

7. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **az104-05-vnetvm-template.json** and **az104-05-vnetvm-parameters.json** into the Cloud Shell home directory.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/1.jpg?st=2020-11-16T12%3A00%3A06Z&se=2026-11-17T12%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EVdTs3TGaIdEIKisQZXloE5NZKv%2Bl2xbNxuj%2F8kYuc8%3D)

8. From the Cloud Shell pane, run the following to create the first resource group that will be hosting the first virtual network and the pair of virtual machines:
 
   ```
   $location = 'eastus'

   $rgName = 'az104-05-rg'
   
   New-AzResourceGroup -Name $rgName -Location $location
   ```
 
  > **Note**: In order to identify Azure regions, from a **PowerShell** session in **Cloud Shell**, run **eastus**

   
9. From the Cloud Shell pane, run the following to create the first virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-05-vnetvm-template.json `
      -TemplateParameterFile $HOME/az104-05-vnetvm-parameters.json `
      -nameSuffix 0 `
      -AsJob
   ```
10. From the Cloud Shell pane, run the following to create the second resource group that will be hosting the second virtual network and the second virtual machine

   ```
   $rgName = 'az104-05-rg1'

   New-AzResourceGroup -Name $rgName -Location $location
   ```
11. From the Cloud Shell pane, run the following to create the second virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-05-vnetvm-template.json `
      -TemplateParameterFile $HOME/az104-05-vnetvm-parameters.json `
      -nameSuffix 1 `
      -AsJob
   ```
12. From the Cloud Shell pane, run the following to create the third resource group that will be hosting the third virtual network and the third virtual machine:

   ```
   $location = 'westus'

   $rgName = 'az104-05-rg2'

   New-AzResourceGroup -Name $rgName -Location $location
   ```
13. From the Cloud Shell pane, run the following to create the third virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-05-vnetvm-template.json `
      -TemplateParameterFile $HOME/az104-05-vnetvm-parameters.json `
      -nameSuffix 2 `
      -AsJob
   ```
> **Note**: Wait for the deployments to complete before proceeding to the next task. This should take about 2 minutes.
  
> **Note**: To verify the status of the deployments, you can examine the properties of the resource groups you created in this task.

14. Close the Cloud Shell pane.

## Configure local and global virtual network peering

In this task, you will configure local and global peering between the virtual networks you deployed in the previous tasks.

1. In the Azure portal, search for and select **Virtual networks**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_1.jpg?st=2020-11-16T12%3A01%3A41Z&se=2026-11-17T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eCiXMams2PvYunfl%2FDtBQLgDUA3nIOMMOb7fhHZZoYs%3D)

2. Review the virtual networks you created in the previous task and verify that the first two are located in the same Azure region and the third one in a different Azure region. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_2.jpg?st=2020-11-16T12%3A04%3A13Z&se=2026-11-17T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9d6qWGBXA4tpipJ5R0saZ2OtAQjPCD%2BDSi9VLhphCDc%3D)

 > **Note**: The template you used for deployment of the three **virtual networks** ensures that the IP address ranges of the three **virtual networks** do not overlap.

3. In the list of virtual networks, click **az104-05-vnet0**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_3.jpg?st=2020-11-16T12%3A05%3A08Z&se=2026-11-17T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=39gRG8zBJtDSWhaqj6QAh1BzIJPMlgnl42bX4phDJvs%3D)

4. On the **az104-05-vnet0** virtual network blade, in the **Settings** section, click **Peerings** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_4.jpg?st=2020-11-16T12%3A05%3A42Z&se=2026-11-17T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9xA3Q9nHauTPc%2FiJ3%2BX3supvzw8qsb7Pu56dXhi69Jc%3D)

5. Add a peering with the following settings (leave others with their default values):

     *   peering link Name(This virtual Network)  :  **az104-05-vnet0_to_az104-05-vnet1**  
     
     *   peering link Name(Remote virtual Network) : **az104-05-vnet1_to_az104-05-vnet0**
     
     *   Virtual Network deployment model : Select Resource Manager type
     
     *   Subscription  :  Select correct subscription
     
     *   Virtual network  : **az104-05-vnet1**
     
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_5.jpg?st=2020-11-16T12%3A15%3A06Z&se=2026-11-17T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=svEz1BnhGtYmuJJkLD3z8Y7KHbEXPonQ5yRTml7%2FXvA%3D)
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_6.jpg?st=2020-11-16T12%3A15%3A43Z&se=2026-11-17T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7iNE9tvpa784e9%2BE%2BjY8ut1yM09PSpyULqaeQ8Nvn0M%3D)
     
 > **Note**: This step establishes two local peerings - one from az104-05-vnet0 to az104-05-vnet1 and the other from az104-05-vnet1 to az104-05-vnet0.


6. On the **az104-05-vnet0** virtual network blade, in the **Settings** section, click **Peerings** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_4.jpg?st=2020-11-16T12%3A05%3A42Z&se=2026-11-17T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9xA3Q9nHauTPc%2FiJ3%2BX3supvzw8qsb7Pu56dXhi69Jc%3D)

7. Add a peering with the following settings (leave others with their default values):

     *   peering link Name(This virtual Network)  :  **az104-05-vnet0_to_az104-05-vnet2**  
     
     *   peering link Name(Remote virtual Network) : **az104-05-vnet2_to_az104-05-vnet0**
     
     *   Virtual Network deployment model : Select Resource Manager type
     
     *   Subscription  :  Select correct subscription
     
     *   Virtual network  : **az104-05-vnet2**
     
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_7.jpg?st=2020-11-17T11%3A04%3A19Z&se=2026-11-18T11%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lOs5Aj5oI3VKBTY0wPUwYDCiOZBOlg8qlRjzXE2qtO0%3D)
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_8.jpg?st=2020-11-17T11%3A05%3A03Z&se=2026-11-18T11%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6N0TQ3%2FTyoVios23h63wNz9f0O8hP2mtyjtg7rzbooc%3D)


> **Note**: This step establishes two global peerings - one from **az104-05-vnet0 to az104-05-vnet2** and the other from **az104-05-vnet2 to az104-05-vnet0**.

8. Navigate back to the **Virtual networks** blade and, in the list of virtual networks, click **az104-05-vnet1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_9.jpg?st=2020-11-17T11%3A07%3A01Z&se=2026-11-18T11%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fCrPoLwaq6pbGkA%2FV5SfZV3fEbk75SjW3iGhoW4rMCE%3D)

9. On the **az104-05-vnet1** virtual network blade, in the **Settings** section, click **Peerings** and then click **+ Add**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_10.jpg?st=2020-11-17T11%3A07%3A48Z&se=2026-11-18T11%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bBuI03I5Lxn%2BNQai86PtB6FjqblWBQBR6IMixNrt5eo%3D)

10. Add a peering with the following settings (leave others with their default values):

     *   peering link Name(This virtual Network)  :  **az104-05-vnet1_to_az104-05-vnet2**  
     
     *   peering link Name(Remote virtual Network) : **az104-05-vnet2_to_az104-05-vnet1**
     
     *   Virtual Network deployment model : Select Resource Manager type
     
     *   Subscription  :  Select correct subscription
     
     *   Virtual network  : **az104-05-vnet2**
     
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_11.jpg?st=2020-11-17T11%3A08%3A43Z&se=2026-11-18T11%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=atFWOPUbpTH7YkyZK2Di8jqkhpyK7q1g6v9TNgEvgtQ%3D)
     
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/2_12.jpg?st=2020-11-17T11%3A09%3A19Z&se=2026-11-18T11%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IDH6oizz0g8I5Qy9Dmm%2FRbSGqzOdo%2BykfkPaBC3jDoI%3D)
    

 > **Note**: This step establishes two global peerings - one from **az104-05-vnet1 to az104-05-vnet2** and the other from **az104-05-vnet2 to az104-05-vnet1**.

## Test intersite connectivity 

In this task, you will test connectivity between virtual machines on the three virtual networks that you connected via local and global peering in the previous task.

1. In the Azure portal, search for and select **Virtual machines**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_1.jpg?st=2020-11-16T12%3A19%3A09Z&se=2026-11-17T12%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C1Fuu20yVGWL21oNNidHLqAUyViYuEgyW%2BJtHBxMcvc%3D)

2. In the list of virtual machines, click **az104-05-vm0**.

3. On the **az104-05-vm0** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_2.jpg?st=2020-11-16T12%3A20%3A12Z&se=2026-11-17T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jvxdW4Yi7rOQnkSKA%2F6abeGEpJK0bIk%2Fk%2Bqb6gFv7xM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_3.jpg?st=2020-11-16T12%3A21%3A17Z&se=2026-11-17T12%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9h8EufHWb7aswO1d54y%2FnOowkpvMAxs8h4%2F%2BATOq4v8%3D)

4. Click on **Downloded** RDP file, It prompted Then click on **Connect**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_8.jpg?st=2020-11-17T11%3A19%3A26Z&se=2026-11-18T11%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=99SC7AKyVpheCkja3d1hG0NsqMejqB3ovdAX%2Bjy3oa0%3D)

    
  > **Note**: This step refers to connecting via **Remote Desktop** from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.

   > **Note**: You can ignore any warning prompts when connecting to the target **virtual machines**.


5. When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_5.jpg?st=2020-11-16T12%3A27%3A00Z&se=2026-11-17T12%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BXARdZz7c2AIeW%2FyO94R2IDx9d7fPkm%2FCNIAvH%2FAleY%3D)

6. Click on **Yes** You can allow the home and work networks, It will Prompted then click on **Yes** to login RDP.
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_10.jpg?st=2020-11-17T12%3A32%3A27Z&se=2026-11-18T12%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BRnnIeehZkAaOqetu%2FRwVbfg%2BNabqIYvCp58NbM52G4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_9.jpg?st=2020-11-17T12%3A01%3A47Z&se=2026-11-18T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q3UYJw0eBHBizoq%2B48x14wwQtXPhOyxk%2FubO%2FbqujzQ%3D)

7. Within the Remote Desktop session to **az104-05-vm0**, right-click the **Start** button and, in the right-click menu, click **Windows PowerShell (Admin)**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_11.jpg?st=2020-11-17T12%3A35%3A33Z&se=2026-11-18T12%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eOk4FyDkYavVobcaT1p8Phk%2Bldfcc8mHvINgJ37bTBA%3D)

8. In the Windows PowerShell console window, run the following to test connectivity to **az104-05-vm1** (which has the private IP address of **10.51.0.4**) over TCP port 3389:

   ```
   Test-NetConnection -ComputerName 10.51.0.4 -Port 3389 -InformationLevel 'Detailed'   
   ```
 
 > **Note**: The test uses TCP 3389 since this is this port is allowed by default by operating system firewall. 


9. Examine the output of the command and verify that the connection was successful.

10. In the Windows PowerShell console window, run the following to test connectivity to **az104-05-vm2** (which has the private IP address of **10.52.0.4**):

   ```
   Test-NetConnection -ComputerName 10.52.0.4 -Port 3389 -InformationLevel 'Detailed'
   ```
  
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_13.jpg?st=2020-11-17T12%3A37%3A07Z&se=2026-11-18T12%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LLn5em%2BugB4jInNuFRjmQzXSi3vUVWXYRZTAxb0Be2g%3D)

11. Switch back to the Azure portal on your lab computer and navigate back to the **Virtual machines** blade. 

12. In the list of virtual machines, click **az104-05-vm1**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_14.jpg?st=2020-11-17T12%3A38%3A22Z&se=2026-11-18T12%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UtatEkYytB6ccAZOnWMgRTBaRHnxSS8wtJQt51KsdRA%3D)

13. On the **az104-05-vm1** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_16.jpg?st=2020-11-17T12%3A40%3A14Z&se=2026-11-18T12%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3ix8OFO3N0Z2Zsz%2Fm%2BEhAWLkl34rF5ANgbfMZR1fczk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_17.jpg?st=2020-11-17T12%3A40%3A52Z&se=2026-11-18T12%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2Gpxi409%2B9CFlOAL4pz65dXexvSmTzC1DLdZ1e9tDKs%3D)

14. Click on **Downloded** RDP file, It prompted Then click on **Connect**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_18.jpg?st=2020-11-17T12%3A42%3A51Z&se=2026-11-18T12%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=B5YFI9CsU1dy3dWwTbwIs5thZBn15iLKEs%2F3%2BgptlNY%3D)

   > **Note**: This step refers to connecting via **Remote Desktop** from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.


  > **Note**: You can ignore any warning prompts when connecting to the target **virtual machines**.


15. When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_5.jpg?st=2020-11-16T12%3A27%3A00Z&se=2026-11-17T12%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BXARdZz7c2AIeW%2FyO94R2IDx9d7fPkm%2FCNIAvH%2FAleY%3D)

 16. Click on **Yes** You can allow the home and work networks, It will Prompted then click on **Yes** to login RDP.
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_10.jpg?st=2020-11-17T12%3A32%3A27Z&se=2026-11-18T12%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BRnnIeehZkAaOqetu%2FRwVbfg%2BNabqIYvCp58NbM52G4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_9.jpg?st=2020-11-17T12%3A01%3A47Z&se=2026-11-18T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q3UYJw0eBHBizoq%2B48x14wwQtXPhOyxk%2FubO%2FbqujzQ%3D)

17. Within the Remote Desktop session to **az104-05-vm1**, right-click the **Start** button and, in the right-click menu, click **Windows PowerShell (Admin)**.

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_11.jpg?st=2020-11-17T12%3A35%3A33Z&se=2026-11-18T12%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eOk4FyDkYavVobcaT1p8Phk%2Bldfcc8mHvINgJ37bTBA%3D)

18. In the Windows PowerShell console window, run the following to test connectivity to **az104-05-vm2** (which has the private IP address of **10.52.0.4**) over TCP port 3389:

   ```
   Test-NetConnection -ComputerName 10.52.0.4 -Port 3389 -InformationLevel 'Detailed'
   ```
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/3_19.jpg?st=2020-11-17T12%3A44%3A23Z&se=2026-11-18T12%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s4Dq0%2BaUx1fxu6zJxEP4MDZT3JGx0zCm3QgVP5rKC28%3D)
  
  > **Note**: The test uses TCP 3389 since this is this port is allowed by default by operating system firewall. 

19. Examine the output of the command and verify that the connection was successful.

## Clean up resources
  
> **Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.  

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. List all resource groups created throughout the labs of this module by running the following command:

   ```
   Get-AzResourceGroup -Name 'az104-05*'
   ```

3. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```
   Get-AzResourceGroup -Name 'az104-05*' | Remove-AzResourceGroup -Force -AsJob
   ```
   
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az104/Images/Lab%2005%20-%20Implement%20Intersite%20Connectivity/4_1.jpg?st=2020-11-17T12%3A45%3A07Z&se=2026-11-18T12%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SzdLQQRXJTnaGiMNN4RIuQx6bX54ot%2BOLlUboJXfk3w%3D)
    > **Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
   
### Review

In this lab, you have:

* Provisioned the lab environment

* Configured local and global virtual network peering

* Tested intersite connectivity 

## Conclusion 

Congratulations! You have successfully completed the lab **Implement Intersite Connectivity**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!
