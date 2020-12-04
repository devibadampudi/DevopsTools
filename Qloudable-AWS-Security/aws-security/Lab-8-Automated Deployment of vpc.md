# Automated Deployment of VPC

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create VPC Stack](#create-vpc-stack)

[Tear down this lab](#tear-down-this-lab)

## Overview

The main aim of this lab is to configure an Amazon VPC and outline some of the AWS security features. AWS CloudFormation will be used to automate the deployment and provide a repeatable way to re-use the template after this lab.

The example CloudFormation template will deploy a completely new VPC incorporating a number of AWS security best practices.

In this lab the CloudFormation template will deploy a completely new VPC incorporating a number of AWS security best practices which are:

Networking subnets created in multiple availability zones for the following network tiers:

1. Application Load Balancer - named ALB1

2. Application instances - named App1

3. Shared services - named Shared1

4. Databases - named DB1

5. VPC endpoints are created for private connectivity to AWS services.

6. NAT Gateways are created to allow different subnets in the VPC to connect to the internet, without any direct ingress access being possible due to Route Table configurations.

7. Network ACLs control access at each subnet layer.

8. While VPC Flow Logs captures information about IP traffic and stores it in Amazon CloudWatch Logs.

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/vpc-architect.png?st=2020-09-24T06%3A25%3A32Z&se=2025-09-25T06%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=w9H0%2FuOpc85OFeQqabzVzVb8PFyJRjJcMeiVuphIlYw%3D)

**Learning Objectives**

1. VPC security features

2. VPC layered subnet architecture

3. Automated deployments

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An **AWS account** that you are able to use for testing, that is not used for production or other purposes.

* An IAM user or role in your AWS account with full access to **CloudFormation, EC2, VPC, IAM, Elastic Load Balancing**.

* Basic understanding of AWS CloudFormation.

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Sign in to the console using below AccountID, IAM username and Password details:

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

## Create VPC Stack

This step will create the VPC and all components using the example CloudFormation template.

1. Download the latest version of the **vpc-alb-app-db.yaml** CloudFormation template from the below link.

**https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Code/vpc-alb-app-db.yaml?st=2020-01-28T09%3A37%3A47Z&se=2023-01-29T09%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=82FK97WJNaVjmFL2l0xndogMMLPH9jY%2FelKx1hUIls4%3D**

2. Click on **lab menu icon** and select **Git bash** as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p0.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

3. Run below commands to change the route directory.

`cd /`

`cd D/PhotonUser/`

`cd Downloads/`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p1.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p2.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. Run below command to download the template.


`curl "https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Code/vpc-alb-app-db.yaml?st=2020-01-28T09%3A37%3A47Z&se=2023-01-29T09%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=82FK97WJNaVjmFL2l0xndogMMLPH9jY%2FelKx1hUIls4%3D" --output vpc-alb-app-db.yaml`

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n1.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

5. Run below command to list the downloaded template file.

`ls`

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n2.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

6. Now go back to AWS console and click on **Services**, search for **CloudFormation** and select **CloudFormation** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n3.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/1.png?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

7. Click on **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/2.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

8. Click **Upload a template file** and then click **Choose file**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/3.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

9. Choose the CloudFormation template you downloaded in step 1, return to the CloudFormation console page and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n4.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/4.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

10. Enter the following details:

**Stack name:** Enter globally unique name. Ex: **WebApp1-VPC**. The parameters may be left as defaults, you can find out more in the description for each. If you change the default name take note.

**Naming Prefix:** Enter globally unique name. Ex: **Webapp1**.

11. At the bottom of the page click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/5.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/6.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/7.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

12. In this lab, we won't add any tags or other options. Click **Next**. Tags, which are key-value pairs, can help you identify your stacks.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/8.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/9.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

13. Review the information for the stack. When you're satisfied with the configuration, check I acknowledge that AWS CloudFormation might create IAM resources with custom names then click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/10.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/11.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

14. After a few minutes the final stack status should change from **CREATE_IN_PROGRESS** to **CREATE_COMPLETE**. You have now created the VPC stack.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/12.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/13.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

## Tear down this lab

**Delete the VPC CloudFormation stack:**

1. Sign in to the AWS Management Console, select your preferred region, and open the CloudFormation console at https://console.aws.amazon.com/cloudformation/.

2. Click the radio button on the left of the WebApp1-VPC stack.

3. Click the Actions button then click Delete stack.

4. Confirm the stack and then click Delete button.

**Conclusion:** Congratulations! You have successfully completed the lab **Automated Deployment of VPC**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

[Amazon VPC User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)

[AWS CloudFormation user guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

