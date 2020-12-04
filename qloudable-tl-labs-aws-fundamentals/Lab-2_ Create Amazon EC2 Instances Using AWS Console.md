# Lab-2: Create Amazon EC2 Instances Using AWS Console

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Create VPC and related network resources](#excercise-1-create-vpc-and-related-network-resources)

[Excercise-2: Create Amazon EC2 Key Pair](#excercise-2-create-amazon-ec2-key-pair)

[Excercise-3: Create Windows EC2 instance in public subnet](#excercise-3-create-windows-ec2-instance-in-public-subnet)

[Excercise-4: Login to the Instance and Install apache in Windows](#excercise-4-login-to-the-instance-and-install-apache-in-windows)

[Excercise-5: Create Ubuntu EC2 Instance in private subnet](#excercise-5-create-ubuntu-ec2-instance-in-private-subnet)

[Excercise-6: Login to the Instance and Install apache in Ubuntu](#excercise-6-login-to-the-instance-and-install-apache-in-ubuntu)


## Overview

The aim of this Lab is to create Amazon EC2 Instances manually in Aws console. In this lab we are creating one windows instance in public subnet and install apache in that windows server and accessing the apache server with local host. In this lab we also creating one ubuntu instance in private subnet and install apache in ubuntu accessing apache with ubuntu instance private IP.

EC2Instance: Amazon Elastic Compute Cloud (Amazon EC2) provides scalable computing capacity in the Amazon Web Services (AWS) cloud. Using Amazon EC2 eliminates your need to invest in hardware up front, so you can develop and deploy applications faster. You can use Amazon EC2 to launch as many or as few virtual servers as you need, configure security and networking, and manage storage. Amazon EC2 enables you to scale up or down to handle changes in requirements or spikes in popularity, reducing your need to forecast traffic.

**Scenario and Objective**

After completing this lab, you will be able to:

* Deploying windows, Ubuntu EC2 Instance from the AWS console.

* You are able to login to the windows instance and Install apache in Windows and access the apache server

* Deploying Ubuntu EC2 Instance from the AWS console.

* You are able to Login to the ubuntu instance and Install apache in ubuntu and access the apache server using ubuntu Instance private Ip address.

## Pre-Requisites 

* AWS User Account

* Puttygen

* RemoteDesktopConnection

* Putty

> **Note**: You can also find shortcuts to these applications in the Start Menu.


## Excercise-1: Create VPC and related network resources

### Task:1 Login to AWS Console

1.	Navigate to chrome on the right pane, you should see AWS console page.

2.	Go to top right corner of the AWS page in the browser, click on My Account and in the dropdown, select AWS Management console.

3.	Use below credentials to login to AWS console.

     **Account ID:** {{Account ID}} <br>
     **IAM username:** {{username}} <br>
     **Password:** {{password}} <br>
     **Region:** {{region}} <br>

4.	Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/1.png?st=2019-11-19T04%3A52%3A15Z&se=2026-11-20T04%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8kBrieb%2BLFAxTamhN4SdVlAHfIkeekSorkrX3V%2BJkQ%3D)

5.	Enter **IAM username** and **Password** from the above information and click on **Sign In**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/2.png?st=2019-11-19T04%3A52%3A35Z&se=2026-11-20T04%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wU1kzF3bCpy1Vjzdf7SPKaLfTWAjc9pJak7dzLkog8M%3D)
 
6.	Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/3.png?st=2019-11-19T04%3A52%3A59Z&se=2026-11-20T04%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WVXGyPDsdg7mDLnyNT9XWeIePPzETvHRO6t8P9Zi%2Frg%3D)
 
7.	In the navigation bar, on the top-right region dropdown, select below region.
     
     * Region: {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/4.png?st=2019-11-19T04%3A53%3A42Z&se=2025-11-20T04%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QhorqSf9OSrWyw272GPbm%2F4lCpTYhfX4M%2FSRDDoVH%2Fw%3D)
 
### Task 2: create VPC

1. Click on **Services**, search for **VPC** and select **VPC** from the options.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/5.png?st=2019-11-19T04%3A53%3A24Z&se=2025-11-20T04%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oCL%2BuTXri0F81lqSFMZ9DA6hgpaBRASUFl070cY1lw4%3D)
 
2.	Click on **Your VPCs** in the left side navigation pane.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/6.png?st=2019-11-19T04%3A54%3A02Z&se=2026-11-20T04%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CmnX2nvEncQD5OgDOwG95UNRd%2FkCHjlhxBwgMWPy%2FqM%3D)

3.	Click on **Create VPC** button

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/7.png?st=2019-11-19T04%3A54%3A25Z&se=2028-11-20T04%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xFNDDKmp4ncy5JX9QbSmWKzpY8ikNR%2BOLZ7wI9pX1Y4%3D)

4.	Enter below details

    * Name tag: **testvpc**
    * IPv4 CIDR block: **10.0.0.0/16**
    * IPv6 CIDR block:  **No IPv6 CIDR Block**
    * Tenancy: **Default**

Click on **create** button. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/8.png?st=2019-11-19T04%3A54%3A43Z&se=2025-11-20T04%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pbZMkGQk94izeq%2BzahJpa7kg04QrNiR9bGy5UIQagyg%3D)
 
