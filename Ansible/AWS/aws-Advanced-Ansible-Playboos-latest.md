# ADVANCED ANSIBLE PLAYBOOKS ON AWS

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

[Asynchronous actions and polling of a task in Ansible Playbook](#asynchronous-actions-and-polling-of-a-task-in-ansible-playbook)

[Task Delegation and Rolling Updates](#task-delegation-and-rolling-updates)

[Blocks for error handling in Ansible Playbooks](#blocks-for-error-handling-in-ansible-playbooks)

[Encrypt sensitive data using Vaults](#encrypt-sensitive-data-using-vaults)

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

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible1.PNG?st=2020-06-22T10%3A01%3A00Z&se=2025-06-23T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=25G4t2T3s%2FILdVWtFgqfOkvni%2FIEhTdDfvdAQmx0sJ4%3D" alt="image-alt-text" >

5. Enter **IAM username** and **Password** from the above information and click on **Sign In**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible2.PNG?st=2020-06-22T10%3A01%3A27Z&se=2025-06-23T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sWd732QnYW%2BQkKYyntda9P9HUYIZtKy4Kk6NLCy19EI%3D" alt="image-alt-text" >

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

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible3.PNG?st=2020-06-22T10%3A02%3A46Z&se=2025-06-23T10%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=I30Il35pMuNdeNjlz1w4%2BpQLxg%2F9FhhidZff9moyNuY%3D" alt="image-alt-text" >

2. Enter below details and click on **create** button.

    * Name tag: **test-IG**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/10.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Internet Gateway creation is completed, **The following internet gateway was created** message will pop up. Click on **close** button to see the created Internet Gateway. By default the **state** of Internet Gateway shows **detached**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/11.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Attach the Internet Gateway to VPC

4. select the **test-IG** Internet Gateway, choose **Attach to VPC** option from **Actions** drop down.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/docker-ce/images/12.PNG?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. select the **testvpc** from drop down and click on **Attach**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible4.PNG?st=2020-06-22T10%3A08%3A22Z&se=2025-06-23T10%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ytJ0HyRobt%2B2fvhVYud6kTGDHNmUaXWgRI9RZGVepgw%3D" alt="image-alt-text" >

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

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible5.PNG?st=2020-06-22T10%3A16%3A46Z&se=2025-06-23T10%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JPKMCyqttINCAQIDwFsjy7uAopI3XV1kG6bCkrVYbVM%3D" alt="image-alt-text" >

4. For **Key pair name**, enter **test-keypair**, and then choose **Create**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible6.PNG?st=2020-06-22T10%3A17%3A47Z&se=2025-06-23T10%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WIlMAyLa0Z8QIf5aJ88T%2FnL%2B4Gl2aYljRgSBPjFE%2Brc%3D" alt="image-alt-text" >

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

11. Click on **view Instances** at the bottom right. Here you can see the two instances that are launched. Click refresh icon on Right top of console to view Instance state.You can change tag names by mouse over on instance1.

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

## Asynchronous actions and polling of a task in Ansible Playbook

All the tasks in a playbook by default are executed synchronously. Tasks in a playbook that are not related to each other can be run asynchronously to avoid blocking or timeout issues. In Asynchronous mode all the tasks are executed at once and then poll until they are completed. In asynchronous mode maximun runtime of a task and how freqently you would like to poll need to be specified. 

Step 1. Create a folder named Ansible and store all the playbooks that are required in this tutorial. Create a YAML file inside the folder using the following commands

```sh
mkdir /root/ansible
cd /root/ansible
vi async.yaml
```

Step 2. Copy the following code into the created async.yaml file 

```yml
---
- hosts: local
  tasks:
    - name: Sleep for 15 sec
      command: /bin/sleep 15
      async: 45
      poll: 0

    - name: Install apache2
      yum:
        name: apache2
        state: present
      async: 60
      poll: 0
      become: true
```

Step 3. In the above code, hosts section is mandatory to determine where the playbook needs to be executed. If async keyword is not defined in the playbook, the task runs synchronously, specify the maximum time for async keywork for the command to execute in asynchrous mode, poll value determines the number of seconds the tasks waits before moving to the next task. Default value of poll is 10 seconds. Specify the value of poll to 0 for the execution to move forward without waiting for the task to complete.

**Note:** Operation that require locks should not be attempted to run with poll value 0 if you want to run other tasks in the playbooks that requires same resources. 

Step 4: Run the command to execute the playbook

``` ansible-playbook async.yaml```

You can see that the execution of the playbook does not stop for 15 seconds but completes the playbook execution.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)


Step 5. Asynchronous tasks can be checked later in the playbook if the task has been completed. Update the file with the following code. 

```vi async2.yaml```

```yml
---
- hosts: local
  tasks:
    - name: sleep for 30 seconds
      command: /bin/sleep 30
      async: 1000
      poll: 0
      register: sleeper

    - name: check on asyn task
      async_status:
        jid: "{{ sleeper.ansible_job_id }}"
      register: job_result
      until: job_result.finished
      retries: 10
```

Execute the playbook with the command **```ansible-playbook async2.yaml```**

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 6. In the above execution, the task when was performed asynchronously was to sleep for 30 seconds. In the next task we checked to see if the above task was completed. Status of the command "Sleep 30 seconds" were tried for 5 times before it finished the task.

## Task Delegation and Rolling Updates

In this section, we will learn about task delegation. In a playbook, if a perticular task needs to be performed on another host, "delegate_to" keyword can be used. This remote execution of a task is part of a playbook and is executed on another specified host.

Step 1: Create a new file under the folder ansible with the following command

```vi /root/ansible/delegation.yaml```<br>
Update the above created file with the below code and replace "delegate_to" value with publicIp of ansible node 

```yml
---
- hosts: local
  tasks:
    - name: install apache2
      apt:
        name: apache2
        state: present
      delegate_to: <ansible node IP>
```
![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 2.  In the above code we run this playbook on local host which is mentioned in the hosts section on the play. But since this task is being delegated to the node "ansiblenode" which was defined in the host section. This task is executed on the ansible node and apache2 is installed on ansible node.

Step 3. Execute the playbook with the command 

```ansible-playbook /root/ansible/delegation.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

As we can see in the execution output that the task was delegated to a different node and apache2 was installed on remote machine.

### Rolling Updates

Step 4. By default, Ansible will manage all the machines referenced in a play in parallel. If the playbook needs to be executed in rolling update use case. It can be managed by using "serial" keyword in the play. Ansible uses the number specified in the keyword and executes those many servers in parallel. 

Step 5. create ```vi /root/ansible/rolling_updates.yaml``` file with the following code, to run the playbook in rolling update for each server.

```yml
---
- hosts: all
  tasks:
    - name: install apache2
      apt:
        name: apache2
        state: present
  serial: 1
```

In the above code we defined serial as 1 which states that only 1 server is executed at a time. 

Step 6.  Execute the playbook with the following command 

```ansible-playbook rolling_updates.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

In the above execution output, first apache2 is installed in the local machine and then it is installed on the remote machine. 

Rolling update can even be defined, if there are different batch of servers that needs to be executed for example

```yml
- name: batch execution
  hosts: all
  serial:
    - 1
    - 5
    - 10 
```

In the above code the task is executed in baches, the first batch would contain a single host, the next would contain 5 hosts, and the remaining batches would contain 10 hosts untill all the available hosts completes task execution. 

## Blocks for error handling in Ansible Playbooks

Blocks allow for logical grouping of tasks and in play error handling. Multiple tasks are grouped into a section named "blocks" and if any of the tasks in the block fails, "rescue" section tasks are executed. The section "always" is executed everytime irrespective of an error either in the block or rescue section.

Step 1: Create a new playbook under the folder ansible with the following command

```vi /root/ansible/blocks.yaml```

Update the created file with the following code

```yml
---
- hosts: local
  tasks:
    - name: Attempt and graceful rollback 
      block:
        - debug:
             msg: 'I execute normally'
        - command: /bin/false
        - debug:
             msg: 'I never execute, due to the above failing command'
      rescue:
        - debug:
             msg: 'I caught an error'
      always:
        - debug:
             msg: ' I always execute'
```

In the block section, "command: /bin/false"  fails to execute and the execution is transferred to the rescue section, where all the tasks under it are executed before proceeding to "always" section.

Step 2.  Execute the playbook with the command 

```ansible-playbook /root/ansible/blocks.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

In the above execution output, we can see that the tasks executed after the error are in the "rescue" section and "block" section.

Step 3. We will update the file "blocks.yaml" with the following code so that it passes execution in the "block" section and continous to execute "always" section.

Changing the command from "/bin/false" to "/bin/true" will pass execution in the block section and always section code is executed. 

```vi  /root/ansible/blocks.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4.  Execute the playbook with the command 

```ansible-playbook blocks.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

## Encrypt sensitive data using Vaults

In this section, we will learn about Ansible vault and how it is used to encrypt sensitive data(usernames and passwords). Ansible vault is a feature of ansible which can encrypt any structured data file used by Ansible. In the steps below, we will see how a playbook can be encrypted with a password and how the encrypted playbooks are executed. 

Step 1: Create a new file  "encrypt.yaml" under the folder ansible with the command

```vi /root/ansible/encrypt.yaml```

Step 2: Update the file with the following code 

```yml
---
- hosts: local
  tasks:
    - name: Print Username and password
      debug:
        msg: ' Username is Sysgain123 and Password is Ansible123'
```

In this above file Username and Password are sensitive data and cannot be stored as a plain text. Ansible vault feature helps us to encrypt the playbook.

Step 3: Encrypt the playbook with the following command

```ansible-vault encrypt encrypt.yaml```

In the above command, ansible-vault is a feature of ansible, encrypt is the keyword used to encrypt a file and encrypt.yaml is the filename which is being encrypted. 

Command prompts to enter the password, type the password and type "Enter".  Type the same password again when asked to confirm. 

**Note:** Password that is being entered is not visible.

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 4. Open the encrypted file and it looks similar to the following image

```vi /root/ansible/encrypt.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 5. Execute the playbook with the following command

```ansible-playbook encrypt.yaml --ask-vault-pass```

The above command prompts for a password and type the same password used to encrypt the file. Ansible decrypts the file and the playbook is executed. 

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

Step 6. If the playbook needs to be updated it can be decrypted using the following command and the passord provided during encryption.

```ansible-vault decrypt encrypt.yaml```

![](https://qloudableassets.blob.core.windows.net/devops/Azure/advanced-ansible-playbooks/images/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D)

The above command decrypts the file into normal text file. It can be encrypted again either with the same password or a new password. 

You have successfully completed this tutorial. In this Training lab we have learnt how to Create a VCN in Oracle Cloud and create multiple compute instances inside a VCN. We have learnt on how to install Ansible, How Ansible connects with other nodes to execute ansible playbook. 

We have learnt about Asynchrouns actions and polling of tasks, task delegation to a different server, blocks for error handing and encryption of sensitive data. 
