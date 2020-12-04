# INTRODUCTION TO ANSIBLE

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS console](#login-to-aws-console)

[Create VPC and related network resources](#create-vpc-and-related-network-resources)

[Create Amazon EC2 Key Pair](#create-amazon-ec2-key-pair)

[Create EC2 instances for Ansible](#create-ec2-instances-for-ansible)

[Login to the Instance](#login-to-the-instance)

[Install Ansible](#install-ansible)

[Creating SSH Keys for Ansible to access other instances](#creating-ssh-keys-for-ansible-to-access-other-instances)

[create a ansible playbook](#create-a-ansible-playbook)

[Conditions in Ansible](#conditions-in-ansible)

[Loops and Variables in Ansible](#loops-and-variables-in-ansible)

## Overview

## Pre-Requisites

1) Basic knowledge of Linux servers

2) YAML language

3) SSH private/public key knowledge

## Login to AWS console

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

    * Number of Instances **1**  (one for Ansible control machine other for Ansible node)
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

In this section, We will create a public and private SSH key pairs for ansible control machine to SSH into the nodes defined in inventory file.

Ansible control machine is a server on which ansible is installed and executes ansible tasks on the managed nodes.

An inventory file is a list of managed nodes which are also called "hosts". Ansible is not installed on managed nodes.

**Step 1.** In the terminal, enter the command ```ssh-keygen```

Press **"Enter"**, when asked for the following 

  a) Enter file in which to save the key 

  b) Enter passphrase

  c) Enter passphrase again

**Tip**
No Passphrase is required.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 2.** Public and Private keys should have been generated and are stored in the directory /root/.ssh/. Public key need to be copied to authorized keys file, which gives ansible access to login into the managed node.

**Note:**
In this example Ansible control machine and the managed node is the same server. If authorized_keys file is already available, overwrite it with the public key or a new file is generated.


Execute the following commands to copy the public key

```cd /root/.ssh```

```cp id_rsa.pub authorized_keys```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >


**Step 3.** Check to see if Ansible is able to connect to the servers, defined in the inventory file that was created in the previous section. 

Execute the following command which pings the servers in the inventory file.

```ansible all -m ping```

Enter "yes" when prompted to add server ip to the known_hosts file. 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Above command pings the servers defined in the inventory file that is created in the previous steps. Since only local machine is added in the inventory file ansible does a ping on the local machine using the SSH key created. 

## create a ansible playbook

In this section, We will learn what an ansible playbook is and how to create and execute a playbook which installs a package on the server.

Ansible Playbook are the files where ansible code is written. They are written in YAML format. Playbooks contains the tasks which the user wants to execute on a particular machine. Multiple tasks can be specified in a playbook which are executed sequentially.

**Important:-**
Both Ansible control machine and managed node are same in this tutorial. All the packages that are being installed and managed are done on the same machine. 

**Step 1.** Create a folder named Ansible and store all the playbooks that are required in this tutorial. Create a YAML file inside the folder using the following commands

```mkdir /root/ansible``` <br>
```cd /root/ansible```<br
```vi install_package.yaml```

**Step 2.** Copy/Type the following code into the created install_package.yaml file 

```yml
---
- hosts: local
  tasks:
     - name: install apache2
       apt: name=apache2 update_cache=yes state=latest
     - name: start apache2
       service: name=apache2 state=started
```

**Step 3.** In the above code, hosts section is mandatory to determine where the playbook needs to be executed. This can be a server name or a group of servers that are defined in the inventory file(created in previous section).  A group named local was defined in the inventory file in the previous section. Ansible runs this playbook on the servers defined under local group. 


**Step 4.** Run the command ```ansible-playbook  install_package.yaml``` Ansible checks the inventory file for the local group and installs the package apache2 with latest version on the servers. 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 5.** From the output, there were 2 tasks run in the playbook , first is gathering facts. Ansible gathers facts of the server on which playbook is running and then executes the tasks defined in the playbook which is installing apache2 package. 

**Step 6.** To validate if apache2 is installed on the server, type the command ```service apache2 status```. 


## Conditions in Ansible

In this section, we will learn how Ansible conditions work and how they can be used inside Ansible playbooks to perform conditional tasks.  

In this example, we will check the system facts and install specified package on respective operating system.

**Step 1.** Create a new file condition.yaml with the command "touch /root/ansible/condition.yaml"

**Step 2.**  Ansible collects the facts before executing a playbook on the server. These facts are the attributes of the machine.

To list all the default facts of the machine run the following code:

```ansible -m setup local```

This command prints all the facts that ansible collects about the machine. If you want it to display single fact, use grep.

The following command displays ansible distribution facts which playbook collects before execution: 

```ansible -m setup local | grep ansible_distribution```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 3.** Create a new file with the command ```vim /root/ansible/condition.yaml``` Add the following code into the file. 

**Note:**
Remove apache2 package on the server using ```apt-get remove -y apache2```

```yml
---
- hosts: local
  tasks:
      - name: install apache on ubuntu servers
        apt:  name=apache2 state=present
        when: (ansible_facts['distribution'] == "Ubuntu")
        register: output1

      - name: Show output of the registered value
        debug: var=output1

      - name: install apache on centos servers
        yum: name=httpd state=present
        when: (ansible_facts['distribution'] == "CentOS" and ansible_facts['distribution_major_version'] == "7")
        register: output2

      - name: show output of registerd value
        debug: var=output2

```
**Step 4.** The tasks in the above code will check the OS type and installs apache/httpd package accordingly, ansible playbook skips the task if condition fails. Register in the task will store output of task to a variable and debug task will display the output of task.

```ansible-playbook  condition.yaml```
 

## Loops and Variables in Ansible

In this section, we will discuss about the variables and loops in Ansible playbooks. Loops are used if a same task needs to be executed multiple times like creating multiple users, installing multiple packages etc.

**Step 1.** create a playbook  ```vim /root/ansible/install_packages.yaml``` and add below content to it.

```yaml
---
- hosts: local
  vars:
    packages:
       - wget
       - apache2
       - telnet
  tasks:
     - name: instal packages
       apt: name="{{item}}" state=latest
       with_items: "{{packages}}"
```

**Step 2.** Packages are defined in a list variable and the variable is used in the task to install multiple packages at the same time. With_items iterates overs the list variable "packages" and stores the value in a temperory variable "item". apt task is executed on each item from the packages variable. 

**Step 3.** If the packages are already installed on the server, Ansible skips installation of the specific package, to validate the playbook installs the required packages, they can be removed with the command

```apt remove -y wget telnet apache2```

**Step 4.** Execute the playbook using the command ```ansible-playbook  install_packages.yaml``` to install the packages

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible/images/13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Step 5.** All the packages are installed on the server. To verify if the package is installed run the command:

```apt list <<package_name>>```


Conclusion:

Congratulations!

You have successfully completed the Introduction to Ansible lab! In this tutorial we have Created a instance in AWS. 

We have learnt basics of Ansible on how to install Ansible and manage the configuration using Ansible. We have used Ansible playbooks to install multiple packages, store values inside variables, loops and conditions in Ansible. Finally we have installed and configured apache on a server and started the Apache service. 

Feel free to continue exploring or start a new lab. 

Thank you for taking this self-paced lab!
