# Automated Deployment of Detective Controls

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#Login-to-aws-console)

[Create Stack](#create-stack)

[Tear down this lab](#tear-down-this-lab)

## Overview

The main aim of this lab is to use AWS CloudFormation to automatically configure detective controls including AWS CloudTrail, AWS Config, and Amazon GuardDuty. You will use the AWS Management Console and AWS CloudFormation to automate the configuration of each service. The skills you learn will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc) .

**Learning Objectives**

1. Implement detective controls

2. Automate security best practices

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes

## Login to AWS Console

* Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

* Use below credentials to login to AWS console.

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

## Create Stack

AWS CloudFormation to configure AWS CloudTrail, AWS Config, and Amazon GuardDuty

**AWS CloudTrail** 

AWS CloudTrail is a service that enables governance, compliance, operational auditing, and risk auditing of your AWS account. With CloudTrail, you can log, continuously monitor, and retain account activity related to actions across your AWS infrastructure. CloudTrail provides event history of your AWS account activity, including actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services.

**Amazon GuardDuty** 

Amazon GuardDuty is a threat detection service that continuously monitors for malicious or unauthorized behavior to help you protect your AWS accounts and workloads. It monitors for activity such as unusual API calls or potentially unauthorized deployments that indicate a possible account compromise. GuardDuty also detects potentially compromised instances or reconnaissance by attackers.

Using **AWS CloudFormation**, we are going to configure **GuardDuty**, and **configure alerting** to your email address.

**AWS Config**

AWS Config is a service that enables you to assess, audit, and evaluate the configurations of your AWS resources. AWS Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations.

1. Download the latest version of the **cloudtrail-config-guardduty.yaml** CloudFormation template from below mentioned Url.

**https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/cloudtrail-config-guardduty.yaml?st=2020-08-05T05%3A44%3A12Z&se=2025-08-06T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=D%2FB%2FaNsFkwkfxyPvVhbDAA2xnmcfepwnv8e9zfqQ5gA%3D**

2. Note if your CloudFormation console does not look the same, you can enable the redesigned console by clicking New Console in the CloudFormation menu.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/1.PNG?st=2020-01-29T06%3A55%3A24Z&se=2023-01-30T06%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=I7dvY7OVLh8%2BiAxskH0s1dtQ8RqTfRL5BmvqKnr5B2M%3D)

3. Click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/2.png?st=2020-01-29T06%3A58%3A54Z&se=2023-01-30T06%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OqCsJtRcxPVMjGkDS5EfAwWY8HLxj%2FVXQGM9u2hjj9Y%3D)

4. Upload the file from the downloaded folder. Click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/3.png?st=2020-01-29T07%3A03%3A30Z&se=2023-01-30T07%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hRLkc77tqDA1FIGjzOXzP3YItYGSNW%2FYW5SMZG7QElg%3D)

5. Enter the following details for each section: General

* **Stack name:** `The name of this stack. For this lab, Ex: DetectiveControls.`

* **CloudTrail:** `Enable CloudTrail Yes/No. If you already have CloudTrail enabled select No.`

* **Config:** `Enable Config Yes/No. If you already have Config enabled select No.`

* **GuardDuty:** `Enable GuardDuty Yes/No. If you already have GuardDuty enabled select No. Note that GuardDuty will create and leave an IAM role the first time its enabled.`

* **S3BucketPolicyExplicitDeny:** `(Optional) Explicitly deny destructive actions to the bucket. AWS root user will be required to modify this bucket if configured.`

* **S3AccessLogsBucketName:**  `(Optional) The name of an existing S3 bucket for storing S3 access logs. CloudTrail`

* **CloudTrailBucketName:** `The name of the new S3 bucket to create for CloudTrail to send logs to. IMPORTANT Specify a bucket name that is unique.`

* **CloudTrailCWLogsRetentionTime:** `Number of days to retain logs in CloudWatch Logs.`

* **CloudTrailS3RetentionTime:** `Number of days to retain logs in the S3 bucket before they are automatically deleted.`

* **CloudTrailEncryptS3Logs:** `(Optional) Use AWS KMS to encrypt logs stored in Amazon S3. A new KMS key will be created.`

* **CloudTrailLogS3DataEvents:** `(Optional) These events provide insight into the resource operations performed on or within S3. Config`

* **ConfigBucketName:** `The name of the new S3 bucket to create for Config to save config snapshots to. IMPORTANT Specify a bucket name that is unique.`

* **ConfigSnapshotFrequency:** `AWS Config configuration snapshot frequency`

* **ConfigS3RetentionTime:** `Number of days to retain logs in the S3 bucket before they are automatically deleted. Guard Duty`

