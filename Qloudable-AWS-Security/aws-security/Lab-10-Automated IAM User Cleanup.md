# Automated IAM User Cleanup

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Deploying IAM Lambda Cleanup with AWS SAM](#deploying-iam-lambda-cleanup-with-aws-sam)

## Overview

This hands-on lab will guide you through the steps to deploy a AWS Lambda function with AWS Serverless Application Model (SAM) to provide regular insights on IAM User/s and AWS Access Key usage within your account. You will use the AWS SAM CLI to package your deployment. Skills learned will help you secure your AWS account in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/cleanup%20arch.PNG?st=2020-09-17T05%3A14%3A41Z&se=2025-09-18T05%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NWvV1JIel6SrbQM0qHXthatTHauAbKeFDmBJIbAkhcM%3D)

**Learning Objectives**

1. Identify orphaned IAM Users and AWS Access Keys

2. Take action to automatically remove IAM Users and AWS Access Keys no longer needed

3. Reduce identity sprawl

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console

## Pre-Requisites

* An AWS account with full access permissions that you are able to use for testing, that is not used for production or other purposes.

**Note:** Please select 'Custom Cloud Account' and link your cloud account on Deployment console page for Lab Launch.

* Select region with support for AWS Lambda from the list: AWS Regions and Endpoints.

* AWS Serverless Application Model (SAM) installed and configured. The AWS Serverless Application Model (SAM) is an open-source framework for building serverless applications.

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

* Sign in to the console using below **AccountID**, **IAM username** and **Password** details:

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

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/5.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

## Deploying IAM Lambda Cleanup with AWS SAM

1. Create an Amazon S3 bucket if you don't already have one, it needs to be in the same AWS region being deployed into.

* From the console dashboard, choose Create bucket.

<img src="https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/1.PNG?st=2019-11-15T05%3A27%3A04Z&se=2022-11-16T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dfiGmRQBdcXAYU%2Bh3pBrho2G4VgBsB2nsfHbQzo%2B3KM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/2.PNG?st=2019-11-15T05%3A28%3A40Z&se=2022-11-16T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uMmd0yMDd%2BGgQPeW4V0gkYh54TrOJZWxOS1dlmiM8xo%3D" alt="image-alt-text" >

* Enter a name for your bucket, type a unique DNS-compliant name for your new bucket. Follow these naming guidelines:

 - The name must be unique across all existing bucket names in Amazon S3.
 - The name must not contain uppercase characters.
 - The name must start with a lowercase letter or number.
 - The name must be between 3 and 63 characters long.

* Choose an AWS Region where you want the bucket to reside. Choose a Region close to you to minimize latency and costs, or to address regulatory requirements. 

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s31.png?st=2020-01-23T11%3A42%3A14Z&se=2022-01-24T11%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7zo9TpnSetZ2qDd3MnTSyplDTEDlm1wKBSdikIwnArE%3D" 
alt="image-alt-text" >

**Note:** that for this example we will accept the default settings and this bucket is secure by default.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s32.png?st=2020-01-23T11%3A43%3A37Z&se=2022-01-24T11%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=t5BCitCB90S2MbBRPsyJQ6sLil%2F2WTHwG75Yld7J6B0%3D" 
alt="image-alt-text" >

* Click **next**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s33.png?st=2020-01-23T11%3A43%3A59Z&se=2022-01-24T11%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7GFpZbB3iNNksM3WZ0dRuWYFJcNTlDHtkhpcoGc04lQ%3D" 
alt="image-alt-text" >

* Click **Create**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s34.png?st=2020-01-23T11%3A44%3A18Z&se=2022-01-24T11%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z1%2Bz%2FGfUuT39ZtbJ0ivNbXsh0coYdhSwi5r7%2FCP2tUo%3D" 
alt="image-alt-text" >

2. Download the latest version of the **cloudformation-iam-user-cleanup.yaml** and  **lambda-iam-user-cleanup.py** CloudFormation template from the below link.

**https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/cloudformation-iam-user-cleanup.yaml?st=2020-03-13T05%3A30%3A09Z&se=2023-03-14T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sLkXxx8wJMh6p9IjNhxNb6Ntj9OUnvI%2B%2FwtdVzvD9%2Fs%3D**

**https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/lambda-iam-user-cleanup.py?st=2020-03-13T05%3A30%3A39Z&se=2023-03-14T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NW%2F9l3TbBewvWuU5uIOW4NHcYBb2yzSCCYK%2B2k9jwUA%3D**

3. Click on **lab menu icon** and select **Git bash** as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p0.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. Run below commands to change the route directory.

`cd /`

`cd D/PhotonUser/`

`cd Downloads/`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p1.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p2.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

5. Run below command to download the template.

`curl "https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/cloudformation-iam-user-cleanup.yaml?st=2020-03-13T05%3A30%3A09Z&se=2023-03-14T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sLkXxx8wJMh6p9IjNhxNb6Ntj9OUnvI%2B%2FwtdVzvD9%2Fs%3D" --output cloudformation-iam-user-cleanup.yaml`

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n1.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

