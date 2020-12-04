# Incident Response with AWS Console and CLI

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Getting Started](#getting-started)

[Identity and Access Management](#identity-and-access-management)

[Block access in AWS IAM](#block-access-in-aws-iam)

[Attach inline deny policy](#attach-inline-deny-policy)

[Delete inline deny policy](#delete-inline-deny-policy)

[Amazon VPC](#amazon-vpc)

[Tear down this lab](#tear-down-this-lab)


## Overview

This hands-on lab will guide you through a number of examples of how you could use the AWS Console and Command Line Interface (CLI) for responding to a security incident. It is a best practice to be prepared for an incident, and have appropriate detective controls enabled. You can find more best practices by reading the [Security Pillar of the AWS Well-Architected Framework](https://wa.aws.amazon.com/wat.pillar.security.en.html)

The skills learned will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**Learning Objectives:**

1. Identify tooling for incident response.

2. Automate containment for incident response.

3. Pre-deploy tools for incident response.

**Some Key points:**

   1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

   2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

   3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

   4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

   5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

**Note:** Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch.

## Login to AWS Console

1. Navigate to Chrome Browser in the right pane, click on **My Account -> AWS Management Console.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

2. Sign in to the console using below AccountID, IAM username and Password details:

* **Account ID:** `{{Account_ID}}` <br>
* **IAM username:** `{{User_Name}}` <br>
* **Password:** `{{Password}}`

3. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

4. Now enter **Account ID** **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{Region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Getting Started

### Install the AWS CLI

Although instructions in this lab are written for both AWS Management console and AWS CLI, its best to install the AWS CLI on the machine you will be using as you can modify the example commands to run different scenarios easily and across multiple AWS accounts.

**Already installed AWS CLI in Powershell. You will run the AWS CLI commands through powershell.**

1. Click on **Launch App** Icon on Top left. Select the Powershell.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/33.png?st=2020-09-30T09%3A54%3A50Z&se=2025-10-01T09%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BRHL0VnBDzQgvPfj7cpQexFuDNdfAG%2FxCbqDOHDh%2FQg%3D)


2. Configure the your AWS credentials.

```
aws configure
```
**AWS Access key id:** Provide your AWS access key id

**AWS Secret Access key:** Provide your AWS Secret key

**Region:** us-east-1

**Default output format:** json

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/34.PNG?st=2020-09-30T09%3A56%3A57Z&se=2025-10-01T09%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fh1Vnnplw1iaDEKGvamJUOl5K37NFJWqlsOQPcJDv7s%3D)


###  Amazon CloudWatch Logs

Amazon CloudWatch Logs can be used to monitor, store, and access your log files from Amazon Elastic Compute Cloud (Amazon EC2) instances, AWS CloudTrail, Amazon Route 53, Amazon VPC Flow Logs, and other sources. It is a best practice to enable logging and analyze centrally, and develop investigation proceses. Using the AWS CLI and developing runbooks for investigation into different events can be significantly faster than using the console. If your logs are stored in Amazon S3 instead, you can use Amazon Athena to directly analyze data.

To list the Amazon CloudWatch Logs Groups you have configured in each region, you can describe them. Note you must specify the region, if you need to query multiple regions you must run the command for each. You must use the region ID such as us-east-1 instead of the region name of US East (N. Virginia) that you see in the console. You can obtain a list of the regions by viewing them in the AWS Regions and Endpoints or using the CLI command: aws ec2 describe-regions. To list the log groups you have in a region, replace the example us-east-1 with your region: aws logs describe-log-groups --region us-east-1 The default output is json, and it will give you all details. If you want to list only the names in a table: aws logs describe-log-groups --output table --query 'logGroups[*].logGroupName' --region us-east-1

### AWS Console

1. Sign in to the AWS Management Console and click on the Services then type the CloudTrail in search button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/1.png?st=2020-09-14T15%3A47%3A50Z&se=2025-09-15T15%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=u2W%2F3ROft76UjKtehkF0%2B2uF%2B9sBICPKIdEIoBKwvTA%3D)

2. On the CloudTrail service home page, the Trails page, or the Trails section of the Dashboard page, choose Create trail.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/2.PNG?st=2020-09-14T15%3A53%3A05Z&se=2025-09-15T15%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ikkxxY9A%2BM5KfF27Cv3VGaUF6%2BHN8JbCTex2UFewnhU%3D)

3. Provide the Trail Name.

3. If this is an AWS Organizations organization trail, you can choose to enable the trail for all accounts in your organization. You only see this option if you are signed in to the console with an IAM user or role in the master account.

3. For Storage location, choose Create new S3 bucket to create a bucket. When you create a bucket, CloudTrail creates and applies the required bucket policies.To make it easier to find your logs, create a new folder (also known as a prefix) in an existing bucket to store your CloudTrail logs. Enter the prefix in Prefix.

4. Uncheck the Log file SSE-KMS encryption.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/24.PNG?st=2020-09-24T03%3A43%3A48Z&se=2025-09-25T03%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y1Ni%2BJKUaEJ697t7m7JLk00OrYi9T07GhNyNOxS26X8%3D)

4. **In Additional settings,configure the following.**

 **a.** For Log file validation, choose Enabled to have log digests delivered to your S3 bucket.
 
 **b.** For SNS notification delivery, choose Enabled to be notified each time a log is delivered to your bucket. CloudTrail stores multiple events in a log file. SNS  notifications are sent for every log file, not for every event.If you enable SNS notifications, for Create a new SNS topic, choose New to create a topic, or choose Existing to use an existing topic.If you choose New, CloudTrail specifies a name for the new topic for you, or you can type a name.
 
 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/23.PNG?st=2020-09-24T03%3A40%3A25Z&se=2025-09-25T03%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CJXAHRtMbTkdwXqkKSiZCP%2FnGMP2xvGx9n21BtjJzPY%3D)
 
5. Configure CloudTrail to send log files to CloudWatch Logs by choosing Enabled in CloudWatch Logs.Enable integration with CloudWatch Logs, choose New to create a new log group, or Existing to use an existing one.you can type a name for Log group name.

6. Choose New to create a new IAM role for permissions to send logs to CloudWatch Logs.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/5.PNG?st=2020-09-14T15%3A55%3A34Z&se=2025-09-15T15%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8KADp78raqb2SogVg8FKSF%2BnQoPZakwYR6%2BG4iu6ZUc%3D)

7. Click on **Next.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/6.PNG?st=2020-09-14T15%3A56%3A01Z&se=2025-09-15T15%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zRyTGv5WoVd6Oa4bBT81tMxcCvUQm7jHr0%2BSZdPZgX8%3D)

8. Click on Management Events, Data Events, Insights Events.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/27.PNG?st=2020-09-24T03%3A46%3A50Z&se=2025-09-25T03%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ziQfz7eoJcUhE3Ph7zUBN3O6TODpCBezwab88MYdQyA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/28.PNG?st=2020-09-24T03%3A48%3A41Z&se=2025-09-25T03%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zaBD9QW2ptpphnCWkfDtCm9ZPJIbO8tpd96jnHVA%2Fgw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/25.PNG?st=2020-09-24T03%3A44%3A40Z&se=2025-09-25T03%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ck9voFAHrgTeH1SZCHfnS6A1%2FcIP8KudBmiscTEGZHI%3D)

