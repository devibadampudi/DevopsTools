# Basic Identity and Access Management User, Group, Role

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Signin to AWS Console](#signin-to-aws-console)

[AWS Identity and Access Management](#aws-identity-and-access-management)

[Assume Administrator Role from an IAM user](#assume-administrator-role-from-an-iam-user)

[Tear down this lab](#tear-down-this-lab)

## Overview

In this hands-on Lab, you will be introduced to configure AWS Identity and Access Management (IAM). You will use the AWS Management Console to guide you through how to configure your first IAM user, group and role for administrative access. The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

<img src="https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/Architecture%20Diagram.PNG?st=2020-09-28T14%3A11%3A31Z&se=2025-09-29T14%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=weSVuRcfe1ROJcJZGnxmOu8XpGeEqezV2VTUS%2FIleUw%3D">

**Learning Objectives:**

1. Create Administrator IAM User and Group

2. Create Administrator IAM Role

3. Assume Administrator Role from an IAM user

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

Note: Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch.

## Signin to AWS Console

1. Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

2. Sign in to the console using below AccountID, IAM username and Password details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

3. Enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible2.PNG?st=2020-06-22T10%3A01%3A27Z&se=2025-06-23T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sWd732QnYW%2BQkKYyntda9P9HUYIZtKy4Kk6NLCy19EI%3D" alt="image-alt-text" >

4. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## AWS Identity and Access Management

As a best practice, do not use the AWS account root user for any task where it's not required. Instead, create a new IAM user for each person that requires administrator access. Then make those users administrators (only if they absolutely need full access to everything) by placing the users into an "Administrators" group to which you attach the AdministratorAccess managed policy.

### Create Administrator IAM User and Group

To create an administrator user for yourself and add the user to an administrators group:

1. Click **Services** and Type IAM in the search box and then select **IAM** service.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/1.PNG?st=2020-02-11T06%3A03%3A10Z&se=2023-02-12T06%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X4USQjDdUmrM5voZuQ1c4m4gDQxT%2Fm1IAZO59ROgvvI%3D)

2. In the navigation pane, click **Users** and then click **Add user**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/2.png?st=2020-01-30T09%3A41%3A26Z&se=2023-01-31T09%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=g7IS%2F89HC6nAOg8S5gLSoXEOk30k8uDuL%2FLwJRR1C3s%3D)

3. For *User name*, type a user name for yourself, such as Bob or Alice. Each user should have their own user name, do not share credentials. The name can consist of letters, digits, and the following characters: plus `(+)`, equal `(=)`, comma `(,)`, period `(.)`, at `(@)`, underscore `(_)`, and hyphen `(-)`. The name is not case sensitive and can be a maximum of 64 characters in length.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/3.png?st=2020-01-30T09%3A44%3A00Z&se=2023-01-31T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ke7QPzwTC5mIBqYzlGZeSkXvVgGtUBBJ%2BDRiNzuxRY0%3D)

4. Select the check box next to **AWS Management Console access**, select **Custom password**, and then type your new password in the text box. This user will be able to do almost anything in your account, by not giving it programmatic access (access & secret key) you reduce your risk, and we will configure lower-privileged users and roles later. If you're creating the user for someone other than yourself, you can optionally select Require password reset to force the user to create a new password when first signing in.

5. Click **Next: Permissions**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/4.png?st=2020-01-30T09%3A45%3A13Z&se=2023-01-31T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ECa9vJbzBogt4xMZOsptDSIhWJ6yvYFDocDaUyS6f0g%3D)

6. On the Set permissions for user page, click **Add user to group**.

7. Click **Create group**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/5.png?st=2020-01-30T09%3A45%3A45Z&se=2023-01-31T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nwTIUxvVs70256OFk94maXqazoM8dd%2FSoccs97TzpPk%3D)

8. In the Create group dialog box, type the name for the new group such as Administrators. The name can consist of letters, digits, and the following characters: `plus (+), equal (=), comma (,), period (.), at (@), underscore (_), and hyphen (-).` The name is not case sensitive and can be a maximum of 128 characters in length.

9. In the policy list, select the check box next to **AdministratorAccess**. Then click **Create group**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/6.png?st=2020-01-30T09%3A47%3A22Z&se=2023-01-31T09%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4jZdIcz9FvS3ZsSgZAOnGUjVqXhOrVG0ujr%2B3WqMimU%3D)

10. Back in the list of groups, verify the check box is next to your new group. Click **Refresh** if necessary to see the group in the list.

11. Click **Next: Tags**. For this lab we will not add tags to the user.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/7.png?st=2020-01-30T09%3A48%3A32Z&se=2023-01-31T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=e%2FKobEc68kg9nYRUqM%2F8UlJDec5TEWwRxysmF6C%2FJrk%3D)

12. Click **Next: Review** to see the list of group memberships to be added to the new user. When you are ready to proceed, click Create user.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/13.png?st=2020-01-30T10%3A06%3A16Z&se=2023-01-31T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Wok0zFfpTGIcPh536FvDSvAI28tCDw4lvsC6ijKtkiM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/8.png?st=2020-01-30T09%3A55%3A40Z&se=2023-01-31T09%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=G3EwdlLkVWiF744rlaGNrnfKMXgRDGnb0mOEH70tCsY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/9.png?st=2020-01-30T10%3A28%3A00Z&se=2023-01-31T10%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=E4rVXk9MAR4QrpIiyTpeChiUhRSe3zSmpqUJRvR%2BOKA%3D)

You can use this same process to create more groups and users and to give your users access to your AWS account resources. To learn about using policies that restrict user permissions to specific AWS resources, see [Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/access.html) and [Example Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html). To add users to the group after it's created, see [Adding and Removing Users in an IAM Group](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups_manage_add-remove-users.html).