5.	Once the VPC creation is completed, **The following VPC was created** message will pop up. Click on **close** button to see the created VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/9.png?st=2019-11-19T04%3A55%3A08Z&se=2026-11-20T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vRtsBaHq0qBuL905s1YZ%2BX4CTMCzW207ZfNUYz5otXM%3D)

### Task:3 Create Internet Gateway

1.	Click on **Internet Gateways** on the left pane and click on **Create Internet Gateway** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/10.png?st=2019-11-19T04%3A55%3A30Z&se=2026-11-20T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ajGKHuAoOIjpuuOzeYSeY9T5n0O0%2FVozZGt49WqVECE%3D)

2. Enter below details and click on **create** button.

    * Name tag: **test-IG**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/11.png?st=2019-11-19T04%3A55%3A57Z&se=2025-11-20T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ulMAUeRin57JWhv1gUuY5%2B4HCN54h4vxkFuXXR8aYOo%3D)

3. Once the Internet Gateway creation is completed, **The following internet gateway was created** message will pop up. Click on **close** button to see the created Internet Gateway. By default the **state** of Internet Gateway shows **detached**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/12.png?st=2019-11-19T04%3A56%3A13Z&se=2025-11-20T04%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PvnVtmgteWmT90tyZY%2FuiwEpC8zeNP4G36Dut69pVDY%3D)
 
### Attach the Internet Gateway to VPC

4. select the **test-IG** Internet Gateway, choose **Attach to VPC** option from **Actions** drop down.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/13.png?st=2019-11-19T04%3A56%3A30Z&se=2026-11-20T04%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nhU%2FA4f1L1u3sf9jr9FUMpdzdsvJxYGDp8iJ2%2FHvwh0%3D)

5. select the **testvpc** from drop down and click on **Attach**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/14.png?st=2019-11-19T04%3A56%3A49Z&se=2025-11-20T04%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IXKQdWrMz11XSp1UuvmZdkuBAVmH6HdSzVVg2XIGdSA%3D)


### Create a route in route table with internet gateway

1. When you create a VPC, route table also will create along with that.

2. To see the route table that is created while creating **testvpc**, Click on **Your VPCs** in the left side navigation pane and select **testvpc** to see the route table.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/15.png?st=2019-11-19T04%3A57%3A08Z&se=2025-11-20T04%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SWga%2BMtKklCNPr%2FUUa1tRLMyxvfiiGdnyKL%2BIg92vXI%3D)
 
3. Click on the **route table** 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/16.png?st=2019-11-19T04%3A57%3A23Z&se=2026-11-20T04%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4p%2B0KwS9A6wQFT1lyYZJ3oh5L36LqFXhxkKJ93eAzcY%3D)

4. Choose **routes** and click on **Edit routes**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/17.png?st=2019-11-19T04%3A57%3A41Z&se=2026-11-20T04%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qIWp5ndJpQKVu8n%2FKfBuPm9LVsbnw7x4bz2k%2BfdrfU0%3D)

5. click on **Add route** and enter the below details.

    * Destination: **0.0.0.0/0**
    * Target: Choose **internet gateway** from drop down and then select **test-IG**

  click on **save routes**  

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/18.png?st=2019-11-19T04%3A57%3A59Z&se=2026-11-20T04%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z1CkGTIXnPhEFkG6T64JanuCCWIsrqs8HaupqbHiyE0%3D)

6. Once the route creation is completed, **Routes successfully edited** message will pop up. Click on **close** button to see the edited route.

### Task:5 Create Public Subnet

1. Choose **Subnets** in the left navigation pane and click on **Create subnet** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/19.png?st=2019-11-19T04%3A58%3A18Z&se=2025-11-20T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5FCWt%2Fd4o90P7D8Oz2CSUn9gY%2BSrXMQD4s6MQ4hG4lA%3D)

2. Specify the below details.

    * Name tag: **Publictest-subnet**
    * VPC: Choose **testvpc** from dropdown
    * Availability Zone: **No preference**
    * IPv4 CIDR block: **10.0.0.0/24**

Click on **create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/20.png?st=2019-11-19T04%3A58%3A35Z&se=2026-11-20T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s7%2F5HZmB%2FYXmbeXS2DayoTVgunnfAFzxZMxg5ByasGk%3D)
 
3. Once the Subnet creation is completed, **The following Subnet was created** message will pop up. Click on **close** button to see the created Subnet.

### Task:6 Create Private Subnet

1.	Choose **Subnets** in the left navigation pane and click on **Create subnet** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/21.png?st=2019-11-19T04%3A58%3A57Z&se=2025-11-20T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5LPFXgltIOmee2aE3kJe7oNps8MgIkB4DqpUQOAUNb0%3D)

2. Specify the below details.

    * Name tag: **Privatetest-subnet**
    * VPC: Choose **testvpc** from dropdown
    * Availability Zone: **No preference**
    * IPv4 CIDR block: **10.0.0.0/24**
 
Click on **create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/22.png?st=2019-11-19T04%3A59%3A13Z&se=2026-11-20T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=94Ju54U2%2BKHJqFmrURp8chKj%2B017BTh9gatpcVY5xOU%3D)
 
3.	Once the Subnet creation is completed, **The following Subnet was created** message will pop up. Click on **close** button to see the created Subnet.

### Task:7 Create NAT Gateway In public subnet: 

