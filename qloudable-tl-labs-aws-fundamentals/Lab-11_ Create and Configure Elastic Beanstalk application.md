# Lab-11: Create and Configure Elastic Beanstalk application

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Create an Application and an Environment](#excercise-1-create-an-application-and-an-environment)

[Excercise-2: Explore Your Environment](#excercise-2-explore-your-environment)

[Excercise-3: Deploy a New Version of Your Application](#excercise-3-deploy-a-new-version-of-your-application)

[Excercise-4: Configure Your Environment](#excercise-4-configure-your-environment)


## Overview

The aim of this lab is to create an application and an Environment using Elastic Beanstalk, upload an application version in the form of an application source bundle (for example, a node.js file) to Elastic Beanstalk, After your environment is launched, you can then manage your environment and deploy new application versions.

**Elastic Beanstalk:**

With Elastic Beanstalk, you can quickly deploy and manage applications in the AWS Cloud without having to learn about the infrastructure that runs those applications. Elastic Beanstalk reduces management complexity without restricting choice or control. You simply upload your application, and Elastic Beanstalk automatically handles the details of capacity provisioning, load balancing, scaling, and application health monitoring.

Elastic Beanstalk supports applications developed in Go, Java, .NET, Node.js, PHP, Python, and Ruby. When you deploy your application, Elastic Beanstalk builds the selected supported platform version and provisions one or more AWS resources, such as Amazon EC2 instances, to run your application. Elastic Beanstalk automatically launches an environment and creates and configures the AWS resources needed to run your code.

### Scenario and Objectives:

After completing this lab, you will be able to:

*  Create a simple Application

*  Explore Your Environment 

*  Deploy a New Version of Your Application

*  Configure Your Environment

## Pre-Requisites

*  AWS User Account

*  Sample application code.


## Excercise-1: Create an Application and an Environment

### Task:1 Login to AWS Console

1.	Navigate to chrome on the right pane, you should see AWS console page.

2.	Go to top right corner of the AWS page in the browser, click on My Account and in the dropdown, select AWS Management console.

3.	Use below credentials to login to AWS console.

     **Account ID:** {{Account ID}} <br>
     **IAM username:** {{username}} <br>
     **Password:** {{password}} <br>
     **Region:** {{region}} 

4.	Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/1.png?st=2019-12-02T12%3A22%3A12Z&se=2025-12-03T12%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B8fnT%2FRGjCYbIOKfTCvZ%2BjN1tmK8R6iQRnaFy6TmnVA%3D)
 
5.	Enter **IAM username** and **Password** from the above information and click on **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/2.png?st=2019-12-02T12%3A22%3A36Z&se=2025-12-03T12%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YM65derb0mLzrwPNpe2wJqX6AMxURsiJ4tcmMQyxp3M%3D)
 
6.	Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/3.png?st=2019-12-02T12%3A22%3A57Z&se=2026-12-03T12%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FJCpPuvcOZYi3%2FxThc2ePfwKSMQfE7XHH4zDnUWwPy0%3D)
 
7.	In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/4.png?st=2019-12-02T12%3A23%3A17Z&se=2025-12-03T12%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h190KaU6gXYPPYRIKq7AEy0ChawiijZ5jIt%2BM%2F7w6Pk%3D)

**Create VPC:**

To create Elastic Beanstalk application the **Default Vpc** should be created.

1.	 Click on **Services**, search for **VPC** and select **VPC** from the options.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/5.png?st=2019-12-02T12%3A23%3A36Z&se=2026-12-03T12%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dKMwQGP6jyGZRpruAvxUkIqH8IH1AKkKkvcHK6%2FxQnQ%3D)
 
2.	Click on **Your VPCs** in the left side navigation pane.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/6.png?st=2019-12-02T12%3A23%3A53Z&se=2026-12-03T12%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uwMNE5gEy8nrQA4o2d%2FtFsLaGXH2KgqL8fdurgoCSkQ%3D)
 
3.	Click on **Actions**, Select **Create Default VPC** button
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/7.png?st=2019-12-02T12%3A24%3A19Z&se=2026-12-03T12%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dGW8WFXFTqYEd1FhsmArNvixTUSkrEd9fMHeKIogIH0%3D)

4.	Click on **Create** to create default vpc

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/8.png?st=2019-12-02T12%3A24%3A37Z&se=2026-12-03T12%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3ORr6Uo3ahjO6x9X8ouq%2FMXs9331Z5dg2rGCuAOkvKc%3D)
 
5.	Once the VPC creation is completed, **The following Default VPC was created** message will pop up. Click on **close** button to see the created VPC.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/9.png?st=2019-12-02T12%3A24%3A55Z&se=2026-12-03T12%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=MDkOKEfyq%2Bg6Aq%2FVTyve9pOUcLbjVdQ3FGl1nzH8F2U%3D)

