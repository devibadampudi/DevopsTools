# CloudFront with WAF Protection

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Launch Instance](#launch-instance)

[Configure AWS WAF](#configure-aws-waf)

[Configure Amazon CloudFront](#configure-amazon-cloudfront)

[Tear down this lab](#tear-down-this-lab)

## Overview

This hands-on lab will guide you through the steps to protect a workload from network based attacks using Amazon CloudFront and AWS Web Application Firewall (WAF). You will use the AWS Management Console and AWS CloudFormation to guide you through how to deploy CloudFront with WAF integration to apply defense in depth methods. Skills learned will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc).

**The following image shows what you will be doing in the lab**

<img src="https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/CloudFront%20with%20WAF%20protection.PNG?st=2020-09-17T11%3A27%3A02Z&se=2025-09-18T11%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vJxoSPYW26LRgxkL5ZM7iVi0nQ3AgoDwkX%2Fmn9fv8MQ%3D">

**Learning Objectives**

1. Protecting network and host-level boundaries

2. System security configuration and maintenance

3. Enforcing service-level protection

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes.

## Login to AWS Console

1. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

2. Sign in to the console using below **AccountID, IAM username** and **Password** details:

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

3. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

4. Now enter **Account ID**, **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Launch Instance

1. Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

2. In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/ec2-1.PNG?st=2020-09-07T11%3A13%3A54Z&se=2025-09-08T11%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=frEFjqUJfvML1CcWO4nB65X7RKQ0350SBeaOZyAaO94%3D)

3. Then choose an **Amazon Machine Image (AMI)** page displays a list of basic configurations, called Amazon Machine Images (AMIs), that serve as templates for your instance. Select the **HVM** edition of the Amazon Linux AMI, either version.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/3.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

4. On the Choose an Instance Type page, you can select the hardware configuration of your instance. Select the **t2.micro** type, which is selected by default. Then select **Next: Configure Instance Details**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/4.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

5. On the Configure Instance Details page, make the following changes:

* Select **Create new VPC**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/5.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/6.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/7.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/8.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/9.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Create Internet gateway

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/IAM%20Tag%20Based%20Access%20Control%20for%20EC2/ec2-2.PNG?st=2020-09-07T11%3A15%3A13Z&se=2025-09-08T11%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8ZFECkg93SJ7HGFZgLZ%2B03e9A8SkR4Tgx9A5eKd0HDg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i2.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i3.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i4.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i5.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Configuring Route table

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i6.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i6.1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i6.2.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i6.3.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i6.4.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Edit DNS hostnames

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i7.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i8.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i9.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Now go back to instance page and refresh the vpc blade and select the vpc you have just created.

* Select **Create new Subnet**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/10.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/11.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/12.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/13.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/n1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Again refresh the vpc blade then select the subnet who have just created.

* Select **Create new IAM role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/14.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

    
* In the new tab that opens, select **Create role**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/15.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* With AWS service pre-selected, select EC2 from the top of the list, then click Next: Permissions.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/16.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Enter `s3` in the search and select AmazonS3ReadOnlyAccess from the list of policies, then click Next: Review. This policy will give this EC2 instance access to read and list any objects in Amazon S3 within your AWS account.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/17.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/18.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Enter a role name, such as `ec2-s3-read-only-role`, and then click Create role.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/19.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Back on the EC2 launch web browser tab, select the **refresh** button next to Create new IAM role, and click the role you just created.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/20.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Scroll down and expand the Advanced Details section. Enter the following in the User Data test box to automatically install Apache web server and apply basic configuration when the instance is launched:

```
#!/bin/bash
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
groupadd www
usermod -a -G www ec2-user
chown -R root:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} +
find /var/www -type f -exec chmod 0664 {} +
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/21.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

6. Accept defaults and click **Next: Add tags**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/22.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

7. Click **Next: Configure Security Group**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/23.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Accept default option **Create a new security group**.

* On the line of the first default entry *SSH*, select **Source** as *My IP*.

* Click **Add Rule**, select Type as *HTTP* and **Source** as *Anywhere*.

> **Note:** Note that best practice is to have an Elastic Load Balancer inline or the EC2 instance not directly exposed to the internet. However, for simplicity in this lab, we are opening the access to anywhere. Other lab modules secure access with Elastic Load Balancer.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/24.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Click **Review and Launch**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/25.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

8. On the Review Instance Launch page, check the details, and then click **Launch**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/26.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

9. If you do not have an existing key pair for access instances, a prompt will appear. Click **Create New**,then type a name such as `waf-keypair`, click Download Key Pair, and then click Launch Instances.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/27.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/28.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

**Important**: This is the only chance to save the private key file. You'll need to provide the name of your key pair when you launch an instance, and you'll provide the corresponding private key each time you connect to the instance.

10. Click **View Instances**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/29.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

11. When your instance is launched, its status will change to running, and it will need a few minutes to apply patches and install Apache web server.

12. You can connect to the Apache test page by entering the public DNS, which you can find on the description tab or instances list. Take note of this public DNS value.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/30.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/31.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

## Configure AWS WAF

Using AWS CloudFormation, we are going to deploy a basic example AWS WAF configuration for use with CloudFront.

Download the latest version of the **waf-global.yaml** CloudFormation template from the below link.

**https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Code/waf-global.yaml?st=2020-02-10T10%3A01%3A55Z&se=2023-02-11T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HwVnMj5CTwWW4xtkEZqkE17UYY6%2BPW5ZN2oP433O1vA%3D**

2. Click on **lab menu icon** and select **Git bash** as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p0.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

3. Run below commands to change the route directory.

`cd /`

`cd D/PhotonUser/`

`cd Downloads/`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p1.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p2.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. Run below command to download the template.

`curl "https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Code/waf-global.yaml?st=2020-02-10T10%3A01%3A55Z&se=2023-02-11T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HwVnMj5CTwWW4xtkEZqkE17UYY6%2BPW5ZN2oP433O1vA%3D" --output waf-global.yaml`

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n1.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

5. Run below command to list the downloaded template file.

`ls`

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n2.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

6. Now go back to AWS console and click on **Services**, search for **CloudFormation** and select **CloudFormation** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/n3.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/1.png?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

8. Click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_VPC/Images/2.PNG?st=2020-01-28T10%3A06%3A50Z&se=2023-01-29T10%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=0BqMEyQrbfHLPyh7dg9djdBzIjrl6Se6z2%2F%2B%2FK19zKk%3D)

7. Click **Upload a template file** and then click **Choose file**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/200_Automated_Deployment_of_EC2_Web_Application/Images/1.PNG?st=2020-01-29T09%3A46%3A47Z&se=2023-01-30T09%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=NM%2F3TrBvy3dEGmPHjS%2F7qK24kpRxB843rQO7my2kOsU%3D)

8. Choose the CloudFormation template you downloaded in step 1, return to the CloudFormation console page and click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

4. Enter the following details:

  * **Stack name:** The name of this stack, Enter globally unique name. **Ex:** `waf-stack`.

  * **WAFName:** Enter the base name to be used for resource and export names for this stack. For this lab, you can use `Lab1`.

  * **WAFCloudWatchPrefix:** Enter the name of the CloudWatch prefix to use for each rule using alphanumeric
  characters only. For this lab, you can use `Lab1`.

The remainder of the parameters can be left as defaults.

5. At the bottom of the page click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f2.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f3.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

6. In this lab, we won't add any tags or other options. Click Next. Tags, which are key-value pairs, can help you identify your stacks.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f4.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f5.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

7. Review the information for the stack. When you're satisfied with the configuration, click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f6.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f7.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

8. After a few minutes the stack status should change from *CREATE_IN_PROGRESS* to *CREATE_COMPLETE*.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/f8.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

10. You have now set up a basic AWS WAF configuration ready for CloudFront to use!

## Configure Amazon CloudFront

Using the AWS Management Console, we will create a CloudFront distribution, and link it to the AWS WAF ACL we previously created.

1. Click on **Services**, search for **CloudFront** and select **CloudFront** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c0.png?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

2. From the console dashboard, choose Create Distribution.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

3. Click Get Started in the Web section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c2.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

4. Specify the following settings for the distribution:

  * In **Origin Domain Name** enter the EC2 public DNS name you recorded from your instance launch.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c3.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

  * In the distribution Settings section, click AWS WAF Web ACL, and select the one you created previously.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c4.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

  * Click Create Distrubution.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c5.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

5. After CloudFront creates your distribution, the value of the Status column for your distribution will change from In Progress to Deployed.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c6.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c7.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

6. When your distribution is deployed, confirm that you can access your content using your new CloudFront URL or CNAME. Copy the Domain Name into a web browser to test.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/c8.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

7. You have now configured Amazon CloudFront with basic settings and AWS WAF.

## Tear down this lab

The following instructions will remove the resources that have a cost for running them. Please note that Security Groups and SSH key will exist. You may remove these also or leave for future use.

**Delete the CloudFront distribution:**

1. Open the Amazon CloudFront console at https://console.aws.amazon.com/cloudfront/home.

2. From the console dashboard, select the distribution you created earlier and click the Disable button. To confirm, click the Yes, Disable button.

3. After approximately 15 minutes when the status is Deployed, select the distribution and click the Delete button, and then to confirm click the Yes, Delete button.

**Delete the AWS WAF stack:**

1. Sign in to the AWS Management Console, and open the CloudFormation console at https://console.aws.amazon.com/cloudformation/.

2. Select the **waf-cloudfront** stack.

3. Click the Actions button, and then click Delete Stack.

4. Confirm the stack, and then click the Yes, Delete button.

**Conclusion:** Congratulations! You have successfully completed the lab **CloudFront with WAF Protection**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

### References & useful resources

[Amazon Elastic Compute Cloud User Guide for Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)

[Amazon CloudFront Developer Guide](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

[Tutorial: Configure Apache Web Server on Amazon Linux 2 to Use SSL/TLS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SSL-on-an-instance.html)

[AWS WAF, AWS Firewall Manager, and AWS Shield Advanced Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html)

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

    https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