The instances in the public subnet can send outbound traffic directly to the Internet, whereas the instances in the private subnet can't. Instead, the instances in the private subnet can access the Internet by using a network address translation (NAT) gateway that resides in the public subnet.

1.	Click on **NAT Gateway** the left pane and click on **Create NAT Gateway** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/23.png?st=2019-11-19T04%3A59%3A30Z&se=2026-11-20T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7zrSJe1Nzt5Tg%2Bk0k7T6QhtKvon%2FVsA%2FfIMzkGbHDoI%3D)

2.	Enter below details and click on **create** Nat gateway  button

    * Subnet*: select the **publictest-subnet** from dropdown
    * Elastic IP Allocation ID: click on **Create New EIP**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/24.png?st=2019-11-19T04%3A59%3A46Z&se=2026-11-20T04%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XzvRLIjFGzYDJIYtKiaNWiybxW9F35g5CSKUMj1jQvk%3D)

Once the Elastic Ip is assigned click on Create NAT Gateway.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/25.png?st=2019-11-19T05%3A00%3A03Z&se=2026-11-20T05%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OnP9LrvYdXs%2Fm1VTVEuXAkU6AfHywiFwKyN0Txcs7pY%3D)

3.	Once the NAT Gateway is completed, **The following NAT Gateway was created** message will pop up. Click on **close** button to see the created NAT Gateway. It is in **pending** state it will take few minutes to change in **available** state. 
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/26.png?st=2019-11-19T05%3A00%3A18Z&se=2025-11-20T05%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WUa26jXt3tc14cGdLAfL07sdJjAutNaL%2Fchl6pZRhZQ%3D)

**Refresh** the Aws Console to see the status of NAT Gateway.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/27.png?st=2019-11-19T05%3A00%3A34Z&se=2025-11-20T05%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fko1SrctZ73IMRRVE8Nxi8psqyT0XxqTEjaJsDmLKdA%3D)
 
Click on the empty space under **Name** and assign name of **NAT gateway**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/28.png?st=2019-11-19T05%3A00%3A54Z&se=2026-11-20T05%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9uwmLj0xAEDmbt%2FmeJ6pquC%2FbA5IEboBKiDtGJUSTUs%3D)
 
#### Create Route table for private subnet association

1.	Click on **Route Tables** the left pane and click on **Create route table** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/29.png?st=2019-11-19T05%3A01%3A12Z&se=2026-11-20T05%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JC5b5BJGGVhTa24pexztjf2PeQc%2BBV5HieVWn6EwiQ0%3D)

2.	Enter below details and click on **create** button

      * Name tag: **privatesubnetRTable**
      * Vpc: select the **testvpc** from dropdown

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/30.png?st=2019-11-19T05%3A01%3A32Z&se=2025-11-20T05%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=beP7Wu6xyTetly4ufnvypSxT8brW83QCFgRb0Zd0GHs%3D)

3.	Once the Route table is completed, **The following Route Table was created** message will pop up. Click on **close** button to see the created Route table.

#### Assign the private subnet association to the Route Table:

1.	Go to the created the **privatesubnetRTable** from Route tables list select **Subnet Associations** then click on **Edit subnet associations**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/31.png?st=2019-11-19T05%3A01%3A50Z&se=2026-11-20T05%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7NBGylWBYJL5iQQOGDBGpsLtoRbhfuZpym8Ki4RTsZw%3D)

2.	In Edit subnet associations Select **Privatetest-subnet** click on **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/32.png?st=2019-11-19T05%3A02%3A09Z&se=2025-11-20T05%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vy5FO6cmIaWqbGdpTUA0DlTg26CR5NjtXOppIEJDxHs%3D)

#### Create a route in route table with Nat gateway:

1.	Click on the **route table** , Choose **routes** and click on **Edit routes**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/33.png?st=2019-11-19T05%3A02%3A28Z&se=2025-11-20T05%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=36zuKG%2BJK73AkB1qSsTGWycWQZ70030GCc%2FrCYcl2Bc%3D)

2.	click on **Add route** and enter the below details.

      * Destination: **0.0.0.0/0**
      * Target: Choose NAT Gateway from drop down and then select **NATGateway**

click on **save routes**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/34.png?st=2019-11-19T05%3A02%3A44Z&se=2026-11-20T05%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ANo8cOSnWsCcGS7f0y8Nb%2BA9Q3QDLUxAI2IwynPUhtg%3D)
 
3.	Once the route creation is completed, **Routes successfully edited** message will pop up. Click on **close** button to see the edited route.


## Excercise-2: Create Amazon EC2 Key Pair

Amazon EC2 Key Pairs: Amazon EC2 uses public–key cryptography to encrypt and decrypt login information. Public–key cryptography uses a public key to encrypt a piece of data, and then the recipient uses the private key to decrypt the data. The public and private keys are known as a key pair.

You must provide the key pair to Amazon EC2 when you create the instance, and then use that key pair to authenticate when you connect to the instance.

1.	Click on **Services** and select **EC2** under the **compute** options.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/35.png?st=2019-11-19T05%3A03%3A06Z&se=2026-11-20T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T8yQS9RfL3E7AqxUgppc7jWecCp%2BJ4tScIY6s8%2BmnNU%3D)
 
2. In the left side navigation pane, under **NETWORK & SECURITY**, choose **Key Pairs** and click **Create Key Pair**

