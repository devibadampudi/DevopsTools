# Lambda Cross Account IAM Role Assumption

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create role for Lambda in account2](#create-role-for-lambda-in-account2)

[Create role for Lambda in account1](#create-role-for-lambda-in-account1)

[Create Lambda in account 1](#create-lambda-in-account-1)

[Tear down this lab](#tear-down-this-lab)

## Overview

This lab demonstrates configuration of an S3 bucket policy (which is a type of resource based policy) in AWS account 2 (the destination) that enables a Lambda function in AWS account 1 (the origin) to list the objects in that bucket using Python boto SDK. If you only have 1 AWS account simply repeat the instructions in that account and use the same account id.

If in classroom and you do not have 2 AWS accounts, buddy up to use each other’s accounts, agree who will be account #1 and who will be account #2.

The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab** 

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/lambda-assumeroles.png?st=2020-09-22T06%3A39%3A53Z&se=2025-09-23T06%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4TkDh8P6aD01VOvRIzM0bXoHOCgN9dTrjOfPJGqCQ98%3D)

**Learning Objectives**

1. Cross account role assumption

2. Lambda assuming another role

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console

## Pre-Requisites

* An AWS account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

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

## Create role for Lambda in account2

1. Sign in to the AWS Management Console as an **IAM user** or **role** in your AWS account, and open the IAM console at https://console.aws.amazon.com/iam/.

2. Click **Roles** on the left, then **create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l9.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

3. Click Another AWS account, enter the account id for account 1 (the origin), then click Next: Permissions.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/i29.png?st=2020-02-11T08%3A36%3A07Z&se=2023-02-12T08%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uxto8r2W79vXnQTtmRgwEYfOfUq8sLMy54vhBSaWd74%3D)

4. Do not select any managed policies, click **Next: Tags**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l11.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

5. Click **Next: Review**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l12.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

6. Enter **LambdaS3ListBuckets** for the Role name then click **Create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r1.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

7. From the list of roles click the name of **LambdaS3ListBuckets**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r2.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

8. Copy the Role ARN and store for use later in this lab.

9. Click **Add inline policy**, then click **JSON** tab.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l15.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

10. Replace the sample json with the following, then click Review Policy.

```json
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3ListAllMyBuckets",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        }
    ]
}
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r3.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

11. Name this policy **LambdaS3ListBucketsPolicy**, then click Create policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r4.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

## Create role for Lambda in account1

1. Sign in to the AWS Management Console as an **IAM user** or **role** in your AWS account, and open the IAM console at https://console.aws.amazon.com/iam/.

2. Click **Roles** on the left, then **create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l9.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

3. AWS service will be pre-selected, select **Lambda**, then click Next: **Permissions**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l10.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

4. Do not select any managed policies, click **Next: Tags**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l11.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

5. Click **Next: Review**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l12.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

6. Enter **Lambda-Assume-Roles** for the Role name then click **Create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r5.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

7. From the list of roles click the name of **Lambda-Assume-Roles**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r6.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

8. Copy the Role ARN and store for use later in this lab.

9. Click **Add inline policy**, then click **JSON** tab.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l15.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

10. Replace the sample json with the following

  * Replace account1 with the AWS Account number (no dashes) of account 1

  * Replace bucketname with the S3 bucket name from account 2

  * Then click Review Policy

11. Replace the sample json with the following, then click Review Policy.

```json
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "stsassumerole",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::account2:role/LambdaS3ListBuckets",
            "Condition": {
                "StringLike": {
                    "aws:UserAgent": "*AWS_Lambda_python*"
                }
            }
        },
        {
            "Sid": "logsstreamevent",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:us-east-1:account1:log-group:/aws/lambda/Lambda-Assume-Roles*/*"
        },
        {
            "Sid": "logsgroup",
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "*"
        }
    ]
}
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r8.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

12. Name this policy **Lambda-Assume-Roles-Policy**, then click Create policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r9.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

## Create Lambda in account 1

1. Open the Lambda console.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l21.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

2. Click **Create a function**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l22.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

3. Accept the default **Author from scratch**.

4. Enter function name as **Lambda-Assume-Roles.**.

5. Select **Python 3.6** runtime.

6. Expand Permissions, click **Use an existing role**, then select the **lambdalists3role** role.

7. Click **Create function**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l23.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l24.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

8. Replace the example function code with the following, replacing the RoleArn with the one from account 2 you created previously.

``` json

import json
 import boto3
 import os
 import uuid

 def lambda_handler(event, context):
     try:
         client = boto3.client('sts')
         response = client.assume_role(RoleArn='arn:aws:iam::account2:role/LambdaS3ListBuckets',RoleSessionName="{}-s3".format(str(uuid.uuid4())[:5]))
         session = boto3.Session(aws_access_key_id=response['Credentials']['AccessKeyId'],aws_secret_access_key=response['Credentials']['SecretAccessKey'],aws_session_token=response['Credentials']['SessionToken'])

         s3 = session.client('s3')
         s3list = s3.list_buckets()
         print (s3list)
         return str(s3list['Buckets'])

     except Exception as e:
         print(e)
         raise e
```

9. Click Save.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r10.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

10. Click **Test**, accept the default event template, enter **event name** of test, then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l26.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

11. Click Test again, and in a few seconds the function output should highlight green and you can expand the detail to see the response from the S3 API.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20IAM%20Role%20Assumption/r12.png?st=2020-02-24T08%3A53%3A52Z&se=2023-02-25T08%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=rSdEcwwLKwgte8Rdd2%2F2t%2Bs0uU3K%2F1P3p4%2FTh%2FWXhhU%3D)

 ## Tear down this lab
 
 Remove the lambda function, then roles.

**Conclusion:** Congratulations! You have successfully completed the lab **Lambda Cross Account IAM Role Assumption**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

[AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
