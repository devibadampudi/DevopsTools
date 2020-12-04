# CloudFront with S3 Bucket Origin

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#Login-to-aws-console)

[Amazon Simple Storage Service](#amazon-simple-storage-service)

[Configure Amazon CloudFront](#configure-amazon-cloudfront)

[Tear down this lab](#tear-down-this-lab)

## Overview

This hands-on lab will guide you through the steps to host static web content in an [Amazon S3 bucket](https://aws.amazon.com/s3/), protected and accelerated by [Amazon CloudFront](https://aws.amazon.com/cloudfront). Skills learned will help you secure your workloads in alignment with the [AWS Well-Architected Framework.](https://aws.amazon.com/architecture/well-architected/)

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/Cloudfront%20with%20s3.png?st=2020-01-23T11%3A41%3A19Z&se=2022-01-24T11%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=azePVxlbC0gGN%2BrcNd3tr2hPRaNOscq3iEV86gD9nlc%3D)

**Learning Objectives**

1. Protecting S3 bucket from direct public access.

2. Improving access time with caching.

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account that you are able to use for testing.

* Permissions to Amazon S3 and Amazon CloudFront.

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

## Amazon Simple Storage Service

Amazon Simple Storage Service (Amazon S3) is storage for the Internet. You can use Amazon S3 to store and retrieve any amount of data at any time, from anywhere on the web.

<img src="https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/3.png?st=2019-11-12T06%3A27%3A55Z&se=2022-11-13T06%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=D4p5rMFI2TXC0q8qx58Hwni%2BMUcGIHkF3CkyQtnGrxg%3D" alt="image-alt-text" >

**Buckets:**

* A bucket is a container for objects stored in Amazon S3. Store an infinite amount of data in a bucket.

* Upload as many objects as you like into an Amazon S3 bucket. Each object can contain up to 5 TB of data.

**Objects:**

* Objects are the fundamental entities stored in Amazon S3. Objects consist of object data and metadata.

* The data portion is opaque to Amazon S3. The metadata is a set of name-value pairs that describe the object.

**Note:** An object is uniquely identified within a bucket by a key (name) and a version ID.

**Create a Bucket:**

1. From the console dashboard, choose Create bucket.

<img src="https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/1.PNG?st=2019-11-15T05%3A27%3A04Z&se=2022-11-16T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dfiGmRQBdcXAYU%2Bh3pBrho2G4VgBsB2nsfHbQzo%2B3KM%3D" alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/2.PNG?st=2019-11-15T05%3A28%3A40Z&se=2022-11-16T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uMmd0yMDd%2BGgQPeW4V0gkYh54TrOJZWxOS1dlmiM8xo%3D" alt="image-alt-text" >

2. Enter a name for your bucket, type a unique DNS-compliant name for your new bucket. Follow these naming guidelines:

* The name must be unique across all existing bucket names in Amazon S3.
* The name must not contain uppercase characters.
* The name must start with a lowercase letter or number.
* The name must be between 3 and 63 characters long.

3. Choose an AWS Region where you want the bucket to reside. Choose a Region close to you to minimize latency and costs, or to address regulatory requirements. 

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s31.png?st=2020-01-23T11%3A42%3A14Z&se=2022-01-24T11%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7zo9TpnSetZ2qDd3MnTSyplDTEDlm1wKBSdikIwnArE%3D" 
alt="image-alt-text" >

**Note:** that for this example we will accept the default settings and this bucket is secure by default.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s32.png?st=2020-01-23T11%3A43%3A37Z&se=2022-01-24T11%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=t5BCitCB90S2MbBRPsyJQ6sLil%2F2WTHwG75Yld7J6B0%3D" 
alt="image-alt-text" >

4. Click **next**.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s33.png?st=2020-01-23T11%3A43%3A59Z&se=2022-01-24T11%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7GFpZbB3iNNksM3WZ0dRuWYFJcNTlDHtkhpcoGc04lQ%3D" 
alt="image-alt-text" >

5. Click Create.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s34.png?st=2020-01-23T11%3A44%3A18Z&se=2022-01-24T11%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z1%2Bz%2FGfUuT39ZtbJ0ivNbXsh0coYdhSwi5r7%2FCP2tUo%3D" 
alt="image-alt-text" >

### Upload example index.html file

1. Create a simple `index.html` file, you can create by coping the following text into your favourite text editor.

```html
 <!DOCTYPE html>
<html>
<head>
<title>AWS</title>
</head>
<body>

<h1>Amazon</h1>
<p>aws-security.</p>

</body>
</html>
```
2. In the console click the name of your bucket you just created.
 
 <img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s35.png?st=2020-01-23T11%3A46%3A20Z&se=2022-01-24T11%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rm%2BehqK4yNRvVu6%2FGYozYCxlSn4zrdhZ5gJ%2FtBivd2A%3D" 
alt="image-alt-text" >

3. Click the Upload button.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s36.png?st=2020-01-23T11%3A48%3A27Z&se=2022-01-24T11%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EDcsuZ59jRX3RZeSBT4oBeSwRuAJ7dlrJaPBCUsyDLA%3D" 
alt="image-alt-text" >

4. Click the **Add files** button, select your `index.html` file, then click the **Upload** button.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s37.png?st=2020-01-23T11%3A49%3A07Z&se=2022-01-24T11%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T%2BkFnrYyqBDEeB7v8TNed7WqC7k8ENiz0WatPRY6faU%3D" 
alt="image-alt-text" >

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s38.png?st=2020-01-23T11%3A50%3A14Z&se=2022-01-24T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hwXIzqWf21T8UwBBKcgty69tM4B8vjglpoVVrznB%2FGE%3D" 
alt="image-alt-text" >

5. Your index.html file should now appear in the list.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s39.png?st=2020-01-23T11%3A51%3A02Z&se=2022-01-24T11%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q3D%2BE2PDyKHQEs%2Fy%2Bf44pQ1pZe3gavr4IPabk%2BiymeY%3D" 
alt="image-alt-text" >

## Configure Amazon CloudFront

1. Using the AWS Management Console, we will create a CloudFront distribution, and configure it to serve the S3 bucket we previously created.

2. From the console dashboard, click Create Distribution.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s310.png?st=2020-01-23T11%3A52%3A41Z&se=2022-01-24T11%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=P78pfuVF6V7%2Bp6cwHNKF%2FyfowWdGhbD4ta9lGnDP9hw%3D" alt="image-alt-text">

3. Click **Get Started** in the Web section.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s311.png?st=2020-01-23T11%3A53%3A06Z&se=2022-01-24T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xQX7Pr3l%2Bof%2BWqWvHt22Jmp6evSWV404MzRsWk3uNiI%3D" alt="image-alt-text">

4. Specify the following settings for the distribution:

 * In the Origin Domain Name field Select the S3 bucket you created previously.

 * In Restrict Bucket Access click the Yes radio then click Create a New Identity.

 * Click the Yes, Update Bucket Policy Button.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s3133.png?st=2020-01-23T11%3A54%3A20Z&se=2022-01-24T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QKSdKyZr56W3zzxOrBjM0qngWv1BRqzz%2BKMTbvB10o4%3D" alt="image-alt-text">

5. Scroll down to the **Distribution Settings** section, in the **Default Root** Object field enter `index.html`. Click Create Distribution.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s313.png?st=2020-01-23T11%3A54%3A47Z&se=2022-01-24T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=6f9sPulyiHGAEbp9oozxAhaggx8KCP6%2BVaetHyUFBz4%3D" alt="image-alt-text">

6. To return to the main CloudFront page click **Distributions** from the left navigation menu.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s314.png?st=2020-01-23T11%3A56%3A54Z&se=2022-01-24T11%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZbLnjDpD5kvJ%2BXnRAsT21PxMOryRHjZE71neAPJQiMM%3D" alt="image-alt-text">

7. After CloudFront creates your distribution which may take approximately **10 minutes**, the value of the Status column for your distribution will change from In Progress to Deployed.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s315.png?st=2020-01-23T11%3A57%3A32Z&se=2022-01-24T11%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=rV311miEgAUBFHojDLiwfzPfQC7DY6mk3tz97XQVQWs%3D" alt="image-alt-text">

8. When your distribution is **deployed**, confirm that you can access your content using your new CloudFront Domain Name which you can see in the console. Copy the Domain Name into a web browser to test.

9. You now have content in a private S3 bucket, that only CloudFront has secure access to. CloudFront then serves the requests, effectively becoming a secure, reliable static hosting service with additional features available such as custom certificates and alternate domain names.

<img src="https://qloudableassets.blob.core.windows.net/aws-security/cloudfront%20with%20securityhub/s316.png?st=2020-01-23T11%3A58%3A10Z&se=2022-01-24T11%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T6nc0aHhEaO7D0PFBYHavWIuDRiAdU3xkIVkQ87URNU%3D" alt="image-alt-text">

## Tear down this lab

### Delete the CloudFront distribution:

1. Open the Amazon CloudFront console at (https://console.aws.amazon.com/cloudfront/home).
  
2. From the console dashboard, select the distribution you created earlier and click the Disable button. To confirm, click the Yes, Disable button.
  
3. After approximately 15 minutes when the status is Disabled, select the distribution and click the Delete. button, and then to confirm click the Yes, Delete button.
  
### Delete the S3 bucket:

1. Open the Amazon S3 console at https://console.aws.amazon.com/s3/ .
  
2. Check the box next to the bucket you created previously, then click Empty from the menu.
  
3. Confirm the bucket you are emptying.
  
4. Once the bucket is empty check the box next to the bucket, then click Delete from the menu.
  
5. Confirm the bucket you are deleting.
  
**Conclusion:** Congratulations! You have successfully completed the lab **CloudFront with S3 Bucket Origin**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References

1. [Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html)

2. [Amazon CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
