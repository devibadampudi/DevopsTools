# Protecting workloads on AWS from the instance to the edge

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Signin to AWS Console](#Signin-to-aws-console)

[Accessing AWS Event Engine](#accessing-aws-event-engine)

[Mitigating Common Web Application Attack Vectors Using AWS WAF](#mitigating-common-web-application-attack-vectors-using-aws-waf)

[Create bucket policy for the S3 bucket in account2](#Create-bucket-policy-for-the-s3-bucket-in-account2)

[Create Lambda in account 1](#create-lambda-in-account1)

[Tear down this lab](#tear-down-this-lab)

## Overview

In this workshop, you will build an environment consisting of two Amazon Linux web servers behind an application load balancer. The web servers will be running a PHP web site that contains several vulnerabilities. You will then use AWS Web Application Firewall (WAF), Amazon Inspector and AWS Systems Manager to identify the vulnerabilities and remediate them.

**Some Key points:**

   1.We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

   2.All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

   3.Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

   4.Do NOT use any data from screen shots.Only use data provided in the content section of the lab

   5.Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/300_Protecting%20workloads%20on%20AWS%20from%20the%20instance%20to%20the%20edge/arc.jpg?st=2020-09-22T09%3A22%3A45Z&se=2025-09-23T09%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WF6Bt1W1pNQgJwe%2FiHL%2BEFqDWMhMP%2BaZBTMu%2Boq18pY%3D)

**Learning Objectives**

    Need to add

## Pre-requisites

1. An AWS account that you are able to use for testing, that is not used for production or other purposes.

## Signin to AWS Console

* Navigate to Chrome Browser in the right pane, click on My Account -> AWS Management Console.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

* Sign in to the console using below AccountID, IAM username and Password details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

* Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Now enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

* Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

* In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Accessing AWS Event Engine

1. Click [here](https://dashboard.eventengine.run/) to open the Event Engine dashboard in a separate browser tab.

2. Enter the team hash code that you were provided and click Proceed..

3. Click AWS Console.

4. Click Open Console.

5. Make sure you are in the correct region.

6. Go to the CloudFormation console.

7. Click [here](https://protecting-workloads.awssecworkshops.com/workshop/perimeter-layer/assess/) to proceed to the Assess Phase of the Perimeter Layer.

8. Optionally download the [Workshop Companion Guide](https://github.com/aws-samples/protecting-workloads-workshop/raw/master/artifacts/pww-companion-guide-v2.pdf)

## Mitigating Common Web Application Attack Vectors Using AWS WAF 

1. Click [here](https://dashboard.eventengine.run/) to open the Event Engine dashboard in a separate browser tab.

2. Enter the team hash code that you were provided and click Proceed..

3. Click AWS Console.

4. Click Open Console.

5. Make sure you are in the correct region.

6. Go to the CloudFormation console.

7. Click [here](https://protecting-workloads.awssecworkshops.com/workshop/perimeter-layer/assess/) to proceed to the Assess Phase of the Perimeter Layer.

8. Optionally download the [Workshop Companion Guide.](https://github.com/aws-samples/protecting-workloads-workshop/raw/master/artifacts/pww-companion-guide-v2.pdf)

Thank you for taking this training lab!

## Tear down this lab


### References

[Using Bucket Policies and User Policies](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html)

[Identity-based policies and resource-based policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.
Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
https://aws.amazon.com/apache2.0/
or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
