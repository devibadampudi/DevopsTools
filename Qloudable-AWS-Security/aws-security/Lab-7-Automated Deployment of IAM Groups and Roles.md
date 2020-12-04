# Automated Deployment of IAM Groups and Roles

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Signin to AWS Console](#signin-to-aws-console)

[AWS CloudFormation to Create a Groups, Policies and Roles with MFA Enforced](#aws-cloudformation-to-create-a-groups-policies-and-roles-with-mfa-enforced)

[Assume Roles from an IAM user](#assume-roles-from-an-iam-user)

[Tear down this lab](#tear-down-this-lab)


## Overview

The main aim of this lab is to Create AWS CloudFormation Stack and Create Web console role using existing IAM user. 

This hands-on lab will guide you through how to use AWS CloudFormation to automatically configure AWS Identity and Access Management (IAM) Groups and roles for cross-account access. You will use the AWS Management Console and AWS CloudFormation to guide you through how to automate the configuration of a new or existing AWS account with IAM best practices. The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc)

**Learning Objectives**

1. Create AWS CloudFormation Stack

2. Assume Roles from an IAM user
  
**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes.
  
## Signin to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

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

## AWS CloudFormation to Create a Groups, Policies and Roles with MFA Enforced

### Create AWS CloudFormation Stack

1. Download the latest version of the **baseline-iamusercreation.yaml** CloudFormation template from the below link.

https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/baseline-iamusercreation.yaml?st=2020-08-27T08%3A56%3A18Z&se=2025-08-28T08%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z2aI5jmd6vl95NceN2Fd%2FKRqTHy%2FSR5%2BA46TMb9VRzs%3D

2. Click on **lab menu icon** and select **Git bash** as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p0.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

3. Run below commands to change the route directory.

`cd /`

`cd D/PhotonUser/`

`cd Downloads/`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p1.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p2.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. Run below command to download the template.


`curl "https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/baseline-iamusercreation.yaml?st=2020-08-27T08%3A56%3A18Z&se=2025-08-28T08%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z2aI5jmd6vl95NceN2Fd%2FKRqTHy%2FSR5%2BA46TMb9VRzs%3D" --output baseline-iamusercreation.yaml`

5. Run below command to list the downloaded template file.

`ls`

6. Now go back to AWS console and click on **Services**, search for **CloudFormation** and select **CloudFormation** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n3.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/1.png?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)
   
7. Click Create Stack.


<img src="https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/a1.png?st=2020-02-07T05%3A37%3A17Z&se=2023-02-08T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6V9%2Bz%2FhMpKPlvIkN49WPO8w6yLy5msdq7c0fyVhJR3M%3D" alt="image-alt-text" >


8.Click the radio button **Upload a template file**. Choose the CloudFormation template you downloaded in step 1, return to the CloudFormation console page and click Next.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/a2.png?st=2020-02-07T05%3A38%3A35Z&se=2023-02-08T05%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oAjO4oLlubQN3MnKSZnm4UX30ITBh0N9KOXQvHk9oAg%3D" alt="image-alt-text" >

9. Enter the following details:
   
* **Stack name:** The name of this stack. For this lab, **Ex:** `baseline-iam`

*  **AllowRegion:** A single region to restrict access, enter your preferred region. **Ex:** `us-east-1`

* **BaselineExportName:** The CloudFormation export name prefix used with the resource name for the resources created, for example, Baseline-PrivilegedAdminRole.

* **BaselineNamePrefix:** The prefix for roles, groups, and policies created by this stack.

* **IdentityManagementAccount:** (optional) AccountId that contains centralized IAM users and is trusted to assume all roles, or blank for no cross-account trust. Note that the trusted account needs to be appropriately secured.

* **OrganizationsRootAccount:** (optional) AccountId that is trusted to assume Organizations role, or blank for no cross-account trust. Note that the trusted account needs to be appropriately secured.

* **ToolingManagementAccount:** AccountId that is trusted to assume the ReadOnly and StackSet roles, or blank for no cross-account trust. Note that the trusted account needs to be appropriately secured.

10. At the bottom of the page click Next.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/a3.png?st=2020-02-07T05%3A39%3A20Z&se=2023-02-08T05%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Nz4%2BZ5wln7%2FOd3Sgaukhmas46%2F%2FdEHmwKUeTsGd9XE4%3D" alt="image-alt-text" >

11. In this lab, we won't add any tags or other options. Click **Next**.

12. Review the information for the stack. When you're satisfied with the configuration, check **I acknowledge that AWS CloudFormation might create IAM resources with custom names** then click **Create stack.**                                    

<img src="https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/a9.png?st=2020-02-07T05%3A41%3A38Z&se=2023-02-08T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=o0XIIm9J5DfhXSH%2B3zQb%2B3PHfVNEteihtXV8PTwFoMc%3D" alt="image-alt-text" >

13. After a few minutes the stack status should change from **CREATE_IN_PROGRESS** to **CREATE_COMPLETE**.


<img src="https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/a4.png?st=2020-02-07T05%3A42%3A45Z&se=2023-02-08T05%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qCs6aZ8Rv3nzd%2BKaGx3hKVrZGHXOvVRcYgrmEdp9TDs%3D" alt="image-alt-text" >
14. You have now set up a number of managed polices, groups, and roles that you can test to improve your AWS security!


<img src="https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/a5.png?st=2020-02-07T05%3A43%3A25Z&se=2023-02-08T05%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=V82asbMWByrUieuiq6oqzKCZUkidSq7AMBb2civYcEg%3D" alt="image-alt-text" >

## Assume Roles from an IAM user

 We will assume the roles previously created in the web console and command line interface (CLI) using an existing IAM user.

###  Use Restricted Administrator Role in Web Console

**Note:** The permissions of your IAM user and any roles that you switch to are not cumulative. Only one set of permissions is active at a time. When you switch to a role, you temporarily give up your user permissions and work with the permissions that are assigned to the role. When you exit the role, your user permissions are automatically restored.

1. In the console, click your **user name** on the navigation bar in the upper right. It typically looks like this: username@account_ID_number_or_alias. Alternatively you can paste the link in your browser that you recorded earlier.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/1.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

2. Click **Switch Role**. If this is the first time choosing this option, a page appears with more information. After reading it, click Switch Role. If you clear your browser cookies, this page can appear again.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/2.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

3. On the Switch Role page, type the **account ID** number or the account alias and the **name of the role that you created** for the PrivilegedAdmin in the previous step, for example, arn:aws:iam::383656460398:role/baseiam-PrivilegedAdmin.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/3.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/i1.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

4. (Optional) Type text that you want to appear on the navigation bar in place of your user name when this role is active. A name is suggested, based on the account and role information, but you can change it to whatever has meaning for you. You can also **select a color** to highlight the display name. The name and color can help remind you when this role is active, which changes your permissions. For example, for a role that gives you access to the test environment, you might specify a Display Name of Test and select the green Color. For the role that gives you access to production, you might specify a Display Name of Production and select red as the Color.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/i2.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

5. Click **Switch Role**. The display name and color replace your user name on the navigation bar, and you can start using the permissions that the role grants you.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/i3.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

6. You are now using the role with the granted permissions! To stop using a role In the IAM console, choose your role's Display Name on the right side of the navigation bar. Choose Back to UserName. The role and its permissions are deactivated, and the permissions associated with your IAM user and groups are automatically restored.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/i4.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/automateddeploymentsofiam/i5.PNG?st=2020-08-27T09%3A44%3A16Z&se=2025-08-28T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=CbBg69w7HxDtp730RHF8CjniVSradIUlAsN7249NfOc%3D)

## Tear down this lab

The following instructions will remove the resources that have a cost for running them. Please note that the changes you made to the root login, users, groups, and policies have no charges associated with them.

Delete the IAM stack:
1. Sign in to the AWS Management Console, and open the CloudFormation console at https://console.aws.amazon.com/cloudformation/.
2. Select the baseline-iam stack.
3. Click the Actions button then click Delete Stack.
4. Confirm the stack and then click the Yes, Delete button.

**Conclusion:** Congratulations! You have successfully completed the **Automated Deployment of IAM Groups and Roles**. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">



### References

[AWS CloudFormation user guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

[AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPracticesAndUseCases.html)



### License:

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
