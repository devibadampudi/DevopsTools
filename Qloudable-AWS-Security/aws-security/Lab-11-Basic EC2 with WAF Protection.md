# EC2 Web Infrastructure Protection

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Launch Instance](#exercise-2-launch-instance)

[Exercise 3: Create AWS WAF Rules](#exercise-3-create-aws-waf-rules)

[Exercise 4: Create Application Load Balancer with WAF integration](#exercise-4-create-application-load-balancer-with-waf-integration)

## Overview

**Introduction**

This hands-on lab will guide you through the introductory steps to protect an Amazon EC2 workload from network based attacks. You will use the AWS Management Console and AWS CloudFormation to guide you through how to secure an Amazon EC2 based web application with defense in depth methods. Skills learned will help you secure your workloads in alignment with the AWS Well-Architected Framework.

### Scenario and Objectives

After completing this lab, you will be able to:

* Protecting network and host-level boundaries

* System security configuration and maintenance

* Enforcing service-level protection

## Pre-Requisites

* An AWS account that you are able to use for testing, that is not used for production or other purposes. 

* Select region with support for AWS WAF for Application Load Balancers from list: AWS Regions and Endpoints.

## Exercise 1: Login to AWS Console

1. Navigate to **Chrome** on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l1.PNG?st=2020-01-13T06%3A18%3A50Z&se=2022-01-14T06%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ukHRsNhJ%2BLMc8q5eUfE14wq6bqb2vBbaVdB9Kag7UOE%3D)

3. Use below credentials to login to AWS console.

* **Account ID:** `{{Account ID}}` <br>
* **IAM username:** `{{username}}` <br>
* **Password:** `{{password}}`

4. Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/l2.png?st=2020-01-13T06%3A19%3A23Z&se=2023-01-14T06%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C8uWnvgRLQGTmwReHDLRxZksoUHSKHfB2H0zZRqMfFc%3D)

## Exercise 2: Launch Instance

For launching your first instance, we are going to use the launch wizard in the Amazon EC2 console.

### Launch Single Linux Instance

You can launch a Linux instance using the AWS Management Console. This tutorial is intended to help you launch your first instance quickly, so it doesn't cover all possible options.

1. Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

2. In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/2.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

3. Then choose an **Amazon Machine Image (AMI)** page displays a list of basic configurations, called Amazon Machine Images (AMIs), that serve as templates for your instance. Select the **HVM** edition of the Amazon Linux AMI (not Amazon Linux 2).

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

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/i1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

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

* Again refresh the vpc blade then select the subnet you have just created.

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

* Select **Add Rule** to type as `HTTP` and on source, `My IP`.

> **Note:** Note that best practice is to have an Elastic Load Balancer inline or the EC2 instance not directly exposed to the internet. However, for simplicity in this lab, we are opening the access to anywhere. Other lab modules secure access with Elastic Load Balancer.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/24.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

* Click **Review and Launch**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/n1.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

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

## Exercise 3: Create AWS WAF Rules

### AWS CloudFormation to create AWS WAF ACL for Application Load Balancer

Using AWS CloudFormation, we are going to deploy a basic example AWS WAF configuration for use with Application Load Balancer.

Download the latest version of the **waf-regional.yaml** CloudFormation template from the below link.

**https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Code/waf-regional.yaml?st=2020-02-11T09%3A14%3A40Z&se=2023-02-12T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0PgxHKBZ1afXhfPRKgSWJy5Z6i5%2FSSLCOYnx7FvyKNs%3D**

2. Click on **lab menu icon** and select **Git bash** as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p0.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

3. Run below commands to change the route directory.

`cd /`

`cd D/PhotonUser/`

`cd Downloads/`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p1.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p2.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. Run below command to download the template.

`curl "https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Code/waf-regional.yaml?st=2020-02-11T09%3A14%3A40Z&se=2023-02-12T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0PgxHKBZ1afXhfPRKgSWJy5Z6i5%2FSSLCOYnx7FvyKNs%3D" --output waf-regional.yaml`

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

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c2.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

4. Enter the following details:

  * **Stack name:** The name of this stack, Enter globally unique name. **Ex:** `lab-waf-regional-stack`.

  * **WAFName:** Enter the base name to be used for resource and export names for this stack. For this lab, you can use `WAFLabReg`.

  * **WAFCloudWatchPrefix:** Enter the name of the CloudWatch prefix to use for each rule using alphanumeric
  characters only. For this lab, you can use `WAFLabReg`.

The remainder of the parameters can be left as defaults.

5. At the bottom of the page click **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c3.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c4.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

6. In this lab, we won't add any tags or other options. Click **Next**. Tags, which are key-value pairs, can help you identify your stacks.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c5.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c6.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

7. Review the information for the stack. When you're satisfied with the configuration, click **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c7.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c8.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

8. After a few minutes the stack status should change from *CREATE_IN_PROGRESS* to *CREATE_COMPLETE*.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/c9.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

10. You have now set up a basic AWS WAF configuration ready for CloudFront to use!

## Exercise 4: Create Application Load Balancer with WAF integration

Using the AWS Management Console, we will create an Application Load Balancer, link it to the AWS WAF ACL we previously created and test.

### Create Application Load Balancer

1. Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l1.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

2. From the console dashboard, choose **Load Balancers** from the Load Balancing section.

3. Click **Create Load Balancer**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l2.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

4. Click **Create** under the **Application Load Balancer** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l3.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

5. Enter Name for Application Load Balancer such as `lab-alb-nsg`. Select all availability zones in your region then click **Next: Configure Security Groups**. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l4.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l5.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

6. You will need to click **Next: Configure Security Groups** again to accept your load balancer is using insecure listener.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l6.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

6. Click **Create a new security group** and enter name and description such as `lab-alb-nsg` and accept default of open to internet. Accept defaults and enter Name such as lab-alb and click **Next: Configure Routing**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l7.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

7. Accept defaults and enter **Name** such as `lab-alb-rout` and click **Next: Register Targets**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l8.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

8. From the list of instances **click the check box** and then **Add to registered** button. Then click **Next: Review**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/n2.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

9. Review the details and click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/n3.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

10. A successful message should appear, click **Close**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/n4.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

11. Take note of the DNS name under the Description tab, you will need this for testing.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/l12.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

### Configure Application Load Balancer with WAF

1. Click on **Services**, Search for **WAF** and then select **WAF & Shield** from the drop down.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a1.png?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

2. Click on **Go to AWS WAF** button under AWS WAF. In the navigation pane, choose **Web ACLs** then click on **AWS WAF Classic** as shown like below.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a2.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a3.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

3. In Filter tab select the **Region** in which you have deployed your Web ACL.

4. Then click on the **web ACL** that you want to associate with the Application Load Balancer.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a4.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

5. On the Rules tab, under **AWS resources using this web ACL**, choose **Add association**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a5.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

6. When prompted, use the Resource list to choose the **Application Load Balancer** that you want to associate this web ACL then select the load balancer you have created in previous step (Ex: `lab-alb`) and click **Add**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a6.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

7. The Application Load Balancer should now appear under **AWS resources using this web ACL**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a7.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

8. You can now test access by entering the DNS name of your load balancer in a web browser.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/Basic%20EC2%20with%20WAF%20Protection/Images/a8.PNG?st=2020-02-11T10%3A41%3A24Z&se=2023-02-12T10%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=JPhISn7QK8VSkw5NFLZSoRpOwprph7zMCMpCwlEuxR0%3D)

**Conclusion:** Congratulations! You have successfully completed the lab **EC2 Web Infrastructure Protection**!.Feel free to continue exploring or start a new lab.

<img src="https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif" alt="image-alt-text">

Thank you for taking this training lab!

**Lab Content Credits:**

* **References:**

[Amazon Elastic Compute Cloud User Guide for Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)

[Tutorial: Configure Apache Web Server on Amazon Linux 2 to Use SSL/TLS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SSL-on-an-instance.html)

[AWS WAF, AWS Firewall Manager, and AWS Shield Advanced Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html)

* **License:**

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