9. Click on **Next.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/29.PNG?st=2020-09-24T03%3A50%3A12Z&se=2025-09-25T03%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=f1%2BaLjpWKq2S2Muyp6mGyT%2BjsEcLGiYd37kbR%2F9NgbY%3D)

10. Click on **Create Trail.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/26.PNG?st=2020-09-24T03%3A50%3A56Z&se=2025-09-25T03%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lYEv84pc6Z4w8nrEaU4mFIGd%2BoCXlau%2B5Rm%2FB6C%2FmAg%3D)

9. Click on created **Cloud Trail.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/10.PNG?st=2020-09-14T16%3A05%3A49Z&se=2025-09-15T16%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nCHdiiWi44AEVwaDdPUp6iPSVp057hqhEG8U5zh67cc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/11.PNG?st=2020-09-14T16%3A06%3A12Z&se=2025-09-15T16%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=K4CKHpdW6vtNW9YPu3SuQ8RxhRwAzGc9LlQSRe2Seiw%3D)

## Identity and Access Management

**Investigate AWS CloudTrail**

As AWS CloudTrail logs API activity for supported services, it provides an audit trail of your AWS account that you can use to track history of an adversary. For example, listing recent access denied attempts in AWS CloudTrail may indicate attempts to escalate privilege unsuccessfully. Note that some services such as Amazon S3 have their own logging, for example read more about Amazon S3 server access logging. You can enable AWS CloudTrail by following the Automated Deployment of Detective Controls lab.

### AWS Console

