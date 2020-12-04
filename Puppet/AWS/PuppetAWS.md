# Puppet

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create VPC and related network resources](#create-vpc-and-related-network-resources)

[Create Amazon EC2 Key Pair](#create-amazon-ec2-key-pair)

[Create EC2 instances for Puppet master and Puppet client](#create-ec2-instances-for-puppet-master-and-puppet-client)

[Login to the instances](#login-to-the-instances)

[Puppet master configuration](#puppet-master-configuration)

[Client configuration](#client-configuration)

[Creating a module](#creating-a-module)

## Overview

In this lab, you'll learn how Puppet helps lay the foundation for your DevOps practices, treat infrastructure as code, and achieve better collaboration between dev, ops, InfoSec, and networking.

You'll see why thousands of companies rely on Puppet to automate the delivery and operation of their software and see it in action with a live demo.

In this lab we will show you the following in a Linux environment:

- Installation of an agent
- Managing resources (packages, files, services, etc.)
- Granular visibility through reporting
- Managing change for more efficient workflows

## Pre-Requisites
 Linux basics

## Login to AWS Console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on `My Account` and in the dropdown, select `AWS Management console`.

3. Use below credentials to login to AWS console.

    * Account ID: {{Account ID}}
    * IAM username: {{user name}}
    * Password: {{password}}
    * Region: {{region}}
 

4. Enter `Account ID` from the above information, then click on `Next`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/acc-log-in.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter `IAM username` and `Password` from the above information and click on `Sign In`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/acc-log-in-usrpass.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/homepage-aws-console.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/region.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Create VPC and related network resources

### create VPC

1. Click on `Services`, search for `VPC` and select `VPC` from the options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on `Your VPCs` in the left side navigation pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on `Create VPC` button

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Enter below details 

    * Name tag: `PuppetVPC`
    * IPv4 CIDR block: `10.0.0.0/16`
    * IPv6 CIDR block:  `No IPv6 CIDR Block`
    * Tenancy: `Default`

  Click on `create` button.  

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Once the VPC creation is completed, `The following VPC was created` message will pop up. Click on `close` button to see the created VPC.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create Internet Gateway

1. Click on `Internet Gateways` on the left pane and click on `Create Internet Gateway` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter below details and click on `create` button.

    * Name tag: `PuppetIGW`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Internet Gateway creation is completed, `The following internet gateway was created` message will pop up. Click on `close` button to see the created Internet Gateway. By default the `state` of Internet Gateway shows `detached`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws8.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Attach the Internet Gateway to VPC

1. select the `PuppetIGW` Internet Gateway, choose `Attach to VPC` option from `Actions` drop down.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. select the `Puppet VPC` from drop down and click on `Attach`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create a route in route table with internet gateway

1. When you create a VPC, route table also will create along with that.

2. To see the route table that is created while creating `PuppetVPC`, Click on `Your VPCs` in the left side navigation pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. select `Puppet VPC` to see the route table. 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Click on the `route table` 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Choose `routes` and click on `Edit routes`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. click on `Add route`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Enter the below details.
   
    * Destination: `0.0.0.0/0`
    * Target: Choose `internet gateway` from drop down and then select `PuppetIGW`

  click on `save routes`  

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Once the route creation is completed, `Routes successfully edited` message will pop up. Click on `close` button to see the edited route.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

### Create Subnet

1. Choose `Subnets` in the left navigation pane and click on `Create subnet` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Specify the below details.

    * Name tag: `PuppetSubnet`
    * VPC: Choose `PuppetVPC` from dropdown
    * Availability Zone: `No preference`
    * IPv4 CIDR block: `10.0.1.0/24`

Click on `create` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Once the Subnet creation is completed, `The following Subnet was created` message will pop up. Click on `close` button to see the created Subnet.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Create Amazon EC2 Key Pair

### create EC2 Key Pair

1. Click on `Services`, search for `EC2` and select `EC2` from the options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane, under `NETWORK & SECURITY`, choose `Key Pairs`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Note:** The navigation pane is on the left side of the Amazon EC2 console. If you do not see the pane, it might be minimized; choose the arrow to expand the pane.

3. Choose `Create Key Pair`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. For `Key pair name`, enter `PuppetKeyPair`, and then choose `Create`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is .pem. Save the private key file in a safe place.

### Convert the .pem file into .ppk file

1. Click on the `Apps` icon and click on `PuTTYgen`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on `Load`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. choose `All files` at the bottom, select PuppetKeyPair.pem file in downloads folder and click on `open`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Click on `Save Private Key`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Enter `PuppetKeyPair` as `File name`, save type as `PuTTY Private Key Files(*.ppk)` and click on `save`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**Note**

In coming sections, you'll need to provide the name of your key pair when you launch an instance and the corresponding private key (.ppk file) when you connect to the instance.

## Create EC2 instances for Puppet master and Puppet client

1. Click on `Services`, select `EC2` under `Compute` section.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane., under `INSTANCES` section, choose `Instances`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Choose `Launch Instance.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. In `Step 1: Choose an Amazon Machine Image (AMI)`, search for `Ubuntu Server 16.04`, choose Ubuntu Server 16.04 LTS (HVM), SSD Volume Type and choose `Select.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. In `Step 2: Choose an Instance Type`, select `t2.micro` type and choose `Next: Configure Instance Details.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/Upload_1.png?sv=2019-10-10&st=2020-10-06T06%3A09%3A49Z&se=2023-10-07T06%3A09%3A00Z&sr=b&sp=r&sig=HBoPZLTTbCdvn6%2BoPJPGvGd7BdsoyPbD%2F03pO5DMJg0%3D" >

6. In `Step 3: Configure Instance Details`, specify the below details.

    * Network: choose `PuppetVPC` from drop down
    * Subnet: Choose `PuppetSubnet` from dropdown
    * Auto-assign Public IP: `Enable`
    
    Keep the default values for others and choose `Next: Add Storage.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/missedaws2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. Choose `Next: Add Tags.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Click on `Add tag`

* Enter `Key` as `Name`
* Enter `Value` as `PuppetMaster` 

And choose `Next: Configure Security Group.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. In Step 6: `Configure Security Group`, review the contents of this page, ensure that `Assign a security group` is set to `Create a new security group` and specify the below details.

* Security group name: `PuppetMasterSG`
* Description: `Security Group for Puppet Master`

Click on `Add Rule`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/missedaws3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

10. Specify the below details
  
   * Protocol: `TCP`
   * Port Range: `8140`
   * source: `0.0.0.0/0` 

 Click on `Add Rule` and add one more rule for 443

   * Protocol: `TCP`
   * Port Range: `443`
   * source: `0.0.0.0/0` 

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/missedaws4.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. Choose `Launch`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

12. Choose `PupetKeyPair` from `Select a key pair drop down` which you created in previous step.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Click on `view Instances` at the bottom right.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

14. Here you can see the `PuppetMaster` instance that is launched.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

15. Similarly Launch one more Ubuntu instance for `Puppet Client`

16. While launching the 2nd instance, in `Add Tags` step specify the below details.

   * Key: `Name`
   * Value: `PuppetClient`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws7.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

17. In Step 6: `Configure Security Group`, review the contents of this page, ensure that `Assign a security group` is set to `Create a new security group` and specify the below details.

* Security group name: `PuppetClientSG`
* Description: `Security Group for Puppet Client`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/missedaws5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

18. Choose the `PuppetKeyPair` while launching.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws9.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

19. After launching the `PuppetClient` you can see the `PuppetMaster` and `PuppetClient` instances like below.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws10.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Login to the instances

To see the Puppet instances that are already provisioned for this lab. Click on `Services`, search for `EC2` and select `EC2` from the options.

### login to the PuppetMaster

1. Select the `PuppetMaster` instance and copy the `Public IP`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws12.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on `Apps Icon` and open `Putty`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws11.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Paste the `Publilc IP`, enter `port` as `22` and expand the SSH section by clicking on `+` symbol.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws14.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. select `Auth` under `SSH` section in the left panel and click on `Browse`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws15.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Go to the path where `PuppetKeyPair.ppk` file is saved, select the `PuppetKeyPair.ppk` file and click on `Open`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws16.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

6. Click on `Open`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws17.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

7. A prompt will be opened, click on `yes`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws18.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

8. Enter login as: `ubuntu`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws19.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

9. Run the below command to become the root user.

   `sudo -i`

10. Puppet is domain specific language so hostname should be like puppet.example.com.

    Now change the hostname of Puppet Master server.

    Run below command.

   `hostname puppet.master.com`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws21.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

11. Edit the hostname file by running below command.

   `vim /etc/hostname`

 12. Replace existing text with `puppet.master.com` and save the file by pressing `esc:wq`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws23.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

13. Run this command for private IP address and copy the `inet addr`.

**ifconfig**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws22.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Note: This address will be updated in the `hosts` file along with the `PuppetClient inet addr` in coming sections.   

### login to the PuppetClient

1. Go back to aws instances page on `chrome`

2. Select the `PuppetClient` instance and copy the `Public IP`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws13.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Open one more putty session from `Apps Icon`

4. Paste the `PublicIP` and enter port as `22`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws20.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

5. Select `PuppetKeyPair.ppk` and Enter login name as `ubuntu`

6. Run the below command to become the root user.

   `sudo -i`

7. Puppet is domain specific language so hostname should be like puppet.example.com.

    Now change the hostname of puppet client server.

    Run below command.

   `hostname puppet.client.com`

8. Edit the hostname file by running below command.

   `vim /etc/hostname`

9. Replace existing text with `puppet.client.com` and save the file by pressing `esc:wq`

10. Run this command for private IP address and copy the `inet addr`.

**ifconfig**

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Note: This address will be updated in the `hosts` file along with the `PuppetMaster inet addr` in coming sections. 

## Puppet master configuration

**Puppet master setup:**

Click on `switch windows` icon and select the `PuppetMaster putty session.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run below command to pen the /etc/hosts file and configure it according to your infrastructure environment

**vim /etc/hosts**

Update the below lines with inet addrs of PuppetMaster, PuppetClient which are copied in previous sections and paste these two lines in the file.

```<Puppet Master inet addr> puppet.master.com```

```<Puppet Client inet addr> puppet.client.com```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

save the file by pressing `esc:wq`

Download puppet enterprise from below command.

 **```sudo wget https://pm.puppetlabs.com/puppet-enterprise/2018.1.3/puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/24.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

 To untar the package run the following command

**```sudo tar -xf puppet-enterprise-2018.1.3-ubuntu-16.04-amd64.tar.gz```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/25.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Change directory to puppet installer file.

**```cd puppet-enterprise-2018.1.3-ubuntu-16.04-amd64```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/26.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**```./puppet-enterprise-installer```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Puppet Enterprise offers two different methods of installation.

**[1] Text-mode Install (Recommended)**

This method will open your EDITOR (vi) with a PE config file (pe.conf) for you to edit before you proceed with installation.

The pe.conf file is a HOCON formatted file that declares parameters and values needed to install and configure PE.

We recommend that you review it carefully before proceeding.

**[2] Graphical-mode Install**

This method will install and configure a temporary web server to walk you through the various configuration options.

**NOTE:** This method requires you to be able to access port 3000 on this machine from your desktop web browser.

Enter **1** for text module installer

 In editor go to **"```console_admin_password": ""```** line type `password@1234` on quotes it is for puppet web login password.

scroll down, **Uncomment** the **```"puppet_enterprise::console_host":```**  line and enter the `puppet.master.com` in empty quotes.

**"```puppet_enterprise::console_host": "puppet.master.com"```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/28.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Press **```esc :wq```** to save the configuration file to proceed the installation enter **Y**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/29.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/30.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run the below command to Check Puppet status.

**```service puppet status```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/31.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run below command: it will generate the master certificates.

**```puppet agent -t```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/32.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

## Client configuration

Go back to PuppetClient putty session

Run below command to open the /etc/hosts file and configure it according to your infrastructure environment

**vim /etc/hosts**

Update the below lines with inet addrs of PuppetMaster, PuppetClient which are copied in previous sections and paste these two lines in the file.

```<Puppet Master inet addr> puppet.master.com```

```<Puppet Client inet addr> puppet.client.com```

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/aws27.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

save the file by pressing `esc:wq`

Run the below command for puppet agent configuration in client system

**```curl -k https://puppet.master.com:8140/packages/current/install.bash | bash```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/33.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >
**In puppet Master VM:**

Let’s run the command at Puppet Master Ubuntu server to view such cert requests.

**```puppet cert list```**

Now the puppet master server must sign the cert requested from puppet client with the following command.

**```puppet cert sign puppet.client.com```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/34.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**In client VM:**

Run the following command

**```puppet agent -t```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/35.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Now client configuration is done.

## Creating a module

**Go to Puppet Master server:**
Run the following command to change dir to modules dir

**```cd /etc/puppetlabs/code/environments/production/modules```**

Run the below command for Creating the module.

**Modules** are self-contained bundles of code and data. You can download pre-built modules from the Puppet Forge or you can write your own modules.

Here we are writing a simple apache module which installs apache and stats the service.

**```puppet module generate foo-apache --skip-interview```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/36.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

**```cd apache/manifests```**

**```vim  init.pp```**

Press Shif +g  the curser will go to the bottom of vim editor 

Press i to change vim to insert mode. Enter the below lines in apache class.

```
package { 'apache2':
  
  ensure => installed,
}

 service { 'apache2':
  ensure => running,
}
```

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/37.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

Run below command to parse the Module

**```puppet parser validate init.pp```**

**```puppet apply init.pp --noop```**

 To apply module on client node we need to modify the site.pp  

Change directory to manifests

**```cd /etc/puppetlabs/code/environments/production/manifests/```**

**```vim site.pp```**

Enter below lines  

```
node 'puppet.client.com' {

       class { 'apache': }

}
```

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/38.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

Go to **Client VM** and run the below command to apply the apache module in client VM

**```puppet agent -t```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/39.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

Check the apache status run the following command.

**```service apache2 status```**

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/40.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

To view, the puppet enterprise web view enter https://publicip and log in with username as `admin` and password as `password@1234`.

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/41.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" > 

After login you can see the page like below.

<img src="https://qloudableassets.blob.core.windows.net/devops/OCI/Puppet/42.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >
