# Terraform OCI

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to OCI Console](#login-to-oci-console)

[Set Up Terraform Provider For OCI](#set-up-terraform-provider-for-oci)

[Create And Deploy A Virtual Network Using Terraform](#create-and-deploy-a-virtual-network-using-terraform)

[Create Virtual Machine And Related Resources Using Terraform](#create-virtual-machine-and-related-resources-using-terraform)

[Install Apache Using Terraform](#install-apache-using-terraform)



## Overview

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON.

Use this Infrastructure as Code tool to provision and manage any cloud, infrastructure, or service. You define the Configuration files to manage the full lifecycle — create new resources, manage existing ones, and destroy those no longer needed.

## Pre-Requisites

1. Familiarity with OCI console

2. Overview of resources that are required to launch a compute instance.

3. Familiarity with Compartments

4. Connecting to a compute instance


## Login to OCI Console

In this section we will login to the OCI console

`Step 1.` Sign in to your OCI account using below credentials 
            
`Cloud Tenant` {{tenancy-name}}<br>
`USER NAME:` {{oci-login-id}} <br>
`PASSWORD:` {{oci-login-password}}<br>
`Compartment Name:` {{compartment-name}} <br>

`1.1` Enter `Cloud Tenant` Name and click on `continue`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`1.2` Enter `USER NAME`, `PASSWORD` and click on `Sign In`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/puppetOCI2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

`Step 2.` Reduce the browser display size as needed
           (Below example is for Chrome). 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 3.` From OCI Services menu, Choose `Networking` and click on `Virtual Cloud Networks`

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`Step 4.` Ensure correct compartment is selected select {{compartment-name}} (Bottom Left of OCI console). 

![alt text](https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


## Set Up Terraform Provider For OCI

1. Click on `Apps Icon` and Open `Visual Studio Code`

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Click on `Terminal` and choose `New Terminal` to open terminal in `Visual Studio Code`

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. We have pre installed `Terraform` in AppStream VM. Execute `terraform --version` command in terminal to see the version of the Terraform.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

4. To install Terraform plugins, click on `Extensions` icon in the left pane of `Visual Studio Code` as shown below.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

5. Search for `Terraform`. You will be able to see `Terraform` plugins in the result list.

6. Choose `Terraform` plugin and click on `Install`.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. Create a directory named `terraformOCI` by executing below command in visual studio terminal.

`mkdir terraformOCI`

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)   

8. On top left corner, click on `File` and choose `Open Folder`

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

9. Paste `D:/Photonuser` in the dropdown and click on `Enter`.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

10. Once click on enter, you will be navigated to `AppStreamUsers(D:)/PhotonUser` directory where terraformOCI folder is created.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)   

11. Select `terraformOCI` and click on `Select Folder`

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

12. Now terraformOCI folder is opened in Visual Studio Code.

### Set Up Terraform Provider File For OCI

#### Generating API keys to setup the provider file with fingerprint and private_key_path.
 
Below is the procedure to generate the API keys.

1. Navigate to the **Menu** of the appstream and choose **gitbash**.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

2. Change the directory from default to the PhotonUser.

```
  cd c:
  cd \Users\PhotonUser
```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci-2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

3. Run the below command to generate the privatekey.pem file.

```
  openssl genrsa -out private.pem 2048

```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

4.  Generating Publickey.pem file from privatekey.pem by running the below command.

```
openssl rsa -in private.pem -outform PEM -pubout -out public.pem

```

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

5.  Now open the publickkey.pem file and copy the content and paste it in the oci console to create the fingerprint.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

6. Switch to OCI Console, Click Profile icon & select User settings

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

7. Click on Add Public Key

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

8. Make sure copy and paste the correct public key, click Add, it will display fingerprint

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

9. If you do not paste Public key properly, you will get the following error.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

> NOTE: Now make a note of the fingerprint it will required to setup the provider.tf file.

#### setting up the provider file.
 
1. Inside the folder, create a file named `provider.tf` by clicking on `new file` symbol beside the Folder name as shown below.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/Terraform/Azure15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Paste the below content in `provider.tf` and `save` the file.

```
provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}
```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/0.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

3. This oci Provider can be used to configure infrastructure in Oracle Cloud Infrastructure. The provider needs to be configured with credentials for the Oracle Cloud Infrastructure account.
  
`Below is the explanation of provider oci arguments:`

`tenancy_ocid`: OCID of your tenancy.<br>
`user_ocid`: OCID of the user.<br>
`fingerprint`: Fingerprint for the key pair being used.(provide the fingerprint address you just creted in the above section)<br>
`private_key_path`: The path (including filename) of the private key stored on your computer, required if private_key is not defined<br>
`region`: An Oracle Cloud Infrastructure region. <br>

4. The path of the key should be in the local directory and make sure to cretae a file named as `oci_api_key.pem` and copy the private key content from the gitbash with the file named as `privatekey.pem`.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


5.  Create a file named `variables.tf` in same directory and paste the below content in it.

```
variable "tenancy_ocid" {
   default = ""  
}

variable "user_ocid" {
   default = ""  
}

variable "fingerprint" {
   default = ""  
}

variable "private_key_path" {
   default = "./oci_api_key.pem"  
}

variable "region" {
  default = ""
}

variable "compartment_ocid" {
  default = ""
}

```

6. Update the below respected values inside the `double quotes` after `default =` in `variables.tf` file.

**tenancy_ocid:**  {{tenancy_ocid}} <br>
**user_ocid:**  {{user_ocid}}<br>
**fingerprint:**  Need to provide your fingerprint address <br>
**private_key_path:**  provide the path as shown in variables.tf file <br>
**region:** {{region}} <br>
**compartment_ocid:** {{compartment_ocid}} 

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 

7. Open the terminal in `Visual Studio code`

8. Execute `terraform init` command to initialize the current working directory with terraform. OCI Terraform plugins will be downloaded.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

 
## Create And Deploy A Virtual Network Using Terraform

### Create A Virtual Network

1. Create a file named `vnet.tf`

2. Paste the below content in the `vnet.tf` and save the file.

```
resource "random_id" "random_id" {
  byte_length = 2
}

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.0.0.0/16"
  dns_label      = "tfdnslabel"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "tfvnet-${random_id.random_id.hex}"
}

```

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Below is the explanation of resource.

`resource "random_id":` The resource random_id generates random numbers that are intended to be used as unique identifiers for other resources.<br> 

`resource "oci_core_virtual_network":` Manages a virtual network.<br>
`cidr_block:` The address space that is used for the virtual network.<br>
`dns_label:` The dns name of the virtual network<br>
`compartment_id:` The compartment ocid where the virtual network is created.<br>
`display_name:` The display name of the virtual network.<br>  

### Deploy Virtual Network

1. Make sure you update compartment_id value as `{{compartment_id}}` in `variables.tf` file.

2. Make sure you save all the files.

3. Execute `terraform init` command to download the plugins for random_id.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  
 
4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of resources that are going to deploy in the OCI cloud.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  

5. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

6. Type `yes` and click on `Enter` to approve the plan.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. You will get ```Apply complete! Resources: 2 added, 0 changed, 0 destroyed``` message once the deployment is completed.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

8. Click on `switch` window icon and select `Chrome` browser to go back to the OCI Console.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

9. Navigate to the **Menu** of the oci console and choose **Networking**--> select **virtual cloud network** to see the created virtual network resource.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

10. Now you have successfully deployed vnet using terraform templates. Click on `switch` window icon and go back to the `visual studio code` to create templates for other resources that are required for a virtual machine.

## Create Virtual Machine And Related Resources Using Terraform

### Create Internet Gateway

1. Create a file named `igw.tf` and paste the below content.

```
resource "oci_core_internet_gateway" "igw" {
    compartment_id  =   "${var.compartment_ocid}"
    display_name    =   "tfigw-${random_id.random_id.hex}"
    vcn_id          =   "${oci_core_virtual_network.vcn.id}"
}
```

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "oci_core_internet_gateway":` Manages a internet gateway.<br>
`compartment_id:` The compartment ocid where the virtual network is created.<br>
`display_name:` The dispaly name of the resource.<br>
`vcn_id:` The resource id of the virtual network to which to attach the internet gateway.

### Create Route table

1. Create a file named `routetable.tf` and paste the below content.

```
resource "oci_core_route_table" "rt" {
    compartment_id      =   "${var.compartment_ocid}"
    display_name        =   "tfrt-${random_id.random_id.hex}"
    vcn_id              =   "${oci_core_virtual_network.vcn.id}"
    route_rules {
        cidr_block      =   "0.0.0.0/0"
        network_entity_id="${oci_core_internet_gateway.igw.id}"
    }
}
```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "oci_core_route_table":` Manages a Route table.<br>
`compartment_id:` The compartment ocid where the virtual network is created.<br>
`display_name:` The dispaly name of the resource.<br>
`vcn_id:` The resource id of the virtual network to which the route table needs to attach.<br>
`route_rules:` Manages the route rules <br>
`cidr_block:` The address space that is used for routing.<br>
`network_entity_id:` The resource id of the internet gateway to which the route table needs to attach.

### Create Security List
1. Create a file named `seclist.tf` and paste the below content.

```
resource oci_core_security_list "seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "tfseclist${random_id.random_id.hex}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
       max = "80"
        min = "80"

    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
        max = "22"
        min = "22"

    }
  }

}

