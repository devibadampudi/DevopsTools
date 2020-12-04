# Set Up an Amazon Elastic Block Store (EBS)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Create an Amazon EBS Volume](#exercise-2-create-an-amazon-ebs-volume)

[Exercise 3: Create an Instance and attach an Amazon EBS Volume to that Instance](#exercise-3-create-an-instance-and-attach-an-amazon-ebs-volume-to-that-instance)

[Exercise 4: Create a Snapshot of an EBS Volume and copy EBS Volumes Between Regions](#exercise-4-create-a-snapshot-of-an-ebs-volume-and-copy-ebs-volumes-between-regions)

[Exercise 5: Monitoring the Status of Your Volumes](#exercise-5-monitoring-the-status-of-your-volumes)

[Exercise 6: Detaching an Amazon EBS Volume from an Instance](#exercise-6-detaching-an-amazon-ebs-volume-from-an-instance)

## Overview

To successfully meet the challenge of storing data in the cloud using AWS, we need to familiarize with the management of Amazon Elastic Block Store (Amazon EBS) volumes and snapshots.

**What Is EBS?**

**Amazon Elastic Block Store (Amazon EBS)** is a raw block-level storage service designed to be used with Amazon EC2 instances. When mounted to Amazon EC2 instances, Amazon EBS volumes can be used like any other raw block device: they can be formatted with a specific file system, host operating systems and applications, and have snapshots or clones made from them.

**Two Types of AWS EBS Volumes:**

There are two Amazon EBS volume type categories: **SSD-backed volumes** and **HDD-backed volumes**.

* **SSD-backed volumes** are optimized for transactional workloads, where the volume performs a lot of small read/write operations. The performance of such volumes is measured in IOPS.

* **HDD-backed volumes** are designed for large sequential workloads where throughput is much more important (and the performance is measured with MiB/s). Each category has two subsets.

**Sub-types of SSD-based EBS Volumes:**

* **General Purpose SSD (gp2)**

Balanced for price and performance and recommended for most use cases, general purpose SSD is a good choice for boot volumes, applications in development and testing environments, and even for low latency production apps that don’t require high IOPS.

* **Provisioned IOPS SSD (io1)**

The SSD volume type to use for critical production applications and databases that need the high performance (up to 32,000 IOPS) Amazon EBS storage. 
Sub-types of HDD-based EBS Volumes

* **Throughput Optimized HDD (st1)**

Throughput Optimized HDD is designed for applications that require larger storage and bigger throughput, such as big data or data warehousing, where IOPS is not that relevant. St1 volumes, much like SSD gp2, use a burst model, where the initial baseline throughput is tied to the volume size, and credits are accumulated over time.

* **Cold HDD (sc1)**

Cold HDD (sc1) is a magnetic storage format suitable for scenarios where storing data at low cost is the main criteria. 

### Scenario and Objectives

In this lab you will learn:

* Creating an Amazon EBS Volume

* Creating an Instance and attaching an Amazon EBS Volume to that Instance

* Creating a Snapshot of an EBS Volume and copying EBS Volumes Between Regions

* Monitoring the Status of Your Volumes

* Detaching an Amazon EBS Volume from an Instance

## Pre-Requisites

* AWS Account

## Exercise 1: Login to AWS Console

1. Navigate to **chrome** on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select AWS Management console.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Use below credentials to login to AWS console.

 **Account ID:** {{Account ID}} <br>
 **IAM username:** {{username}} <br>
 **Password:** {{password}} <br>
 **Region:** {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Enter **Account ID** from the above information, then click on Next.

5. Enter **IAM username** and **Password** from the above information and click on Sign In.

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. In the navigation bar, on the top-right region dropdown, select below region.

 * Region: {{region}}

## Exercise 2: Create an Amazon EBS Volume

**To create a new EBS volume using the console**

1. Click on **Services**, select **EC2** from the search pane as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

2. In the navigation pane, choose **Volumes** under **ELASTIC BLOCK STORE**.

3. Choose **Create Volume**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

4. Enter below values to crate Volume.

* **Volume Type** : `General Purpose SSD (gp2)`.

* **Size (GiB)**: `100`

* **IOPS**: `300/3000`

* ***Availability Zone**:  `us-east-1a`

> **Note:** EBS volumes can only be attached to EC2 instances within the same Availability Zone.

8. Click on **Add Tag** and enter Key and Value as below:

* **Key**: `Name`
* **Value**: `Awstl-volume`

9. Left remaining values as default and choose **Create Volume**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

10. Once the Volume got created you will see **Volume created successfully** popup then clik on **close** to get back to Volumes page.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/4.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

## Exercise 3: Create an Instance and attach an Amazon EBS Volume to that Instance

### Creating Instance

#### Create VPC

1. Click on `Services`, search for `VPC` and select `VPC` from the options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Click on `Your VPCs` in the left side navigation pane.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws2.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Click on `Create VPC` button

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws3.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. Enter below details 

    * Name tag: `Awstl-vpc`
    * IPv4 CIDR block: `10.0.0.0/16`
    * IPv6 CIDR block:  `No IPv6 CIDR Block`
    * Tenancy: `Default`

5. Click on `Create` button.  

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/v1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

6. Once the VPC creation is completed, `The following VPC was created` message will pop up. Click on `close` button to see the created VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/v2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/v3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

#### Create Internet Gateway

1. Click on `Internet Gateways` on the left pane and click on `Create Internet Gateway` button.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/puppetaws6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. Enter below details and click on `create` button.

    * Name tag: `Awstl-igw`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/i1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

3. Once the Internet Gateway creation is completed, `The following internet gateway was created` message will pop up. Click on `close` button to see the created Internet Gateway. By default the `state` of Internet Gateway shows `detached`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/i2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/i3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

#### Attach the Internet Gateway to VPC

1. select the `Awstl-igw` Internet Gateway, choose `Attach to VPC` option from `Actions` drop down.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/i4.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

2. select the `Awstl-vpc` from drop down and click on `Attach`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/i5.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/i6.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

#### Create a route in route table with internet gateway

1. When you create a VPC, route table also will create along with that.

2. To see the route table that is created while creating `Awstl-vpc`, Click on `Your VPCs` in the left side navigation pane.

3. select `Awstl-vpc` to see the route table.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/r1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

4. Click on the `route table`.

5. Choose `routes` and click on `Edit routes`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/r2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

6. click on `Add route`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/r3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

7. Enter the below details.
   
    * Destination: `0.0.0.0/0`
    * Target: Choose `internet gateway` from drop down and then select `Awstl-igw`

  click on `save routes`  

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/r4.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

8. Once the route creation is completed, `Routes successfully edited` message will pop up. Click on `close` button to see the edited route.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/r5.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/r6.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

#### Create Subnet

1. Choose `Subnets` in the left navigation pane and click on `Create subnet` button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/s1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

2. Specify the below details.

    * Name tag: `subnet1`
    * VPC: Choose `Awstl-vpc` from dropdown
    * Availability Zone: `us-east-1a`
    * IPv4 CIDR block: `10.0.1.0/24`

Click on `create` button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/s2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

3. Once the Subnet creation is completed, `The following Subnet was created` message will pop up. Click on `close` button to see the created Subnet.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/s3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

#### Create Amazon EC2 Key Pair

1. Click on `Services`, search for `EC2` and select `EC2` from the options.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane, under `NETWORK & SECURITY`, choose `Key Pairs`.

**Note:** The navigation pane is on the left side of the Amazon EC2 console. If you do not see the pane, it might be minimized; choose the arrow to expand the pane.

3. Choose `Create Key Pair`.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/k1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

4. For `Key pair name`, enter `Awstl-keypair` and then choose `Create`.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/k2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

5. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is .pem. Save the private key file in a safe place.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/k3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

#### Create EC2 instance

1. Click on `Services`, select `EC2` under `Compute` section.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance1.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

2. In the left side navigation pane., under `INSTANCES` section, choose `Instances`.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance5.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

3. Choose `Launch Instance.`

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/Puppet/awsinstance6.png?st=2019-09-06T10%3A31%3A31Z&se=2022-09-07T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=fwljWymO6LKz5xubtKh3mAsK3r858hNP%2Bl6%2FtadP4MM%3D" alt="image-alt-text" >

4. In `Step 1: Choose an Amazon Machine Image (AMI)`, search for `Ubuntu Server 16.04`, choose Ubuntu Server 16.04 LTS (HVM), SSD Volume Type and choose `Select.`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e1.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

5. In `Step 2: Choose an Instance Type`, select `t2.micro` type and choose `Next: Configure Instance Details.`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e2.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

6. In `Step 3: Configure Instance Details`, specify the below details.

    * Network: choose `Awstl-vpc` from drop down
    * Subnet: Choose `subnet1` from dropdown
    * Auto-assign Public IP: `Enable`
    
7. Keep the default values for others and choose `Next: Add Storage.`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e3.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

8. Choose `Next: Add Tags.`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e4.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

8. Click on `Add tag`

* Enter `Key` as `Name`
* Enter `Value` as `Awstl-instance` 

And choose `Next: Configure Security Group.`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e5.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

9. In Step 6: `Configure Security Group`, review the contents of this page, ensure that `Assign a security group` is set to `Create a new security group` and specify the below details.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e6.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

11. Choose `Launch`.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e7.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

12. Choose `Awstl-keyapair` from `Select a key pair drop down` which you created in previous step.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e8.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

13. Click on `view Instances` at the bottom right.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e9.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

14. Here you can see the `Awstl-instance` instance that is launched.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/e10.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

### Attaching Amazon EBS Volume to the Instance

**To attach an EBS volume to an instance using the console:**

1. In the navigation pane, choose **Volumes** under **Elastic Block Store**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/5.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

2. Select an **available** volume and choose **Actions**, then select **Attach Volume**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/6.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

3. For Instance, start typing the name or ID of the instance. Select the instance from the list of options (only instances that are in the same Availability Zone as the volume are displayed).

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/7.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

4. For Device, you can keep the suggested device name.

5. Choose **Attach**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/8.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

## Exercise 4: Create a Snapshot of an EBS Volume and copy EBS Volumes Between Regions

1. In the navigation pane, choose **Snapshots** under ELASTIC BLOCK STORE.

2. Choose Create **Snapshot**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/9.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

3. **Select resource type** as `Volume`.

4. For **Volume**, choose a the created volume from the dropdown. **Ex**: `Awstl-volume`.

5. Click on Add tag and specify the Key and Value as like below.

* **Key**: `Name`
* **Value**: `Awstl-snapshot`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/10.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

6. Now click on **Create Snapshot**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/11.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

### Copy a Snapshot

**To copy a snapshot using the console:**

1. In the navigation pane, choose **Snapshots**.

2. Select the snapshot you created earlier to copy, and then choose **Copy** from the **Actions** list.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/12.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

3. In the **Copy** Snapshot dialog box, update the following as necessary:

* **Destination region:** `US West (N.California)`

**Description:** You can change this description as necessary.

4. Then Choose **Copy**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/13.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

5. In the Copy Snapshot confirmation dialog box, choose **Close**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/14.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

6. To view the progress of the copy process, switch to the destination Region, and then refresh the Snapshots page.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/15.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/16.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

## Exercise 5: Monitoring the Status of Your Volumes

You can view all the information like **Description**, **Status Check**, **Monitoring** and **Tags** status as shown like below screens.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/17.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/18.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/19.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/20.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

## Exercise 6: Detaching an Amazon EBS Volume from an Instance

In the navigation pane, choose **Volumes**.

Select a volume and choose **Actions**, **Detach Volume**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/21.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)

In the confirmation dialog box, choose **Yes**, **Detach**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/EBSLab4/22.PNG?st=2019-11-29T11%3A53%3A22Z&se=2023-11-30T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Z8aMiH2N5xfdePSiV1d9w%2BgtZQMAnsTQhu%2F9xbOOq5M%3D)
