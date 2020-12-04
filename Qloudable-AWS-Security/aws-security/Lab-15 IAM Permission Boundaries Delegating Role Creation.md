# IAM Permission Boundaries Delegating Role Creation

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Signin to AWS Console](#signin-to-aws-console)

[Create IAM policies](#create-iam-policies)

[Create and Test Developer Role](#create-and-test-developer-role)

[Create and Test User Role](#create-and-test-user-role)

[Tear down this lab](#tear-down-this-lab)

## Overview

This hands-on lab will guide you through the steps to configure an example AWS Identity and Access Management (IAM) permission boundary. AWS supports permissions boundaries for IAM entities (users or roles). A permissions boundary is an advanced feature in which you use a managed policy to set the maximum permissions that an identity-based policy can grant to an IAM entity. When you set a permissions boundary for an entity, the entity can perform only the actions that are allowed by the policy. In this lab you will create a series of policies attached to a role that can be assumed by an individual such as a developer, the developer can then use this role to create additional user roles that are restricted to specific services and regions. This allows you to delegate access to create IAM roles and policies, without them exceeding the permissions in the permission boundary. We will also use a naming standard with a prefix, making it easier to control and organize policies and roles that your developers create.The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/Architecture.PNG?st=2020-09-28T11%3A20%3A21Z&se=2025-09-29T11%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CL599iteh74%2Fk3a1zF8LKphL8Psj%2Bscjl2vNyEz%2FkiQ%3D)

**Learning Objectives**

1. Create IAM policies

2. Create and Test Developer Role
   
3. Create and Test User Role

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
* **IAM username:** `{{User_Name}}` <br>
* **Password:** `{{Password}}`

3. Enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible1.PNG?st=2020-06-22T10%3A01%3A00Z&se=2025-06-23T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=25G4t2T3s%2FILdVWtFgqfOkvni%2FIEhTdDfvdAQmx0sJ4%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/devops/AWS/introduction-to-ansible-playbooks/Images/Ansible2.PNG?st=2020-06-22T10%3A01%3A27Z&se=2025-06-23T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sWd732QnYW%2BQkKYyntda9P9HUYIZtKy4Kk6NLCy19EI%3D" alt="image-alt-text" >

4. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{Region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)


## Create IAM policies

### Create policy for permission boundary

This policy will be used for the permission boundary when the developer role creates their own user role with their delegated permissions. In this lab using AWS IAM we are only going to allow the us-east-1 (North Virginia) and us-west-1 (North California) regions, optionally you can change these to your favourite regions and add / remove as many as you need. The only service actions we are going to allow in these regions are AWS EC2 and AWS Lambda, note that these services require additional supporting actions if you were to re-use this policy after this lab, depending on your requirements.

1. In the navigation pane, Click Services and then type **IAM**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/37.PNG?st=2020-02-11T06%3A07%3A30Z&se=2023-02-12T06%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CVh5%2FSxNXp%2FfSmFO%2FFtutpxunFdTfvDWBZt%2FBbWuGp0%3D)

1. In the navigation pane, click Policies and then click Create policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/1.PNG?st=2020-02-04T09%3A41%3A20Z&se=2023-02-05T09%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QVKuutiieVVY%2FP6Vxc6l%2BNm5%2BFAAqWX%2BUxoZaxpKAtE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/2.PNG?st=2020-02-04T09%3A42%3A38Z&se=2023-02-05T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zHf3TQOH%2BBo0qu4Ru3EuusT6oRz0XECKxKCLPWFcoKE%3D)

2. On the Create policy page click the JSON tab.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/3.PNG?st=2020-02-07T05%3A51%3A41Z&se=2023-02-08T05%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WhWSyyGOrIPOvYQoh5YdNY7dmAahs3ZT8xk21EhBgwY%3D)

3. Replace the example start of the policy that is already in the editor with the policy below.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EC2RestrictRegion",
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": [
                        "us-east-1",
                        "us-west-1"
                    ]
                }
            }
        },
        {
            "Sid": "LambdaRestrictRegion",
            "Effect": "Allow",
            "Action": "lambda:*",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": [
                        "us-east-1",
                        "us-west-1"
                    ]
                }
            }
        }
    ]
}
```

4. Click **Review policy**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/4.PNG?st=2020-02-07T05%3A53%3A16Z&se=2023-02-08T05%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6n0daMvEoVEBJUgIlu0O5P%2FcHMcZXL%2BDCU%2FBxts8f1g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/16.PNG?st=2020-02-07T10%3A23%3A15Z&se=2023-02-08T10%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Hl9K5CAQibWk6TYNFbGx%2BkPicbLXlEuEQ%2BpXC0kHwx4%3D)

5. Enter the name of *restrict-region-boundary* and any description to help you identify the policy, verify the summary and then click **Create policy**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/17.PNG?st=2020-02-07T10%3A32%3A02Z&se=2023-02-08T10%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sJPrO7skvPzEGrH7jGdehsBzWJto2j6fMW3kSwLCOAI%3D)

### Create developer IAM restricted policy

This policy will be attached to the developer role, and will allow the developer to create policies and roles with a name prefix of app1, and only if the permission boundary **restrict-region-boundary** is attached. You will need to change the account id placeholders of 123456789012 to your account number in 5 places. You can find your account id by navigating to https://console.aws.amazon.com/billing/home?#/account in the console. Naming prefixes are useful when you have different teams or in this case different applications running in the same AWS account. They can be used to keep your resources looking tidy, and also in IAM policy as the resource as we are doing here.

1. Create a managed policy using the JSON policy below and name of iam-Consoleaccess-Policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/1.PNG?st=2020-02-07T09%3A10%3A38Z&se=2023-02-08T09%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FQE2IpD1VuNmnshq%2Fj%2FP8QhVfemeT1lbgisnKu7YUfQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/2.PNG?st=2020-02-07T09%3A12%3A11Z&se=2023-02-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BAoK9Qx1LxcVf5UeISZjwDIP7Lmj4pD76l0yp6PN1Uk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/3.PNG?st=2020-02-07T09%3A12%3A59Z&se=2023-02-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HuK%2B4ISvvdfiZwlm2SO61G7XD7ECtxGz4QkOMmkSi4E%3D)

2. Replace the example start of the policy that is already in the editor with the policy below.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CreatePolicy",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:CreatePolicyVersion",
                "iam:DeletePolicyVersion"
            ],
            "Resource": "arn:aws:iam::123456789012:policy/app1*"
        },
        {
            "Sid": "CreateRole",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole"
            ],
            "Resource": "arn:aws:iam::123456789012:role/app1*",
            "Condition": {
                "StringEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::123456789012:policy/restrict-region-boundary"
                }
            }
        },
        {
            "Sid": "AttachDetachRolePolicy",
            "Effect": "Allow",
            "Action": [
                "iam:DetachRolePolicy",
                "iam:AttachRolePolicy"
            ],
            "Resource": "arn:aws:iam::123456789012:role/app1*",
            "Condition": {
                "ArnEquals": {
                    "iam:PolicyARN": [
                        "arn:aws:iam::123456789012:policy/*",
                        "arn:aws:iam::aws:policy/*"
                    ]
                }
            }
        }      
    ]
}
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/6.PNG?st=2020-02-07T09%3A15%3A04Z&se=2023-02-08T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZF2aZyuPbdRumgmW8gVbol2LvW1IlLdtodkHAovA5jQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/13.PNG?st=2020-02-07T09%3A35%3A30Z&se=2023-02-08T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lg8yslX1T1pUI6W89EUetg4ncIElBoNtaE%2FXVXtN%2FL0%3D)

### Create developer IAM console access policy

This policy allows list and read type IAM service actions so you can see what you have created using the console. Note that it is not a requirement if you simply wanted to create the role and policy, or if you were using the Command Line Interface (CLI) or CloudFormation.

1. Create a managed policy using the JSON policy below and name of *iam-restricted-list-read*.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/1.PNG?st=2020-02-07T09%3A10%3A38Z&se=2023-02-08T09%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FQE2IpD1VuNmnshq%2Fj%2FP8QhVfemeT1lbgisnKu7YUfQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/2.PNG?st=2020-02-07T09%3A12%3A11Z&se=2023-02-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BAoK9Qx1LxcVf5UeISZjwDIP7Lmj4pD76l0yp6PN1Uk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/3.PNG?st=2020-02-07T09%3A12%3A59Z&se=2023-02-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HuK%2B4ISvvdfiZwlm2SO61G7XD7ECtxGz4QkOMmkSi4E%3D)

2. Replace the example start of the policy that is already in the editor with the policy below.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Get",
            "Effect": "Allow",
            "Action": [
                "iam:ListPolicies",
                "iam:GetRole",
                "iam:GetPolicyVersion",
                "iam:ListRoleTags",
                "iam:GetPolicy",
                "iam:ListPolicyVersions",
                "iam:ListAttachedRolePolicies",
                "iam:ListRoles",
                "iam:ListRolePolicies",
                "iam:GetRolePolicy"
            ],
            "Resource": "*"
        }
    ]
}
``` 

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/7.PNG?st=2020-02-07T09%3A38%3A29Z&se=2023-02-08T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MYTVvUOLpzpKj4Bn7E3y41fsf%2B2C%2FJ%2FhSSpBDao4%2BO4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/14.PNG?st=2020-02-07T09%3A42%3A18Z&se=2023-02-08T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1glxwmNM8kgkcJI3%2FTF%2BmbUFE9nIt%2BJDP7SRCM9WU3g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/15.PNG?st=2020-02-07T09%3A43%3A19Z&se=2023-02-08T09%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uylo9zcq4VGxdoWz%2FXIPMCWVIobvEliz1PtzHvVPeCk%3D)