```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "oci_core_security_list":` Manages a security list.<br>
`compartment_id:` The compartment ocid where the virtual network is created.<br>
`display_name:` The dispaly name of the resource.<br>
`vcn_id:` The resource id of the virtual network to which the route table needs to attach.<br>
`egress_security_rules:` Manages the outbound security rules <br>
`protocol:` Name of the protocol to which the rule is applied.<br>
`destination:` Provide the Address range from where the rule need to be applied.<br>
`ingress_security_rules:` Manages the inbound security rules <br>
`protocol:` Name of the protocol to which the rule is applied.<br>
`source:` Provide the Address range in where the rule is applied.

### Create subnet
1. Create a file named `subnet.tf` and paste the below content.

```
data "oci_identity_availability_domains" "ADs" {
  compartment_id        =   "${var.tenancy_ocid}"
}
resource "oci_core_subnet" "sub" {
    compartment_id      =   "${var.compartment_ocid}"
    display_name        =   "tfsub${random_id.random_id.hex}"
    availability_domain =   "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
    cidr_block          =   "10.0.1.0/24"
    route_table_id      =   "${oci_core_route_table.rt.id}"
    security_list_ids   =   ["${oci_core_security_list.seclist.id}"]
    vcn_id              =   "${oci_core_virtual_network.vcn.id}"
}

```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`data "oci_identity_availability_domains":` Data block to retreive the Name of the availability .<br>
`resource "oci_core_subnet":` Manages a subnet.<br>
`compartment_id:` The compartment ocid where the virtual network is created.<br>
`display_name:` The dispaly name of the resource.<br>
`availability_domain:` The name of the availability domain in which the subnet need to deploy.<br>
`cidr_block:` The address space that is used for the sub network.<br>
`route_table_id:` The resource id of the Route table to which the subnet need to associate/attach. <br>
`security_list_ids:` The resource id of the security list to which the subnet need to attach.<br>
`vcn_id:` The resource id of the virtual network to which the route table needs to attach.

