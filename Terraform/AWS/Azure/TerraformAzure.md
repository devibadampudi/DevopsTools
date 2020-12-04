# Terraform Azure

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login To Azure Portal](#login-to-azure-portal)

[Set Up Terraform Provider For Azure](#set-up-terraform-provider-for-azure)

[Create And Deploy A Virtual Network Using Terraform](#create-and-deploy-a-virtual-network-using-terraform)

[Create Virtual Machine And Related Resources Using Terraform](#create-virtual-machine-and-related-resources-using-terraform)

[Deploy The Templates For Creating Virtual Machine](#deploy-the-templates-for-creating-virtual-machine)

[Install Apache Using Terraform](#install-apache-using-terraform)


## Overview

  Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON.

  Use this Infrastructure as Code tool to provision and manage any cloud, infrastructure, or service. You define the Configuration files to manage the full lifecycle — create new resources, manage existing ones, and destroy those no longer needed.

## Pre-Requisites
  
  1. Familiarity with Azure Portal.

  2. Overview of resources that are required to launch a Virtual machine.

  3. Familiarity with resource groups.

  4. Connecting to a Virtual machine.

## Login To Azure Portal

  In this section we will login to the Azure Portal.

  1. Use the below credentials to login to the Azure Portal.

 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}<br>
 **Resource group Name:** {{resource-group-name}} <br>
 **location:** {{azure-rg-location}}
 
 2. In the lab console window, use the web browser and go to https://portal.azure.com

 3. Enter the Azure login_ID provided in the lab credentials and click on `Next`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 4. Enter the Azure login_Password Provided in the lab credentials and click on `Sign in`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 5. Update the Password.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azuree1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 6. The dashboard of the Azure portal will Appear after a successful login.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 7. Click on `Resource groups`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 8. You can see {{resource-group-name}} resource group which is already created.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 `Note:` Going further we will deploy the resources in this resource group using Terraform templates.

 9. Click on {{resource-group-name}} resource group to see the resources.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 For now there are no resources in this resource group.



## Set Up Terraform Provider For Azure

 ### Install Terraform Plugins For Azure

 1. Click on `Apps Icon` and Open `Visual Studio Code`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Click on `Terminal` and choose `New Terminal` to open terminal in `Visual Studio Code`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 3. We have pre installed `Terraform` in AppStream VM. Execute `terraform --version` command in terminal to see the version of the Terraform.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 4. To install terraform plugins, click on `Extensions` icon in the left pane of `Visual Studio Code` as shown below.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

 5. search for `Terraform`. You will be able to see `Terraform` and `Azure Terraform` plugins in the result list.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 6. Choose `Terraform` plugin and click on `Install`.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 7. Choose `Azure Terraform` plugin and click on `Install`.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 8. Create a directory named `terraformAzure` by executing below command in visual studio terminal.

 `mkdir terraformAzure`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

 9. On top left corner, click on `File` and choose `Open Folder`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 10. Paste `D:/Photonuser` in the dropdown and click on `Enter`.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 11. Once click on enter, you will be navigated to `AppStreamUsers(D:)/PhotonUser` directory where terraformAzure folder is created.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)   

 12. Select `terraformAzure` and click on `Select Folder`

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

 13. Now terraformAzure folder is opened in Visual Studio Code.

 ### Set Up Terraform Provider File For Azure
 
 1. Inside the folder, create a file named `provider.tf` by clicking on `new file` symbol beside the Folder name as shown below.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 2. Paste the below content in `provider.tf` and `save` the file.

```
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  features {}
}
```
 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 3. This Azure Provider can be used to configure infrastructure in Microsoft Azure using the Azure Resource Manager API's. 
  
  `Below is the explanation of provider azurerm arguments:`

  `subscription_id`: The Subscription ID inside which you want deploy the resources.<br>
  `client_id`: The Application ID of Service Principle.<br>
  `client_secret`: The Password of Service Principle.<br>
  `tenant_id`: The Tenant ID in which the subscription exists.<br>

 `Note:` You can directly hard code the values for arguments in above `provider.tf` file like below.

 ```subscription_id = "xxxxxxxxxxxx"```

 But it is best practice to pass sensitive values from `variables.tf` file as below.

 ```subscription_id = "${var.subscription_id}"```


 4. Create a file named `variables.tf` in same directory and paste the below content in it.

```
variable "subscription_id" {
   default = ""  
}

variable "client_id" {
   default = ""  
}

variable "client_secret" {
   default = ""  
}

variable "tenant_id" {
   default = ""  
}

variable "azure_rg_location" {
  default = ""
}

variable "resource_group_name" {
  default = ""
}
```
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 5.Update the below respected values inside the `double quotes` after `default =` in `variables.tf` file.

 **subscription_id:**  {{subscription_id}} <br>
 **client_id:**  {{client_id}}<br>
 **client_secret:**  {{client_secret}} <br>
 **tenant_id:**  {{tenant_id}} <br>
 **Resource group Name:** {{resource-group-name}} <br>
 **location:** {{azure-rg-location}}

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 6. Open the terminal in `Visual Studio code`

 7. Execute `terraform init` command to initialize the current working directory with terraform. Azure Terraform plugins will be downloaded.

 ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


## Create And Deploy A Virtual Network Using Terraform

### Create A Virtual Network

 1. Create a file named `vnet.tf`

 2. Paste the below content in the `vnet.tf` and save the file.

```
resource "random_id" "random_id" {
  byte_length = 2
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tfvnet-${random_id.random_id.hex}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
}
```

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 3. Below is the explanation of resource.

  `resource "random_id":` The resource random_id generates random numbers that are intended to be used as unique identifiers for other resources.<br> 

  `resource "azurerm_virtual_network":` Manages a virtual network.<br>
  `name:` The name of the virtual network.<br>
  `address_space:` The address space that is used for the virtual network.<br>
  `location:` The location/region where the virtual network is created.<br>
  `resource_group_name:` The name of the resource group in which to create the virtual network.<br>  

### Deploy Virtual Network

 1. Make sure you update location value as `{{azure-rg-location}}` and resource_group_name value as `{{resource-group-name}}` in `variables.tf` file.

 2. You will get below error message if you miss to update the value of resource group or location
 
 ```"resource_group_name" may only contain alphanumeric characters, dash, underscores, parentheses and periods```

 3. Make sure you save all the files.

 4. Execute `terraform init` command to download the plugins for random_id.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/newrandom.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  
 
 5. Execute `terraform plan` command on terminal to create an execution plan which shows the information of 

  resources that are going to deploy.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)    

 6. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 7. Type `yes` and click on `Enter` to approve the plan.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 8. You will get ```Apply complete! Resources: 2 added, 0 changed, 0 destroyed``` message once the deployment is      completed.

 9. Click on `switch` window icon and select `Chrome` browser to go back to the Azure Portal.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 10. Navigate to the resource group `{{resource-group-name}}` to see the created virtual network resource.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 11. Now you have successfully deployed vnet using terraform templates. Click on `switch` window icon and go back to the `visual studio` to create templates for other resources that are required for a virtual machine.


## Create Virtual Machine And Related Resources Using Terraform

### Create Subnet

 1. Create a file named `subnet.tf` and paste the below content.

```
resource "azurerm_subnet" "subnet" {
  name                 = "tfsubnet-${random_id.random_id.hex}"
  resource_group_name = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.0.0.0/24"
}
```
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/newsubnet.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "azurerm_subnet":` Manages a subnet.<br>
  `name:` The name of the subnet.<br>
  `resource_group_name:` The name of the resource group in which to create the subnet.<br>
  `virtual_network_name:` The name of the virtual network to which to attach the subnet.<br>
  `address_prefix:` The address prefix to use for the subnet.<br>

### Create Public IP

 1. Create a file named `pip.tf` and paste the below content.

```
resource "azurerm_public_ip" "pip" {
  name                = "tfpip-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
  allocation_method   = "Static"
}

```
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/newpip.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "azurerm_public_ip":` Manages a Public IP Address.<br>
  `name:` Specifies the name of the Public IP resource . <br>
  `location:` Specifies the supported Azure location where the resource exists.<br>
  `resource_group_name:` The name of the resource group in which to create the public ip.<br>
  `allocation_method:` Defines the allocation method for this IP address. Possible values are Static or Dynamic.<br>  

### Create Network Security Group

 1. Create a file named `nsg.tf` and paste the below content.

```
resource "azurerm_network_security_group" "nsg" {
  name                = "tfnsg-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
}
```
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/newnsg.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "azurerm_network_security_group":` Manages a network security group that contains a list of network   security rules. Network security groups enable inbound or outbound traffic to be enabled or denied.<br>
  `name:` Specifies the name of the network security group.<br>
  `location:` Specifies the supported Azure location where the resource exists.<br>
  `resource_group_name:` The name of the resource group in which to create the network security group. <br>    

### Create Network Security Rule

 1. Create a file named `securule.tf` and paste the below content.

```
resource "azurerm_network_security_rule" "nsgrule1" {
  name                        = "tfrule1-${random_id.random_id.hex}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "nsgrule2" {
  name                        = "tfrule2-${random_id.random_id.hex}"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 80
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
```
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/secrule3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "azurerm_network_security_rule":` Manages a Network Security Rule.<br>
  `name:` The name of the security rule.<br>
  `priority:` Specifies the priority of the rule. The value can be between `100` and `4096`. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.<br>
  `direction:` The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.<br>
  `access:` Specifies whether network traffic is allowed or denied. Possible values are `Allow` and `Deny`.<br>
  `protocol:` Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, or * (which matches all)<br>
  `source_port_range:` Source Port or Range. Integer or range between `0` and `65535` or `*` to match any.<br>
  `destination_port_range:` Destination Port or Range. Integer or range between `0` and `65535` or `*` to match any.<br>
  `source_address_prefix:` CIDR or source IP range or * to match any IP.<br>
  `destination_address_prefix:` CIDR or destination IP range or * to match any IP.<br>
  `resource_group_name:` The name of the resource group in which to create the Network Security Rule.<br>
  `network_security_group_name:` The name of the Network Security Group that we want to attach the rule to.<br>     

### Create Network Interface

 1. Create a file named `nic.tf` and paste the below content.

```
resource "azurerm_network_interface" "nic" {
  name                = "tfnic-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
  

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pip.id}"
   }
}
```
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/newnic.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "azurerm_network_interface":` Manages a Network Interface located in a Virtual Network.<br>
  `name:` The name of the network interface.<br>
  `location:` The location/region where the network interface is created.<br>
  `resource_group_name:` The name of the resource group in which to create the network interface.<br>
  `network_security_group_id:` The ID of the Network Security Group to associate with the network interface.<br>

  `ip_configuration:` One or more ip_configuration associated with this NIC as documented below.<br>
  `name:` User-defined name of the IP.<br>
  `subnet_id:` Reference to a subnet in which this NIC has been created.<br>
  `private_ip_address_allocation:` Defines how a private IP address is assigned. Options are `Static` or `Dynamic`.<br>
  `public_ip_address_id:` Reference to a Public IP Address to associate with this NIC.<br>

### Create Virtual Machine

 1. Create a file named `vm.tf` and paste the below content.

```
resource "azurerm_virtual_machine" "vm" {
  name                  = "tfvm-${random_id.random_id.hex}"
  location            = "${var.azure_rg_location}"
  resource_group_name = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "Basic_A1"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "tfazureosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "tfazure-vm"
    admin_username = "${var.VM_user_name}"
    admin_password = "${var.VM_password}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
```    

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/newvm.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "azurerm_virtual_machine":` Manages a Virtual Machine.<br>
  `name:` Specifies the name of the Virtual Machine.<br>
  `location:` Specifies the Azure Region where the Virtual Machine exists.<br>
  `resource_group_name:` Specifies the name of the Resource Group in which the Virtual Machine should exist.<br>
  `network_interface_ids:` A list of Network Interface ID's which should be associated with the Virtual Machine.<br>
  `vm_size:` Specifies the size of the Virtual Machine.<br>
  `delete_os_disk_on_termination:` Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? Defaults to false.<br>
  `delete_data_disks_on_termination:` Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? Defaults to false.<br>

  `storage_image_reference:` A storage_image_reference block.<br>
  `publisher:` Specifies the publisher of the image used to create the virtual machine.<br>
  `offer:` Specifies the offer of the image used to create the virtual machine.<br>
  `sku:` Specifies the SKU of the image used to create the virtual machine. <br>
  `version:` Specifies the version of the image used to create the virtual machine. <br>

  `storage_os_disk:` A storage_os_disk block.<br>
  `name:` Specifies the name of the OS Disk.<br>
  `caching:` Specifies the caching requirements for the OS Disk.<br>
  `create_option:` Specifies how the OS Disk should be created.<br>
  `managed_disk_type:` Specifies the type of Managed Disk which should be created.<br>

  `os_profile:` An os_profile block. Required when `create_option` in the `storage_os_disk` block is set to `FromImage`.<br>
  `computer_name:` Specifies the name of the Virtual Machine.<br>
  `admin_username:` Specifies the name of the local administrator account. We will pass this value through variables file.<br>
  `admin_password:` The password associated with the local administrator account.We will pass this value through variables file.<br>

  `os_profile_linux_config:` A os_profile_linux_config block.<br>
  `disable_password_authentication:` Specifies whether password authentication should be disabled. If set to false, an admin_password must be specified.<br>

 3. Update the `variables.tf` file with below content

```
variable "VM_user_name" {
  default = "adminuser"  
}

variable "VM_password" {
  default = "P@ssword1234"  
}
```

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/variablesupdate2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 These values will be passed to `vm.tf` file.

### Create Outputs File

 1. Create a file named `outputs.tf` and paste the below content.
 
```
output "public_ip_address" {
   value = ["${azurerm_public_ip.pip.ip_address}"]
}
output "VM_username" {
   value = ["${var.VM_user_name}"]
}
output "VM_password" {
   value = ["${var.VM_password}"]
}
```

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/outputs.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. This file will print the outputs when you execute terraform apply command in next sections.

## Deploy The Templates For Creating Virtual Machine

### Deploy The Templates

 1. Make sure you update location value as `{{azure-rg-location}}` and resource_group_name value as `{{resource-group-name}}` in `variables.tf` file.

 2. You will get below error message if you miss to update the value of resource group or location
 
 ```"resource_group_name" may only contain alphanumeric characters, dash, underscores, parentheses and periods```

 3. Make sure you saved all the files. Execute `terraform plan` command on terminal to create an execution plan which shows the information of resources that are going to deploy.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

 4. You will get ```Plan: 7 to add, 0 to change, 0 to destroy``` message.

 5. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

 6. Type `yes` and click on `Enter` to approve the plan.
 
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 7. Once the deployment is completed, you can see ```Apply complete! Resources: 7 added, 0 changed, 0 destroyed``` message along with the outputs `VM_public_ip_address`, `VM_public_ip_address` and `VM_password`.

### Check The Deployed Resources In Azure Portal

 1. Click on `switch` window icon and select `Chrome` browser to go back to the Azure Portal.

 2. Navigate to the resource group `{{resource-group-name}}` to see the created resources.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 3. Now you have successfully created virtual machine using terraform.

### Connect To The Virtual Machine

 1. Click on `switch` window icon and select `Visual Studio`.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Copy the `VM_public_ip_address`.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 3. Click on `Apps` icon and select `putty`.

 4. Paste the `VM_public_ip_address`, make sure port is `22` and click on `open`.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 6. Click on `yes`.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 6. Enter username as `adminuser` and password as `P@ssword1234`

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 7. Now you have successfully log in to the virtual machine.

## Install Apache Using Terraform

### Create Script for Apache Installation

 1. Click on `switch` window icon and select `Visual Studio`.

 2. Create a file named `apache-install.sh` and paste the below content.

```
#!/bin/bash

echo "---------------------Update the packages---------"
sudo apt-get update -y
echo "--------------------Install Apache--------------"
sudo apt-get install apache2 -y
```

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/new27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 3. End of Line Sequence should be `LF` for the script. Otherwise you will get errors while executing the script.

 4. To select `LF` as the end of line sequence, Clcik on `CRLF` at the bottom right corner of Visual Studio

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 5. Select `LF`

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 6. Once done, you can see the end of line sequence as `LF` at the bottom of Visual Studio Code.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)



  
### Create Null Resource Template For Installing Apache

 1. Create a file named `extension.tf` and paste the below content.

```
resource "null_resource" "install_apache" {
  connection {
    type     = "ssh"
    host     = "${azurerm_public_ip.pip.ip_address}"
    user     = "${var.VM_user_name}"
    password = "${var.VM_password}"
  }
  provisioner "file" {
    source      = "./apache-install.sh"
    destination = "/home/${var.VM_user_name}/apache-install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.VM_user_name}/apache-install.sh",
      "cd /home/${var.VM_user_name}/",
      "./apache-install.sh >> remote-exec.log"
    ]
  }
}
```

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 2. Below is the explanation of resource.

  `resource "null_resource":` The null_resource resource implements the standard resource lifecycle but takes no further action.<br>

  `provisioner "file":` The file provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource.<br>

  `provisioner "remote-exec":` The remote-exec provisioner invokes apache script on a virtual machine after it is created.<br>

 3. Execute `terraform init` command on terminal to download null resource plugins.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of 

  resources that are going to deploy.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/30.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

 4. You will get ```Plan: 1 to add, 0 to change, 0 to destroy``` message.

 5. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/extension.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

 6. Type `yes` and click on `Enter` to approve the plan.
 
  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/extension1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 7. You have successfully installed apache inside the virtual machine using terraform.

 8. Click on `Switch windows` icon and select Chrome.

 9. Browse the `VM_public_ip_address` in new tab.

  ![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/apache.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 10. Apache is installed successfully through Terraform templates.

 `Conclusion:` Congratulations! You have successfully completed Terraform on Azure lab for creating a Virtual machine and for adding extension to it using teraform templates. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab!