The AWS console provides a visual way of querying Amazon CloudWatch Logs, using CloudWatch Logs Insights and does not require any tools to be installed.

1. Open the Amazon CloudWatch console at https://console.aws.amazon.com/cloudwatch/ and select your region.

2. From the left menu, choose Insights under Logs.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/30.PNG?st=2020-09-24T03%3A58%3A32Z&se=2025-09-25T03%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LlN1QabjEspfGPgpGWCxvl1SAPGx5nwuemIMjszVbxk%3D)

3. From the dropdown near the top select your CloudTrail Logs group, then the relative time to search back on the right.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/31.PNG?st=2020-09-24T04%3A04%3A03Z&se=2025-09-25T04%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0CgkZdF1zoQ8Q1kRsvWwlXWd0CSnfql8q71EN9HpLAM%3D)

4. Copy the following example queries below into the query input, then click Run query.

**IAM users and roles created**

Listing users and roles created can help identify unauthorized activity:

```
filter eventName="CreateUser" or eventName = "CreateRole" | fields requestParameters.userName, requestParameters.roleName, responseElements.user.arn, responseElements.role.arn, sourceIPAddress, eventTime, errorCode
```
**Note:** Take the Required information from the logs after ran the query.

**IAM access denied attempts:**

To list all IAM access denied attempts you can use the following example. Each of the line item results allows you to drill down to reveal further details:

```
filter errorCode like /Unauthorized|Denied|Forbidden/ | fields awsRegion, userIdentity.arn, eventSource, eventName, sourceIPAddress, userAgent

```

**IAM access key:**

If you need to search for what actions an access key has performed you can search for it e.g. AKIAIOSFODNN7EXAMPLE:

```
filter userIdentity.accessKeyId ="AKIAIOSFODNN7EXAMPLE" | fields awsRegion, eventSource, eventName, sourceIPAddress, userAgent
```

**IAM source ip address:**

If you suspect a particular IP address as an adversary you can search such as 192.0.2.1:

```
filter sourceIPAddress = "192.0.2.1" | fields awsRegion, userIdentity.arn, eventSource, eventName, sourceIPAddress, userAgent
```
**IAM access key created**

An access key id will be part of the responseElements when its created so you can query that:

```
filter responseElements.credentials.accessKeyId ="AKIAIOSFODNN7EXAMPLE" | fields awsRegion, eventSource, eventName, sourceIPAddress, userAgent

```

**S3 List Buckets**

Listing buckets may indicate someone trying to gain access to your buckets. Note that Amazon S3 server access logging needs to be enabled on each bucket to gain further S3 access details:

```
filter eventName ="ListBuckets" | fields awsRegion, eventSource, eventName, sourceIPAddress, userAgent

```

### AWS CLI

Remember you might need to update the **--log-group-name**, **--region** and/or **--start-time** parameter to a millisecond epoch start time of how far back you wish to search. You can use a web conversion tool such as www.epochconverter.com.

**IAM access denied attempts:**

To list all IAM access denied attempts you can use CloudWatch Logs with --filter-pattern parameter of AccessDenied for roles and Client.UnauthorizedOperation for users:

```
aws logs filter-log-events --region us-east-1 --start-time 1551402000000 --log-group-name CloudTrail/DefaultLogGroup --filter-pattern AccessDenied --output json --query 'events[*].message'| jq -r '.[] | fromjson | .userIdentity, .sourceIPAddress, .responseElements'

```
**IAM access key:**

If you need to search for what actions an access key has performed you can modify the --filter-pattern parameter to be the access key to search such as AKIAIOSFODNN7EXAMPLE:

```
aws logs filter-log-events --region us-east-1 --start-time 1551402000000 --log-group-name CloudTrail/DefaultLogGroup --filter-pattern AKIAIOSFODNN7EXAMPLE --output json --query 'events[*].message'| jq -r '.[] | fromjson | .userIdentity, .sourceIPAddress, .responseElements'

```

**IAM source ip address:**

If you suspect a particular IP address as an adversary you can modify the --filter-pattern parameter to be the IP address to search such as 192.0.2.1:

```
aws logs filter-log-events --region us-east-1 --start-time 1551402000000 --log-group-name CloudTrail/DefaultLogGroup --filter-pattern 192.0.2.1 --output json --query 'events[*].message'| jq -r '.[] | fromjson | .userIdentity, .sourceIPAddress, .responseElements'

```
**S3 List Buckets**

Listing buckets may indicate someone trying to gain access to your buckets. Note that Amazon S3 server access logging needs to be enabled on each bucket to gain further S3 access details:

