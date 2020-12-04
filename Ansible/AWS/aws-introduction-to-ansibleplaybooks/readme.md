# INTRODUCTION TO ANSIBLE PLAYBOOKS ON AWS

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create VPC and related network resources](#create-vpc-and-related-network-resources)

[Create Amazon EC2 Key Pair](#create-amazon-ec2-key-pair)

[Create EC2 instances for Ansible](#create-ec2-instances-for-ansible)

[Login to the Instance](#login-to-the-instance)

[Install Ansible](#install-ansible)

[Creating SSH Keys for Ansible to access other instances](#creating-ssh-keys-for-ansible-to-access-other-instances)

[Create a Playbook](#create-a-Playbook)

[Install multiple roles in servers](#install-multiple-roles-in-servers)

[Variables and handlers](#variables-and-handlers)


## Overview

Welcome to the Introduction to Ansible Playbooks Learning Lab!

Ansible Playbooks are an organized unit of scripts that is used for server configuration management by the automation tool Ansible. Ansible Playbooks are used to automate the configuration of multiple servers at a time. Playbooks are written in YAML format.

Playbook contains one or more plays/tasks which executes a simple command or a script. Every playbook has an attribute hosts, where servers or group of servers are defined. These plays are executed in sequencial manner on the servers defined in the playbook.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

It is possible to run several hundreds of tasks in a single playbook, but it is efficient to reuse a task multiple time in multiple playbooks so tasks or group of tasks can be organized into roles. These roles can be included into a playbook. Directory structure of a sample ansible project is:

provision.yaml<br>
webserver.yaml
roles/
  provision_server/
  tasks/
    main.yaml
  handlers/
  files/
  templates/
  vars/
  defaults/
  webserver/
  tasks/
  files/
  templates/

In the above hierarchy provision.yaml and webserver.yaml are the playbooks defined in the project and roles directory contains 2 roles, provision and webserver.

Each role has multiple folders:

- tasks - contains single or multiple yaml files with each file containing multiple tasks
- handlers - contains handlers that can be used in this role like restart service 
- files - contains files that are copied into the target machine
- templates - contains a template file which can be used for deploying into the target machine. Template files are used with the variables defined in the playbook.
- vars - common variables that are used in this role. 
- defaults - variables that are default for the role can be defined in this folder. 

In the above folder structure the tasks folder is the mandatory folder and all the other folders are optional. In this tutorial we will learn about ansible playbooks and how different roles are executed in multiple servers from a single playbook. We will learn some Ansible features and how they are helpful in playbooks.

Click Start above to begin the lab!


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

## Create EC2 instances for Ansible

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

choose: **Review and Launch**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/33.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Choose **Launch**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/35.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. choose **test-keypair** from **Select a key pair drop down** which you created in previous step and enable acknowledge check box and click **Lauch Inatances**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/36.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. Click on **view Instances** at the bottom right. Here you can see the two instances that are launched. Click refresh icon on Right top of console to view Instance state.You can change tag names by mouse over on instance1 and click edit icon.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/37.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. Copy the Instacne public IP

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

## Install Ansible

**Step 1.**  We now have a instance in AWS with a Public IP  address which is accessible over the internet. 

**Step 2.** The "sudo" command allows user to run programs with elevated privileges and "su" command allows you to become another user. Running the following command will default to root account(system administrator account) which allows installing and configuring ansible using apt-get package manager.

```sudo su - ```

```apt-add-repository ppa:ansible/ansible -y ```

```apt-get update```

```apt-get install -y ansible```
 
**Note:** Along with Anisble package, multiple pre-requisite packages are being installed which takes a couple of minutes.


**Step 3.** Ansible has a default inventory file created which is located at "/etc/ansible/hosts". Inventory file contains a list of nodes which are managed/configured by ansible.

It is always a good practice to back up the default inventory file to reference it in future if required.

Run the following commands to move and create a new inventory file

```sudo mv /etc/ansible/hosts /etc/ansible/hosts.orig```

```sudo touch /etc/ansible/hosts```

```vi /etc/ansible/hosts```

**Step 4.** Update the created hosts file in the step 8 with the following data

Press i to change vi editor to insert mode then copy and past the below lines to hosts file. Afer updating the file, press Esc wq to save save and quit the file.
```
[local]
127.0.0.1
```
**Step 5.** In the Step 9, we have added local server's ip address(127.0.0.1) to the hosts inventory file, ansible uses the host file to SSH into the servers and run the required ansible jobs.

**Step 6.** To validate Ansible is installed and configured correctly, run the following command

 ansible --version

**Note:** It is ok, if the above command returns different version of ansible. 

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Creating SSH Keys for Ansible to access other instances

In this section, we will create a public and private SSH key pairs for ansible control machine to SSH into the nodes defined in inventory file.

Ansible control machine is a server on which Ansible is installed and executes Ansible tasks on the managed nodes.

An inventory file is a list of managed nodes which are also called "hosts". Ansible is not installed on managed nodes.

**Step 1.** In the terminal of Ansible Control Machine (where ansible is installed), enter the command ```ssh-keygen```

Press "Enter", when asked for the following:

    a) Enter file in which to save the key 

    b) Enter passphrase

    c) Enter passphrase again

**Tip:** No Passphrase is required.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 2.** Public and Private keys should have been generated and are stored in the directory /root/.ssh/. Public key need to be copied to authorized keys file, which gives Ansible access to login into the managed node.

**Note:** In this example Ansible control machine and the managed node is the same server. If authorized_keys file is already available, overwrite it with the public key or a new file is generated.


Execute the following commands to copy the public key:

```cd /root/.ssh```

```cp id_rsa.pub authorized_keys```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 3.** Open authorized_keys and copy the data using the following command:

``` cat /root/.ssh/authorized_keys```
            
Highlight the SSH key and copy (using the mouse)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 4.** Login to the second server there We need to paste the copied public key to the authorized keys file in the second server. Follow the steps to copy the public key:

**Tip:** You can swap between the workspace windows (Putty,Notepad etc.) by clicking the Switch Window icon.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

```sh
sudo su -
cd /root/.ssh/
vi authorized_keys
```
Copy the key into authorized_keys file 
 

**Note:** The public key needs to be copied into authorized_keys file in all servers(nodes) so that ansible control machine can SSH into the machines.

**Step 5.** In the Ansible Control Machine, Check to see if Ansible is able to connect to the servers, defined in the inventory file that was created in the previous section. Execute the following command which pings the servers in the inventory file.

```ansible all -m ping```

Enter "yes" when prompted to add server ip to the known_hosts file. You might need to type twice as 2 hosts are added to the known_hosts file.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Above command pings the servers defined in the inventory file that is created in the previous steps. Since only local machine is added in the inventory file ansible does a ping on the local machine using the SSH key created. 


## Create a Playbook

In this section, we will create an Ansible playbook and learn mroe about roles in Ansible.

**Note:** In this lab by default the "vi" text editor is used to update files. To learn vi text editor visit "https://ryanstutorials.net/linuxtutorial/vi.php". Any other user preferred text editor can be used to update files.

Ansible has an inbuilt tool ansible-galaxy which is used to create roles. Roles are pre-packaged units of work known to Ansible as roles. Roles can be accessed from Ansible playbooks. Roles consist of the tasks it needs to perform. Roles can be shared between playbooks. Ansible Galaxy creates the default directory hierarcy for a role. 

**Note:** Ansible Control Machine Terminal can be accessed by "Switch Windows" beside the apps menu. If the terminal is closed, git-bash can be opened and the server can be logged into from apps menu.

**Step 1.** Open the terminal of Ansible Control Machine, Create a folder named Ansible and store all the playbooks that are required in this tutorial. Create a folder roles under Ansible to store all roles in the folder. 

 
```sh
mkdir -p /root/ansible/roles
cd /root/ansible/roles
ansible-galaxy init create_user
```
![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 2.** Under the folder create_user, navigate to the tasks directory by entering:

```cd create_user/tasks/```

Next, enter ```vi main.yml``` to edit the file "main.yaml", then update it with the following code (see screenshot below):

```yml
---
# tasks file for create_user
- name: Create a new user
  user:
      name: user1
      state: present
  become: true
```

In the above code, we are creating a new user named user1. The attribute "become: true" implies to create the user Sysgain from a root account. 

**Step 3.** Create a new playbook in the parent directory where the roles folder is available. Enter the command: ```vi /root/ansible/Create_user.yaml ```  then update it with the following code (see screenshot below):

```yml
---
- name: Create a new user
  hosts: local
  roles: 
      - role: create_user
```
In the above playbook, we are executing the role "create_user" in the local group(inventory file) which is defined in the host section.

**Note:** Servers are defined under groups which are inturn defined under an inventory file. This file was created in the previous sections of this tutorial.

**Step 4.** Execute the following command to run the playbook and create a new user "user1"

```ansible-playbook /root/ansible/Create_user.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 5.** Hosts section of the playbook is defined as "local" which create's the user in the local server(Ansible Control Machine). To create a user in all the servers mentioned in the ansible inventory file, Update the hosts section to "all" in playbook  and run the command **```ansible-playbook /root/ansible/Create_user.yaml```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

In the above execution, User user1 was only created in the remote server as the user already exists in the local machine.

**Step 6.** To check if the User(user1) is created in the machines, run the following command

```cat /etc/passwd | grep user1```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Install multiple roles in servers

In this section, We will learn to install multiple roles in different servers from a single playbook.

In the local machine we will install Apache and the remote node we will be installing nginx package from a single playbook that is executed from Ansible Control Machine.

**Step 1.**  Inside the directory roles, create a new role named "apache". This role is used to install/configure and manage the apache service. 

 ```ansible-galaxy init /root/ansible/roles/apache```

 ```ansible-galaxy init /root/ansible/roles/nginx```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

**Step 2.** Inside Apache role, Update the file "main.yaml" under the folder tasks with the following code: ```vi  /root/ansible/roles/apache/tasks//main.yml```

```yml
---
# tasks file for apache
- name: Install package Apache
  apt:
       name: apache2
       state: latest

- name: start Apache service
  service:
       name: apache2
       state: started
```

In the above code, we are installing the latest version of Apache and starting the service of Apache. 

**Step 3.** Inside nginx role, Update the file "main.yaml" (using vi command) under the folder tasks with the following code: ```vi /root/ansible/roles/nginx/tasks/main.yml```

```yml
---
# tasks file for nginx
- name: Install package nginx
  apt:
       name: nginx
       state: latest

- name: Start nginx service
  service:
       name: nginx
       state: started
```

In the above code, we are installing the latest version of nginx and starting the service of nginx.

**Step 4.** Create a new playbook "Package_install.yaml" under the parent folder Ansible where roles directory is available. Update the following code: ```vi /root/ansible/Package_install.yaml```

```yml
---
- name: Install Apache
  hosts: local
  roles: 
      - role: apache
  become: true

- name: Install nginx
  hosts: webserver
  roles: 
      - role: nginx
  become: true
```

From the above code, the role "apache" is being installed on the hosts group local and the role "nginx" is being installed on the webserver group. 

**Note:** The groups "local" and "webserver" are defined under inventory file in the previous sections. We have defined Ansible Control Machine in the local group and the second node server in the webserver group.

**Step 5.**  Execute the playbook from Ansible Control Server which installs apache on the local machine and nginx on the second compute instance. 

``` ansible-playbook /root/ansible/Package_install.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

From the above output, we can see that Apache is installed on the local machine and nginx is installed on the remote machine.

**Tip:** We can view the IP address of the server on which the playbook is executing in the output section.

**Step 6.** To validate the packages Apache and nginx are installed on their respective servers. Login into their respective server and the following command:

```service apache2 status (shows status of apache service)```

```service nginx status ( shows status of nginx service)```  (check in remote server)

## Variables and handlers

In this section, we will learn about different types of variables and use of handlers in Ansible.

Handlers are tasks that are only executed when they are notified by other tasks in the playbook. For example, if a configuration of a package is updated then the handler is notified to restart the service for the configuration to take effect.

### Variables

Group Variables: These variables are defined in the parent/top directory where roles folder is available. Variables defined here can be accessed across roles. 

Local Variables: These variables are defined inside the role and the scope the variable is limited to the specific role. 

**Step 1.** Enter ```mkdir /root/ansible/group_vars``` to create a folder named "group_vars"  in the top hierarchy of the folders where roles folder is available. Create a new file "login.yaml" by entering ```vi /root/ansible/group_vars/login.yaml``` and update the code as follows:

```yml
---
username: "testuser@sysgain.com"
password: "AnsibleTutorial"
```
 **Step 2.** These variables can be used in all the roles defined in the roles folder.  

**Step 3.**  Create a new role variables and update "main.yml" file under tasks directory as follows:

```ansible-galaxy init /root/ansible/roles/variables```

```vi /root/ansible/roles/variables/tasks/main.yml```

update file with :

```yaml
---
# tasks file for /root/ansible/roles/variables
- name: Output Group Variables
 debug:
    msg: "The group variable username is {{ username }} and password is {{ password }}"
```
The above code takes variable values from the group variables defined in the group variable directory

**Step 4.** Create a new playbook ```vi /root/ansible/variable.yaml``` in the main directory where ansible directory and update the code with the following (see screenshot below):

```yml
---
- name: Include group variable
  hosts: all
  tasks:
      - include_vars: "group_vars/login.yaml"

- name: Show variable
  hosts: local
  roles: 
      - role: variables
```
In the above code, since login.yaml file was included in the playbook which is a group variables file, they can be automatically passed to the subsequent tasks in the playbook. These variables can be accessed in all the nodes that role is executed on.

**Step 5.** Execute the playbook with the following command 

```ansible-playbook /root/ansible/variable.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

### Handlers

**Step 1.** Handlers are only executed if a certain task reports any changes. For example, if a configuration of a package is updated, then handler is notified to restart the package service which picks up updated configuration.

**Step 2.** Under the role Apache, there is a folder named handlers. Update the file ```vi /root/ansible/roles/apache/handlers/main.yml``` file with the following code (see screenshot below):

```yml
---
# handlers file for apache
- name: restart apache
  service:
      name: apache2
      state: restarted
```
**Step 3.** We will be maintaining a file using Apache module and if the file changes we will notify the handler to restart Apache service.

Go to the role Apache and templates folder by entering ```cd /root/ansible/roles/apache/templates/```  Create a new file ```vi Sample.j2```  and update file with any content. Here ".j2 " is the format of the template that Ansible recognizes. 

 **Step 4.** Update the Ansible existing role code at ```vi /root/ansible/roles/apache/tasks/main.yml``` file with the following code (see below screenshot):

```yml
- name: Update a file
  template:
       src: Sample.j2
       dest: /etc/Sample.txt
  notify:
       - restart apache
```
**Step 5.** Create a new playbook ```vi /root/ansible/apache.yaml``` file under the top folder in the hierarchy with the following code (see screenshot below):

```yml
---
- name: Install and configure Apache
  hosts: local
  roles: 
      - role: apache
  become: true
```
**Step 6.** Enter the below command to execute the playbook apache, which installs Apache and configures the file in the location (/etc/Sample.txt). Since this file was configured for the first time, it notifies handler and Apache service is restarted. Subsequent execution of the playbook will not restart the service as there are no changes to the file. 

```ansible-playbook /root/ansible/apache.yaml```

**Note:** If the file (Sample.j2) is updated in the templates folder then subseqent runs of ansible will restart apache service

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

In the above execution output we can see that file was updated and the handler was notified to restart the service. Immediate execution of the playbook again will skip that step as the file is not being updated as shown below:

![](https://qloudableassets.blob.core.windows.net/devops/Azure/introduction-to-ansible-playbook/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)