**Note:** The navigation pane is on the left side of the Amazon EC2 console. If you do not see the pane, it might be minimized; choose the arrow to expand the pane.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/36.png?st=2019-11-19T05%3A03%3A44Z&se=2025-11-20T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lPku%2Ft5gLCpy6lji4E1Yjl%2FU8LZRWorHBZ58dCMEc%2Bg%3D)

3. For **Key pair name**, enter **test-keypair**, and then choose **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/37.png?st=2019-11-19T05%3A04%3A02Z&se=2025-11-20T05%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QSTKGlzlgceH6ztGsVs9Q8vhWMv7BbpS97pOO%2FReiQs%3D)

4. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is **.pem**.

### Task :1 Convert the .pem file into .ppk file

1. Click on the **Apps** icon and click on **PuTTYgen**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/38.png?st=2019-11-19T05%3A04%3A21Z&se=2025-11-20T05%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tRE3Dn1E3NlHg%2FeWbKggK3AuuIBSHoXaL3jDXiETTmQ%3D)

2. Click on **Load**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/39.png?st=2019-11-19T05%3A08%3A10Z&se=2025-11-20T05%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Km7W2t38ICy%2BXljy3zblu7Yrl%2BTYbVwfLAqIgEbfkyA%3D)

3. choose **All files** at the bottom, select test-keypair.pem file in downloads folder and click on **open**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/40.png?st=2019-11-19T05%3A08%3A24Z&se=2028-11-20T05%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4ym%2FGzlz3%2FPW2s680eTnMjrZuo7xWOwENXfQjjW%2BPag%3D)

4. Click on **Save Private Key**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/41.png?st=2019-11-19T05%3A10%3A09Z&se=2025-11-20T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FC7dr%2FxBuPGy4pS0rHhuT15N0hxt3J8M5J6sMy2cH78%3D)

5. Enter **test-keypair** as **File name**, save type as **PuTTY Private Key Files(*.ppk)** and click on **save**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/42.png?st=2019-11-19T05%3A10%3A31Z&se=2026-11-20T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uaSOCZtREOkWiEkKAoY4Tq%2Fe1tGO74QZsgbAxac32c8%3D)


**Note**: In coming sections, you'll need to provide the name of your key pair when you launch an instance and the corresponding private key (.ppk file) when you connect to the instance.


## Excercise-3: Create Windows EC2 instance in public subnet

1.	Click on **Services**, select **EC2** under **Compute** section.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/43.png?st=2019-11-19T05%3A10%3A46Z&se=2025-03-20T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mj8hYuxqeRjba9l4%2FcoJLDxWetWzhedorqoBEroQHok%3D)

2.	In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/44.png?st=2019-11-19T05%3A11%3A22Z&se=2025-11-20T05%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DXJN3aFNCekJ7k1DO5KD2jnSTlSt8lu%2FfpnoULGq4Y4%3D)
 
3.	In **Step 1: Choose an Amazon Machine Image (AMI)**, search for **Windows Server 2012 R2 Base** choose an image which is eligible for **free tier** and choose **Select**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/45.png?st=2019-11-19T07%3A10%3A47Z&se=2025-11-20T07%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CYZXTfq7Kp6AqIMfYfDOAK2T%2Bh387Q3Izb1j2BkfOjo%3D)

4.	In **Step 2: Choose an Instance Type**, select **t2.medium** type and choose **Next: Configure Instance Details.**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/46.png?st=2019-11-19T05%3A11%3A40Z&se=2026-11-20T05%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FexKsVEFmYbnmRd3pdIfFq%2FVN9NF%2F%2BKrW0K1CMfjexA%3D)

5.	5.	In **Step 3: Configure Instance Details**, specify the below details.

    * Network: choose **testvpc** from drop down
    * Subnet: Choose **Publictest-subnet** from dropdown
    * Auto-assign Public IP: **Enable**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/47.png?st=2019-11-19T05%3A11%3A56Z&se=2027-11-20T05%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dN4W5VCMaJRZS%2Fj7c5Sr1npxfLgcrDpT2f%2BTszjJnLk%3D)

Keep the default values for others and choose **Next: Add Storage**.

6.	6. Keep the default values for others and choose **Next: Add Tags.**. Click on **Add tag** Add tags page.

* Enter **Key** as **Name**
* Enter **Value** as **windows** 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/48.png?st=2019-11-19T05%3A12%3A13Z&se=2025-11-20T05%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rT607tCt2ufK2SevG62FbCCKfV7kyV%2BRPOdRKcHr20Y%3D)

And choose **Next: Configure Security Group.**

7.	In Step 6: **Configure Security Group**, review the contents of this page, ensure that **Assign a security group** is set to **Create a new security group** and specify the below details.

* Security group name: **windows-SG**
* Description: **windows Security Group**

Click on **Add Rule**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/49.png?st=2019-11-19T05%3A12%3A28Z&se=2027-11-20T05%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=waCk%2BYPBVL7kqGazb%2FEhCRUf3GyW51w6cKyKYRTk3Hc%3D)
 
8.	Specify the below details.

      - Protocol: **TCP**
      - Port Range: **80**
      - source: **0.0.0.0/0** 

choose: **Review and Launch**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/50.png?st=2019-11-19T05%3A12%3A42Z&se=2026-11-20T05%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jEr4SImV6Ei6yZvYYK1IeCSBabctfpOCbVW8J2zXRTM%3D)
 