```
aws logs filter-log-events --region us-east-1 --start-time 1551402000000 --log-group-name CloudTrail/DefaultLogGroup --filter-pattern ListBuckets --output json --query 'events[*].message'| jq -r '.[] | fromjson | .userIdentity, .sourceIPAddress, .responseElements'

```
## Block access in AWS IAM

Blocking access to an IAM entity, that is a role, user or group can help when there is unauthorized activity as it will no longer be able to perform any actions. Be careful as blocking access may disrupt the operation of your workload, which is why it is important to practice in a non-production environment. Note that the AWS IAM entity may have created another entity, or other resources that may allow access to your account. You can use AWS CloudTrail that logs activity in your AWS account to determine the IAM entity that is performing the unauthorized operations. Additionally service last accessed data in the AWS Console can help you audit permissions.

**List AWS IAM roles/users/groups**

If you need to confirm the name of a role, user or group you can list:

### AWS Console

Sign in to the AWS Management Console as an IAM user or role in your AWS account, and open the AWS IAM console at https://console.aws.amazon.com/iam/.

Click Roles on the left, the role will be displayed and you can use the search field.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/12.PNG?st=2020-09-14T16%3A19%3A30Z&se=2025-09-15T16%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DogcXN%2B5H8gEhbnWtEp%2BlhUoHEmYpXv%2BOXtzRyGe7%2B4%3D)

### AWS CLI

aws iam list-roles This provides a full json formatted list of all roles, if you only want to display the RoleName use an output of table and query:

```
aws iam list-roles --output table --query 'Roles[*].RoleName' 
```
List all users:

```
aws iam list-users --output table --query 'Users[*].UserName' 
```
List all groups:

```
aws iam list-groups --output table --query 'Groups[*].GroupName'

```

## Attach inline deny policy

Attaching an explicit deny policy to an AWS IAM role, user or group will quickly block ALL access for that entity which is useful if it is performing unauthorized operations. Please note that the role will still be able to call the sts API to obtain information on itself, e.g. using get-caller-identity will return the account ID, user ID and ARN.

 
 ### AWS Console

1.Sign in to the AWS Management Console as an AWS IAM user or role in your AWS account, and open the AWS IAM console at https://console.aws.amazon.com/iam/.

2. Click either Groups, Users or Roles on the left, then click the name to modify.

3. Click Permissions tab.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/13.PNG?st=2020-09-15T08%3A56%3A02Z&se=2025-09-16T08%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fbuichI%2BAxA97PmqfT4gvHKdP5cLvnVI0wsZCImAhmU%3D)

4. Click Add inline policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/14.PNG?st=2020-09-15T08%3A57%3A44Z&se=2025-09-16T08%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JS1sd%2BXhjE39HyYgzJSp0LZG16ZVPp8xh39698Fsi%2Bc%3D)

5. Click the JSON tab then replace the example with the following:

```
{
    "Version": "2012-10-17",
    "Statement": [
        { "Effect": "Deny", "Action": "*", "Resource": "*" }
        ]
}
```

6. Click Review policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/32.PNG?st=2020-09-24T04%3A10%3A10Z&se=2025-09-25T04%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9bECD8UpYV3upJ8QK4wn04QITRFs5x4ZaqhzQgPNZOs%3D)

7. Enter Name of DenyAll then click Create policy. Note that the console may incorrectly display the access level.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/16.PNG?st=2020-09-15T09%3A00%3A42Z&se=2025-09-16T09%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=w8hJzpAbP5LzUxGWxrDJrakVxLdMUyxKQjKrnfGnvHo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/17.PNG?st=2020-09-15T09%3A02%3A03Z&se=2025-09-16T09%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hWh%2FATfZ3RPzhCwSFD32VtpjK4%2BzatuDUASzZvUIl9c%3D)

### AWS CLI

Create the below Policy and save it and assign that path policy document file.

```

{
    "Version": "2012-10-17",
    "Statement": [
        { "Effect": "Deny", "Action": "*", "Resource": "*" }
        ]
}

```

Block a role, modify ROLENAME to match your role name:

`aws iam put-role-policy --role-name ROLENAME --policy-name DenyAll --policy-document file://D:\PhotonUser\Downloads\DenyAll.json`

Block a user, modify USERNAME to match your user name:

`aws iam put-user-policy --user-name USERNAME --policy-name DenyAll --policy-document file://D:\PhotonUser\Downloads\DenyAll.json` 