## Create and Test Developer Role

### Create Developer Role

 Create a role for developers that will have permission to create roles and policies, with the permission boundary and naming prefix enforced:
 
1. Sign in to the AWS Management Console as an IAM user that can assume roles in your AWS account, and open the IAM console at https://console.aws.amazon.com/iam/.

2. In the navigation pane, click Roles and then click Create role.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/19.PNG?st=2020-02-10T06%3A24%3A07Z&se=2023-02-11T06%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HdBuD455fymyUxg%2BmGk22Y7vq2k%2FS%2Faw7WHPHBdI2tY%3D)

3. Click Another AWS account, then enter your account ID then click Next: Permissions.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/20.PNG?st=2020-02-10T06%3A25%3A18Z&se=2023-02-11T06%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xMpb9u5bwqKgKhvWF0IL90AusCDv1jwCGuTyKnDF2WQ%3D)

4. In the search field start typing createrole then check the box next to the createrole-restrict-region-boundary policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/21.PNG?st=2020-02-10T06%3A26%3A47Z&se=2023-02-11T06%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cYgE1wwCrfDh8kvKrPwDTKSy7NHL9B0gJZ3NtkDg6kM%3D)

5. Erase your previous search and start typing iam-res then check the box next to the **IAM-RestrictedPolicy** policy and then click Next: Tags.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/22.PNG?st=2020-02-10T06%3A28%3A17Z&se=2023-02-11T06%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wqlbyaufBLVL7wVJEAjJixMK%2B0K4rYGYfxy3oMrcXzc%3D)