9.	Choose **Launch**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/51.png?st=2019-11-19T05%3A13%3A00Z&se=2026-11-20T05%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zogDcNMIz%2BgFqyO0bTjpLrgWhiV%2BORTaLDcPACzBWEs%3D)
 
10.	choose **test-keypair** from **Select a key pair drop down** which you created in previous step.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/52.png?st=2019-11-19T05%3A13%3A16Z&se=2026-11-20T05%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JRHyiZHWEcTor50j4ITSu9WeohhhB23JKTRtUUdFM8w%3D)
 
11.	Click on **view Instances** at the bottom right.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/53.png?st=2019-11-19T05%3A13%3A35Z&se=2026-11-20T05%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yDQAldrO%2Fz6BS%2FzkklLcjPOEwRVFqRB2f0o6n8wdvYc%3D)

12.	Here you can see the **windows** instance that is launched.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/54.png?st=2019-11-19T05%3A13%3A53Z&se=2025-11-20T05%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aVLH8HJDz7N5CdkCiEQfqPMQ%2FD9MO%2FVGUSDeyLirYxo%3D)


## Excercise-4: Login to the Instance and Install apache in Windows

To see the instances that are already provisioned for this lab. Click on Services, search for EC2 and select EC2 from the options.

### Task:1 Login to the Windows Instance

1. Select the **windows** instance and click on **Connect**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/55.png?st=2019-11-19T05%3A14%3A08Z&se=2025-11-20T05%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WTxJEMB1n%2F%2FtGuBN8qmVyGlUNVDSK%2BesZOlthlulHBc%3D)

2. It will show the below pop up box click on **Get Password**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/56.png?st=2019-11-19T05%3A14%3A23Z&se=2025-11-20T05%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ux5nnhtqVvwyicmlU9C1OutH5vcpPkF7QhDhrjQ6wvU%3D)
 
3. Then select the **choose file** and uploaded the **test-keypair.pem** file which is  downloaded at the time of creating keypair.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/57.png?st=2019-11-19T05%3A14%3A40Z&se=2026-11-20T05%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KxE0cEuj5bfgS%2BrQxZ0buQJ1FKJyvTxlXCkRSIymBeE%3D)

4. After uploaded the **test-keypair.pem** file click on **Decrypt Password**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/58.png?st=2019-11-19T05%3A14%3A56Z&se=2025-11-20T05%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8A3dFmaujVDxH%2F3OPZLWgJVU3tlbyECPG93wvNOvf68%3D)
 
5. Then it will display the **password** ,copy the **Public IP, User name, Password** values to login to windows Instance.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/59.png?st=2019-11-19T05%3A15%3A12Z&se=2025-11-20T05%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Cz1tdSekrW%2Bahezuw%2BYf4MbqjzFGlK7jMY1JmatR2w0%3D)

6. After copied the Public IP,User name,Password values click on **close**.

7. Click on **Apps Icon** and open **Remote Desktop Client**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/60.png?st=2019-11-19T05%3A15%3A30Z&se=2026-11-20T05%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xKz1qXiX%2FDySG3aJJ3ngEoMfHK739QcZuUl5n5uPUR0%3D)

8.	Paste the copied **Publilc IP** click on **connect**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/61.png?st=2019-11-19T05%3A15%3A45Z&se=2025-11-20T05%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uumnF26DK5IlkQmhQ3WYeEmnrjpVo%2FrsrurYXyxDxA4%3D)
 
when prompted to **sign in**, provide the **User name, Password** which you copied before and click on **OK**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/62.png?st=2019-11-19T05%3A16%3A03Z&se=2025-11-20T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pvhEW48UdwV3TtDazpJFbkFrjRcruk%2BIdriFhsYGTkw%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/63.png?st=2019-11-19T05%3A16%3A21Z&se=2025-11-20T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=t8aBk4yDOaOEcGGB%2FYPs8gjLFxNCQWyCsjO%2FDsreVFs%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/64.png?st=2019-11-19T05%3A16%3A37Z&se=2025-11-20T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5Jrk6ktBQreiLWAzYZ9pC7DUTzHk9nAzhcJVigd7jNA%3D)

### Task:2 Install Apache in Windows Instance

1. After login to the windows server you can see the **power shell icon** in task bar click on that **powershell**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/65.png?st=2019-11-19T05%3A16%3A52Z&se=2025-11-20T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VMvlGjSKHOFgy6mH9ReH96HiKzxJwzmIFp86Gnxd2Lw%3D)

**Copy** and **paste** the below command and **Run** In powershell prompt by enter.