### Task:2 Create an Application and an Environment

To create your sample application, you'll use the Create a web app console wizard. It creates an Elastic Beanstalk application and launches an environment within it. An environment is the collection of AWS resources required to run your application code.

1.	Click on **Services**, search for **Elastic Beanstalk** and select **Elastic Beanstalk** from the options.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/10.png?st=2019-12-02T12%3A25%3A18Z&se=2026-12-03T12%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zOWF0xXARIs2IT892jWyuBXbRKM7XVv6dw0V%2F95UTeI%3D)

2.	Click on **Get started** to create application

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/11.png?st=2019-12-02T12%3A25%3A35Z&se=2025-12-03T12%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JZ0Ocmi1Or4CqykNAOhb64mcf%2F2drUmkxezEypoJ3Qo%3D)
 
3.	In create a web app page enter the below details then choose **Create application**.

    - ApplicationName: **testapplication**
	- Application Tags
         Key: **appname**
         Value: **testapp**
	- Platform: select **Node.Js** from dropdown
	- Application code: select **sample application** 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/12.png?st=2019-12-02T12%3A25%3A51Z&se=2026-12-03T12%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=msi789qRLsLSnRHwaGDcLJveI%2FzYeb3eGhdbJCL1zqU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/13.png?st=2019-12-02T12%3A26%3A10Z&se=2025-12-03T12%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=G6iALbsttTTeGtKajL1I1skF7HJ1oN7MF64YnSlBCD0%3D)
 
4.	To run the **testapplication** on AWS resources, Elastic Beanstalk takes the following actions. They take about five minutes to complete.

5.	Launches an environment named **Testapplication-env** with these AWS resources:

	- An Amazon Elastic Compute Cloud (Amazon EC2) instance (virtual machine)
	- An Amazon EC2 security group
	- An Amazon Simple Storage Service (Amazon S3) bucket
	- Amazon CloudWatch alarms
	- An AWS CloudFormation stack
	- A domain name

It will takes few minutes.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/14.png?st=2019-12-02T12%3A26%3A27Z&se=2025-12-03T12%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FfHP7wB%2FdIiRzfDmeezRg1lWnp3NhaV1f0U1M1cktT0%3D)

 
## Excercise-2: Explore Your Environment

To see an overview of your Elastic Beanstalk application's environment, use the environment dashboard in the Elastic Beanstalk console.

1. Open the **Elastic Beanstalk** console or directly click on **Elastic Beanstalk**..

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/34.png?st=2019-12-02T12%3A26%3A49Z&se=2025-12-03T12%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZRVxWYvE%2FGiP2JboPKpkQ%2BsT6chPTAo3A3K7EavTfPc%3D)

2. Choose **Testapplication-env**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/16.png?st=2019-12-02T12%3A27%3A51Z&se=2025-12-03T12%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KSzf01gtrkxkNw7Adh9NVXdNsOvZm2QVbEZ4tVR%2FDjY%3D)

3. **Dashboard** shows top level information about your environment. This includes its URL, its current health status, the name of the currently deployed application version, its five most recent events, and the platform version that the application is running on.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/17.png?st=2019-12-02T12%3A28%3A21Z&se=2026-12-03T12%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TZ5edpB4UbW3n0SNlrJrQnFmQMIJgeF%2BWTeHdk6TLcA%3D)

4. **Configuration** Shows the resources provisioned for this environment, such as the Amazon Elastic Compute Cloud (Amazon EC2) instances that host your application. You can configure some of the provisioned resources on this page.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/18.png?st=2019-12-02T12%3A29%3A07Z&se=2025-12-03T12%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1W06KF3TJlH8AcHgXOjIh%2FOLiawOOyIDvwlnbBkw8eo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/19.png?st=2019-12-02T12%3A29%3A40Z&se=2025-12-03T12%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JdirxxJUayjQsoVVdYh9QNXsdIcMd5MP%2FRjqnitRyrI%3D)

5. **Health** Shows the status of and detailed health information about the Amazon EC2 instances running your application.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/20.png?st=2019-12-02T12%3A30%3A02Z&se=2026-12-03T12%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qJEI3WjlbCOOgnBq06tprnupBnZcB4K%2Fd57v%2FX91RFM%3D)

6.	**Monitoring** Shows statistics for the environment, such as average latency and CPU utilization. You can use this page to create alarms for the metrics that you are monitoring.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/21.png?st=2019-12-02T12%3A30%3A23Z&se=2027-04-03T12%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EYrI7TJc90M9SJKoBy9ebnxOS4d2z0nfp1%2B3AXAQtlo%3D)

