# AWS Account and Root User

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to AWS Console](#sign-in-to-aws-console)

[Account Settings and Root User Security](#account-settings-and-root-user-security)

[Tear Down this lab](#tear-down-this-lab)

## Overview

This hands-on lab will guide you through the introductory steps to configure a new AWS account and secure the root user.This process is not required for accounts you manage with [AWS Organizations](https://aws.amazon.com/organizations/) or [AWS Control Tower](https://aws.amazon.com/controltower/) to manage your AWS accounts.The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**Learning Objectives:**

1. Generate and Review the AWS Account Credential Report

2.  Enable a Virtual MFA Device for Your AWS Account Root User

3.  Remove Your AWS Account Root User Access Keys
 
4.  Periodically Change the AWS Account Root User Password

5.  Configure a Strong Password Policy for Your Users

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

Note: Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch.

## Sign in to AWS Console

1.Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

2. sign in as the **Root user** using your AWS account email address.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/login.PNG?st=2020-09-25T08%3A12%3A23Z&se=2025-09-26T08%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8DsuJz3uLV2NyUlj4gCLvwAr3LHK2J0lPsVpAslSSzU%3D)

3. Sign in to the console using below **AccountID, IAM username** and **Password** details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

4. Now enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`


## Account Settings and Root User Security

When you first create an Amazon Web Services (AWS) account, you begin with a single sign-in identity that has complete access to all AWS services and resources in the account. This identity is called the AWS account root user and is accessed by signing in with the email address and password that you used to create the account. It is strongly recommend that you do not use the root user for your everyday tasks, even the administrative ones. Instead, adhere to the best practice of using the root user only to create your first IAM user, groups and roles. Then securely lock away the root user credentials and use them to perform only a few account and service management tasks. 

### Generate and Review the AWS Account Credential Report

Its good to get an idea of what you have configured already in your AWS account especially if you have had it for a while. You should audit your security configuration in the following situations:

* On a periodic basis. You should perform the steps described here at regular intervals as a best practice for security.

* If there are changes in your organization, such as people leaving.

* If you have stopped using one or more individual AWS services. This is important for removing permissions that users in your account no longer need.

* If you've added or removed software in your accounts, such as applications on Amazon EC2 instances, AWS OpsWorks stacks, AWS CloudFormation templates, etc.

* If you ever suspect that an unauthorized person might have accessed your account.

As you review your account's security configuration, follow these guidelines:

* **Be thorough**. Look at all aspects of your security configuration, including those you might not use regularly.
* **Don't assume**. If you are unfamiliar with some aspect of your security configuration (for example, the reasoning behind a particular policy or the existence of a role), investigate the business need until you are satisfied.
* **Keep things simple**. To make auditing (and management) easier, use IAM groups, consistent naming schemes, and straightforward policies.

You can use the AWS Management Console to download a credential report as a comma-separated values (CSV) file. Please note that credential report can take 4 hours to reflect changes. To download a credential report using the AWS Management Console:

1. Open the IAM console at https://console.aws.amazon.com/iam/.

2. In the navigation pane, click Credential report.

3. Click Download Report.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/1.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

### Enable a Virtual MFA Device for Your AWS Account Root User

You can use IAM in the AWS Management Console to configure and enable a virtual MFA device for your root user. To manage MFA devices for the AWS account, you must be signed in to AWS using your root user credentials. You cannot manage MFA devices for the root user using other credentials.

If your MFA device is lost, stolen, or not working, you can still sign in using alternative factors of authentication. To do this, you must verify your identity using the email and phone that are registered with your account. This means that if you can't sign in with your MFA device, you can sign in by verifying your identity using the email and phone that are registered with your account. Before you enable MFA for your root user, review your account settings and contact information to make sure that you have access to the email and phone number.

1. Use your AWS account email address and password to sign in as the AWS account root user to the IAM console at [https://console.aws.amazon.com/iam/](https://console.aws.amazon.com/iam/)

2. Do one of the following:

   * **Option 1**: Click Dashboard, and under Security Status, expand Activate MFA on your root user. Then expand the Multi-Factor Authentication (MFA) section on the page.

3. Click Manage MFA or Activate MFA, depending on which option you chose in the preceding step.

 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/2.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)
4. In the wizard, click A virtual MFA device and then click Next Step.
 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/3.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

5. Confirm that a virtual MFA app is installed on the device, and then click Next Step. IAM generates and displays configuration information for the virtual MFA device, including a QR code graphic. The graphic is a representation of the secret configuration key that is available for manual entry on devices that do not support QR codes.

 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/4.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

6. With the Manage MFA Device wizard still open, open the virtual MFA app on the device.

7. If the virtual MFA software supports multiple accounts (multiple virtual MFA devices), then click the option to create a new account (a new virtual device).

 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/5.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

8. The easiest way to configure the app is to use the app to scan the QR code. If you cannot scan the code, you can type the configuration information manually.

   * To use the QR code to configure the virtual MFA device, follow the app instructions for scanning the code. For example, you might need to tap the camera icon or tap a command like Scan account barcode, and then use the device's camera to scan the QR code.

   * If you cannot scan the code, type the configuration information manually by typing the Secret Configuration Key value into the app. For example, to do this in the AWS Virtual MFA app, click Manually add account, and then type the secret configuration key and click Create.

    **Important**

    Make a secure backup of the QR code or secret configuration key, or make sure that you enable multiple virtual MFA devices for your account. A virtual MFA device might become unavailable, for example, if you lose the smartphone where the virtual MFA device is hosted). If that happens, you will not be able to sign in to your account and you will have to contact customer service to remove MFA protection for the account.

    **Note**: The QR code and secret configuration key generated by IAM are tied to your AWS account and cannot be used with a different account. They can, however, be reused to configure a new MFA device for your account in case you lose access to the original MFA device.

    The device starts generating six-digit numbers.


9. In the Manage MFA Device wizard, in the Authentication Code 1 box, type the six-digit number that's currently displayed by the MFA device. Wait up to 30 seconds for the device to generate a new number, and then type the new six-digit number into the Authentication Code 2 box.

   **Important**

   Submit your request immediately after generating the codes. If you generate the codes and then wait too long to submit the request, the MFA device successfully associates with the user but the MFA device is out of sync. This happens because time-based one-time passwords (TOTP) expire after a short period of time. If this happens, you can resync the device.
    ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/6.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

10. Click Next Step, and then click Finish.

 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/7.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

The device is ready for use with AWS.

### Configure Account Security Challenge Questions

Configure account security challenge questions because they are used to verify that you own an AWS account.

1. Use your AWS account email address and password to sign in as the AWS account root user and open the AWS account settings page at [https://console.aws.amazon.com/billing/home?#/account/](https://console.aws.amazon.com/billing/home?#/account/).

2. Navigate to security challenge questions configuration section.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Aws-Security/Images/Lab1/4.png)

3. Select three challenge questions and enter answers for each.

4. Securely store the questions and answers as you would passwords or other credentials.

5. Click update.

### Configure Account Alternate Contacts

Alternate contacts enable AWS to contact another person about issues with the account, even if you are unavailable.

1. Use your AWS account email address and password to sign in as the AWS account root user and open the AWS account settings page at [https://console.aws.amazon.com/billing/home?#/account/](https://console.aws.amazon.com/billing/home?#/account/).

2. Navigate to alternate contacts configuration section.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Aws-Security/Images/Lab1/5.png)

3. Enter contact details for billing, operations and security.

4. Click update.

### Remove Your AWS Account Root User Access Keys

You use an access key (an access key ID and secret access key) to make programmatic requests to AWS. However, **do not** use your AWS account root user access key. The access key for your AWS account gives full access to all your resources for all AWS services, including your billing information. You cannot restrict the permissions associated with your AWS account access key.

* Check in the credential report; if you don't already have an access key for your AWS account, don't create one unless you absolutely need to. Instead, use your account email address and password to sign in to the AWS Management Console and create an IAM user for yourself that has administrative privileges.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/8.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

* If you do have an access key for your AWS account, delete it unless you have a specific requirement. To delete or rotate your AWS account access keys, go to the [Security Credentials](https://console.aws.amazon.com/iam/home?#security_credential) page in the AWS Management Console and sign in with your account's email address and password. You can manage your access keys in the Access keys section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/9.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/10.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/11.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/13.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

* Never share your AWS account password or access keys with anyone.

### Periodically Change the AWS Account Root User Password

You must be signed in as the AWS account root user in order to change the password.

To change the password for the root user:

1. Use your AWS account email address and password to sign in to the AWS Management Console as the root user.

   **Note**

     If you previously signed in to the console with IAM user credentials, your browser might remember this preference and open your account-specific sign-in page. You cannot use the IAM user sign-in page to sign in with your AWS account root user credentials. If you see the IAM user sign-in page, click Sign-in using root account credentials near the bottom of the page to return to the main sign-in page. From there, you can type your AWS account email address and password.

2. In the upper right corner of the console, click your account name or number and then click My Account.

3. On the right side of the page, next to the Account Settings section, click Edit.

4. On the Password line choose Click here to change your password.
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/14.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

5. Choose a strong password. Although you can set an account password policy for IAM users, that policy does not apply to your AWS account root user.

   AWS requires that your password meet these conditions:

   * have a minimum of 8 characters and a maximum of 128 characters
   * include a minimum of three of the following mix of character types: uppercase, lowercase, numbers, and `! @ # $ % ^ & * () <> [] {} | _ + - =` symbols
   * not be identical to your AWS account name or email address

    **Note**

   AWS is rolling out improvements to the sign-in process. One of those improvements is to enforce a more secure password policy for your account. If your account has been upgraded, you are required to meet the password policy above. If your account has not yet been upgraded, then AWS does not enforce this policy, but highly recommends that you follow its guidelines for a more secure password.

    To protect your password, it's important to follow these best practices:

   * Change your password periodically and keep your password private, since anyone who knows your password can access your account.

   * Use a different password on AWS than you use on other sites.

 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/15.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)


   * Avoid passwords that are easy to guess. These include passwords such as secret, password, amazon, or 123456. They also include things like a dictionary word, your name, email address, or other personal information that can easily be obtained.

### Configure a Strong Password Policy for Your Users

You can set a password policy on your AWS account to specify complexity requirements and mandatory rotation periods for your IAM users' passwords. The IAM password policy does not apply to the AWS root account password.

To create or change a password policy:

1. Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/.

2. In the navigation pane, click Account Settings.

3. In the Password Policy section, select the options you want to apply to your password policy.
 
  ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/15.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)


4. Click Apply Password Policy.


 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/16.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/AWS%20Account%20and%20Root%20User/17.png?st=2020-02-24T05%3A37%3A01Z&se=2023-02-25T05%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=LChbnRgpXPChkT%2BhUpxG9pnafCsHwb%2BWr3yhLVCuOMc%3D)

**Note:** Please note that the changes you made to the account and root user have no charges associated with them.

## Tear Down this lab

 Please note that the changes you made to secure your account and root user should remain in place, and have no charges associated with them.
 
 **Conclusion:** Congratulations! You have successfully completed the lab **AWS Account and Root User**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References & useful resources

[AWS Tasks That Require Root User](https://docs.aws.amazon.com/general/latest/gr/root-vs-iam.html#aws_tasks-that-require-root.html)

[Getting credential reports for your AWS account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html)

[AWS Identity and Access Management User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

[IAM Best Practices and Use Cases](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPracticesAndUseCases.html)

[Resetting Your Lost or Forgotten Passwords or Access Keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys_retrieve.html)

[Using MFA Devices With Your IAM Sign-in Page](https://docs.aws.amazon.com/IAM/latest/UserGuide/console_sign-in-mfa.html)

[What If an MFA Device Is Lost or Stops Working](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_lost-or-broken.html)

****

### License:

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

