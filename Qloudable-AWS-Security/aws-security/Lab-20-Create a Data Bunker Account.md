# Create a Data Bunker Account

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#exercise-1-login-to-aws-console)

[Create a Data Bunker Account](#exercise-2-create-a-data-bunker-account)

[Tear down this lab](#tear-down-this-lab)

## Overview

The main aim of this lab is to create Data Bunker Account. In this lab we will create a secure data bunker. A data bunker is a secure account which will hold important security data in a secure location. Ensure that only members of your security team have access to this account. In this lab we will create a new security account, create a secure S3 bucket in that account and then turn on CloudTrail for our organisation to send these logs to the bucket in the secure data account. You may want to also think about what other data you need in there such as secure backups.

**The following image shows what you will be doing in the lab**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/architect.png?st=2020-09-22T07%3A33%3A49Z&se=2025-09-23T07%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8jgD%2BVyZ22w5uNXfFgzQHw%2FoLRbQIEgdaf73D9z3Sbo%3D)

**Learning Objectives**

1. Create a Security account from the organizations master account

2. Create the bucket for CloudTrail logs

3. Ensure cross account access is read-only

4. Turn on CloudTrail from the root account

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

1. Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

2.  Sign in to the console using below **AccountID, IAM username** and **Password** details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

3. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Create a Data Bunker Account

### Create a Security account from the organizations master account

#### Setting up a master account

All accounts that use AWS Organizations for billing and control purposes must have a master account. This account controls membership to the organization, and pays the bills of all the members (someone's got to do it).

How to do it.

1. To set up a master account, perform the following steps:

i. Go to the My Organization section of the account you want to become the master. You must be logged in with your root credentials (that is, those you created the account with)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/org1.png?st=2020-09-21T09%3A06%3A48Z&se=2025-09-22T09%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=G5QwMLk5SDwMRrzAUeUu7c1g7XE7PwjoXJIz8r0a3wM%3D)

ii. In the AWS Organizations section of the AWS console, click on Create organization, as shown in the following screenshot:

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/org2.png?st=2020-09-21T09%3A10%3A16Z&se=2025-09-22T09%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aOE5gZqVEyxY7PUkyEzrSIQj%2Fh8PFO9OlyJDtSohzj8%3D)

iii. Unless you have a specific requirement, choose ENABLE ALL FEATURES to get the full benefit of organizations, as shown in the following screenshot:

 ![alt text]( https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/org3.png?st=2020-09-21T09%3A12%3A35Z&se=2025-09-22T09%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aO90N6v4AQIOaXPOgYctLdOxYvu66A0kN%2FFAiPViDKg%3D)

iv. Now that your account has been converted, you can return to the AWS Organizations page to see a list of all your accounts:

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/org4.png?st=2020-09-21T09%3A14%3A31Z&se=2025-09-22T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=U5N0%2FCSfSFSz9yBnBnRPOHEA%2BUVUVs1iJaB%2ByP0Joxk%3D)

2. If you do not have an account within your organization to store security logs. Navigate to AWS Organizations and select Create Account. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/createaccount.png?st=2020-09-21T09%3A39%3A42Z&se=2025-09-22T09%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BNy8PmdAyWGt2hFnBI9xgSsiP%2BL%2BHUaYdz8cUSnlpWM%3D)

3. Include a cross account access role and note it's name (default is OrganizationAccountAccessRole) - we will modify this later to remove unnecessary access

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/accessRole.png?st=2020-09-21T09%3A42%3A55Z&se=2025-09-22T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z0AHwf2wg3XK%2BURF%2FmIZaELd8jzOlzWGU2IXhDzRGck%3D)

4. (Optional) If your role does not have permission to assume any role you will also have to add an IAM policy. The AWS administrator policy has this by default, otherwise follow the steps in the AWS Organizations Documentation to grant permissions to access the role

5. Consider applying best practices as a baseline such as lock away your AWS account root user access keys and using multi-factor authentication

6. Navigate to Settings and take a note of your Organization ID

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/settings.png?st=2020-09-21T09%3A23%3A46Z&se=2025-09-22T09%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ix2EBT1tZIYUSRnuCzhCoUaaqtJUqZjuMjWbXyneYEE%3D)

### Create the bucket for CloudTrail logs