### Create Administrator IAM Role

To create an administrator role for yourself (and other administrators) to be used with the administrator user and group you just created:

1. In the navigation pane, click **Roles** and then click **Create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/10.png?st=2020-01-30T10%3A29%3A43Z&se=2023-01-31T10%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JeS%2BR9tlwZWTLZOXEM%2BuJlh4YY2t%2Fdicdx83ihMEH6E%3D)

2. Click Another AWS account, then enter your account ID and tick **Require MFA,** then click **Next: Permissions**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/16.PNG?st=2020-02-06T10%3A58%3A40Z&se=2023-02-07T10%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pe7KQeIJJpn5L6BeYgWdO06jaN2ZHqGM75j5L2vQ15U%3D)

**Note:** If you are not enabled MFA in your account, uncheck the MFA option.

4. Tick AdministratorAccess from the list, and then click **Next: Tags**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/17.PNG?st=2020-02-06T11%3A00%3A05Z&se=2023-02-07T11%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=P13tk5lLYf33LKmyWfl56o1%2F04Gl8INeWsaCMaf0H40%3D)

5. Click **Next: Review**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/18.PNG?st=2020-02-06T11%3A01%3A00Z&se=2023-02-07T11%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TiWV18QeZBEVMwngY8RrpbBESTOiebZuYO%2FdaWQeyE4%3D)

5. Enter a role name, e.g. 'Administrators' then click **Create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/19.PNG?st=2020-02-06T11%3A01%3A41Z&se=2023-02-07T11%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VVCZid%2BE%2F9km0qW3dXvzHJzhT8v84KqBbO84fhp5c88%3D)

6. Check the role you have configured by clicking the role you have just created. Record both the Role ARN and the link to the console. You can also optionally change the session duration timeout.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/23.png?st=2020-02-06T11%3A04%3A03Z&se=2023-02-07T11%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YIIuMUBLxm0RVDc3XTv3eOu7E0qqvSOsu0nlwa0PYys%3D)

7. The role is now created, with full administrative access.

## Assume Administrator Role from an IAM user

We will assume the role using the IAM user that we previously created in the web console. As the IAM user has full access it is a best practice not to have access keys to assume the role on the CLI, instead we should use a restricted IAM user for this so we can enforce the requirement of MFA.

### Use Administrator Role in Web Console

A role specifies a set of permissions that you can use to access AWS resources that you need. In that sense, it is similar to a user in AWS Identity and Access Management (IAM). A benefit of roles is they allow you to enforce the use of an MFA token to help protect your credentials. When you sign in as a user, you get a specific set of permissions. However, you don't sign in to a role, but once signed in (as a user) you can switch to a role. This temporarily sets aside your original user permissions and instead gives you the permissions assigned to the role. The role can be in your own account or any other AWS account. By default, your AWS Management Console session lasts for one hour.

!Tip:
The permissions of your IAM user and any roles that you switch to are not cumulative. Only one set of permissions is active at a time. When you switch to a role, you temporarily give up your user permissions and work with the permissions that are assigned to the role. When you exit the role, your user permissions are automatically restored.


1. Sign in to the AWS Management Console as an IAM user **https://console.aws.amazon.com.**

2. In the console, click your user name on the navigation bar in the upper right. It typically looks like this: **username@account_ID_number_or_alias**. Alternatively you can paste the link in your browser that you recorded earlier.

3. Click Switch Role. If this is the first time choosing this option, a page appears with more information. After reading it, click Switch Role. If you clear your browser cookies, this page can appear again.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/20.PNG?st=2020-02-06T11%3A13%3A21Z&se=2023-02-07T11%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aFphlDul7Bwv1rL4JFrpcXsZfIOEPuJKwM0cpY3GI%2BE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/21.PNG?st=2020-02-06T11%3A14%3A22Z&se=2023-02-07T11%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=m5L9ABWv97WLVeS%2FfS2LRPmB%2Bd8tuM0LS72jpFhPUho%3D)

4. On the Switch Role page, type the account ID number or the account alias in the Account field, and the name of the role that you created for the Administrator in the Role field.

5. (Optional) Type text that you want to appear on the navigation bar in place of your user name when this role is active. A name is suggested, based on the account and role information, but you can change it to whatever has meaning for you. You can also select a color to highlight the display name. The name and color can help remind you when this role is active, which changes your permissions. For example, for a role that gives you access to the test environment, you might specify a Display Name of Test and select the green Color. For the role that gives you access to production, you might specify a Display Name of Production and select red as the Color.

6. Click Switch Role. The display name and color replace your user name on the navigation bar, and you can start using the permissions that the role grants you.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20Identity%20and%20Access%20Management%20User%2C%20Group%2C%20Role/images/22.PNG?st=2020-02-06T11%3A15%3A40Z&se=2023-02-07T11%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kL0xtcQI9yNSpmvjIHiznhWSzA36Egj1eblA94qUBlU%3D)

!Tip:
The last several roles that you used appear on the menu. The next time you need to switch to one of those roles, you can simply click the role you want. You only need to type the account and role information manually if the role is not displayed on the Identity menu.

7. You are now using the role with the granted permissions!

**To stop using a role** In the IAM console, click your role's Display Name on the right side of the navigation bar. Click Back to UserName. The role and its permissions are deactivated, and the permissions associated with your IAM user and groups are automatically restored.

## Tear down this lab

Please note that the changes you made to the users, groups, and roles have no charges associated with them.

**Conclusion:** You have Successfully completed in creating **Basic Identity and Access Management User, Group, Role**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

## References & useful resources

[AWS Identity and Access Management User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
[IAM Best Practices and Use Cases](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPracticesAndUseCases.html)
[AWS CloudFormation User Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

***

## License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

    https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