7.	**Events** Shows information or error messages from the Elastic Beanstalk service and from other services whose resources this environment uses.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/22.png?st=2019-12-02T12%3A31%3A04Z&se=2027-12-03T12%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZsNyFhew8qoWjd8433lhDPqM8mB080x3A52pPQMKywc%3D)
 
8.	**Tags** Shows environment tags and allows you to manage them. Tags are key-value pairs that are applied to your environment.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/23.png?st=2019-12-02T12%3A31%3A30Z&se=2025-12-03T12%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hwEzMFuCUfoDzYIQVwu6OZSAfziyPCM9sTb1hS7m1aM%3D)

 
## Excercise-3: Deploy a New Version of Your Application

you might need to deploy a new version of your application. You can deploy a new version at any time, as long as no other update operations are in progress on your environment.

The application version that you started this tutorial with is called **Sample Application**.

### Task1: To update your application version

1.	Download the sample application code by copy and paste the below link in **Chrome** new browser.

https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/nodejs-v1.zip?st=2019-12-02T09%3A41%3A12Z&se=2026-12-03T09%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=W1xDq9sYB4S7gmdjjZV6b3JDG5n%2FQ1AxabRwj%2ByyWk0%3D


![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/15.png?st=2019-12-06T07%3A03%3A50Z&se=2026-12-07T07%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oIP1ja2T%2F3PILMX1MPppekWmuXsq5e8QA%2BdMAizPveo%3D)

2.	Open the **Elastic Beanstalk** console or directly click on **Elastic Beanstalk**.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/24.png?st=2019-12-03T06%3A47%3A59Z&se=2026-12-04T06%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=91aXPjMTJrWCiqeQwSLsiF72xr%2F4gclzs3YwfCs100M%3D)

3.	From the Elastic Beanstalk applications page, choose **testapplication** app, and then choose **testapplication-env**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/25.png?st=2019-12-03T06%3A48%3A23Z&se=2026-12-04T06%3A48%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fXbaZqXFxEwb1G7eV%2FCSy2WQhhSYD3A2AoiGKiimTss%3D)
 
4.	In the Overview section, choose **Upload and Deploy**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/26.png?st=2019-12-03T06%3A49%3A15Z&se=2026-12-04T06%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JhrCxgZtEaipxLv7N1Q1h%2FfW6ijUgsnJ6VREmx4jYlk%3D)
 
5.	Choose **Choose File**, and then upload the sample application source bundle that you downloaded.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/27.png?st=2019-12-03T06%3A50%3A47Z&se=2025-12-04T06%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Q%2BRwKkPXbQC%2BbrMciBdUC1I5GyoFI4E1jKIP5u0CKAU%3D)

choose the downloaded Nodejs file from the path D:\PhotonUser\Downloads
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/44.png?st=2019-12-06T07%3A11%3A44Z&se=2025-12-07T07%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=r1QFfUthOHIj7bOZHKy8J0%2FzcOCGH5OoNqGYHou29AE%3D)
 
The console automatically fills in the Version label **Sample Application-1** with a new unique label. If you type in your own version label, ensure that it's unique.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/29.png?st=2019-12-03T06%3A51%3A19Z&se=2026-12-04T06%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Qt4DwM8bT5zM8oVdj3gzTEUCHrjsRYQx873fgyTeS%2FQ%3D)

6.	Choose **Deploy**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/30.png?st=2019-12-03T06%3A51%3A40Z&se=2025-12-04T06%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Ye5S6wmfyQtboO12JWrhl8qmfC%2B5wEJe5yhUDSXVe30%3D)
 
While Elastic Beanstalk deploys your file to your Amazon EC2 instances, you can view the deployment status on the environment's dashboard. While the application version is updated, the **Environment Health** status is gray. When the deployment is complete, Elastic Beanstalk performs an application health check. When the application responds to the health check, it's considered healthy and the status returns to green. The environment dashboard shows the new **Running Version** the name you provided as the **Version label**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/31.png?st=2019-12-03T06%3A52%3A03Z&se=2026-12-04T06%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oLkAlPLZzitI17kQz7xEYnEIaRProGNyPpEGztEbi7A%3D)

7. Elastic Beanstalk also uploads your new application version and adds it to the table of application versions. To view the table, choose **testapplication**, and then choose **Application Versions**.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/32.png?st=2019-12-03T06%3A52%3A24Z&se=2026-12-04T06%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=h3VA5k8wbLOVkUieon4HjJ6tOBUnt0%2FRrn%2BZU5tJDDs%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/33.png?st=2019-12-03T06%3A52%3A41Z&se=2026-12-04T06%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1sUFeEc6MB8chOvpCC7hqAyqr3mF4d2H0DVQVpze3tQ%3D)