1. Swtich roles into the security account for your organization.
  
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/switchroles.png?st=2020-09-21T09%3A28%3A18Z&se=2025-09-22T09%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ceoeI69%2Bny6wUJvlyXEQ2mqu%2FucKIP2fO5LTnpMvPg4%3D)

2. Navigate to S3.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/navigates3.png?st=2020-09-21T09%3A35%3A34Z&se=2025-09-22T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LRSOYMcRQLiSQ8K4lme2FNxeclFV%2FP1nVgBVnfn2lgQ%3D)

3. Press Create Bucket.

 ![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/createbucket.png?st=2020-09-21T09%3A33%3A15Z&se=2025-09-22T09%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bKSy%2FOcM5voaLzEk5TtFUu5oxTAm6w91eMZ5pKaFnnM%3D)

4. Enter a name for your bucket, make note of it and click Next

5. Under configuration options enable versioning and enable object lock. This will prevent our logs from being deleted. Press Next
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/versionenbling.png?st=2020-09-21T11%3A22%3A19Z&se=2025-09-22T11%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kDhfWg%2FZ5VCki7WXEepPNtrdVrbHEbi%2FpmjWLNLFlm4%3D)
  
6. Select object lock under advanced settings.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/objectlock.png?st=2020-09-21T11%3A24%3A07Z&se=2025-09-22T11%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XqoCeA%2Bsqa%2FwU7FT6a7ICouXAfEyaVuiPEDTQWh%2Fq0Y%3D)
  
7. Do not modify any permissions - press Next

8. Press Create Bucket

9. Press the bucket we just create and navigate to the Properties tab

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/bucket-settings.png?st=2020-09-21T12%3A04%3A58Z&se=2025-09-22T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nyBgqUt0xMNiHyvS3nQxybRpgu%2B%2FljE%2B890cgm9GMZQ%3D)

10. Under Object Lock, enable compliance mode and set a retention period. The length of the retention period will depend on your organisational requirements. If you are enabling this just for baseline security start with 31 days to keep one month of logs

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/enabling-compliancemode.png?st=2020-09-21T12%3A08%3A31Z&se=2026-09-22T12%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RGAx8q8BIni8BNkjqUtQo1It31827H1p8MLjkhaj4ao%3D)
 
11. Under the Permissions tab, replace the Bucket Policy with the following, replacing [bucket] and [organization id], Press **Save**.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::[bucket]"
        },
        {
            "Sid": "AWSCloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::[bucket]/AWSLogs/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Sid": "AWSCloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::[bucket]/AWSLogs/[organization id]/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}

```

12. (Optional) Next we will add a lifecycle policy to clean up old logs. Navigate to Management

13. (Optional) Add a lifecycle rule named Delete old logs, press Next

14. (Optional) Add a transition rule for both the current and previous versions to move to Glacier after 32 days. Press Next

15. (Optional) Select the current and previous versions and set them to delete after 365 days

### Ensure cross account access is read-only

1. Navigate to IAM and select Roles

2. Select the organizations account access role for your orgainzation: Note: the default is OrganizationAccountAccessRole

3. Press Attach Policy and attach the AWS managed ReadOnlyAccess Policy

4. Navigate back to the OrganizationAccountAccessRole and press the X to remove the AdministratorAccess policy

### Turn on CloudTrail from the root account

1. Switch back to the root account

2. Navigate to CloudTrail

3. Select Trails from the menu on the left

4. Press Create Trail

5. Enter a name for the trail such as OrganizationTrail

6. Select Yes next to Apply trail to my organization

7. Under Storage location, select No for Create new S3 bucket and enter the bucket name of the bucket created in step 2

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Aws-Data%20bunker%20account/cloud-trail.png?st=2020-09-21T12%3A31%3A50Z&se=2025-09-22T12%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=H7XY8PmkaDhN3JJjt5X%2FO%2B88tLxk6a9bcokA2XFdCjQ%3D)

## Tear down this lab

1. Remove the lambda function, then roles.

2. If you created a new S3 bucket, then you may remove it.

**Conclusion:** Congratulations! You have successfully completed the lab **Data Bunker Account**!.Feel free to continue exploring or start a new lab.

![alt text](https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif)

Thank you for taking this training lab!

### References

[Master account creation](https://aws.amazon.com/blogs/security/aws-organizations-now-requires-email-address-verification/)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
https://aws.amazon.com/apache2.0

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
