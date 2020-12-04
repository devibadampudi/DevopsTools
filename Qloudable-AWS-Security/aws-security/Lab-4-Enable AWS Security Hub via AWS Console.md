# Enable AWS Security Hub via AWS Console

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Enable AWS Security Hub](#enable-aws-security-hub)

## Overview

The main aim of this lab is to Enable AWS Security Hub using AWS console.The AWS console provides a graphical user interface to search and work with the AWS services. We will use the AWS console 
to enable AWS Security Hub.

[AWS Security Hub](https://aws.amazon.com/security-hub/?aws-security-hub-blogs.sort-by=item.additionalFields.createdDate&aws-security-hub-blogs.sort-order=desc) gives you a comprehensive view of your high-priority security alerts and compliance status across AWS accounts. There are a range of powerful security tools at your disposal, from firewalls and endpoint protection to vulnerability and compliance scanners. But oftentimes this leaves your team switching back-and-forth between these tools to deal with hundreds, and sometimes thousands, of security alerts every day. With Security Hub, you now have a single place that aggregates, organizes, and prioritizes your security alerts, or findings, from multiple AWS services, such as Amazon GuardDuty, Amazon Inspector, and Amazon Macie, as well as from AWS Partner solutions. Your findings are visually summarized on integrated dashboards with actionable graphs and tables. You can also continuously monitor your environment using automated compliance checks based on the AWS best practices and industry standards your organization follows. Get started with AWS Security Hub in just a few clicks in the Management Console and once enabled, Security Hub will begin aggregating and prioritizing findings.

**Learning Objectives**

  1. Enable AWS Security Hub via AWS Console
 
 **Some Key points:**

  1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

  2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

  3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

  4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

  5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes.   

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on My Account -> AWS Management Console.

* Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Use below credentials to login to AWS console.

* **Account ID:** `{{Account_ID}}` <br>
* **IAM username:** `{{User_Name}}` <br>
* **Password:** `{{Password}}`

* Select **IAM user** and then enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/3.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/4.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{Region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/5.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

## Enable AWS Security Hub

1. Once you have logged into your AWS account you can use the search facility to locate **Security Hub**. All you need to do is type in **Security Hub** in the search field.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/Enable-securityhub/sh1.png?st=2020-01-23T09%3A04%3A32Z&se=2022-01-24T09%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PTesftKx5aFsxD2gvBA9fPcweqAeiQt0nkcdTvsQXEY%3D" alt="image-alt-text" >

2. Once Security Hub shows up you can click on Security Hub to **go to the Security Hub** service.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/Enable-securityhub/sh2.png?st=2020-01-23T09%3A04%3A59Z&se=2022-01-24T09%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=I2%2BtM%2FjRTiQP3YopjxbKmb%2Bfqjz70qXOrN0U8ii%2FwkI%3D" alt="image-alt-text" >

### Enable AWS Security Hub

1. In the AWS Security Hub service console you can click on the Enable Security Hub orange button to **enable AWS Security Hub** in your account.

2. AWS Security Hub requires services permissions to run within your account. You can review the service role permissions in the following screen. Remember to click **Enable AWS Security Hub**

<img src="https://qloudableassets.blob.core.windows.net/aws-security/Enable-securityhub/sh3.png?st=2020-01-23T09%3A05%3A25Z&se=2022-01-24T09%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fbGcAQKLng%2B%2F8v%2FgjCAn8OU1u7cOiwaaikX4UOK0uAQ%3D" alt="image-alt-text" >

### Explore AWS Security Hub

1. With AWS Security Hub now enabled in your account, you can explore the **security insights** AWS Security Hub offers.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/Enable-securityhub/sh4.png?st=2020-01-23T09%3A05%3A54Z&se=2022-01-24T09%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iOXhQQgokl%2FEwLUexWb4d1dnfxW1LKiVelPUYYREpok%3D" alt="image-alt-text" >

**Conclusion:** Congratulations! You have successfully completed the **Enable AWS Security Hub** via AWS Console. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

### References

1. [AWS Security Hub](https://aws.amazon.com/security-hub/)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