## Excercise-4: Configure Your Environment

You can configure your environment to better suit your application. For example, if you have a compute-intensive application, you can change the type of Amazon Elastic Compute Cloud (Amazon EC2) instance that is running your application. To apply configuration changes, Elastic Beanstalk performs an environment update.

When you change configuration settings, Elastic Beanstalk warns you about potential application downtime.

### Task:1 Make a Configuration Change

In the below configuration change, you edit your environment's capacity settings. You configure a load-balanced, automatically scaling environment that has between two and four Amazon EC2 instances in its Auto Scaling group, and then you verify that the change occurred. Elastic Beanstalk creates an additional Amazon EC2 instance, adding to the single instance that it created initially. Then, Elastic Beanstalk associates both instances with the environment's load balancer. As a result, your application's responsiveness is improved and its availability is increased.

**To change your environment's capacity**

1.	Open the **Elastic Beanstalk** console or directly click on **Elastic Beanstalk**..

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/34.png?st=2019-12-02T12%3A26%3A49Z&se=2025-12-03T12%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZRVxWYvE%2FGiP2JboPKpkQ%2BsT6chPTAo3A3K7EavTfPc%3D)
 
2.	Navigate to the management page for your environment by click on **Testapplication-env**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/35.png?st=2019-12-03T06%3A53%3A04Z&se=2026-12-04T06%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=n%2BC3bZx9sVUyol5lX2ZWL6wFXo0sx1b4delU4hdbSGc%3D)
 
3.	Choose **Configuration**.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/36.png?st=2019-12-03T06%3A53%3A22Z&se=2025-12-04T06%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KbuFQ7V0M8ZBCMgkbUdIUuNRE1QGqLozEbI9edpTFlk%3D)

4.	In the **Capacity** configuration category, choose **Modify**.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/37.png?st=2019-12-03T06%3A53%3A39Z&se=2026-12-04T06%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4oxw%2Bq6saaFCCDY2nPRIYDIhXlhZlGyO5Rfpsw6MZZ8%3D)

5.	In the **Auto Scaling Group** section, change **Environment type** to **Load balanced**.
    **Instances row**: change **Max to 4**, and then change **Min to 2**.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/38.png?st=2019-12-03T06%3A53%3A57Z&se=2026-12-04T06%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RoA4XFXpypJY4q4Z2mhg%2BqCLHPA8ejT%2B8tLFbAze8IU%3D)

6.	On the **Modify capacity** page, choose Apply.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/39.png?st=2019-12-03T06%3A54%3A19Z&se=2026-12-04T06%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4LAaBYpsDUfBPN1Qurf4CAalC9Yo9mTObM%2BS%2BFPXz%2BA%3D)

7.	A warning tells you that this update replaces all of your current instances. Choose **Confirm**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/40.png?st=2019-12-03T09%3A06%3A36Z&se=2026-12-04T09%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XUIy3Bw09c8f4cewydMjNb84mhVXiu6dXl5iYF1tv08%3D)
 
8.	In the navigation pane, choose **Events**.

The environment update can take a few minutes. To find out that it's complete, look for the event Successfully deployed new configuration to environment in the event list. This confirms that the Auto Scaling minimum instance count has been set to 2. Elastic Beanstalk automatically launches the second instance.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/41.png?st=2019-12-03T09%3A06%3A56Z&se=2026-12-04T09%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uiqe0kV%2BblGd3uMCbLGyW3wV4U4UQ940HuoUDz0AJS4%3D)


### Task 2: Verify the Configuration Change

When the environment update is complete and the environment is ready, verify your change.

**To verify the increased capacity**

1.	In the navigation pane, choose **Health**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/42.png?st=2019-12-03T09%3A07%3A18Z&se=2025-12-04T09%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BDx4CodwPuYGpqYlATPZRNvNWRJhbbmvm1KUV3iEHVw%3D)
 
2.	Look at the **Enhanced Health Overview** page.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ElasticBeanstalk/43.png?st=2019-12-03T09%3A07%3A40Z&se=2025-12-04T09%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=B4pwrGoSppd1u7aYpIQGnF7vyag1XyLlFaWi4Itajms%3D)
 
You can see that the **Total** number of instances is **2**. You can also see that two Amazon EC2 instances are listed under the **Overall** line. Your environment capacity has increased to two instances.

> **Result:** After completing this lab, you would be able to create an sample Application, Explore Your Environment,  Deploy a New Version of Your Application, Configure Your Environment using Elastic Beanstalk service from AWS Console.