### Create Virtual Machine
1. Create a file named `instance.tf` and paste the below content.

```
resource "oci_core_instance" "instance" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")}"
    compartment_id      = "${var.compartment_ocid}"
    shape               = "${var.instance_shape}"
    display_name        = "tfinstance-${random_id.random_id.hex}"
    source_details {
      source_id         = "${var.image_id[var.region]}"
      source_type       = "image"
    }

    create_vnic_details {
      subnet_id         = "${oci_core_subnet.sub.id}"
      assign_public_ip  = true
    }

    metadata ={
      ssh_authorized_keys = "${var.sshPublicKey}"
    }
}

```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "oci_core_instance":` Manages a virtual Machine.<br>
`availability_domain:` The name of the availability domain in which the subnet need to deploy.<br>
`compartment_id:` The compartment ocid where the virtual network is created.<br>
`shape:`  The Image sku that we are using in to launch the instance.<br>
`display_name:` The dispaly name of the resource.<br>
`source_details:` This block is used to retrieve the type of the image using to launch the inastance.<br>
`source_id:` The ocid of the image we are using while deploying the instance.<br>
`source_type:` By default the source type is 'IMAGE'. <br>
`create_vnic_details:` The resource block is used to create and attach network interface card to the vm.<br>
`subnet_id:` The resource id of the subnet to which the vm need to attach.<br>
`assign_public_ip:` If we want to assign public ip to the vm we need to enable the falg to **true**.<br>
`metadata:` 
`ssh_authorized_keys:` 

3. Update the `variables.tf` with below content.

```
    variable "instance_shape" {
        default = "VM.Standard2.1"
    }
    variable "image_id" {
        type = "map"
        default={
            us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaag2qdx4i2j4h7tn2do5t6dc4yjaj2mc65kvfsgswpfdmfboe6rkoq"
        }
    }
    variable "sshPublicKey" {
        default = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqhTwbcQyGoLY99SSoXGEKXr/5b0sVHUCN1aeYplF1otZeh1zCC3YLX8ICZJqLCRiGg/o5A1g3kUTb5uuy0U6ABydLqsQxHIoYTkbPjZH2ULngFsSCYcwz7I3VbhDqRrqXGzbl+vLFqUc+o1gFHfyADKB3Hbnys9IqUQ8hmGpeTLvf+G+A2/6wTnYjLrJCyBuCY7fHdzV7nhXh2VSNS73IDmsF/EGXgzGmt08nA13rjPKaqKup7e0Kh8JepK6DOZrPV5qedv9AYmQ9X3/E6X4XGUYWXNOTgP7VCi7Ffj2tmokSjk9pkbLFwMEmpS4w9p5JXxBPOROEeop7uxOy3+O2w== rsa-key-20200107"
    }