```

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/66.png?st=2019-11-19T05%3A17%3A09Z&se=2025-11-20T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gzcku2HBnw2Ub5GZayONXMul2Qtpxsdgzop2On%2BlSSY%3D)

2. After run the command in power shell you can see the **chrome icon** in taskbar. Click on **chrome icon**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/67.png?st=2019-11-19T05%3A17%3A30Z&se=2025-11-20T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OatSifQOLYAzDQx4OCQKlU87XwUkvpwJFOpidQfY1JE%3D)

3. Copy the below url and paste it In chrome new window it will download the **apache installation zip** file.

https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/Apache24.zip?st=2019-11-15T09%3A42%3A51Z&se=2026-11-16T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gCT%2FRpAmFGDmrKfmx7mQg1yazq3P%2FuNC1%2FgkQ3QuA8g%3D

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/68.png?st=2019-11-19T05%3A17%3A49Z&se=2025-11-20T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BjvDVO4p49KNHUqNRczUVOgIBywKYQEBj7Nol0ze1Ks%3D)
 
4. Install the latest **C++ Redistributable Visual Studio 2017** by copy and paste the below url in chrome new window and follow the below steps.

https://www.microsoft.com/en-in/download/details.aspx?id=48145

First click on Download and then select **vc_redist.x64.exe** then click on **Next**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/69.png?st=2019-11-19T05%3A18%3A11Z&se=2025-11-20T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jPblMmjLC9WiTcCBd0F%2FTQ6%2FSnaLPiOCdy2w52khACI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/70.png?st=2019-11-19T05%3A18%3A29Z&se=2025-11-20T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=whDi7wjZtIvqqM1X0l%2FKJTI%2FyEpoU88PrKcWCMc8q7Y%3D)

5. Now you can see the vc_redist.x64.exe is downloaded, right click on that and select **show in folder** you can redirected to the **downloads** path. Right click on vc_redist.x64.exe select **Run as administrator**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/71.png?st=2019-11-19T05%3A18%3A48Z&se=2025-11-20T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IybJH1bYlWl0%2FqWp9n%2Fv6F3ISq6lZfbR0AKDpqdNJ%2FU%3D)

6. Click on **Install** then close the window after installation.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/72.png?st=2019-11-19T05%3A24%3A02Z&se=2025-11-20T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=m01EzJBz5BskZ8c8cjBh9N3oaDzochlwoBdJ5p%2FMto0%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/73.png?st=2019-11-19T05%3A24%3A19Z&se=2026-11-20T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3a8W4IfNt8R1S5xbzvlKrmHYaJcRrsKEfKc4X4KDNOc%3D)

7. In downloads path copy the **Apache24 zip** file and paste it in **C:/** path.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/74.png?st=2019-11-19T05%3A24%3A37Z&se=2025-11-20T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aSCXiaHeuWXeJAGV5A1%2FpFiqiHrn9DYf9RCCokR7yw4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/75.png?st=2019-11-19T05%3A24%3A59Z&se=2025-11-20T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IWrNyPPejBTtw7NMcUJu8aKkR8ltLqT8AgTg%2FtJS4Lg%3D)

8. Right click on that Apache24 zip file select **Extract All** and exctract to the C:/ path.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/76.png?st=2019-11-19T05%3A25%3A17Z&se=2025-11-20T05%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yjS%2FyyNbyi4Y6o%2FQ72WpX6JKBdiUx3jGYYPs7dhdVmk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/77.png?st=2019-11-19T05%3A25%3A33Z&se=2026-11-20T05%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wBbjGhR30J%2Bfxx10%2BaOW2%2FDlxD0h7QpM%2FdEuZGxPh9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/78.png?st=2019-11-19T05%3A25%3A49Z&se=2025-11-20T05%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2NH5%2F7QkbeVjgwgyh5MuhLhlBcnLwS%2FCrmhRlHEKMgo%3D)

9. From windows **start menu** search for **command prompt** and navigate to the command prompt.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/79.png?st=2019-11-19T05%3A26%3A12Z&se=2025-11-20T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XhMIFyuHUQQ097VHrl3VorxrncXeoeQLc%2FsivQJC7Dc%3D)
 
10. In command prompt run the below commands.

```

cd/

cd Apache24/bin

httpd -k install