Block a group, modify GROUPNAME to match your user name:

`aws iam put-group-policy --group-name GROUPNAME --policy-name DenyAll --policy-document file://D:\PhotonUser\Downloads\DenyAll.json`

**Note:** Modify Policy name and Policy path with created earlier

## Delete inline deny policy

To delete the policy you just attached and restore the original permissions the entity had:

### AWS Console

1. Sign in to the AWS Management Console as an IAM user or role in your AWS account, and open the AWS IAM console at https://console.aws.amazon.com/iam/.

2. Click **Roles** on the left.
3. Click the checkbox next to the role to delete.
4. Click **Delete role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/18.PNG?st=2020-09-15T09%3A16%3A09Z&se=2025-09-16T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tv9U6dP7othScfRLDi%2Fe6JMG87wSjYczhaVkZoUIQGU%3D)

5. Confirm the role to delete then click Yes, delete.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/19.PNG?st=2020-09-15T09%3A18%3A07Z&se=2025-09-16T09%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gS73scpY72RprVSOYx5klKfC3PZbrkC9hzz4msA4yz0%3D)

### AWS CLI

Delete policy from a role: 

`aws iam delete-role-policy --role-name ROLENAME --policy-name DenyAll`

Delete policy from a user: 

`aws iam delete-user-policy --user-name USERNAME --policy-name DenyAll`

Delete policy from a group: 

`aws iam delete-group-policy --group-name GROUPNAME --policy-name DenyAll`

**Note:** Modify Policy name with created earlier

## Amazon VPC

Amazon VPC that has VPC Flow Logs enabled captures information about the IP traffic going to and from network interfaces in your Amazon VPC. This log information may help you investigate how Amazon EC2 instances and other resources in your VPC are communicating, and what they are communicating with. You can follow the Automated Deployment of VPC lab for creating a Amazon VPC with Flow Logs enabled.

**Investigate Amazon VPC Flow Logs**

### AWS Management Console

The AWS Management console provides a visual way of querying CloudWatch Logs, using CloudWatch Logs Insights and does not require any tools to be installed.

1. Open the Amazon CloudWatch console at https://console.aws.amazon.com/cloudwatch/ and select your region.
2. From the left menu, choose **Insights** under **Logs**.
3. From the dropdown near the top select your CloudTrail Logs group, then the relative time to search back on the right.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/21.PNG?st=2020-09-15T09%3A36%3A53Z&se=2025-09-16T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=O7eDEk%2FtO9%2FkLKcD%2FprfQ48Gex5F8eOyK9Pu5cI1rx4%3D)

4. Copy the following example queries below into the query input, then click **Run query**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Incident%20Response%20with%20AWS%20Console%20and%20CLI/Images/22.PNG?st=2020-09-15T09%3A38%3A06Z&se=2025-09-16T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ni80H1D9dTXM1uR5Qpr8ofOoxPT2f%2B9SW9UjK%2F7OwtQ%3D)

**Rejected requests by IP address:**

Rejected requests indicate attempts to gain access to your VPC, however there can often be noise from internet scanners. To count the rejected requests by source IP address:

`filter action="REJECT" | stats count(*) as numRejections by srcAddr | sort numRejections desc`

**Reject requests originating from inside your VPC**

Rejected requests that originate from inside your VPC may indicate your infrastructure in your VPC is attempting to connect to something it is not allowed to, e.g. a database instance is trying to connect to the internet and is blocked. This example uses regex to match the start of your VPC as 10.: 

`filter action="REJECT" and srcAddr like /^10\./ | stats count(*) as numRejections by srcAddr | sort numRejections desc`

**Requests from an IP address**

If you suspect an IP address and want to list all requests that originate, replace 192.0.2.1 with the IP you suspect:

`filter srcAddr = "192.0.2.1" | fields @timestamp, interfaceId, dstAddr, dstPort, action`

**Request count from a private IP address by destination address**

If you want to list and count all connections by a private IP address, replace 10.1.1.1 with your private IP:

`filter srcAddr = "10.1.1.1" | stats count(*) as numConnections by dstAddr | sort numConnections desc`

## Tear down this lab

The following instructions will remove the resources that have a cost for running them.

1. Delete the Cloud Trail resource.

2. Delete the Created Roles and Policies.

**Conclusion:** Congratulations! You have successfully completed the lab **Incident Response with AWS Console and CLI**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

[AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/reference/)

[AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

[Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html)


### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