```
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Please use the below link to take the image_id value based on the region and version you want to create.

https://docs.cloud.oracle.com/iaas/images/image/12df5e33-7fe4-48ef-8f5d-00c54d71aff3/

4. To generate an SSH key with PuTTYgen, follow these steps:

`4.1.`  Open the PuTTYgen program.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/19-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`4.2.`  For Type of key to generate, select SSH-2 RSA.

`4.3.`  Click the Generate button.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Note:** Move your mouse in the area below the progress bar. When the progress bar is full, PuTTYgen generates your key pair.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

`4.4.` Type a passphrase in the Key passphrase field. Type the same passphrase in the Confirm passphrase field. You can use a key without a passphrase, but this is not recommended.

`4.5.`  Right-click in the text field labeled Public key for pasting into OpenSSH authorized_keys file and choose Select All.

`4.6.`  Right-click again in the same text field and choose Copy.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

> Note: Make sure to copy and paste the key in variables.tf file under the variable **sshPublicKey**.

`4.7.`  Click the Save private key button to save the private key. Warning! You must save the private key. You will need it to connect to your machine.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/24-0.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/24-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Also follow the below steps to save the pem key file which will be used in further(while deploying null resource or extension resource we need pem file to connect to the vm and install the script.)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/49.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/50.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/51-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


5.  Create a file named `outputs.tf` and paste the below content. 

```
output "VM_Username" {
  value = ["${var.VM_user_name}"]
}
output "public_ip_address" {
  value = ["${oci_core_instance.instance.public_ip}"]
}
```
It will provide the VM Username and IPAddress after deploying the virtual machine in the oci cloud.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


### Deploy The Templates For Creating Virtual Machine

1. Make sure you update compartment_id value as `{{instance_shape}}` , `{{image_id}}`,`{{sshPublicKey}}` in `variables.tf` file.

2. Make sure you save all the files.

3. Execute `terraform init` command to download the plugins for random_id.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  
 
4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of resources that are going to deploy.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
You will get Plan: 7 to add, 0 to change, 0 to destroy message.

5. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

6. Type `yes` and click on `Enter` to approve the plan.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/30.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. You will get ```Apply complete! Resources: 7 added, 0 changed, 0 destroyed``` message once the deployment is completed also the outputs of vm.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/48.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/31-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Check The Deployed Resources In OCI Console.

8. Click on `switch` window icon and select `Chrome` browser to go back to the OCI Console.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/oci17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

9. Navigate to the **Menu** of the oci console and choose **compute**--> select **instances** to see the created virtual Machine resource.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/32.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/33.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/34.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

10. Now you have successfully deployed Virtual Machine using terraform templates. Click on `switch` window icon and go back to the `visual studio code` to create templates for other resources that are required for a virtual machine.

### Connect To The Virtual Machine

1. Click on `switch` window icon and select `Visual Studio`.

2. Copy the `VM_public_ip_address`.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/31-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. Click on `Apps` icon and select `Putty`.

4. Paste the `VM_public_ip_address`, make sure port is `22` and click on `open`.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/34-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/36.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Choose the privatekey name and click on open.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


5. Click on `yes`.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/38.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

6. Enter username as `ubuntu`

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

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

sudo apt-get update
sudo apt-get install -y firewalld
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
# exit
```

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/42.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

