# CHEF-SERVER-SETUP

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create VPC and related network resources](#create-vpc-and-related-network-resources)

[Create Amazon EC2 Key Pair](#create-amazon-ec2-key-pair)

[Create EC2 instances for chef server and workstation](#create-ec2-instances-for-chef-server-and-workstation)

[Login to the Instance](#login-to-the-instance)

[Chef Server Configuration](#chef-server-configuration)

[Workstation Configuration](#workstation-configuration)

[Bootstrap a Node](#bootstrap-a-node)

[write a cookbook](#write-a-cookbook)

## Overview

Chef has three main architectural components: Chef Server, Chef Client (node), and Chef Workstation.

The Chef Server is the management point and there are two options for the Chef Server: a hosted solution or an on-premises solution. We will be using a hosted solution.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The Chef Client (node) is the agent that sits on the servers you are managing.

The Chef Workstation is the admin workstation where we create policies and execute management commands. We run the knife command from the Chef Workstation to manage the infrastructure.

There is also the concept of “Cookbooks” and “Recipes”. These are effectively the policies we define and apply to the servers.
## Pre-Requisites

1) Basic knowledge of Linux servers

2) YAML language

3) SSH private/public key knowledge

## Login to AWS Console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

3. Use below credentials to login to AWS console.

    - Account ID: {{Account ID}}
    - IAM username: {{user name}}
    - Password: {{password}}
    - Region: {{region}}
 

4. Enter **Account ID** from the above information, then click on **Next**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/1.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter **IAM username** and **Password** from the above information and click on **Sign In**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/2.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/3.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/4.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Create VPC and related network resources

### create VPC

1. Click on **Services**, search for **VPC** and select **VPC** from the options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/05.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on **Your VPCs** in the left side navigation pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/5.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on **Create VPC** button

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/6.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Enter below details 

    * Name tag: **testvpc**
    * IPv4 CIDR block: **10.0.0.0/16**
    * IPv6 CIDR block:  **No IPv6 CIDR Block**
    * Tenancy: **Default**

  Click on **create** button.  

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/7.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Once the VPC creation is completed, **The following VPC was created** message will pop up. Click on **close** button to see the created VPC.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/8.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create Internet Gateway

1. Click on **Internet Gateways** on the left pane and click on **Create Internet Gateway** button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/9.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter below details and click on **create** button.

    * Name tag: **test-IG**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/10.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Internet Gateway creation is completed, **The following internet gateway was created** message will pop up. Click on **close** button to see the created Internet Gateway. By default the **state** of Internet Gateway shows **detached**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/11.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Attach the Internet Gateway to VPC

4. select the **test-IG** Internet Gateway, choose **Attach to VPC** option from **Actions** drop down.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/12.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. select the **testvpc** from drop down and click on **Attach**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/13.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create a route in route table with internet gateway

1. When you create a VPC, route table also will create along with that.

2. To see the route table that is created while creating **testvpc**, Click on **Your VPCs** in the left side navigation pane and select **testvpc** to see the route table.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/14.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on the **route table** 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/15.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Choose **routes** and click on **Edit routes**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/16.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. click on **Add route** and enter the below details.

    * Destination: **0.0.0.0/0**
    * Target: Choose **internet gateway** from drop down and then select **test-IG**

  click on **save routes**  

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/17.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once the route creation is completed, **Routes successfully edited** message will pop up. Click on **close** button to see the edited route.

### Create Subnet

1. Choose **Subnets** in the left navigation pane and click on **Create subnet** button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/18.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Specify the below details.

    * Name tag: **test-subnet**
    * VPC: Choose **testvpc** from dropdown
    * Availability Zone: **No preference**
    * IPv4 CIDR block: **10.0.0.0/24**

Click on **create** button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/19.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Subnet creation is completed, **The following Subnet was created** message will pop up. Click on **close** button to see the created Subnet.

## Create Amazon EC2 Key Pair

Amazon EC2 Key Pairs: Amazon EC2 uses public–key cryptography to encrypt and decrypt login information. Public–key cryptography uses a public key to encrypt a piece of data, and then the recipient uses the private key to decrypt the data. The public and private keys are known as a key pair.

You must provide the key pair to Amazon EC2 when you create the instance, and then use that key pair to authenticate when you connect to the instance.

### create EC2 Key Pair

1. Click on **Services** and select **EC2** under the **compute** options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/20.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane, under **NETWORK & SECURITY**, choose **Key Pairs** and click **Create Key Pair**

**Note:** The navigation pane is on the left side of the Amazon EC2 console. If you do not see the pane, it might be minimized; choose the arrow to expand the pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/021.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. For **Key pair name**, enter **test-keypair**, and then choose **Create**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/21.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is **.pem**.

### Convert the .pem file into .ppk file

1. Click on the **Apps** icon and click on **PuTTYgen**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/22.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on **Load**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/23.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. choose **All files** at the bottom, select test-keypair.pem file in downloads folder and click on **open**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/24.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Click on **Save Private Key**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/25.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter **test-keypair** as **File name**, save type as **PuTTY Private Key Files(*.ppk)** and click on **save** and close Putty key Generator.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/26.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Note**

In coming sections, you'll need to provide the name of your key pair when you launch an instance and the corresponding private key (.ppk file) when you connect to the instance.

## Create EC2 instances for chef server and workstation

1. Click on **Services**, select **EC2** under **Compute** section.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/27.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/28.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. In **Step 1: Choose an Amazon Machine Image (AMI)**, search for **Ubuntu Server 16.04 LTS**, choose an image which is eligible for **free tier** and choose **Select.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/29.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. In **Step 2: Choose an Instance Type**, select **t2.medium** type and choose **Next: Configure Instance Details.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/30.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. In **Step 3: Configure Instance Details**, specify the below details.

    * Number of Instances **2**  (one for Ansible control machine other for Ansible node)
    * Network: choose **testvpc** from drop down
    * Subnet: Choose **test-subnet** from dropdown
    * **Auto-assign Public IP: Enable**
    
    Keep the default values for others and choose **Next: Add Storage.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/31.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Keep the default values for others and choose **Next: Add Tags.**. Click on **Add tag** Add tags page.

* Enter **Key** as **Name**
* Enter **Value** as **instance1**  or give any name

And choose **Next: Configure Security Group.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/32.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. In Step 6: **Configure Security Group**, review the contents of this page, ensure that **Assign a security group** is set to **Create a new security group** and specify the below details.

* Security group name: **test-SG**
* Description: **test Security Group**

Click on **Add Rule**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/33.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Specify the below details.
  
   * Protocol: **TCP**
   * Port Range: **443**
   * source: **0.0.0.0/0** 

  choose: **Review and Launch**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/34.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. Choose **Launch**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/35.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. choose **test-keypair** from **Select a key pair drop down** which you created in previous step and enable acknowledge check box and click **Lauch Inatances**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/36.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. Click on **view Instances** at the bottom right. Here you can see the two instances that are launched. Click refresh icon on Right top of console to view Instance state.You can change tag names by mouse over on instance1 and click edit.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/37.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Copy the Instacne public IP

## Login to the Instance

1. Click on **Apps Icon** and open **Putty**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/38.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Paste the **Publilc IP** and then expand the SSH section on left pane by clicking on **+** symbol.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/39.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. select **Auth** under **SSH** section in the left panel and click on **Browse**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/40.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Go to the path where **test-keypair.ppk** file is saved, select the **.ppk** file and click on **Open**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/41.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click on **Open**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/42.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. A prompt will be opened, click on **yes**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/43.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Enter login as: **ubuntu**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/44.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

similarly login to workstation serve also.

## Chef Server Configuration

**Chef Server Configuration:**

Step 1. Switch to the root user

**``` sudo -i```**

Step 2. Run the below command to download the chef server.

**``` wget https://packages.chef.io/files/stable/chef-server/12.17.5/ubuntu/16.04/chef-server-core_12.17.5-1_amd64.deb```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
Step 3. Install the Chef server package, using the name of the package downloaded.

**``` dpkg -i chef-server-core_*.deb```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4. Run the following to start the chef services

**``` chef-server-ctl reconfigure```**

As the Chef server is composed by many different services that work together to create a functioning system, this step may take a few minutes to execute.
  
Step 5. Run the following command to create an administrative user for chef server web console.

**Syntax :** chef-server-ctl user-create USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL 'PASSWORD' (options)

**``` chef-server-ctl user-create chefadmin Chef Admin admin@test.com Password@1234 --filename /etc/opscode/chefadmin.pem```**

Note: Remember the user name and password.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

An RSA private key is generated automatically. This is the user’s private key and should be saved to a safe location. The --filename option will save the RSA private key to the specified absolute path.
 
Step 6. Run the following command to create an organization:

An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The --filename option will save the RSA private key to the specified absolute path.

Syntax: chef-server-ctl org-create ORG_NAME "ORG_FULL_NAME" (options)

**``` chef-server-ctl org-create orguser  “chef-orguser, Inc.” --association_user chefadmin --filename /etc/opscode/orguser-validator.pem```**
  
![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 7. To enable Chef server web view run below commands.

**``` chef-server-ctl install chef-manage```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
**Run:**

**```curl ifconfig.co```**  outputs the Public IP of chef server.

**``` sudo hostname <chef_server_publicip>```**

**``` chef-server-ctl reconfigure```**

**``` chef-manage-ctl reconfigure --accept-license  ```**

It takes 2 to 3 mins

After that chef server configuration is ready

Step 8. You can browse chef-server from chrome with Ip. use Username and passwords as created above.

```https://<chef-server-Public-IP>```

**click Advanced and then click Proceed to ip (unsafe)**


![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Workstation Configuration

The Workstation is where you create cookbooks, recipes, attributes and manage configurations. A workstation can be hosted on any machine, on any flavor of OS but it is recommended that you host it on a remotely accessible machine.

**Setting Up a Workstation:**

Open putty from applications drop-down at top-left corner of the workspace.
 
Step 1. Connect using the IP and .ppk of "Workstation Server VM".

Step 2. After login to workstation, Run the below command to download the Chef Development Kit.

**``` wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb```**

Step 3. Run the below command to install ChefDK.

**``` sudo dpkg -i chefdk_*.deb```**

Step 4. Run the below command to verify the components of the development kit.

**``` chef verify```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

### Downloading the Starter kit:

Step 5. Open new tab on chrome browser and enter ```https://< chef server public ip>```

Login: chefadmin<br>
Password: Password@1234

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Step 6. Click on orguser organization under the Administration tab, then select Starter kit from the navigation panel.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Step 7. Click on Download starter kit, Ignore any warnings and click on proceed.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
Step 8. Open git bash from application dropdown.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
Step 9. Copy the downloaded starter kit and private key(.pem) files to the chef workstation. Private key will be used in **bootstrap a node** step

**``` scp -i ~/Downloads/test-keypair.pem ~/Downloads/* ubuntu@Workstation_ip:/home/ubuntu```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
**Switch to the workstation window using**

Step 10. Make sure you have starter kit and private key in home directory.

**``` ls $HOME```**

Extract the starter kit. 

```sh
sudo apt-get install unzip
sudo unzip chef-starter.zip
```
The starter kit contains "chef-repo" repository containing .chef, cookbooks and roles sub-directories.

".chef" directory contains configuration file (knife.rb) and chef-server user key.

"Cookbook" directory is the default to store and upload the cookbooks to chef server.

Note: All the knife commands are to be executed from chef-repo directory.

**``` cd ~/chef-repo```**

Initialize the git on chef-repo

**``` sudo git init```**
 
Step 11. Download and check the certs from the Chef Server to the CheckDK host

**``` sudo knife ssl fetch```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

WARNING: Certificates from chef-server will be fetched and placed in your trusted_cert directory (/home/ubuntu/chef-repo/.chef/trusted_certs).
You should verify the authenticity of these certificates after downloading.
 
**``` sudo knife ssl check```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Bootstrap a Node

Bootstrapping a node installs the chef-client and validates the node, allowing it to read from the Chef server and make any needed configuration changes picked up by the chef-client in the future.

1.From your workstation, bootstrap the node either by using the node’s root user, or a user with elevated privileges:

As the node’s root user, changing password to your root password and nodename to the desired name for your node. You can leave this off it you would like the name to default to your node’s hostname:

As a user with sudo privileges, change username to the username of a user on the node, password to the user’s password and nodename to the desired name for the node. You can leave this off it you would like the name to default to your node’s hostname:

**```knife bootstrap localhost -x  <workstation username> -P <Workstation Password> --sudo --node-name chefnodevm```**


## write a cookbook

In this section we well leran about how to write a cookbook and how to apply on node.

From your workstation, move to your chef-repo:

**``` cd ~/chef-repo/cookbooks```**
 
Moving on to create a cookbook, named lamp-stack.

**``` sudo chef generate cookbook  lamp-stack```**
 
Change directory to the new cookbook.

**``` cd lamp-stack```**
 
Listing the files in the cookbook, you'll see the defaults.
**``` ls```**
 
default.rb

The default.rb file in recipes contains the “default” recipe resources.

Because each section of the LAMP stack (Apache, MySQL, and PHP) will have its own recipe, the default.rb file is used to prepare your servers.

1.From within your lamp-stack directory, navigate to the recipes folder:
 
Install and Enable Apache

Apache will also need to be set to turn on at reboot, and start. In the same file, add the additional lines of code:

This uses the service resource, which calls on the Apache service; the enable action enables it upon startup, whereas start will start Apache.

**``` sudo vim recipes/default.rb```**

add below code then save and close the default.rb file
```sh
execute "update" do
  command "apt-get update -y"
end
package "apache2" do
        action :install
end
service "apache2" do
        action [:enable, :start]
end
```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

To apply the Apache recipe, upload the LAMP Stack recipe to the  chef server:

**``` sudo knife cookbook upload lamp-stack```**
 
Add the recipe to a node’s run-list, replacing nodename with your chosen node’s name:

**``` sudo knife node run_list add chefnodevm "recipe[lamp-stack::default]"```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
From that node, run the chef-client:

**``` sudo chef-client```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
After a successful chef-client run, check to see if Apache is running:

**``` service apache2 status```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
  
Paste chef server Url ```https://< chef-server-ip>/organizations/orguser``` in web browser.

Login with your user name and password

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

You can see the page like below.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/chef-server/images/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
