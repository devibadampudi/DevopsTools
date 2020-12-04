# Lambda Cross Account Using Bucket Policy

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Signin to AWS Console](#Signin-to-aws-console)

[Create S3 bucket in account2](#create-s3-bucket-in-account2)

[Create role for Lambda in account1](#create-role-for-lambda-in-account1)

[Create bucket policy for the S3 bucket in account2](#Create-bucket-policy-for-the-s3-bucket-in-account2)

[Create Lambda in account 1](#create-lambda-in-account1)

[Tear down this lab](#tear-down-this-lab)

## Overview

This lab demonstrates configuration of an S3 bucket policy (which is a type of resource based policy) in AWS account 2 (the destination) that enables a Lambda function in AWS account 1 (the origin) to list the objects in that bucket using Python boto SDK. If you only have 1 AWS account simply repeat the instructions in that account and use the same account id.

If in classroom and you do not have 2 AWS accounts, buddy up to use each other’s accounts, agree who will be account #1 and who will be account #2.

The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/arc_lamda.jpg?st=2020-09-18T09%3A38%3A08Z&se=2025-09-19T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=s48usL8fbtO%2F1mrtFPWPg2pFjT4XNSezWesv4kj3GQg%3D)

**Learning Objectives**

1. Resource based policies versus identity based policies.

2. S3 bucket policies.

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes.

## Signin to AWS Console

1. Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

* Sign in to the console using below **AccountID**, **IAM username** and **Password** details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

2. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

3. Now enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Create S3 bucket in account2

1. In account 2 sign in to the S3 Management Console as an IAM user or role in your AWS account, and open the S3 console at https://console.aws.amazon.com/s3

**Create a Bucket**

2. Choose Create **bucket**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l1.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

**Bucket Name:** Type a Unique name

**Region:** {{Region}} 

3.	Choose **Create.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l2.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

**Add an Object to a Bucket**

4. Open the below Url in Chrome and save it in folder.

https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/example.png?st=2019-11-15T05%3A44%3A24Z&se=2022-11-16T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QguqN%2F8I4Gj7XCNj%2BK7FWeeKnZEZfJr8i6HTmV4HXb8%3D

5. In the Upload dialog box, choose Add files to choose the file to upload.

6. Choose a file to upload from saved folder, and then choose Open.

7. Choose Upload.

8. In the Bucket name list, choose the name of the bucket that you want to **upload** your object to.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l5.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

9. Choose **Upload.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l6.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l7.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

**Bucket Policies:**

* Bucket policies provide centralized access control to buckets and objects based on a variety of conditions, including Amazon S3 operations, requesters, resources, and aspects of the request (for example, IP address).

**Access Control Lists:** 

1. Public access

    * Select the check boxes next to the permissions that you want to grant to the user, and then choose **Save.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l3.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

2. If you want to **Open all public access** edit the Block all public access and **uncheck** the dialouge box and save it.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l4.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

3. Click the **make public**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l8.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

* Record the **bucketname**.


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

6. Enter **lambdalists3role** for the Role name then click **Create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l13.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

7. From the list of roles click the name of **lambdalists3role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l14.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

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
              "Sid": "S3ListBucket",
              "Effect": "Allow",
              "Action": [
                  "s3:ListBucket"
              ],
              "Resource": "arn:aws:s3:::bucketname"
          },
          {
              "Sid": "logsstreamevent",
              "Effect": "Allow",
              "Action": [
                  "logs:CreateLogStream",
                  "logs:PutLogEvents"
              ],
              "Resource": "arn:aws:logs:us-east-1:account1:log-group:/aws/lambda/Lambda-List-S3*/*"
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

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l17.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

12. Name this policy **LambdaLiss3Policy**, then click Create policy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l18.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l19.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

## Create bucket policy for the S3 bucket in account2

1. In account 2 sign in to the S3 Management Console as an IAM user or role in your AWS account, and open the S3 console at https://console.aws.amazon.com/s3

2. Click on the name of the bucket you will use for this workshop.

3. Go to the **Permissions tab**.


4. Click **Bucket Policy**.

  * Enter the following **JSON** policy

  * Replace account1 with the AWS Account number (no dashes) of account 1

  * Replace bucketname with the **S3 bucket name** from account 2

  * Note: This policy uses least privilege. Only resources using the IAM role from **account 1** will have access.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1565731301209",
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::bucketname",
            "Principal": {
                "AWS":"arn:aws:iam::account1:role/Lambda-List-S3-Role"
            },
            "Condition": {
                "StringLike": {
                    "aws:UserAgent": "*AWS_Lambda_python*"
                }
            }
        }
    ]
}
```


![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l20.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

* Click **Save**.


## Create Lambda in account1

1. Open the Lambda console.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l21.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

2. Click **Create a function**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l22.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

3. Accept the default **Author from scratch**.

4. Enter function name as **lambdalists3**.

5. Select **Python 3.7** runtime.

6. Expand Permissions, click **Use an existing role**, then select the **lambdalists3role** role.

7. Click **Create function**.


![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l23.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)


![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l24.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)


8. Replace the example function code with the following, replacing the RoleArn with the one from account 2 you created previously.

```

import json
import boto3
import os
import uuid

def lambda_handler(event, context):
    try:
        
        # Create an S3 client
        s3 = boto3.client('s3')

        # Call S3 to list current buckets
        objlist = s3.list_objects(
                        Bucket='bucketname',
                        MaxKeys = 10) 
        
        print (objlist['Contents'])
        return str(objlist['Contents'])


    except Exception as e:
        print(e)
        raise e
```

9. Click Save.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l25.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

10. Click **Test**, accept the default event template, enter **event name** of test, then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l26.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l27.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

11. Click Test again, and in a few seconds the function output should highlight green and you can expand the detail to see the response from the S3 API.


![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Lambda%20Cross%20Account%20Using%20Bucket%20Policy/l28.png?st=2020-02-11T05%3A03%3A58Z&se=2023-02-12T05%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=tu5wT9SqExhFeKLco1towzDk4WOHiOE3pxk8QyrJNug%3D)

## Tear down this lab

1. Remove the lambda function, then roles.

2. If you created a new S3 bucket, then you may remove it.

**Conclusion:** Congratulations! You have successfully completed the lab **Lambda Cross Account Using Bucket Policy**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

[Using Bucket Policies and User Policies](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html)

[Identity-based policies and resource-based policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
