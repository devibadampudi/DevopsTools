# IAM Tag Based Access Control for EC2

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create IAM managed policies](#create-iam-managed-policies)

[Create Role](#create-role)

[Test Role](#test-role)

[Tear Down this lab](#tear-down-this-lab)


## Overview

This hands-on lab will guide you through the steps to configure example AWS Identity and Access Management (IAM) policies, and a AWS IAM role with associated permissions to use EC2 resource tags for access control. Using tags is powerful as it helps you scale your permission management, however you need to be careful about the management of the tags which you will learn in this lab. In this lab you will create a series of policies attached to a role that can be assumed by an individual such as an EC2 administrator. This allows the EC2 administrator to create tags when creating resources only if they match the requirements, and control which existing resources and values they can tag.

The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/Architecture%20diagram.PNG?st=2020-09-25T10%3A32%3A39Z&se=2025-09-26T10%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TTt3LoCgt6yMEJyGJjylStDevKi0St81SXyLoBLlP%2BI%3D)

**Learning Objectives**

1. IAM least privilege

2. IAM policy conditions

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

Note: Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch.

## Login to AWS Console

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

## Create IAM managed policies

The policies are split into five different functions for demonstration purposes, you may like to modify and combine them to use after this lab to your exact requirements. In addition to enforcing tags, a region restriction only allow regions us-east-1 (North Virginia) and us-west-1 (North California).

### Create policy named ec2-list-read

1. This policy allows read only permissions with a region condition. The only service actions we are going to allow are EC2, note that you typically require additional supporting actions such as Elastic Load Balancing if you were to re-use this policy after this lab, depending on your requirements.

2. In the navigation pane, click **Policies** and then click **Create policy**.
<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i1.png?st=2020-02-07T09%3A04%3A21Z&se=2023-02-08T09%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1wR6tRz4YvDujjui0mYzOCnDFHYcbfuvXHJBVDqp8xM%3D" alt="image-alt-text" >


3. On the Create policy page click the **JSON** tab.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i2.png?st=2020-02-07T09%3A06%3A36Z&se=2023-02-08T09%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i5tjn%2F7bhVP2TAVfHXlaHN5IyF8GfESYA8NJ%2B48XkiQ%3D" alt="image-alt-text" >

4. Replace the example start of the policy that is already in the editor with the policy below.

```json


{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ec2listread",
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
                "ec2:Get*"
            ],
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

5. Click **Review policy**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i3.png?st=2020-02-07T09%3A07%3A43Z&se=2023-02-08T09%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SzQ07NuUXHeYxo1DvaYf2tIQ1WPSF%2F5u7F8wCEPT7oQ%3D" alt="image-alt-text" >

6. Enter the name of ec2-list-read and any description to help you identify the policy, verify the summary and then click **Create policy**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i4.png?st=2020-02-07T09%3A08%3A10Z&se=2023-02-08T09%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jyvXLCEf4RtfKpbIBhM%2FovieJpBbnWeqgA3zEGDJ48I%3D" alt="image-alt-text" >

### Create policy named ec2-create-tags

This policy allows the creation of tags for EC2, with a condition of the action being RunInstances, which is launching an instance.

7. Create a managed policy using the JSON policy below and name of ec2-create-tags.
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ec2createtags",
            "Effect": "Allow",
            "Action": "ec2:CreateTags",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:CreateAction": "RunInstances"
                }
            }
        }
    ]
}
```

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i5.png?st=2020-02-07T09%3A10%3A46Z&se=2023-02-08T09%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=StCjw%2Fdj3mX6d69UsAnA2jg%2B9%2BXa1WfnhBqCcfFE5z8%3D" alt="image-alt-text" >


<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i6.png?st=2020-02-07T09%3A11%3A23Z&se=2023-02-08T09%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mxY%2B1oHNMZd%2B0xLIQ9YcxR5EkuyURup%2BRbgoN0t4h5A%3D" alt="image-alt-text" >

### Create policy named ec2-create-tags-existing

This policy allows creation (and overwriting) of EC2 tags only if the resources are already tagged **Team / Alpha**.

8. Create a managed policy using the JSON policy below and name of ec2-create-tags-existing.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ec2createtagsexisting",
            "Effect": "Allow",
            "Action": "ec2:CreateTags",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:ResourceTag/Team": "Alpha"
                },
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": [
                        "Team",
                        "Name"
                    ]
                },
                "StringEqualsIfExists": {
                    "aws:RequestTag/Team": "Alpha"
                }
            }
        }
    ]
}
```

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i7.png?st=2020-02-07T09%3A11%3A43Z&se=2023-02-08T09%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T4XJ9oRQUPpmtiYRWnBpPrOml4k7xQTqSB09Ykc9ZOI%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i8.png?st=2020-02-07T09%3A12%3A04Z&se=2023-02-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LdHDb9cxv3LNMwNPERLW1fDS56a01GAQYDSfn2uRapw%3D" alt="image-alt-text" >

### Create policy named ec2-run-instances

This first section of this policy allows instances to be launched, only if the conditions of region and specific tag keys are matched. The second section allows other resources to be created at instance launch time with region condition.

9. Create a managed policy using the JSON policy below and name of ec2-run-instances.
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ec2runinstances",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": [
                        "us-east-1",
                        "us-west-1"
                    ],
                    "aws:RequestTag/Team": "Alpha"
                },
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": [
                        "Name",
                        "Team"
                    ]
                }
            }
        },
        {
            "Sid": "ec2runinstancesother",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": [
                "arn:aws:ec2:*:*:subnet/*",
                "arn:aws:ec2:*:*:key-pair/*",
                "arn:aws:ec2:*::snapshot/*",
                "arn:aws:ec2:*:*:launch-template/*",
                "arn:aws:ec2:*:*:volume/*",
                "arn:aws:ec2:*:*:security-group/*",
                "arn:aws:ec2:*:*:placement-group/*",
                "arn:aws:ec2:*:*:network-interface/*",
                "arn:aws:ec2:*::image/*"
            ],
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
<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i9.png?st=2020-02-07T09%3A12%3A52Z&se=2023-02-08T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wklyyutFHarOjqBd4%2BZ6TyEU6j8CUOKlbuAkUlBBSzw%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i10.png?st=2020-02-07T09%3A13%3A14Z&se=2023-02-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rd4nAy6tEBK72uXzPUsuAonswZJe0q5LI2NQe2hGHQ8%3D" alt="image-alt-text" >


### Create policy named ec2-manage-instances

This policy allows reboot, terminate, start and stop of instances, with a condition of the key Team is Alpha and region.

10. Create a managed policy using the JSON policy below and name of ec2-manage-instances.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ec2manageinstances",
            "Effect": "Allow",
            "Action": [
                "ec2:RebootInstances",
                "ec2:TerminateInstances",
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:ResourceTag/Team": "Alpha",
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

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i11.png?st=2020-02-07T09%3A13%3A46Z&se=2023-02-08T09%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2oGPswZLcXCYg%2BLF3E2nF6lz7z0SAUIFhlr6po%2BLYm8%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i12.png?st=2020-02-07T09%3A14%3A05Z&se=2023-02-08T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ixTq2JnPtcSs8UokB6hQM7Qo2HIV2W4%2FlSz7xdwdQfY%3D" alt="image-alt-text" >

## Create Role

1. Create a role for EC2 administrators, and attach the managed policies previously created.

2. Sign in to the AWS Management Console as an IAM user with MFA enabled that can assume roles in your AWS account, and open the IAM console at https://console.aws.amazon.com/iam/.


3. In the navigation pane, click **Roles** and then click **Create role**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i13.png?st=2020-02-07T09%3A14%3A49Z&se=2023-02-08T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=d19l7hgDP6jVhABbzbWyJha2Xeq8h8wiAOmn3oXOw8I%3D" alt="image-alt-text" >

4. Click Another AWS account, then enter the account ID of the account you are using now and tick Require MFA, then click **Next: Permissions**. We enforce MFA here as it is a best practice.

*Note:* If you have MFA in your account enable it or uncheck the options. 

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i14.png?st=2020-02-07T09%3A15%3A59Z&se=2023-02-08T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UvbYd%2BiWqjgg69aMxIVaUZZsaQRsTyje%2FUAxIv2hTnU%3D" alt="image-alt-text" >

5. In the search field start typing ec2- then check the box next to the policies: AmazonEC2FullAccess, ec2-create-tags, ec2-create-tags-existing, ec2-list-read, ec2-manage-instances, ec2-run-instances. and then click **Next: Tags**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/1.PNG?st=2020-08-28T09%3A59%3A04Z&se=2025-08-29T09%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZwOOc010iG4AgtfKaZ1ZGzj2djTDMC0qc1n3c2cP8bg%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i15.png?st=2020-02-07T09%3A16%3A47Z&se=2023-02-08T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=j4R%2BwOsvI2Wc5jFAxSxczrYyw6W6emmeKhoTxeY4QSM%3D" alt="image-alt-text" >

6. For this lab we will not use IAM tags, click **Next: Review**.

7. Enter the name of ec2-admin-team-alpha for the **Role name** and click **Create role**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i16.png?st=2020-02-07T09%3A17%3A24Z&se=2023-02-08T09%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Zg5QlubsiZ%2Bkbxj%2BSYjer2XXDoRt9uHRWH1oNJak5VM%3D" alt="image-alt-text" >

8. Check the role you have created by clicking on ec2-admin-team-alpha in the list. Record both the Role ARN and the link to the console.

9. The role is now created, ready to test!

## Test Role

### Assume ec2-admin-team-alpha Role

Now you will use an existing IAM user with MFA enabled to assume the new ec2-admin-team-alpha role.

1. Sign in to the AWS Management Console as an IAM user with MFA enabled. https://console.aws.amazon.com.


2. In the console, click your user name on the navigation bar in the upper right. It typically looks like this: `username@account_ID_number_or_alias` then click **Switch Role**. Alternatively you can paste the link in your browser that you recorded earlier.

3. On the Switch Role page, type you account ID number in the **Account** field, and the name of the role ec2-admin-team-alpha that you created in the previous step in the **Role** field. (Optional) Type text that you want to appear on the navigation bar in place of your user name when this role is active. A name is suggested, based on the account and role information, but you can change it to whatever has meaning for you. You can also select a color to highlight the display name.

4. Click **Switch Role**. If this is the first time choosing this option, a page appears with more information. After reading it, click Switch Role. If you clear your browser cookies, this page can appear again.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i17.png?st=2020-02-07T09%3A18%3A04Z&se=2023-02-08T09%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AejIU03aBtCJzKQcC%2BB5NPGg9gvlP3J9B3bUbg%2F80wI%3D" alt="image-alt-text" >

5. The display name and color replace your user name on the navigation bar, and you can start using the permissions that the role grants you replacing the permission that you had as the IAM user.


### Launch Instance without Tags
 
1. Navigate to the EC2 Management Console in the us-east-2 (Ohio) region https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2. The EC2 Dashboard should display a list of errors including You are not authorized. This is the first test passed, as us-east-2 region is not allowed.

2. Navigate to the EC2 Management Console in the us-east-1 (North Virginia) region https://us-east-1.console.aws.amazon.com/ec2/v2/home?region=us-east-1. The EC2 Dashboard should display a summary list of resources with the only error being Error retrieving resource count from Elastic Load Balancing as that requires additional permissions.

3. Click Launch Instance button to start the wizard.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/I19.png?st=2020-02-07T09%3A22%3A59Z&se=2023-02-08T09%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q7j0CQJbNgKL1twHUO0OPhtMxxMr9ZfIgQvKqZV8%2Fzk%3D" alt="image-alt-text" >

4. Click Select next to the first Amazon Linux 2 Amazon Machine Image to launch.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i20.png?st=2020-02-07T09%3A23%3A20Z&se=2023-02-08T09%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AHMjbk7XeIyiqdNNhQMbK%2BRovowZ9K4I9dcDA1XrlYg%3D" alt="image-alt-text" >
5. Accept the default instance size by clicking Next: Configure Instance Details.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i21.png?st=2020-02-07T09%3A24%3A36Z&se=2023-02-08T09%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5yznHzDhZXlBP6vhWc9gmqGZO%2FNrzi3RHA8lCFdeLpI%3D" alt="image-alt-text" >

6. Enter the datails for 

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i22.png?st=2020-02-07T09%3A27%3A53Z&se=2023-02-08T09%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=k6ngyEy4MznEdvIWERWhrg6Kf9mXPSaOVNmxHgxj1is%3D" alt="image-alt-text" >

* Click **Create a new vpc** .

* Enter below details

**a. Name tag:** vpc-qldtest

**b. IPv4 CIDR block:** 10.0.0.0/16

**c. IPv6 CIDR block:** No IPv6 CIDR Block

**d. Tenancy:** Default

* Click on create button.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i23.png?st=2020-02-07T09%3A28%3A38Z&se=2023-02-08T09%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hb33WaUqUGmQSGJjA2Qh6l1QYbbZ9%2Bv480sl%2BybU9Qw%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i24.png?st=2020-02-07T09%3A28%3A59Z&se=2023-02-08T09%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KZtJUgK4VIJaj8OdeSrKzottaqkOc1RfpO9bgea45LU%3D" alt="image-alt-text" >

* Once the VPC creation is completed, The following VPC was created message will pop up. Click on close button to see the created VPC.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i25.png?st=2020-02-07T09%3A31%3A38Z&se=2023-02-08T09%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FY4sB9MZR7YHSp%2BYCr5Vpiw9wf7%2Fv4CeGQJEsdPutZg%3D" alt="image-alt-text" >


* Click **Create subnet** and 

* Specify the below details.

**a. Name tag:** vpc-qldtestsubnet.

**b. VPC:** Choose **vpc-qldtest** from dropdown.

**c. Availability Zone:** No preference.

**d. IPv4 CIDR block:** 10.0.0.0/24.

* Click on create button.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i26.png?st=2020-02-07T09%3A32%3A41Z&se=2023-02-08T08%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h2tJ5LKkPOpkSJKWXMxG%2B29iao8wSygidYU8qH39QEE%3D" alt="image-alt-text" >

* Once the Subnet creation is completed, The following Subnet was created message will pop up. Click on close button to see the created Subnet.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i26.png?st=2020-02-07T09%3A32%3A41Z&se=2023-02-08T08%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h2tJ5LKkPOpkSJKWXMxG%2B29iao8wSygidYU8qH39QEE%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i27.png?st=2020-02-07T09%3A34%3A15Z&se=2023-02-08T09%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3piYgTyg3NiqfMp%2BIBZbIW8wQsuooESIreb1HqOVldQ%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i28.png?st=2020-02-07T09%3A35%3A53Z&se=2023-02-08T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QX07u640gLxULClDb6rcDK2ubRVLI2Gq8Od8ddS05zg%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i29.png?st=2020-02-07T09%3A38%3A40Z&se=2023-02-08T08%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=S4OT2VD9zxg5y3cuhUddqsskDRueDu7CduN6CJmTQmk%3D" alt="image-alt-text" >

7. Accept default **storage** options by clicking Next: **Add Tags**.

8. Lets add an incorrect tag now that will fail to launch. Click Add Tag enter Key of **Name** and Value of **Example**. Repeat to add Key of **Team** and Value of **aws**. Note: Keys and values are case sensitive! Click Next: Configure Security Group.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i30.png?st=2020-02-07T09%3A48%3A51Z&se=2023-02-08T09%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SIZbDj%2BNcYsrPTL%2B%2FKGP9YBLeD2KEQgZ%2Fzb%2BrxKOnR4%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i31.png?st=2020-02-07T09%3A54%3A15Z&se=2023-02-08T09%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JCaJ%2FUdfowIkYxDQgwoYL7J17RwVUV3TD4RYb6wyGA0%3D" alt="image-alt-text" >


9. Click Select an existing **security group**, click the check box next to security group with name default, then click Review and Launch.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i32.png?st=2020-02-07T09%3A54%3A35Z&se=2023-02-08T09%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UBO96E7mqLQlzl4z0nIAX7gfCqwmdAkbbmNlpVw2vcM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i33.png?st=2020-02-07T09%3A54%3A56Z&se=2023-02-08T09%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3%2FyPUK7IAJ9qX%2BEmiMpWrt5BOJFedwCnzblKVUqDMCw%3D" alt="image-alt-text" >

10. You should see a message that the instance is now launching. Click View Instances and do not terminate it just yet.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i34.png?st=2020-02-07T09%3A55%3A17Z&se=2023-02-08T09%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZIzA0VpF%2F3wV23wE44PPRg3jrQbnAoVNEx%2FS3UyQCdk%3D" alt="image-alt-text" >

### Modify Tags On Instances

1. Continuing from  in the EC2 Management Console instances view, click the check box next to the instance named Example then the Tags tab.


2. Click Add/Edit Tags, try changing the Team key to a value of **Test** then click Save. An error message should appear.

3. Change the Team key back to Alpha, and edit the Name key to a value of **Test** and click Save. The request should succeed.

### Manage Instances

Continuing from in the EC2 Management Console instances view, click the check box next to the instance named Test. Click Actions button then expand out Instance State then Terminate. Check the instance is the one you wish to terminate by it's name and click Yes, Terminate. The instance should now terminate.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/i35.png?st=2020-02-07T09%3A55%3A45Z&se=2023-02-08T09%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2F5aRRm9HQ53yK%2FSLc1OqpF7ntIrZyC2zx8UXfxgEQ00%3D" alt="image-alt-text" >

## Tear Down this lab

1. Using the original IAM user, select the created Role in the IAM console at https://console.aws.amazon.com/iam/ and click Delete role.

2. For each of the policies you created, one at a time select the radio button then Policy actions drop down menu then Delete. 

3. Delete created EC2 instance.

**Conclusion:** Congratulations! You have successfully completed the lab **IAM Tag Based Access Control for EC2!**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

1. [What Is IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

2. [IAM Best Practices and Use Cases](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPracticesAndUseCases.html)

3. [Become an IAM Policy Master in 60 Minutes or Less](https://www.youtube.com/watch?v=YQsK4MtsELU&feature=youtu.be)

4. [Actions](https://www.youtube.com/watch?v=YQsK4MtsELU&feature=youtu.be)

5. [Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html)

****

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
