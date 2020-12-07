    # Create,Configure and Secure Your Virtual Private Cloud (VPC)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Create a New VPC](#exercise-2-create-a-new-vpc)

[Exercise 3: Create a Route table and associate it with your VPC](#exercise-3-create-a-route-table-and-associate-it-with-your-vpc)

[Exercise 4: Create Internet Gateway and attached it to your VPC](#exercise-4-create-internet-gateway-and-attached-it-to-your-vpc)

[Exercise 5: Create Private and Public Subnets](#exercise-5-create-private-and-public-subnets)

## Overview

The Aim of this lab is about how to create, configure and secure a VPC using AWS account.

**What Is Amazon VPC?**

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.

**Amazon VPC Concepts**

Amazon VPC is the networking layer for Amazon EC2.

The following are the key concepts for VPCs:

* A **virtual private cloud (VPC)** is a virtual network dedicated to your AWS account.

* A **subnet** is a range of IP addresses in your VPC.

* A **route table** contains a set of rules, called routes, that are used to determine where network traffic is directed.

* An **internet gateway** is a horizontally scaled, redundant, and highly available VPC component that allows communication between instances in your VPC and the internet. It therefore imposes no availability risks or bandwidth constraints on your network traffic.

* A **VPC endpoint** enables you to privately connect your VPC to supported AWS services and VPC endpoint services powered by PrivateLink without requiring an internet gateway, NAT device, VPN connection, or AWS Direct Connect connection. Instances in your VPC do not require public IP addresses to communicate with resources in the service. Traffic between your VPC and the other service does not leave the Amazon network.

### Scenario and Objectives

After completing this lab, you will be able to:

* Create a New VPC

* Create Private and Public Subnets

* Create a Route table and associate it with your VPC

* Create Internet Gateway and attached it to your VPC

## Pre-Requisites

* Familiarity with AWS Console

## Exercise 1: Login to AWS Console

1. Navigate to **Chrome** on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

3. Use below credentials to login to AWS console.

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Once you provide all that information correctly and click SignIn you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Exercise 2: Create a New VPC

1. Click on **Services**, search for **VPC** and select **VPC** from the options. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Click on **Your VPCs** in the left side navigation pane then click on Create VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/2.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Specify your VPC Name and CIDR (Classless Inter-Domain Routing), In my case I am using the following:

**Name tag:** `Awstl-VPC`

**IPV4 CIDR block:** `192.168.0.0/24`

**IPv6 CIDR block:** `No IPv6 CIDR Block`

**Tenancy:** `Default`

4. Click on **Create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/3.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. It takes few seconds for the VPC to be created. After the VPC is created click on close button to see the created VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/4.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/5.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

<question id="ce264978-ee0c-4863-8015-ee3bb5ee73dc" retry=5 required=false input=true time=5></question>

## Exercise 3: Create a Route table and associate it with your VPC

1. From VPC Dashboard chose Route Tables from the left navigation pane and click on **create Route table**. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/13.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Specify the below details:

**Name tag:** `Awstl-RouteTable`

**VPC:** `Select your VPC, in my case VPC is Awstl-VPC`

3. Click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/14.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

After the Route table is created click on close button to see the created route table.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/15.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/16.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Exercise 4: Create Internet Gateway and attached it to your VPC

1. From VPC Dashboard chose **Internet gateway** from the left navigation pane and click on **Create internet gateway**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/17.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Now specify the Name of Internet gateway and then click on **Create**.

**Ex:** `Awstl-igw`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/18.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Once the Internet Gateway creation is completed, **the following internet gateway was created** message will pop up. Click on **close** button to see the created Internet Gateway. By default the state of Internet Gateway shows **detached**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/19.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/20.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. To attach internet gateway to your VPC, Select the created internet gateway and right click on it, then select the **Attach to VPC** option.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/21.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. **Select** the previously created VPC from the drop down, in my case the vpc is **Awstl-vpc** then click on **Attach**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/22.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/23.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Now Add Route to your route Table for Internet, go to **Route Tables** option, Select your Route Table, In my case it is **Awstl-RouteTable**.

7. Now click on **Routes** Tab and choose **Edit routes** and then click on **Add route**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/24.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/25.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

8. Mention **Destination IP** of Internet as **0.0.0.0/0** and the **target** option as **Internet gateway** then already created internet gateway will be populated automatically as shown below then select it.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/26.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/27.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

9. Click on **Save routes**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/28.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

10. Click on **Close** to get back to previous page.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/29.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Exercise 5: Create Private and Public Subnets

### Creating Private Subnet

1. From the **VPC Dashboard** choose **Subnets** in the left navigation pan and then click on **Create Subnet** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/6.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Specify the following details:

**Name tag:** `private-subnet`

**VPC:** Choose `Awstl-VPC` from the dropdown

**Availability zone:** Choose a Availability Zone in which you want to create subnet

**IPV4 CIDR block:** `192.168.0.0/25`

3. Click on **Create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/7.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/8.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

### Creating Public Subnet

1. Similarly Create **Public Subnet** with following details:

**Name tag:** `public-subnet`

**VPC:**  Choose `Awstl-VPC` from the dropdown.

**Availability zone:** Choose the same Availability Zone as the private subnet that you created in the previous step

**IPV4 CIDR block:** `192.168.0.128/25`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/9.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/10.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/11.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/12.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. By default, subnet is **private subnet** when it is created. To configure **public subnet**, Select the subnet that you just created and select **Route table** tab then choose **Edit Route Table association**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n2.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. By default, the private route table is associated. Choose the other available route table so that the **0.0.0.0/0** destination is routed to the internet gateway **(Awstl-igw)** and choose **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n4.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. With **public subnet** still selected, **Right click** and choose **Modify auto-assign IP settings**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n5.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Select **Enable auto-assign public IPv4 address** and choose **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/n6.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

> **Result:** After completing this lab, you would be able to create a new VPC, create a Route table and associate it with your VPC, create an Internet Gateway and attached it to your VPC and create private & public Subnets.
    