`curl "https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/lambda-iam-user-cleanup.py?st=2020-03-13T05%3A30%3A39Z&se=2023-03-14T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NW%2F9l3TbBewvWuU5uIOW4NHcYBb2yzSCCYK%2B2k9jwUA%3D" --output lambda-iam-user-cleanup.py`

6. Run below command to list the downloaded template file.

`ls`

* Upload the files **cloudformation-iam-user-cleanup.yaml** and **lambda-iam-user-cleanup.py** in s3 bucket then make public the files. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/2.png?st=2020-03-12T05%3A28%3A49Z&se=2022-03-13T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=mVpVm7MGqaOtbewUaKrkcf9RATHDz1Y4rR27iL1jbOk%3D)

**Note:** Open PowerShell from the lab menu and run below commands to configure aws account.

`aws --version`

**Output:**
```
aws-cli/2.0.30 Python/3.7.7 Windows/10 botocore/2.0.0dev34
```
`aws configure`

**Output:**

```
AWS Access Key ID [****************WX5Q]: ****************WX5Q
AWS Secret Access Key [****************WWw1]: ****************WWw1
Default region name [us-east-1]: us-east-1
Default output format [json]: json

```

7. Now that you have the S3 bucket created and the files downloaded to your machine. You can start to create your deployment package on the command line with AWS SAM.

   Make sure you are working in the folder where where you have downloaded the files to.

   Run the following command to prepare your deployment package:

 `aws cloudformation package --template-file cloudformation-iam-user-cleanup.yml  --output-template-file output-template.yaml --s3-bucket <bucketname>`

 **Ex:** `aws cloudformation package --template-file cloudformation-iam-user-cleanup.yaml --output-template-file output-template.yaml --s3-bucket ab-bucket13`

 **Output:**

```
Uploading to abcd7b1f3022d83ebc2868dd2ccadcd7  2237 / 2237.0  (100.00%)
Successfully packaged artifacts and wrote output template to file output-template.yaml.
Execute the following command to deploy the packaged template
aws cloudformation deploy --template-file C:\Users\Sysgain inc\awscleanup\output-template.yaml --stack-name <YOUR STACK NAME>
```

8. Once you have finished preparing the package you can deploy the CloudFormation with AWS SAM:

> **NOTE:** The template file to use here is the output file from the previous command:

 `aws cloudformation deploy --template-file output-template.yaml  --stack-name IAM-User-Cleanup --capabilities CAPABILITY_IAM --parameter-overrides NotificationEmail=<replace_with_your_email_address>`
    
**Ex:** `aws cloudformation deploy --template-file output-template.yaml --stack-name IAM-User-Cleanup --capabilities CAPABILITY_IAM --parameter-overrides NotificationEmail=example@gmail.com`

**Output:**

```
Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - IAM-User-Cleanup
```

9. Once you have completed the deployment of your AWS Lambda function, test the function by going to the AWS Lambda function in your AWS account and create a dummy event by selecting test.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/5.png?st=2020-03-12T05%3A28%3A49Z&se=2022-03-13T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=mVpVm7MGqaOtbewUaKrkcf9RATHDz1Y4rR27iL1jbOk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/6.png?st=2020-03-12T05%3A28%3A49Z&se=2022-03-13T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=mVpVm7MGqaOtbewUaKrkcf9RATHDz1Y4rR27iL1jbOk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/7.png?st=2020-03-12T05%3A28%3A49Z&se=2022-03-13T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=mVpVm7MGqaOtbewUaKrkcf9RATHDz1Y4rR27iL1jbOk%3D)

10. If your test runs successfully you should receive an email from:

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/8.png?st=2020-03-12T05%3A28%3A49Z&se=2022-03-13T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=mVpVm7MGqaOtbewUaKrkcf9RATHDz1Y4rR27iL1jbOk%3D)

```
 AWS Notifications <no-reply@sns.amazonaws.com> 
 
 with the subject line of: *IAM user cleanup from <account_ID>* 
 
 and the body of the email will have a status report from the findings. E.g. IAM Users and AWS Access Keys which require a cleanup

 IAM user cleanup successfully ran.

 User John Doe has not logged in since 2018-04-19 08:36:18+00:00 and needs cleanup

 User John Doe has not used access key AKIAIOSFODNN7EXAMPLE in since 2018-04-22 21:32:  00+00:00 and needs cleanup

 User John Doe has not used access key AKIAIOSFODNN7EXAMPLE in since 2018-04-22 20:08:00+00:00 and needs cleanup
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Iamuserclenup/9.png?st=2020-03-12T05%3A28%3A49Z&se=2022-03-13T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=mVpVm7MGqaOtbewUaKrkcf9RATHDz1Y4rR27iL1jbOk%3D)

**Conclusion:** Congratulations! You have successfully completed the lab **Automated IAM User Cleanup**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab.

### References

* [AWS Identity and Access Management User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
* [What is IAM Access Analyzer?](https://docs.aws.amazon.com/IAM/latest/UserGuide/what-is-access-analyzer.html)
* [IAM Best Practices and Use Cases](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPracticesAndUseCases.html)
* [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-reference.html#serverless-sam-cli)
* [AWS Serverless Application Model (SAM)](https://aws.amazon.com/serverless/sam/)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