```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/80.png?st=2019-11-19T05%3A26%3A30Z&se=2025-11-20T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Mo8otF1339nhm4WEzlOEENnefDTuwK1CCsdWnKV1GB8%3D)

11. From windows start menu search for **run** and navigate to the **Run** 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/81.png?st=2019-11-19T05%3A26%3A54Z&se=2025-11-20T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wKOLqIXY0oSyjz1P%2BEAiyCu6RhM4xXG28y8gEZyK0nY%3D)

12. In Run enter **service.msc** click on **OK**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/82.png?st=2019-11-19T05%3A27%3A09Z&se=2025-11-20T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tGmQHIoqQCEpJGO2us1ExS7KHe%2F22lXDdxuYPAYxsK0%3D)

Select the **Apache2.4** and click on **Start**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/83.png?st=2019-11-19T05%3A27%3A25Z&se=2025-11-20T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X5eqASsB%2Bq0M%2BLO%2F39%2FohXIajEccdw0IMFTaBgQoLsA%3D)

13. After start the **apache** service if you enter **http://localhost:80** in your chrome new window you can see the webpage like below.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/84.png?st=2019-11-19T05%3A29%3A57Z&se=2025-11-20T05%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vPo8leZ4bIKec%2FnT8BOZ4H86iNgY%2Bh9FeNIYlBLVdvA%3D)

If you see this page, it means that your Apache installation has been **successfully** done.

Minimize this RDP session go back to the **AWS console**.


## Excercise-5: Create Ubuntu EC2 Instance in private subnet

1.	Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/85.png?st=2019-11-19T05%3A32%3A45Z&se=2025-11-20T05%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q%2Bmfh3qJfo2UvE0v%2FciuDN%2BBOn%2Fp93s5MBuaEn8n9nk%3D)

2.	In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/86.png?st=2019-11-19T05%3A33%3A11Z&se=2025-11-20T05%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=a3o%2B4fcf%2F0fuZ29yiORReby%2F28HoZ1QMz059e9ZcLyA%3D)

3.	In **Step 1: Choose an Amazon Machine Image (AMI)**, search for **Ubuntu Server 16.04 LTS**, choose an image which is eligible for **free tier** and choose **Select.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/87.png?st=2019-11-19T05%3A33%3A35Z&se=2025-11-20T05%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X2aBsgp2F22Wj0lcUmwA9MJfJJ7ZL1By6foGeASNiX0%3D)

4.	In **Step 2: Choose an Instance Type**, select **t2.medium** type and choose **Next: Configure Instance Details.**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/87.png?st=2019-11-19T05%3A33%3A35Z&se=2025-11-20T05%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X2aBsgp2F22Wj0lcUmwA9MJfJJ7ZL1By6foGeASNiX0%3D)

5.	In **Step 3: Configure Instance Details**, specify the below details.

    * Network: choose **testvpc** from drop down
    * Subnet: Choose **Privatetest-subnet** from dropdown
    * **Auto-assign Public IP: Enable**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/89.png?st=2019-11-19T05%3A34%3A40Z&se=2025-11-20T05%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zXj21e3xXjgR5uDxXvdwPUbeZY4wZKL64y6llnOjt2s%3D)

Keep the default values for others and choose **Next: Add Storage.**

6. Keep the default values for others and choose **Next: Add Tags.**. Click on **Add tag** Add tags page.

* Enter **Key** as **Name**
* Enter **Value** as **ubuntu** 
 
And choose **Next: Configure Security Group.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/90.png?st=2019-11-19T05%3A34%3A56Z&se=2025-11-20T05%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7TWAV5dT7E8BG1a1Fg9uek%2F39Q3ZPOP%2Fq%2BGkdeiUoEQ%3D)

7.	In Step 6: **Configure Security Group**, review the contents of this page, ensure that **Assign a security group** is set to **Create a new security group** and specify the below details.

* Security group name: **ubuntu-SG**
* Description: **ubuntu Security Group**

Click on **Add Rule**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/91.png?st=2019-11-19T05%3A35%3A23Z&se=2025-11-20T05%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LSukRsycDaY5kC%2FiVwyZD4WwXB9QR7VPsHLhnx4J%2Br4%3D)
 
8. Specify the below details.
  
   * Protocol: **TCP**
   * Port Range: **80**
   * source: **0.0.0.0/0** 

  choose: **Review and Launch**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/92.png?st=2019-11-19T05%3A35%3A39Z&se=2025-11-20T05%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3YNUTm%2BNdJ%2FsJi6mv7C7ZmFv6b47qHP0Ej0UG5ouPz8%3D)
 
9.	Choose **Launch**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/93.png?st=2019-11-19T05%3A36%3A00Z&se=2025-11-20T05%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6xpGbpiqlURnZ8ZuTSXsO4CbImUL%2FhnisAD2%2Fv9%2Fd60%3D)
 
10.	choose **test-keypair** from **Select a key pair drop down** which you created in previous step.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/94.png?st=2019-11-19T05%3A36%3A23Z&se=2026-11-20T05%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wg1ta%2Fbxutho5EGlMCF99k02B4oOCC2Oftb%2BRu3c7Z0%3D)

11.	Click on **view Instances** at the bottom right.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/95.png?st=2019-11-19T05%3A36%3A40Z&se=2026-11-20T05%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zUAiOs2B4683a0wGNP3W1QywKSRvF%2BQRFc41AdaEapI%3D)

12.	Here you can see the **Instance1** instance that is launched.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/96.png?st=2019-11-19T05%3A36%3A55Z&se=2025-11-20T05%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YNKcQ1H0tOCHGJn1B2JpSoqOAFOfWqg27kIetxi3TyQ%3D)

## Excercise-6: Login to the Instance and Install apache in Ubuntu

First maximize to the **RDP session** which you used before for installing apache.

### Task:1 Login to the Ubuntu Instance

You can’t access private subnet instance directly so you need to login the ubuntu instance using the windows instance which is launched in public subnet.

1. In that RDP session, chrome new window enter **putty install** click on that https://www.putty.org/
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/97.png?st=2019-11-19T05%3A37%3A12Z&se=2025-11-20T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wESpLoSlIWty9l%2BffNAuxXvaCkaWEOBdSqONUcVp1rM%3D)

2. Click on that **Here** you can redirected to the other page.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/98.png?st=2019-11-19T05%3A37%3A27Z&se=2026-11-20T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OgCnPIDJl%2FQRcz83fEjt207gkEQWqpBI0Oa2OeA5e2U%3D)

3. In this select and click on **putty-0.73-installer.msi**,the msi file is downloaded to the windows instance.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/99.png?st=2019-11-19T05%3A37%3A45Z&se=2026-11-20T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aXGWpw38p5YjpCt81NTf8u%2By73ghy15bUoZPDKecAxM%3D)

4. In chrome edge you can see the downloaded file and **right click** on this select **show in folder**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/100.png?st=2019-11-19T05%3A38%3A33Z&se=2026-11-20T05%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QGp88AVgMO50obq8yrki5CLX7B0pxQMZKz4czFBg2fI%3D)

5. Now you can navigate to the downloads path **right click** on that putty msi file select **Install**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/101.png?st=2019-11-19T05%3A38%3A59Z&se=2025-11-20T05%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rQQBAXSCGRULtI167RMMSYsWuPS%2F8wwCsVeP3Ulub70%3D)
 
6. Click on **Run** in the pop up box, then click on **Next**,**Install** after complete the installation click on **Finish** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/102.png?st=2019-11-19T05%3A39%3A20Z&se=2025-11-20T05%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FhCZBUrH7zXARjxM4dZoQ%2FhOAD8CGMaQUtdnBly2mZU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/103.png?st=2019-11-19T05%3A40%3A24Z&se=2027-11-20T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=z9KJ52fmMMmZMVuAzqmETN1QLmsSRe0kQw5bYo3gMac%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/104.png?st=2019-11-19T05%3A40%3A40Z&se=2025-11-20T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aloLocaIp7jOCg91iLHIxNtbUDBEK9tMnLqvMXy3Bh8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/105.png?st=2019-11-19T05%3A40%3A56Z&se=2025-11-20T05%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TM7BtODmfUW06pUIWpa8Tr3n3vDLxjIORDlmtToocL0%3D)

7. Copy and paste the **test-keypair.ppk** file from your app stream  or drag and drop to windows desktop.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/106.png?st=2019-11-19T05%3A41%3A15Z&se=2025-11-20T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Kj8CSk2V5jRr66ZLAgXbxTyvaUhsCnRy8mTozbvir4U%3D)

8. To see the instances that are already provisioned for this lab. Click on **Services**, search for EC2 and select **EC2** from the options.Select the **ubuntu instance** and copy the **private IP**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/107.png?st=2019-11-19T05%3A41%3A54Z&se=2025-11-20T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EpUVIaDEI%2B0FGhgvyg1lFX3VAK%2FfQsVwuQGActQfD2k%3D)
 
9.	From the windows **Start Menu** search for **Putty** and click on the **Putty**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/108.png?st=2019-11-19T05%3A42%3A11Z&se=2026-11-20T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6Trdo5GTRMV3O6x5LjSs90VNzLHTbYE6QSbVrNyzKCU%3D)
 
10.	Paste the **Private IP**, expand the SSH section by clicking on **+** symbol.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/109.png?st=2019-11-19T05%3A42%3A29Z&se=2025-11-20T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PmoLUwSYBPmLKdXyFVm2Jn1sq5cgqKOfvzaj8eixhQA%3D)

11.	select **Auth** under **SSH** section in the left panel and click on **Browse**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/110.png?st=2019-11-19T05%3A42%3A46Z&se=2025-11-20T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YBeghJhK%2FUW7P4TO7gKzxEbGKMyyBUpVae31CjFIAqI%3D)

12. Go to the path where **test-keypair.ppk** file is saved, select the **.ppk** file and click on **Open**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/111.png?st=2019-11-19T05%3A43%3A11Z&se=2025-11-20T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XGXGGLOlXRz0Qcyz8rxPSM2QErg5DLaXnDQ7FK3BymU%3D)
 
13.	Click on **Open**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/112.png?st=2019-11-19T05%3A43%3A29Z&se=2026-11-20T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=j69sgBeCvfNij1K%2Fo4BSqbvZwl9twsGPgqya2dop3cY%3D)

5.	A prompt will be opened, click on **yes**
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/113.png?st=2019-11-19T05%3A43%3A47Z&se=2025-11-20T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LDk3E6fbgS%2BC0e5ejIgoRErzNNReZ%2BPiqZL3KjZTxoU%3D)
 
6.	Enter login as: **ubuntu**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/114.png?st=2019-11-19T05%3A44%3A02Z&se=2025-11-20T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TvUQkaFZ5R1%2BDPG5437V6RbQOEE7pGwkoVzQVUmFxcg%3D)
 
### Task:2 Install Apache in Windows Instance

1. Run the below commands to install **Apache2** in ubuntu instance

```

