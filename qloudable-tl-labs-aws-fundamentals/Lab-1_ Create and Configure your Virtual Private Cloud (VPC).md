# Create, Configure and Secure Your Virtual Private Cloud (VPC)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create a New VPC](#create-a-new-vpc)

[Create a Route table and associate it with your VPC](#create-a-route-table-and-associate-it-with-your-vpc)

[Create Internet Gateway and attached it to your VPC](#create-internet-gateway-and-attached-it-to-your-vpc)

[Create Private and Public Subnets](#create-private-and-public-subnets)

## Overview

The main aim of this lab is about how to create, configure and secure a VPC using AWS account.

**What Is Amazon VPC?**

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.

**Amazon VPC Concepts**

Amazon VPC is the networking layer for Amazon EC2.

The following are the key concepts for VPCs:

 1. A **virtual private cloud (VPC)** is a virtual network dedicated to your AWS account.

 2. A **subnet** is a range of IP addresses in your VPC.

 3. A **route table** contains a set of rules, called routes, that are used to determine where network traffic is directed.

 4. An **internet gateway** is a horizontally scaled, redundant, and highly available VPC component that allows communication between instances in your VPC and the internet. It therefore imposes no availability risks or bandwidth constraints on your network traffic.

 5. A **VPC endpoint** enables you to privately connect your VPC to supported AWS services and VPC endpoint services powered by PrivateLink without requiring an internet gateway, NAT device, VPN connection, or AWS Direct Connect connection. Instances in your VPC do not require public IP addresses to communicate with resources in the service. Traffic between your VPC and the other service does not leave the Amazon network.

**Learning Objective**

1. Create a New VPC

2. Create Private Subnets

3. Create a Route table and associate it with your VPC

4. Create Internet Gateway and attached it to your VPC

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* Familiarity with AWS Console

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

* Sign in to the console using below **AccountID**, **IAM username** and **Password** details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

* Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Now enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

* Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

* In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Create a New VPC

1. Click on **Services**, search for **VPC** and select **VPC** from the options. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Click on **Your VPCs** in the left side navigation pane then click on Create VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/2.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Specify your VPC Name and CIDR (Classless Inter-Domain Routing), In my case I am using the following:

```
 Name tag: Awstl-VPC

 IPV4 CIDR block: 192.168.0.0/24

 IPv6 CIDR block: No IPv6 CIDR Block

 Tenancy: Default
```
4. Click on **Create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/3.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. It takes few seconds for the VPC to be created. After the VPC is created click on close button to see the created VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/4.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/5.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Create a Route table and associate it with your VPC

1. From VPC Dashboard chose Route Tables from the left navigation pane and click on **create Route table**. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/13.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Specify the below details:

```
 Name tag: Awstl-RouteTable

 VPC: Select your VPC, in my case VPC is Awstl-VPC
```
3. Click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/14.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/15.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/16.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Create Internet Gateway and attached it to your VPC

1. From VPC dashboard there is an option to create Internet gateway select **Internet gateways** -> **Create internet gateway** and specify the Name of Internet gateway.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/17.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/18.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Once the Internet Gateway creation is completed, **the following internet gateway was created** message will pop up. Click on **close** button to see the created Internet Gateway. By default the state of Internet Gateway shows **detached**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/19.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/20.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Once the Internet gateway is created, attached it to your VPC, Select and Right Click Your Internet gateway and then select the **Attach to VPC** option.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/21.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/22.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/23.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Now Add Route to your route Table for Internet, go to **Route Tables** option, Select your Route Table, In my case it is **Awstl-RouteTable**, click on Route Tab and Click on **Edit routes** and  the click on **add route**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/24.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/25.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Mention **Destination IP** of Internet as **0.0.0.0/0** and in the **target** option **your Internet gateway** will be populated automatically as shown below.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/26.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/27.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Click on **Save routes**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/28.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/29.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Create Private and Public Subnets

### Creating Subnet1

1. From the **VPC Dashboard** choose **Subnets** in the left navigation pan and then click on **Create Subnet** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/6.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Specify the following details:

```
 Name tag: subnet1

 VPC: Choose Awstl -VPC from the dropdown

 Availability zone: Choose a different Availability Zone than your original subnets in the VPC

 IPV4 CIDR block: 192.168.0.0/25
```
3. Click on **Create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/7.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/8.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

### Creating Subnet2

1. Similarly Create **Subnet2** with following details:

```
 Name tag: subnet2

 VPC:  Choose Awstl -VPC from the dropdown.

 Availability zone: Choose the same Availability Zone as the private subnet that you created in the previous step

 IPV4 CIDR block: 192.168.0.128/25
```
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/9.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/10.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/11.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/12.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. By Default the Subnet created is a Private Subnet. To configure the Public subnet, Select the subnet2 that you just created and choose **Edit Route Table association**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n2.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. By default, the private route table is selected. Choose the other available route table so that the **0.0.0.0/0** destination is routed to the internet gateway **(Awstl-igw)** and choose **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n4.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. With your subnet2 still selected, **Right click** and choose **Modify auto-assign IP settings**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n5.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Select **Enable auto-assign public IPv4 address** and choose **Save** and then click on **Close**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n6.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. After completing this lab, you would be able to create a new VPC, create a Route table and associate it with your VPC, create an Internet Gateway and attached it to your VPC and create private & public Subnets.

**Conclusion:** Congratulations! You have successfully completed the lab **Create, Configure and Secure Your Virtual Private Cloud (VPC)**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

1. [Amazon Virtual Private Cloud](https://aws.amazon.com/vpc/)