* **GuardDutyEmailAddress:** `The email address you own that will receive the alerts, you must have access to this address for testing.`

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/4.png?st=2020-01-29T07%3A05%3A23Z&se=2023-01-30T07%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q6K3%2Bw4riNclxnAIIlI70UjULJ8wNLQgJTVNw1qGavI%3D)

6. Once you have finished entering the details for the template continue to the bottom of the page and click **Next.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/5.png?st=2020-01-29T07%3A06%3A48Z&se=2023-01-30T07%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qehRiuIuzzhmf3zqxirNNfRX0ZRppAzOBryUMcfPEuo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/6.png?st=2020-01-29T07%3A07%3A19Z&se=2023-01-30T07%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rhzrb%2BC8rCRpL%2BwHiDjFGYlj5EngD18jKXmySaXR6IA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/7.png?st=2020-01-29T07%3A07%3A42Z&se=2023-01-30T07%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1Oy7U4%2BnIKigBCM4oTrJ2zqv94hDTfUNwdzdGlr%2BNk8%3D)

7. Review the information for the stack. When you're satisfied with the configuration, check I acknowledge that AWS CloudFormation might create IAM resources with custom names then click Create stack.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/8.png?st=2020-01-29T07%3A08%3A20Z&se=2023-01-30T07%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tiQxWKStAedGHEqha4tmhuVLf9BsvEtrkF7RJ9tlLXI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/9.png?st=2020-01-29T09%3A28%3A31Z&se=2023-01-30T09%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4X0GGPH9zOhDWxaB85LH2y3SpafzTvrjxkHMM2xdiqc%3D)

8. After a few minutes the stack status should change from CREATE_IN_PROGRESS to CREATE_COMPLETE. You have now set up detective controls to log to your buckets and retain events, giving you the ability to search history and later enable pro-active monitoring of your AWS account!

9. You should receive an email to confirm the SNS email subscription, you must confirm this. Note as the email is directly from GuardDuty via SNS is will be JSON format.

## Tear down this lab

The following instructions will remove the resources that have a cost for running them

### Delete the stack

1. Sign in to the AWS Management Console, and open the CloudFormation console at https://console.aws.amazon.com/cloudformation/.

2. Select the DetectiveControls stack.

3. Click the Actions button then click Delete Stack.

4. Confirm the stack and then click the Yes, Delete button.

### Empty and Delete the S3 buckets

1. Sign in to the AWS Management Console, and open the S3 console at https://console.aws.amazon.com/s3/.

2. Select the CloudTrail bucket name you previously created without clicking the name.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/bucket-teardown.png?st=2020-09-24T10%3A17%3A38Z&se=2025-09-25T10%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tzsfQfmAVM7NGaTGcwj3HqM0oonYJVm7JD2rPaPNcPo%3D)

3. Click Empty bucket and enter the bucket name in the confirmation box

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/empty2.png?st=2020-09-24T10%3A21%3A56Z&se=2025-09-25T10%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=77dGiZabI%2BqzpXxGdCkYijvp2OZVuP8zU4qnEGqXaP8%3D)

4. Click Confirm and the bucket will be emptied when the bottom task bar has 0 operations in progress.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/terdown3.png?st=2020-09-24T10%3A26%3A29Z&se=2025-09-25T10%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z%2F5GpO3LsjFlJFCWo2%2FdgYD6H0rZEJv5LpkF34b%2F2QE%3D)

5. With the bucket now empty, click Delete bucket.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/teardown4.png?st=2020-09-24T10%3A29%3A02Z&se=2025-09-25T10%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=350ntwUbMo7usgxY5pAsBhaH48xLkkoMi41IrCeKZ3E%3D)

6.Enter the bucket name in the confirmation box and click Confirm.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Automated%20Deployment%20of%20Detective%20Controls/images/tear5.png?st=2020-09-24T10%3A30%3A37Z&se=2025-09-25T10%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZzZWC37uuNs%2FaSvydCS61NDw%2FiqJaBXAuAG3FJHLbaA%3D)

7. Repeat steps 2 to 6 for the Config bucket you created.

**Conclusion:** Congratulations! You have successfully completed the Automated Deployment of Detective Controls. Feel free to continue exploring or start a new lab.

<img src="https://qloudableassets.blob.core.windows.net/aks/images%20for%20aks/sp%20images%20gif/congrats-gif.gif?st=2019-08-26T06%3A22%3A30Z&se=2022-08-27T06%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7h%2B1GwYtoaOpGYaKxe%2FrQN3dbKfhoKw%2FbPWiqstjlIc%3D" alt="image-alt-text">

### References

1. [AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)

2. [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

3. [Amazon GuardDuty](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