6. For this lab we will not use IAM tags, click Next: Review.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/25.PNG?st=2020-02-10T06%3A35%3A03Z&se=2023-02-11T06%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Qnq9nVZS%2B2%2FF5scqvwNKoiqGWqUiYyBtRtn07KVDO6c%3D)

7. Enter the name of developer-restricted-iam for the Role name and click Create role.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/24.PNG?st=2020-02-10T06%3A33%3A22Z&se=2023-02-11T06%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2DOoixBBqnVvvJpqRcKSPlnzm%2B3MT3jNTlAy2CXtOmI%3D)

8. Check the role you have created by clicking on *developer-restricted-iam* in the list. Record both the Role ARN and the link to the console.

9. The role is now created, ready to test!

### Test Developer Role

Now you will use an existing IAM user to assume the new developer-restricted-iam role.

1. Sign in to the AWS Management Console as an IAM user https://console.aws.amazon.com.
   
2. In the console, click your user name on the navigation bar in the upper right. It typically looks like this: username@account_ID_number_or_aliasthen click Switch Role. Alternatively you can paste the link in your browser that you recorded earlier.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/26.png?st=2020-02-10T07%3A02%3A30Z&se=2023-02-11T07%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KZ6MlFTfPOjOBbYvXGPbDx6kKjDW4YYJnh78HWU0Dh4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/27.png?st=2020-02-10T07%3A04%3A42Z&se=2023-02-11T07%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2fw1SyTJonQwkv5QTA%2FoHc7Ps2bWSusCpWHEIOjjohk%3D)

