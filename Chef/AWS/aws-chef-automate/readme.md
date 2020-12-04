# CHEF AUTOMATE

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create VPC and related network resources](#create-vpc-and-related-network-resources)

[Create Amazon EC2 Key Pair](#create-amazon-ec2-key-pair)

[Create EC2 instances for chef Automate, Chef Server  and workstation](#create-ec2-instances-for-chef-automate-chef-server-and-workstation)

[Installing and configuring chef server](#installing-and-configuring-chef-server)

[Install and cofigure Chef Automate](#install-and-cofigure-chef-automate)

[Configure chef worstation](#configure-chef-worstation)

[Bootstrap a node, Scan and fix compliance issues](#bootstrap-a-node-scan-and-fix-compliance-issues)

## Overview


Chef Automate
Chef Automate provides a full suite of enterprise capabilities for workflow, node visibility and compliance. Chef Automate integrates with the open-source products Chef, InSpec and Habitat. Chef Automate comes with comprehensive 24×7 support services for the entire platform, including open source components.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/01.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Compliance:
Chef Automate 1.5.46 or later provides an easy way to view how successful the nodes in your infrastructure are at meeting the compliance requirements specified by your organization. Several built-in profiles are included in Chef Automate to scan for security risks, outdated software, and more. These profiles cover a variety of security frameworks, such as Center for Internet Security (CIS) benchmarks. If you have additional compliance requirements, you can also write your own compliance profiles in InSpec and upload them to Chef Automate. For more information how to view the compliance status across your cluster, see Compliance Overview.

If you are using an older version of Chef Automate, or your workflow requires you to use our standalone Chef Compliance server, you can find general information on Chef Compliance here

Nodes:
Chef Automate gives you a data warehouse that accepts input from Chef, Habitat, and Chef Automate workflow and compliance. It provides views into operational, compliance, and workflow events. There is a query language available through the UI and customizable dashboards. For more information, see Nodes Overview

Workflow:
Chef Automate includes a pipeline for continuous delivery of infrastructure and applications. This full-stack approach, where infrastructure changes are delivered in tandem with any application changes, allows for safe deployment at high velocity. For information Chef Automate safely moves changes move through a gated pipeline, see Workflow Overview.

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

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/1.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter **IAM username** and **Password** from the above information and click on **Sign In**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/2.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/3.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/4.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Create VPC and related network resources

### create VPC

1. Click on **Services**, search for **VPC** and select **VPC** from the options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/05.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on **Your VPCs** in the left side navigation pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/5.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on **Create VPC** button

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/6.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Enter below details 

    * Name tag: **testvpc**
    * IPv4 CIDR block: **10.0.0.0/16**
    * IPv6 CIDR block:  **No IPv6 CIDR Block**
    * Tenancy: **Default**

  Click on **create** button.  

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/7.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Once the VPC creation is completed, **The following VPC was created** message will pop up. Click on **close** button to see the created VPC.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/8.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create Internet Gateway

1. Click on **Internet Gateways** on the left pane and click on **Create Internet Gateway** button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/9.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter below details and click on **create** button.

    * Name tag: **test-IG**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/10.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Internet Gateway creation is completed, **The following internet gateway was created** message will pop up. Click on **close** button to see the created Internet Gateway. By default the **state** of Internet Gateway shows **detached**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/11.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Attach the Internet Gateway to VPC

4. select the **test-IG** Internet Gateway, choose **Attach to VPC** option from **Actions** drop down.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/12.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. select the **testvpc** from drop down and click on **Attach**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/13.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create a route in route table with internet gateway

1. When you create a VPC, route table also will create along with that.

2. To see the route table that is created while creating **testvpc**, Click on **Your VPCs** in the left side navigation pane and select **testvpc** to see the route table.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/14.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on the **route table** 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/15.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Choose **routes** and click on **Edit routes**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/16.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. click on **Add route** and enter the below details.

    * Destination: **0.0.0.0/0**
    * Target: Choose **internet gateway** from drop down and then select **test-IG**

  click on **save routes**  

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/17.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once the route creation is completed, **Routes successfully edited** message will pop up. Click on **close** button to see the edited route.

### Create Subnet

1. Choose **Subnets** in the left navigation pane and click on **Create subnet** button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/18.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Specify the below details.

    * Name tag: **test-subnet**
    * VPC: Choose **testvpc** from dropdown
    * Availability Zone: **No preference**
    * IPv4 CIDR block: **10.0.0.0/24**

Click on **create** button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/19.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Subnet creation is completed, **The following Subnet was created** message will pop up. Click on **close** button to see the created Subnet.

## Create Amazon EC2 Key Pair

Amazon EC2 Key Pairs: Amazon EC2 uses public–key cryptography to encrypt and decrypt login information. Public–key cryptography uses a public key to encrypt a piece of data, and then the recipient uses the private key to decrypt the data. The public and private keys are known as a key pair.

You must provide the key pair to Amazon EC2 when you create the instance, and then use that key pair to authenticate when you connect to the instance.

### create EC2 Key Pair

1. Click on **Services** and select **EC2** under the **compute** options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/20.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane, under **NETWORK & SECURITY**, choose **Key Pairs** and click **Create Key Pair**

**Note:** The navigation pane is on the left side of the Amazon EC2 console. If you do not see the pane, it might be minimized; choose the arrow to expand the pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/021.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. For **Key pair name**, enter **test-keypair**, and then choose **Create**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/21.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is **.pem**.

## Create EC2 instances for chef Automate, Chef Server and workstation

1. Click on **Services**, select **EC2** under **Compute** section.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/27.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/28.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. In **Step 1: Choose an Amazon Machine Image (AMI)**, search for **Ubuntu Server 16.04 LTS**, choose an image which is eligible for **free tier** and choose **Select.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/29.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. In **Step 2: Choose an Instance Type**, select **t2.medium** type and choose **Next: Configure Instance Details.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/30.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. In **Step 3: Configure Instance Details**, specify the below details.

    * Number of Instances **3**  (one for Ansible control machine other for Ansible node)
    * Network: choose **testvpc** from drop down
    * Subnet: Choose **test-subnet** from dropdown
    * **Auto-assign Public IP: Enable**
    
    Keep the default values for others and choose **Next: Add Storage.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/31.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Keep the default values for others and choose **Next: Add Tags.**. Click on **Add tag** Add tags page.

* Enter **Key** as **Name**
* Enter **Value** as **instance1**  or give any name

And choose **Next: Configure Security Group.**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/32.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. In Step 6: **Configure Security Group**, review the contents of this page, ensure that **Assign a security group** is set to **Create a new security group** and specify the below details.

* Security group name: **test-SG**
* Description: **test Security Group**

Click on **Add Rule**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/33.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Specify the below details.
  
   * Protocol: **TCP**
   * Port Range: **443**
   * source: **0.0.0.0/0** 
  
  Similarly  add 80 port also. Next  choose: **Review and Launch**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/34.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. Choose **Launch**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/35.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. choose **test-keypair** from **Select a key pair drop down** which you created in previous step and enable acknowledge check box and click **Lauch Inatances**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/36.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. Click on **view Instances** at the bottom right. Here you can see the three instances that are launched. Click refresh icon on Right top of console to view Instance state.You can change tag names by mouse over on instance1 and click edit.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/37.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Note down the three Instacne public IPs


## Installing and configuring chef server

In this section, you'll be installing and configuring the Chef server.

### Login to chef serverW

Click on **Apps Icon** and open **Git bash**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/22.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**To connect to Chef server Run below command on git bash**

 **HINT:** You can swap between the workspace windows by clicking the Switch Window icon besides to app Icon.

```ssh -i ~/Downloads/test-keypair.pem ubuntu@<chef server IP>```

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/39.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Installation Script:

The below script will download and install the chef server and it creates chef user(chefadmin) and organization (orguser). 

In chef-server **Run:** 

**```sudo -i```**        (**chef server installation should be on root use**r)

**``` wget https://raw.githubusercontent.com/sysgain/tl-scripts/master/chef-server-setup.sh```**
 
**``` bash chef-server-setup.sh```**
 
The process would take 10 to 15 minutes. Meanwhile, go to the next section and Install Chef automate.

## Install and cofigure Chef Automate

In this section, we are going to install Chef Automate server and create a user for Chef Automate web console.

1. Copying keys to Chef Automate server:

    1.1 Open a new "Git-bash" from the "Apps" icon. 

    1.2 To get the keys from Chef-server with SCP command, you'll need SSH keys into Automate server. 

    1.3 In this lab, we are used the same keys for all the three servers. Push these keys from git bash to Automate server with scp command.

    1.4 On AWS console copy second server IP and pass it to below command. This command will copy the ".pem" file to Chef Automate Home directory. 

    **```scp -i ~/Downloads/test-keypair.pem ~/Downloads/test-keypair.pem  ubuntu@<ChefAutomate_public_IP>:/home/ubuntu```**<br>
    
    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/40.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

    1.5 Now login to Chef Automate server 

    **```ssh -i ~/Downloads/test-keypair.pem ubuntu@<Public_IP>```**

    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/41.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

    1.6 Check for the copied keys:<br>  **```ls ~```**

    1.7 we will copy the Chef user-key after Chef-server setup script is succeeded.

2. Download and Install Chef Automate:<br>

    Go to sudo user and run the installation steps.

    **```sudo -i ```**

    **``` wget https://packages.chef.io/files/stable/automate/1.8.38/ubuntu/16.04/automate_1.8.38-1_amd64.deb```**
 
3. Installing deb package:<br>
 
    **``` dpkg -i automate_1.8.38-1_amd64.deb```**

    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/42.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
    
    To set up the Chef Automate server we require Chef server user key and Chef Automate license. Run below command to get temporary Automate license.
 
    **``` wget https://aztdrepo.blob.core.windows.net/chefautomate-testdrive/automate.license -O /tmp/automate.license```**
 
   Next, wait until Chef server script succeeded.
 
4. Copying user key from Chef-server:
 
    
    4.1 Run below command it copies the Chef-server user key to /tmp directory. Pass **chef server IP** in below command
 
    **``` scp -i /home/ubuntu/test-keypair.pem ubuntu@<chef-server IP>:/etc/opscode/chefadmin.pem /tmp ```**

    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/43.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
5. **Chef Automate Setup:**
 
    Run below command to set up the Automate server, in this command, we are passing the Automate license, Chef-server user key file paths and **chef server Private ip**(take it from AWS instance details page). 
 
    **```automate-ctl setup --license /tmp/automate.license --key /tmp/chefadmin.pem --server-url https://<Chef-server-PrivateIP>/organizations/orguser --fqdn $(hostname) --enterprise default --configure --no-build-node```**
 
    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/44.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
    Run:   **``` automate-ctl reconfigure```**
 
6. Creating Chef Automate user:
 
    **``` automate-ctl create-user default chefuser --password Password@1234 --roles "admin"```**
 
        
    **NOTE:** Run below commands on **Chef server**
 
    Go to **chef server:**  
    
    **HINT:** You can swap between the workspace windows by clicking the Switch Window icon besides to app Icon.
 
    **``` chmod 777 /etc/opscode/chef-server.rb```**
 
    Pass Chef Automate IP in below command and run it enables the compliance data collection.
 
    **```  echo "data_collector['root_url'] = 'https://<Automate public IP>/data-collector/v0/'" >> /etc/opscode/chef-server.rb```**

    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/45.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

    **```chef-server-ctl reconfigure```**
 
    Browse Chef Automate on your favorite browser 

    **HINT:** You can swap between the workspace windows by clicking the Switch Window icon besides to app Icon.

    ```https://chefautomate-IP```

   Login username: **chefuser**<br>
   Password: **Password@1234**

    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/46.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

    ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/47.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
 
## Configure chef worstation

In this section, you'll learn how to install Chefdk and workstation configuration steps.

1. Open a new "git-bash" terminal 

2. We need to send private key to the Workstation. Follow steps mentioned in the previous section.

   **```scp -i ~/Downloads/test-keypair.pem ~/Downloads/test-keypair.pem  ubuntu@<Chefworkstation_public_IP>:/home/ubuntu```**<br>

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/48.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 
   ssh to Chef workstation 

   In git-bash run 

   **```ssh -i ~/Downloads/test-keypair.pem ubuntu@<workStationPublic_IP>```**
![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/49.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
 

3. Check keys are copied or not:<br>  

   **```ls ~```**
   
  ### Download and Install ChefDk
   
 
   ```sh
   sudo -i
   wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb
   dpkg -i chefdk_*.deb
   ```
   verify the components of the development kit

   **``` git init```**

   **```Chef verify  ```**

4. **Download Starter kit**

**HINT:** You can swap between the workspace windows by clicking the Switch Window icon besides to app Icon.

   Open a new tab on chrome browser and enter **https://< Chef-server-public-ip>**

   **Login: chefadmin**<br>
   **Password: Password@1234**

   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/50.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   After login, you can see Chef server web console. Click on Administration tab and click on orguser organization,  then select Starter kit from the left panel.

   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/51.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   Click on Download starter kit and click Proceed.

   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/52.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


   From workstation instance run exit. and copy the starter kit from git bash to workstation VM

   **run twise: **<br> **``` exit```**

   Now we need to copy the downloaded starter kit to Chef-workstation.

   **Run in git bash**

   **```scp -i ~/Downloads/test-keypair.pem ~/Downloads/chef-starter.zip ubuntu@<workstationIP>:/home/ubuntu```**

   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/53.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


   **ssh to workstation**

   **```ssh -i ~/Downloads/test-keypair.pem ubuntu@<workstation PublicIP>```**

   Install unzip
   
   **```sudo apt-get install unzip```**
   
   **```sudo unzip chef-starter.zip```**

   The starter kit contains Chef-repo repository. it has ".Chef", cookbooks and roles folders

   where .chef folder contains knife.rb (configuration file) and Chef-server user key

   cookbook folder is to store cookbooks and it is the default path to unload the cookbook to Chef server.

   **NOTE: You should run every knife command from chef-repo folder, other wise commands will get fail**

   **```cd ~/chef-repo```**
   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/54.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   Initialize the git on Chef-repo

   **```sudo git init```**

5. Download and check the certs from the Chef Server to the CheckDK host:

   **```sudo knife ssl fetch```**

   WARNING: Certificates from Chef-server will be fetched and placed in your trusted_cert directory (/home/ubuntu/Chef-repo/.Chef/trusted_certs).

   You should verify the authenticity of these certificates after downloading.

   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/55.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

   **```sudo knife ssl check```**

   ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/56.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Bootstrap a node, Scan and fix compliance issues

In this section, we will see how to bootstrap the workstation vm itself as chef node and scan the compliance and fix the issues by applying cookbooks on the workstation

Bootstrap the Workstation:

1. Run the below command to bootstrap the workstation

**``` sudo knife bootstrap localhost -x ubuntu -i ~/Downloads/test-keypair.pem -N chefnode --sudo```**

2. Now download the cookbooks

**``` sudo git clone https://github.com/sysgain/OCI-chef-tl-cookbooks.git```**

3. Move or copy the cookbooks to cookbook folder.

**``` sudo mv  OCI-chef-tl-cookbooks/* cookbooks/```**

Upload Cookbooks to Chef Server:

**Run**

**``` sudo knife cookbook upload audit-linux compat_resource ohai sysctl os-hardening```**

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/58.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

4. Go back to Chef Automate web page and refresh the page, there you can see a node is added

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/59.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

5. Now add audit-linux recipe to chefnode run list

**``` sudo knife node run_list add chefnode "recipe[audit-linux]"```**

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/60.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Now run:**

**``` sudo chef-client```**

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/61.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

6. Go to Chef automate and click compliance tab, here we see the chef node compliances.

  ![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/62.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

7. Click on 1Nodes then click node name to view the list of compliances.

To fix the issues we need to apply the os-hardening cookbook.

8. Add the os-hardening recipe to chefnode runlist

**``` sudo knife node run_list add chefnode "recipe[os-hardening]"```**

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/63.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Now run :

**``` sudo chef-client```**

It will fix compliance issues.

9. Now refresh the Chef automate you can see the node is passed in compliance tab.

![](https://qloudableassets.blob.core.windows.net/devops/AWS/aws-chef-automate/images/64.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