3. End of Line Sequence should be `LF` for the script. Otherwise you will get errors while executing the script.

4. To select `LF` as the end of line sequence, Click on `CRLF` at the bottom right corner of Visual Studio

  
### Create Null Resource Template For Installing Apache

1. Create a file named `extension.tf` and paste the below content.

```
resource "null_resource" "install_apache1" {
  connection {
    type        = "ssh"
    host        = "${oci_core_instance.instance.public_ip}"
    user        = "${var.VM_user_name}"
    private_key = "${(file(var.ssh-pvt-key))}"
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

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/43.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

We also need `pem file` of the `sshpublic key` to run the extension in the vm. For that create a file named as `instance_pvt_key.pem` and paste the pem key.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

2. Below is the explanation of resource.

`resource "null_resource":` The null_resource resource implements the standard resource lifecycle but takes no further action.<br>

`provisioner "file":` The file provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource.<br>

`provisioner "remote-exec":` The remote-exec provisioner invokes apache script on a virtual machine after it is created.<br>

3. Update the `variables.tf` with below content and save the file.

```
    variable "VM_user_name" {
        default = "ubuntu"
    }
    variable "ssh-pvt-key" {
        default= "./instance_pvt_key.pem"
    }
```

3. Execute `terraform init` command on terminal to download null resource plugins.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

4. Execute `terraform plan` command on terminal to create an execution plan which shows the information of 
resources that are going to deploy.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/44.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)  

5. You will get ```Plan: 1 to add, 0 to change, 0 to destroy``` message.

6. Execute `terraform apply` command to apply the changes required to reach the desired state configuration.

7. Type `yes` and click on `Enter` to approve the plan.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/45.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D) 
 
![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/46-1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

8. You have successfully installed apache inside the virtual machine using terraform.

9. Click on `Switch windows` icon and select Chrome.

10. Browse the `VM_public_ip_address` in new tab.

![](https://qloudableassets.blob.core.windows.net/devops/OCI/Terraform/Images/47.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

11. Apache is installed successfully through Terraform templates.

`Conclusion:` Congratulations! You have successfully completed Terraform on OCI lab for creating a Virtual machine and for adding extension to it using Terraform templates. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">


Thank you for taking this training lab.