3. On the Switch Role page, type the account ID number or the account alias and the name of the role developer-restricted-iam that you created in the previous step. (Optional) Type text that you want to appear on the navigation bar in place of your user name when this role is active. A name is suggested, based on the account and role information, but you can change it to whatever has meaning for you. You can also select a color to highlight the display name.

4. Click Switch Role. If this is the first time choosing this option, a page appears with more information. After reading it, click Switch Role. If you clear your browser cookies, this page can appear again.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/34.png?st=2020-02-10T09%3A09%3A52Z&se=2023-02-11T09%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BWsKi4Xn%2BtpL%2B4vtlI8D0MIQiBL8duFcKnFBayHxQbw%3D) 

5. The display name and color replace your user name on the navigation bar, and you can start using the permissions that the role grants you replacing the permission that you had as the IAM user.

6. You are now using the developer role with the granted permissions, stay logged in using the role for the next section.

## Create and Test User Role

### Create User Role

While you are still assuming the developer-restricted-iam role you created in the previous step, create a new user role with the boundary policy attached and name it with the prefix. We will use AWS managed policies for this user role, however the createrole-restrict-region-boundary policy will allow us to create and attach our own policies, only if they have a prefix of app1.

1. Verify that you are Using the developer role previously created by checking the top bar and open the IAM console at [https://console.aws.amazon.com/iam/](https://console.aws.amazon.com/iam/). You will notice a number of permission denied messages as this developer role is restricted. Least privilege is a best practice!

2. In the navigation pane, click Roles and then click Create role.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/19.PNG?st=2020-02-10T07%3A12%3A23Z&se=2023-02-11T07%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZNNmL4dpTDXembT0GaWTHWgudDojA50qVIVoOoGxx4Q%3D)

3. Click Another AWS account, then enter your account ID that you have been using for this lab then click Next: Permissions.

**Note:** If you are not enabled MFA in your account, uncheck the Require MFA option.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/20.PNG?st=2020-02-10T07%3A13%3A05Z&se=2023-02-11T07%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PJeuAN2%2B2M3QsEu7VFQJ2juAk32Ee%2BgB0f3mGBsPYgU%3D)

4. In the search field start typing ec2full then check the box next to the AmazonEC2FullAccess policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/29.png?st=2020-02-10T07%3A17%3A46Z&se=2023-02-11T07%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nESxo8zeDRPHMQP4v%2FbIlQ3gReBboZqcKHT05S7SxUY%3D)

5. Erase your previous search and start typing lambda then check the box next to the AWSLambdaFullAccess policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/30.png?st=2020-02-10T07%3A18%3A45Z&se=2023-02-11T07%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uiv71z4CtLRox32ladJl8yGgoUqbafatMH6GU%2FXOWSI%3D)

6. Expand the bottom section Set permissions boundary and click Use a permissions boundary to control the maximum role permissions. In the search field start typing boundary then click the radio button for restrict-region-boundary and then click Next: Tags.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/31.png?st=2020-02-10T07%3A19%3A28Z&se=2023-02-11T07%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=E15Nl7U%2BBNZFOOqDFrHlcmWScgcEqfw%2Bu6Q53XgAtPk%3D)

7. For this lab we will not use IAM tags, click **Next: Review.**

8. Enter the Role name of app1-user-region-restricted-services for the role and click Create role.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/32.png?st=2020-02-10T07%3A20%3A45Z&se=2023-02-11T07%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MsBU0n3qBlh0I9f0P%2BFqY3ghNp6Xiw2lAlYFsI%2FRncQ%3D)

