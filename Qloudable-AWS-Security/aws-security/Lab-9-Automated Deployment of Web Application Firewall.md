# Automated Deployment of Web Application Firewall

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Configure AWS WAF](#configure-aws-waf)

[Tear down this lab](#tear-down-this-lab)

## Overview

The main aim of this lab is to Deploy the AWS Web Application Firewall (WAF) using cloudformation template.

This hands-on lab will guide you through the steps to protect a workload from network based attacks using AWS Web Application Firewall (WAF) integrated with Amazon CloudFront. You will use the AWS Management Console and AWS CloudFormation to guide you through how to deploy AWS Web Application Firewall (WAF) with CloudFront integration to apply defense in depth methods. Skills learned will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/AWS-WAF.png?st=2020-09-23T09%3A46%3A29Z&se=2025-09-24T09%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NrcnoUlXdiPK8bgJftDqcPszSTuWoo6YMMbugf2a0aE%3D)

**Learning Objectives**

1. Deploying a WAF cloudformation template

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes. 

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Sign in to the console using below **AccountID, IAM username** and **Password** details:

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

## Configure AWS WAF

Using AWS CloudFormation, we are going to deploy a basic example AWS WAF configuration for use with CloudFront.

1. Click on **Services**, search for **CloudFormation** and select **CloudFormation** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/1.png?st=2020-02-11T10%3A34%3A33Z&se=2023-02-12T10%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vCz7%2F8i7FfUNyhoBYUuMIIKV9wtyJvw7WUDfkpwIFvM%3D)

2. Click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/2.PNG?st=2020-02-11T10%3A36%3A05Z&se=2023-02-12T10%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=F9guxff4yfC7trMPJeblSnb%2BxHNW486jd4DJ1xZWzEY%3D)

**Note:** Copy and Paste the below URL in new chrome browser to Download the template and save the template in downloads:

**https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/Code/waf-global.yaml?st=2020-02-13T10%3A07%3A10Z&se=2023-02-14T10%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uDhZGVqerGALjBvcfZdB2ZuwDJScrXZAJ50U4cFk6Zw%3D**

3. Click the radio button **Upload a template file**. Choose the CloudFormation template you downloaded in previous step, return to the CloudFormation console page and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/w1.PNG?st=2020-08-27T10%3A31%3A01Z&se=2025-08-28T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3IU%2FKirMFE5evLea4vjY4j527rkPO3uRPTNXDNZmvRQ%3D)

4. Enter the following details:

* **Stack name:** The name of this stack. **Ex:** `waf`

* **WAFName:** Enter the base name to be used for resource and export names for this stack. For this lab, **Ex:** `Lab1`

* **WAFCloudWatchPrefix:** Enter the name of the CloudWatch prefix to use for each rule using alphanumeric characters only. **Ex:** `Lab1` The remainder of the parameters can be left as defaults.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/4.PNG?st=2020-02-11T10%3A40%3A39Z&se=2023-02-12T10%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fJXNK2rWQhHpCqWNUDDLdZV9CVSQrOKmvFTBcenRONQ%3D)

5. At the bottom of the page click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/5.PNG?st=2020-02-11T10%3A42%3A09Z&se=2023-02-12T10%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nki8%2FRrhnZqwgFt8BRQI8kNYH5lm7CoJ5H%2BWMtu%2FnSQ%3D)

6. In this lab, we won't add any tags or other options. Click **Next**. Tags, which are key-value pairs, can help you identify your stacks.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/6.PNG?st=2020-02-11T10%3A43%3A07Z&se=2023-02-12T10%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=usZgkzOIUMT4V2J21hrZ6O4cb3mmBZjssJObzNjarJE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/7.PNG?st=2020-02-11T10%3A43%3A48Z&se=2023-02-12T10%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=K7ZqEWELue1C19x5%2Fc2jARA8SC%2F0U856V9jr0eK2xBg%3D)

7. Review the information for the stack. When you're satisfied with the configuration, click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/8.PNG?st=2020-02-11T10%3A44%3A35Z&se=2023-02-12T10%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OBcIUfyWBJdyTrnj5f0Th2Z2r9YFlR24nJ1q0q0fzZg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/9.PNG?st=2020-02-11T10%3A45%3A31Z&se=2023-02-12T10%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=O6rOpekUJuTwjjLlo8cY4KUeU0oNTW%2FKH4gGSoPwo6s%3D)

8. After a few minutes the stack status should change from **CREATE_IN_PROGRESS** to **CREATE_COMPLETE**.

9. You have now set up a basic AWS WAF configuration ready for CloudFront to use!

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Web%20Application%20Firewall/images/10.PNG?st=2020-02-11T10%3A46%3A10Z&se=2023-02-12T10%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8DQt7DvyWa6vgN%2FO2kd0PwiKU6JzH9Ow5XvRAGZG12A%3D)

## Tear down this lab

The following instructions will remove the resources that have a cost for running them. Please note that Security Groups and SSH key will exist. You may remove these also or leave for future use.

### Delete the CloudFront distribution

1. Open the Amazon CloudFront console at https://console.aws.amazon.com/cloudfront/home.

2. From the console dashboard, select the **distribution** you created earlier and click the **Disable** button. To confirm, click the **Yes, Disable** button.

3. After approximately 15 minutes when the status is Deployed, select the distribution and click the **Delete** button, and then to confirm click the **Yes, Delete** button.
Delete the AWS WAF stack:

### Delete Stack

1. Sign in to the AWS Management Console, and open the CloudFormation console at https://console.aws.amazon.com/cloudformation/.

2. Select the waf-cloudfront stack.

3. Click the Actions button, and then click Delete Stack.

4. Confirm the stack, and then click the Yes, Delete button.

**Conclusion**

Congratulations! You have successfully completed the lab **Automated Deployment of WebApplication Firewall**!.Feel free to continue exploring or start a new lab.

![alt text](https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif)

Thank you for taking this training lab..

### References

1. [Amazon Elastic Compute Cloud User Guide for Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)

2. [Amazon CloudFront Developer Guide](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

3. [Tutorial: Configure Apache Web Server on Amazon Linux 2 to Use SSL/TLS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SSL-on-amazon-linux-2.html)

4. [AWS WAf,  AWS Firewall manager, and  AWS Shield Advanced Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
