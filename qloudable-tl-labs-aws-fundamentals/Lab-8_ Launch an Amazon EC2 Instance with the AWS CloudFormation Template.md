# Launch an   EC2 Instance with the AWS CloudFormation Template

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Create Amazon EC2 Key Pair](#exercise-2-create-amazon-ec2-key-pair)

[Exercise 3: Launch an Amazon EC2 Instance with the AWS CloudFormation Template](#exercise-3-launch-an-amazon-ec2-instance-with-the-aws-cloudformation-template)

## Overview

**AWS CloudFormation Concepts**:

When you use AWS CloudFormation, you work with templates and stacks. You create templates to describe your AWS resources and their properties. Whenever you create a stack, AWS CloudFormation provisions the resources that are described in your template.

**Topics**:

* Templates

* Stacks

* Change Sets

**Templates**:

An AWS CloudFormation template is a JSON or YAML formatted text file. You can save these files with any extension, such as .json, .yaml, .template, or .txt. AWS CloudFormation uses these templates as blueprints for building your AWS resources. For example, in a template, you can describe an Amazon EC2 instance, such as the instance type, the AMI ID, block device mappings, and its Amazon EC2 key pair name. Whenever you create a stack, you also specify a template that AWS CloudFormation uses to create whatever you described in the template.

You can also specify multiple resources in a single template and configure those resources to work together.

AWS CloudFormation templates have additional capabilities that you can use to build complex sets of resources and reuse those templates in multiple contexts. For example, you can add input parameters whose values are specified when you create an AWS CloudFormation stack. In other words, you can specify a value like the instance type when you create a stack instead of when you create the template, making the template easier to reuse in different situations.

**Stacks**:

When you use AWS CloudFormation, you manage related resources as a single unit called a stack. You create, update, and delete a collection of resources by creating, updating, and deleting stacks. All the resources in a stack are defined by the stack's AWS CloudFormation template. AWS CloudFormation provisions all those resources for you. You can work with stacks by using the AWS CloudFormation console or AWS CLI.

**Change Sets**:

If you need to make changes to the running resources in a stack, you update the stack. Before making changes to your resources, you can generate a change set, which is a summary of your proposed changes. Change sets allow you to see how your changes might impact your running resources, especially for critical resources, before implementing them.
For example, if you change the name of an Amazon RDS database instance, AWS CloudFormation will create a new database and delete the old one. You will lose the data in the old database unless you've already backed it up. If you generate a change set, you will see that your change will cause your database to be replaced, and you will be able to plan accordingly before you update your stack.

## Pre-Requisites

* AWS Account

* Basic knowledge on CloudFormation Templates

## Exercise 1: Login to AWS Console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Use below credentials to login to AWS console.

**Account ID**: `{{Account ID}}` <br>
**IAM username**: `{{user name}}` <br>
**Password**: `{{password}}`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Enter `Account ID` from the above information, then click on `Next`.

5. Enter `IAM username` and `Password` from the above information and click on `Sign In`

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. In the navigation bar, on the top-right region dropdown, select below region.

**Region**: `{{region}}`

## Exercise 2: Create Amazon EC2 Key Pair

1. Click on **Services**, search for **EC2** and select EC2 from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/11.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

2. In the left side navigation pane, under **NETWORK & SECURITY**, choose **Key Pairs**.

3. Click **Create Key Pair**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/12.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. For Key pair name, enter any unique name and then click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/13.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

5. The **private key file** is **automatically downloaded** by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is .pem. **Save** the private key file in a safe place.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/14.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/15.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

> **Note:** In coming section, you'll need to provide the name of your key pair when you launch an instance.

## Exercise 3: Launch an Amazon EC2 Instance with the AWS CloudFormation Template

> **Note:** Download the template from the below link.

**https://qloudableassets.blob.core.windows.net/aws-fundamentals/Templates/WebServerInstance.JSON?st=2019-11-25T05%3A23%3A01Z&se=2023-11-26T05%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yFnVTv%2BrJEjJN7G6fVMmfr0JLrYIfp0Vih9%2B%2F5%2Bs0nI%3D**

1. Click on **lab menu icon** and select **Git bash** as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p0.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

2. Run below commands to change the route directory.


`cd /`

`cd D/PhotonUser/`

`cd Downloads/`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p1.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p2.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

3. Run below command to downloa the template.


`curl "https://qloudableassets.blob.core.windows.net/aws-fundamentals/Templates/WebServerInstance.JSON?st=2019-11-21T09%3A31%3A06Z&se=2023-11-22T09%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Sn1o%2F8cGv6ePM0JLAX8sc2L%2BzINfpibPwe36f%2Fyky0Y%3D" --output WebServerInstance.JSON`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p3.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

4. Run below command to list the downloaded template file.

`ls`

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/p4.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

5. Now go back to AWS console and click on **Services**, search for **CloudFormation** and select **CloudFormation** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/1.png?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

6. Click on **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/2.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

7. In **Prepare template**, choose **Template is ready**.


8. In **Specify template**, choose **Upload a Template file** and then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/3.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/4.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/5.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

9. In the Stack name box, type a name for the stack (for example, Awstl-stack).

10. In Parameters, type the following, and then choose **Next**.

```
 InstanceType: type the instance type as t2.micro

 KeyName: type the instance key name from dropdown

 SSHLocation: 0.0.0.0/0
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/6.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

11. For **TagKey** and **TagValue**, leave the default. Leave remaining boxes as blank and then choose **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/7.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/8.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

12. Review the details and click on **Create stack**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/9.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/10.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

13. After AWS CloudFormation has created the stack and launched the Amazon EC2 instance, in the AWS CloudFormation console, **CREATE_COMPLETE** will be displayed as shown like below. This process can take several minutes.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/16.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

14. Click on the created stack to see the **Stack info**, **Events**, **Resources**, **Outputs**, **Parameters**, **Template** and **Change sets** status.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/17.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

15. Now click o **Resources** tab to check the deployed resources.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/18.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/19.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

16. You can directly go to that created resources by **clicking** on **hyperlink** of that particular resource as shown like below.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/20.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

17. Click on **VPC hyperlink** to go to that created VPC under VPC Dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/21.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

18. After clicking on **subnet hyperlink** you will directly go to the subnet pane as shown like below.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/22.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

19. Click on **webServerInstance hyperlink** and **copy** the **IPv4 Public IP address** of the instance.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/23.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

20. **Paste** the copied **Public IP Address** in new chrome browser to see the launched sample webserver.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab8/24.PNG?st=2019-11-21T09%3A20%3A01Z&se=2023-11-22T09%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=IabB5ShvYv%2B9wDSWRlPWnXYttYM2xdkG1UazLLp8T9Q%3D)

> **Result:** After completion of this Lab you would be able to create a AWS Key Pair and launch the Web server instance using CloudFormation Template in AWS console.