9. The role should create successfully if you followed all the steps. Record both the Role ARN and the link to the console. If you receive an error message a common mistake is not changing the account number in the policies in the previous steps.

### Test User Role


Now you will use an existing IAM user to assume the new app1-user-region-restricted-services role, as if you were a user who only needs to administer EC2 and Lambda in your allowed regions.


1. In the console, click your role's Display Name on the right side of the navigation bar. Click Back to your previous username. You are now back to using your original IAM user.

2. In the console, click your user name on the navigation bar in the upper right. Alternatively you can paste the link in your browser that you recorded earlier for the app1-user-region-restricted-services role.

3. On the Switch Role page, type the account ID number or the account alias and the name of the role app1-user-region-restricted-services that you created in the previous step.

4. Select a different color to before, otherwise it will overwrite that profile in your browser.

5. Click Switch Role. The display name and color replace your user name on the navigation bar, and you can start using the permissions that the role grants you.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/26.png?st=2020-02-10T07%3A02%3A30Z&se=2023-02-11T07%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KZ6MlFTfPOjOBbYvXGPbDx6kKjDW4YYJnh78HWU0Dh4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/27.png?st=2020-02-10T07%3A04%3A42Z&se=2023-02-11T07%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2fw1SyTJonQwkv5QTA%2FoHc7Ps2bWSusCpWHEIOjjohk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/33.png?st=2020-02-10T07%3A23%3A31Z&se=2023-02-11T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=l1H9ZsXCQgxwjnYiMKYtE9vpoyNeepeFQijF9l5A39o%3D)

6. You are now using the user role with the only actions allowed of EC2 and Lambda in us-east-1 (North Virginia) and us-west-1 (North California) regions!

8. Navigate to the EC2 Management Console in the us-east-1 region [https://us-east-1.console.aws.amazon.com/ec2/v2/home?region=us-east-1](https://us-east-1.console.aws.amazon.com/ec2/v2/home?region=us-east-1). The EC2 Dashboard should display a summary list of resources with the only error being *Error retrieving resource count* from Elastic Load Balancing as that requires additional permissions.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/35.png?st=2020-02-10T09%3A45%3A16Z&se=2023-02-11T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EEF48yJZafj%2BUcf2ER9cGTLgqyMF3FEXRDzlVZA9WqQ%3D)

9. Navigate to the EC2 Management Console in a region that is not allowed, such as ap-southeast-2 (Sydney) [https://ap-southeast-2.console.aws.amazon.com/ec2/v2/home?region=ap-southeast-2](https://ap-southeast-2.console.aws.amazon.com/ec2/v2/home?region=ap-southeast-2). The EC2 Dashboard should display a number of unauthorized error messages.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Permission%20Boundaries%20Delegating%20Role%20Creation/images/36.png?st=2020-02-10T09%3A48%3A44Z&se=2023-02-11T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0bLkkj3qo%2B%2BO3PRmVJLsFxCJ%2ByfeHfmrV52dc%2BpaimY%3D)

## Tear down this lab

Please note that the changes you made to the users, groups, and roles have no charges associated with them.

1. Using the original IAM user, for each of the roles you created select them in the IAM console at https://console.aws.amazon.com/iam/ and click **Delete role.** The roles created are: **app1-user-region-restricted-services, developer-restricted-iam**.

2. For each of the policies you created, one at a time select the radio button then Policy actions drop down menu then Delete. The policies created are: **restrict-region-boundary createrole-restrict-region-boundary**, **iam-restricted-list-read**.

**Conclusion:** Congratulations! You have now learnt about IAM Permission Boundaries Delegating Role Creation!. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

### References

***
[Permissions Boundaries for IAM Entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html)

[AWS Identity and Access Management User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

[IAM Best Practices and Use Cases](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPracticesAndUseCases.html)

[Become an IAM Policy Master in 60 Minutes or Less](https://youtu.be/YQsK4MtsELU)

[Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html)
***

## License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

    https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