sudo apt-get update
sudo apt install apache2 -y
 
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/115.png?st=2019-11-19T05%3A44%3A18Z&se=2025-11-20T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4LHCuY78RCxvJqqcU4H5RcnSnW4SobW6WY8inQMwBx0%3D)

2. By running the below command you can see whether **Apache2** is installed or not
 
```
sudo service apache2 status
 
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/116.png?st=2019-11-19T05%3A44%3A33Z&se=2025-11-20T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5Z7NOYZgg4phJ%2FPgTQlkVEt5ol2%2FXTbbDVGC17Q7BgA%3D)

3. After that replace the **ubuntu instance private ip** in below command and paste it in chrome in RDP session you can able to access the apache server.

```

URL:  http://[ubuntuprivateIP]:80
EX: http://10.0.1.9:80
 
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EC2lab/EC2labimages/117.png?st=2019-11-19T05%3A44%3A54Z&se=2026-11-20T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1BfG3LCDFLb9givYtfGeQo9YJ0NHfZb8BJQCI4RhU94%3D)

4. If you see this page, it means that your Apache installation has been **successfully** done in the ubuntu instance.if you try to access the apache server outside the public subnet you can’t access.

> **Result:** After completing this lab, you would be able to create a new VPC, create a Route table and associate it with your VPC, create an Internet Gateway and attached it to your VPC and create private & public Subnets. You are able to launch windows instance and ubuntu instance from AWS console.You can install apache in both the instances and able to access the apache server.
