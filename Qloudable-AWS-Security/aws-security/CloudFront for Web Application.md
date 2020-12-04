# CloudFront for Web Application

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Configure CloudFront - EC2 OR Load Balancer](#configure-cloudfront-ec2-or-load-balancer)

[Tear down this lab](#tear-down-this-lab)


## Overview

This hands-on lab will guide you through the steps to help protect a web application from network based attacks using Amazon CloudFront. You will use the AWS Management Console and AWS CloudFormation to guide you through how to deploy CloudFront. Skills learned will help you secure your workloads in alignment with the [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/).

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console

## Pre-Requisites

 1. An AWS account that you are able to use for testing, that is not used for production or other purposes. NOTE: You will be billed for any applicable AWS resources used if you complete this lab.
 
2. A web application to configure as the origin to CloudFront.

## Login to AWS Console

1. Navigate to Chrome Browser in the right pane, click on **My Account** -> **AWS Management Console**

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/1.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

2. Use below credentials to login to AWS console.

* **Account ID:** `{{Account_ID}}` <br>
* **IAM username:** `{{User_Name}}` <br>
* **Password:** `{{Password}}`

3. Select **IAM user** and then enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/2.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

4. Now enter **IAM user name** and **Password** from the above inforamtion, then click **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/3.PNG?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

5. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/4.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

6. In the navigation bar, on the top-right, select below region from the drop down as shown like below.

* **Region:** `{{Region}}`

![alt text](https://qloudableassets.blob.core.windows.net/aks/images%20for%20EKS/VPC-AWS/5.png?st=2020-06-10T13%3A07%3A47Z&se=2023-06-11T13%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=uACJa6AYxoTiMqvwBUPyNa2Gecw2%2Fw9G9K%2FC%2FWMF8E0%3D)

## Configure CloudFront - EC2 OR Load Balancer

### Launch Instance

1. Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/1.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

2. In the left side navigation pane, choose **Instances** under **INSTANCES** section, and cleck **Launch Instance.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-security/CloudFront%20with%20WAF%20Protection/Images/2.PNG?st=2020-02-10T10%3A48%3A31Z&se=2023-02-11T10%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=TGJwPs0sK8SVwOyZDpN124T5wOFyURrs8p4qcWMvphI%3D)

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

## Tear down this lab

The following instructions will remove the resources that have a cost for running them. Please note that Security Groups and SSH key will exist. You may remove these also or leave for future use.

Delete the CloudFront distribution:

1. Open the Amazon CloudFront console at https://console.aws.amazon.com/cloudfront/home.
2. From the console dashboard, select the distribution you created earlier and click the Disable button. To confirm, click the Yes, Disable button.
3. After approximately 15 minutes when the status is Deployed, select the distribution and click the Delete button, and then to confirm click the Yes, Delete button.

### Conclusion

* You have Successfully configured Amazon CloudFront with basic settings.

![alt text](https://raw.githubusercontent.com/sysgain/qloudable-tl-labs-aks-assets/master/Deploy%20AKS%20Cluster%20using%20Azure%20Portal/Images/congrats-gif.gif)

Thank you for taking this training lab..


### References & useful resources

For more information on configuring CloudFront, see [Viewing and Updating CloudFront Distributions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/HowToUpdateDistribution.html) in the CloudFront documentation.

### License

Licensed under the Apache 2.0 and MITnoAttr License.

Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

    https://aws.amazon.com/apache2.0/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
