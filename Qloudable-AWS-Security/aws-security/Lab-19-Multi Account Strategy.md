# Multi-Account Strategy

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Create multiple accounts](#exercise-2-create-multiple-accounts)

## Overview

 The main aim of this lab is to create multiple accounts.

**Introduction**

This hands-on lab will guide you through the introductory steps to protect an Amazon EC2 workload from network based attacks. You will use the AWS Management Console and AWS CloudFormation to guide you through how to secure an Amazon EC2 based web application with defense in depth methods. Skills learned will help you secure your workloads in alignment with the AWS Well-Architected Framework.

### Scenario and Objectives

After completing this lab, you will be able to:

* Create an AWS Organization in the root account

* To invite another account to join your organization (console)

* Create a new account in organizations. Make note of the organizations account access role

* To create an AWS Organizations administrator role in a member account (console)

## Pre-Requisites

* AWS account 

## Exercise 1: Login to AWS Console

1. Navigate to **Chrome** on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

3. Use below credentials to login to AWS console.

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

4. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Exercise 2: Create multiple accounts

### Create an AWS Organization in the root account

1. Sign in to the AWS Management Console and open the AWS Organizations console at https://console.aws.amazon.com/organizations/. You must sign in as an IAM user, assume an IAM role, or sign in as the root user (not recommended) in the account that you want to be the organization's master account.

2. On the introduction page, choose Create organization.

3. In the Create organization confirmation dialog box, choose Create organization.

    **Note**
    By default, the organization is created with all features enabled. You can also create the organization with only consolidated           billing features enabled.

    The organization is created. You're now on the Accounts tab. The star next to the account email indicates that it's the master           account.

    A verification email is automatically sent to the address that is associated with your master account. There might be a delay before     you receive the verification email.

4. Verify your email address within 24 hours. For more information, see Email Address Verification.

5. Add accounts to your organization as follows:

 * To create an AWS account that is automatically part of your AWS organization, see Creating an AWS Account in Your Organization.

 * To invite an existing account to your organization, see Inviting an AWS Account to Join Your Organization.

    **Note**
    You can add new accounts to your organization without verifying your master account's email address. To invite existing accounts,       you must first verify that email address.

### To invite another account to join your organization (console)

1. Sign in to the Organizations console at https://console.aws.amazon.com/organizations/. You must sign in as an IAM user, assume an IAM role, or sign in as the root user (not recommended) in the organization's master account.

2. If your email address is already verified, skip this step.

    If your email address isn't verified yet, follow the instructions in the verification email within 24 hours. There might be a delay     before you receive the verification email. You can't invite an account until your email address is verified.

3. On the Accounts tab, choose Add account.

4. Choose Invite account.

5. Enter either the email address or the account ID number of the AWS account that you want to invite to your organization. If you want to invite multiple accounts, separate them with commas.

6. (Optional) For Notes, enter any message that you want included in the email invitation to the other account owners.

7. Choose Invite.

    **Important**
     If you get a message that you exceeded your account quotas for the organization or that you can't add an account because your            organization is still initializing, contact AWS Support.

8. The console redirects you to the Invitations tab. View all open and accepted invitations here. The invitation that you just created appears at the top of the list with its status set to OPEN.

    AWS Organizations sends an invitation to the email address of the owner of the account that you invited to the organization. This       email includes a link to the AWS Organizations console, where the account owner can view the details and choose to accept or decline     the invitation. Alternatively, the owner of the invited account can bypass the email, go directly to the AWS Organizations console,     view the invitation, and accept or decline it.

    The invitation to this account immediately counts against the maximum number of accounts that you can have in your organization. AWS     Organizations doesn't wait until the account accepts the invitation. If the invited account declines, the master account cancels the     invitation. If the invited account doesn't respond within the specified time period, the invitation expires. In either case, the         invitation no longer counts against your quota.


### Create a new account in organizations. Make note of the organizations account access role

1. Sign in to the Organizations console at https://console.aws.amazon.com/organizations/. You must sign in as an IAM user, assume an IAM role, or sign in as the root user (not recommended) in the organization's master account.

2. On the Accounts tab, choose Add account.

3. Choose Create account.

4. Enter the name that you want to assign to the account. This name helps you distinguish the account from all other accounts in the organization and is separate from the IAM alias or the email name of the owner.

5. Enter the email address for the owner of the new account. This address must be unique to this account because it can be used to sign in as the root user of the account.

6. (Optional) Specify the name to assign to the IAM role that is automatically created in the new account. This role grants the organization's master account permission to access the newly created member account. If you don't specify a name, AWS Organizations gives the role a default name of OrganizationAccountAccessRole.

 **Important**
   Remember this role name. You need it later to grant access to the new account for IAM users in the master account.

7. Choose Create.

* If you get an error that indicates that you exceeded your account limits for the organization, contact AWS Support.

* If you get an error that indicates that you can't add an account because your organization is still initializing, wait one hour and try again.

* You can also check the AWS CloudTrail log for information on whether the account creation was successful. For more information, see Logging and Monitoring in AWS Organizations.

* If the error persists, contact AWS Support.

7. You are redirected to the Accounts/All accounts tab, showing your new account at the top of the list with its status set to Pending creation. When the account is created, this status changes to Active.

    **Note**
    By default, the Accounts tab hides account creation requests that failed. To show them, choose the switch at the top of the list and     change it to Show.

9. Now that the account exists and has an IAM role that grants administrator access to users in the master account, you can access the account by following the steps in Accessing and Administering the Member Accounts in Your Organization.

    When you create an account, AWS Organizations initially assigns a password to the root user that is a minimum of 64 characters long.     All characters are randomly generated with no guarantees on the appearance of certain character sets. You can't retrieve this           initial password, as it's discarded after the account is created. To access the account as the root user for the first time, you         must go through the process for password recovery. For more information, see Accessing a Member Account as the Root User.

### To create an AWS Organizations administrator role in a member account (console)

1. Sign in to the IAM console at https://console.aws.amazon.com/iam/. You must sign in as an IAM user, assume an IAM role, or sign in as the root user (not recommended) in the member account that has permissions to create IAM roles and policies.

2. In the IAM console, navigate to Roles and then choose Create Role.

3. Choose Another AWS account.

4. Enter the 12-digit account ID number of the master account that you want to grant administrator access to and choose Next: Permissions.

    For this role, because the accounts are internal to your company, you should not choose Require external ID. For more information       about the external ID option, see When Should I Use the External ID? in the IAM User Guide.

5. If you have MFA enabled and configured, you can optionally choose to require authentication using an MFA device. For more information about MFA, see Using Multi-Factor Authentication (MFA) in AWS in the IAM User Guide.

6. On the Attach permissions policies page, choose the AWS managed policy named AdministratorAccess and then choose Next: Tags.

7. On the Add tags (optional) page, choose Next: Review.

8. On the Review page, specify a role name and an optional description. We recommend that you use OrganizationAccountAccessRole, which is the default name assigned to the role in new accounts. To commit your changes, choose Create role.

9. Your new role appears on the list of available roles. Choose the new role's name to view the details, paying special note to the link URL that is provided. Give this URL to users in the member account who need to access the role. Also, note the Role ARN because you need it in step.

10. Sign in to the IAM console at https://console.aws.amazon.com/iam/. This time, sign in as a user in the master account who has permissions to create policies and assign the policies to users or groups.

11. Navigate to Policies and then choose Create Policy.

    **Note**
    This example shows how to create a policy and attach it to a group. If you already created this policy for other accounts, skip to       step 18

12. For Service, choose STS.

13. For Actions, start typing AssumeRole in the Filter box and then select the check box next to it when it appears.

14. Choose Resources, ensure that Specific is selected and then choose Add ARN.

15. Enter the AWS member account ID number and then enter the name of the role that you previously created in steps 1–8. Choose Add.

16. If you're granting permission to assume the role in multiple member accounts, repeats steps 14 and 15 for each account.

17. Choose Review policy.

18. Enter a name for the new policy and then choose Create policy to save your changes.

19. Choose Groups in the navigation pane and then choose the name of the group (not the check box) that you want to use to delegate administration of the member account.

20. Choose the Permissions tab.

21. Choose Attach Policy, select the policy that you created in steps 11–18, and then choose Attach Policy.

    The users who are members of the selected group now can use the URLs that you captured in step 9 to access each member account's         role. They can access these member accounts the same way as they would if accessing an account that you create in the organization.     For more information about using the role to administer a member account, see Accessing a Member Account That Has a Master Account       Access Role.

    Accessing a Member Account That Has a Master Account Access Role
    When you create a member account using the AWS Organizations console, AWS Organizations automatically creates an IAM role named         OrganizationAccountAccessRole in the account. This role has full administrative permissions in the member account. The role is also     configured to grant that access to the organization's master account. You can create an identical role for an invited member account     by following the steps in Creating the OrganizationAccountAccessRole in an Invited Member Account. To use this role to access the       member account, you must sign in as a user from the master account that has permissions to assume the role. To configure these           permissions, perform the following procedure. We recommend that you grant permissions to groups instead of users for ease of             maintenance.


1. Invite any existing accounts

2. For each AWS account required

3. Create a new account in organizations. Make note of the organizations account access role.

4. Create a new IAM role in the root account that has permission to assume that role to access the new AWS account

5. Consider applying best practices as a baseline such as lock away your AWS account root user access keys and using multi-factor authentication

* **License:**

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.