# Lab-6: Create and Configure EC2 Auto Scaling in AWS Console

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Create a Launch Template](#excercise-1-create-a-launch-template)

[Excercise-2: Create an Auto Scaling Group](#excercise-2-create-an-auto-scaling-group)

[Excercise-3: Verify Your Auto Scaling Group](#excercise-3-verify-your-auto-scaling-group)


## Overview

The aim of this lab to create and configure the EC2 Auto scaling and create a new instance through autoscaling group when your instance is terminated.

**Ec2 Auto Scaling:**

Amazon EC2 Auto Scaling helps you ensure that you have the correct number of Amazon EC2 instances available to handle the load for your application. You create collections of EC2 instances, called Auto Scaling groups. You can specify the minimum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes below this size. You can specify the maximum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes above this size. If you specify the desired capacity, either when you create the group or at any time thereafter, Amazon EC2 Auto Scaling ensures that your group has this many instances. If you specify scaling policies, then Amazon EC2 Auto Scaling can launch or terminate instances as demand on your application increases or decreases.

**Scenario and Objectives**

After completing this lab, you will be able to:

* Create a launch template

* Create autoscaling group

* You can verify when your instance is terminated it will launch new instance through autoscaling group.

## Pre-Requisites

* AWS User Account.

## Excercise-1: Create a Launch Template

Essentially launch template that specifies the type of EC2 instance that Amazon EC2 Auto Scaling creates for you. Include information such as the ID of the Amazon Machine Image (AMI) to use, the instance type, key pairs, security groups, and block device mappings

### Task:1 Login to AWS Console

1.	Navigate to chrome on the right pane, you should see AWS console page.

2.	Go to top right corner of the AWS page in the browser, click on My Account and in the dropdown, select AWS Management console.

3.	Use below credentials to login to AWS console.

     **Account ID:** {{Account ID}} <br>
     **IAM username:** {{username}} <br>
     **Password:** {{password}} <br>
     **Region:** {{region}} 

4.	Enter **Account ID** from the above information, then click on **Next**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/1.png?st=2019-11-25T10%3A31%3A03Z&se=2027-11-26T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=e7K%2BgsVFfUduRVPXh%2BB4IM8rm3o8ipGJBCOq2dH%2F6Rk%3D)

5.	Enter **IAM username** and **Password** from the above information and click on **Sign In**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/2.png?st=2019-11-25T10%3A31%3A29Z&se=2025-11-26T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=t2R4g8hEQLFPQ4F7DXK11xntdAxz5JNQvB9baHppCCQ%3D)

6.	Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/3.png?st=2019-11-25T10%3A31%3A50Z&se=2025-11-26T10%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xKcihTsy90fIBeENxJ6BEY80ADaReL6Wkm7%2BNhUNnfE%3D)

7.	In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/4.png?st=2019-11-25T10%3A32%3A09Z&se=2026-11-26T10%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Us0b4SpUEGrQxk20h0cIrACEdK51%2BJ4Und3UehhWF2M%3D)

### Task 2: Create VPC, Subnet and Security Group

First you have create the Vpc, Subnet and Security Group to create launch template.

**Create VPC:**

1.	 Click on **Services**, search for **VPC** and select **VPC** from the options.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/5.png?st=2019-11-25T10%3A32%3A26Z&se=2026-11-26T10%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qwO8wYzDqZzSXHlIFXUjX3Wk7%2B5qqumUluf2VI8Libc%3D)

2.	Click on **Your VPCs** in the left side navigation pane.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/6.png?st=2019-11-25T10%3A32%3A43Z&se=2028-11-26T10%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9q0aNSA0ORIvuC9xIXaoDw7CU%2FRMhKWXT5w8EUH0p7k%3D)
 
3.	Click on **Create VPC** button

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/7.png?st=2019-11-25T10%3A33%3A03Z&se=2025-11-26T10%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oV8sQWUQGib4XaKL2xDeTFROePdJtY0YqobMgsDLu%2Bc%3D)

4.	Enter below details

    * Name tag: **Autoscalevpc**
    * IPv4 CIDR block: **10.0.0.0/16**
    * IPv6 CIDR block:  **No IPv6 CIDR Block**
    * Tenancy: **Default**

Click on **create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/8.png?st=2019-11-25T10%3A33%3A22Z&se=2026-11-26T10%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JiKikROrqqK0NbqS9issHLqEGcIufbFsdtby2scst%2F4%3D)

5.	Once the VPC creation is completed, **The following VPC was created** message will pop up. Click on **close** button to see the created VPC.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/9.png?st=2019-11-25T10%3A33%3A46Z&se=2025-11-26T10%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RRL2apToBplochGP1EwXPo6tuAtjulsF0qHn1bREAhA%3D)

**Create Public Subnet**

1.	Choose **Subnets** in the left navigation pane and click on **Create subnet** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/10.png?st=2019-11-25T11%3A56%3A49Z&se=2026-11-26T11%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=r1JU7wBVohOiO%2FXnSUQZpuh1wr%2FqVFLuxSu%2BtDgaBOQ%3D)
 
2.	Specify the below details.

    * Name tag: **autoscale-subnet**
    * VPC: Choose **testvpc** from dropdown
    * Availability Zone: **No preference**
    * IPv4 CIDR block: **10.0.0.0/24**

Click on **create** button.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/11.png?st=2019-11-25T11%3A57%3A20Z&se=2025-11-26T11%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2%2FrT%2B4xRjFn9lZRrnY%2BjpoqvqpjM4vF4ugRk4%2Be%2F8AY%3D)
 
3.	Once the Subnet creation is completed, **The following Subnet was created** message will pop up. Click on **close** button to see the created Subnet.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/12.png?st=2019-11-25T11%3A57%3A41Z&se=2025-11-26T11%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8GiNltdzCpnyk689HF43ivTgX8uDAX09D7qNIbL%2BIaU%3D)

**Create Security Group:**

1.	In the left side navigation pane, under **SECURITY**, choose **Security Groups** ,Click on **Create security group**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/13.png?st=2019-11-25T11%3A58%3A05Z&se=2026-11-26T11%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aw%2BJAr1O8KHb30af48QLgqcRtZNxS22HqAeEDKugbKg%3D)
 
2.	Specify the below details.

	* Security Group name*: **autoscaleSG**
	* Description: **allow ssh access**
	* VPC: **autoscalevpc**

Click on **create** button.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/14.png?st=2019-11-25T11%3A58%3A24Z&se=2026-11-26T11%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wMsIyRrlCJQJS335U2ey69utapOeA4YAM6PKspUMiPk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/15.png?st=2019-11-25T11%3A58%3A45Z&se=2026-11-26T11%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xkff5dcwQIMFdeyd0FPRJU75kt7uSL0dwxYPd8lXNSE%3D)

3.	Once the security group creation is completed, **The following security group was created message will pop up**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/16.png?st=2019-11-25T11%3A59%3A04Z&se=2025-11-26T11%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IFYfPPCeU3ZzKckyBBK%2B%2FbyPfbuVbw7fyqRPnXCDUU8%3D)

Note : Copy and save the Security Group ID it will be use in create launch template in Add Network Interface step.

4.	 Click on **close** button to see the created Security Group.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/17.png?st=2019-11-25T11%3A59%3A26Z&se=2025-11-26T11%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Tf%2BJ%2BCQ3Ejjc0pZwoyNoqzfB4dTk%2BtP%2B6g%2BwVF%2Fwwzc%3D)


### Task 2: Create a launch template for an Auto Scaling group

1.	Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/18.png?st=2019-11-25T11%3A59%3A43Z&se=2025-11-26T11%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jtL%2BqPZ%2BW0RMiYb5GTEFVnt66hiKhb9d4%2BxkCSXZ2cc%3D)
 
2.	In the left side navigation pane, under **INSTANCES**, choose **Launch Templates**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/19.png?st=2019-11-25T12%3A00%3A03Z&se=2026-11-26T12%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=z7qcGozwiPyzV%2Br5wPouOR6NtFRKOqVkrrPabrD4RtU%3D)

3.	Choose **Create launch template**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/20.png?st=2019-11-25T12%3A00%3A22Z&se=2025-11-26T12%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=794%2BNcrxa7clwJu9CnrV35Sn8Ws606UBzgBMxiwsH3k%3D)

4.	For Launch template name, enter a name **Autoscaletemplate**.

5.	For Template version description, enter a description for the initial version of the launch template to help you remember what this template is used for. Enter description **launch template for an Auto Scaling group**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/21.png?st=2019-11-25T12%3A00%3A40Z&se=2026-11-26T12%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bjScOUfd4fTCTwqXUmQZ6Tla2iJ4PX4J2IeE%2Fx7cxQA%3D)

6.	For **AMI ID**, choose a version of **Amazon Linux 2 (HVM),SSD Volume Type** from the **Quick Start** list. The Amazon Machine Image (AMI) serves as basic configuration templates for your instances.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/22.png?st=2019-11-25T12%3A01%3A00Z&se=2030-11-26T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hX5Q22xUtprBqlwOxgdIxFpcfqOMZTPgq1x9i0Zb80M%3D)
 
7.	For **Instance type**, choose a hardware configuration that is compatible with the AMI that you specified. Select **t2.micro** from the dropdown list.

8.	For **Key pair name**, keep the default Don’t include in launch template because you won't connect to your instance as part of this tutorial.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/23.png?st=2019-11-25T12%3A01%3A23Z&se=2026-11-26T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kgY%2FgX0p8AZFkH7b3kkGascOh41Wj65paMRk3z68wag%3D)

9.	For **Network type**, choose **VPC**.

10.	Skip **Security Groups** to configure a security group in the next step. When a network interface is specified, the security group must be a part of it.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/24.png?st=2019-11-25T12%3A01%3A45Z&se=2025-11-26T12%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ohDfcKZ7K9Q8GWeAkMBbQ6KH6hoC%2FX7N3ZTVr8ttrMA%3D)
 
11.	For **Storage (Volumes)**, specify volumes to attach to the instances in addition to the volumes specified by the AMI you specified. You just keep the default volume.

12.	For **Instance Tags**, specify one or more tags to associate with the instances and volumes.

Click on **Add tag**

   * Enter **Key** as **Name**
   * Enter **Value** as **AutoscaleEC2** 
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/25.png?st=2019-11-25T12%3A02%3A03Z&se=2026-11-26T12%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8K95rW%2B%2F5IvkpQI5%2FVuotUxEvwo5%2B62BicZ%2BEYrwLao%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/26.png?st=2019-11-25T12%3A02%3A28Z&se=2026-11-26T12%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZhSw%2B5JIYIM%2FEQIl6mJPHUkud%2Bz0i7gxdPmCVxdJQHU%3D)
 
13.	Scroll down For **Network interfaces**, do the following to specify the primary network interface:

   - Choose **Add network interface**.

   - To **assign public IP** addresses to instances in a nondefault VPC, for **Auto-assign public IP**, choose **Enable**. This allows your instances to      communicate with the internet and other services in AWS.

   - For **Security group ID**, specify the security group ID which you created security group in before and copied for the network interface.

   - For **Delete on termination**, choose **Yes** whether the network interface is deleted when the Auto Scaling group scales in and terminates the instance to which the network interface is attached.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/27.png?st=2019-11-25T12%3A02%3A50Z&se=2025-11-26T12%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AH6%2F0scJxI2MyrNnMZhb8Y9CPGtiCfoMQ%2B5oXImOuH8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/28.png?st=2019-11-25T12%3A03%3A09Z&se=2026-11-26T12%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ayhsl2qYOMXhnl5%2BrPS6owfZz80JfVheOQJgyT8GE0w%3D)

14.	Choose **Create launch template**.

15.	On the confirmation page, you can see **Successfully created Autoscaletemplate** message.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/29.png?st=2019-11-25T12%3A03%3A28Z&se=2026-11-26T12%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Fhit3NEunA2x%2BubrqkEczCkW377E452P8Bt3DKrjEqg%3D)

## Excercise-2: Create an Auto Scaling Group

When you create an Auto Scaling group, you include information such as the subnets for the instances and the initial number of instances to start with.
Follow the below procedure to continue after creating the launch template.

1.	Click on **Services**, select **EC2** under **Compute** section.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/30.png?st=2019-11-25T12%3A03%3A52Z&se=2026-11-26T12%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ogisGs0I9rmwOD6LxRUjmp7oNbajeQN32PAzUl7JEDo%3D)
 
2.	In the left side navigation pane, under **AUTO SCALING**, Choose **Auto Scaling Groups**, Click on **Create Auto Scaling group**. 

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/31.png?st=2019-11-25T12%3A04%3A10Z&se=2025-11-26T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fwONG3gBs5y3T0oyTlupj9EokeVX7CJjw%2FMTgF4pEUk%3D)
 
3.	Select the **Launch template**, then click on **Next Step**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/32.png?st=2019-11-25T12%3A04%3A27Z&se=2025-11-26T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cdCjgXb9i3xozNszNWMyl0JOh%2BZcM1rkqCwY1D8U9Bc%3D)
 
4.	For the **Configure Auto Scaling group** details step, 

	- **Group name**, type a name for your Auto Scaling group as **autoscaletest**

	- [Launch template] For **Launch template version**, choose **latest** whether the Auto Scaling group uses the default, the latest, or a specific version of   the launch template when scaling out.

    - [Launch template] For **Fleet Composition**, choose **Adhere to the launch template**.

	- Keep **Group size** set to the default value of **1** instance for this tutorial.

	- **Network** select **autoscalevpc** from dropdown which you created before.

	- For **Subnet**, choose **autoscalesubnet** from the VPC.

	- Choose **Next: Configure scaling policies**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/33.png?st=2019-11-25T12%3A04%3A47Z&se=2028-11-26T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X7HQs6Ka%2Fd07fyu%2FLw2hPJpK%2FaYACt%2FFCuXxiNkRT4o%3D)
 
5.	On the **Configure scaling policies** page, select **Keep this group at its initial size** and choose **Review**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/34.png?st=2019-11-25T12%3A05%3A17Z&se=2025-11-26T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ULekzIc8Pu4qriLvUw76LfsS2ESxZq6etzpD7YDggZ8%3D)
 
6.	On the **Review** page, choose **Create Auto Scaling group**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/35.png?st=2019-11-25T12%3A05%3A39Z&se=2025-11-26T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1eYTmdK2uF9p43GFXG%2BZh7J35KSP9ak5q5alH8i8luw%3D)

7.	On the **Auto Scaling group creation status** page, choose **Close**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/36.png?st=2019-11-25T12%3A05%3A59Z&se=2026-11-26T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kvPkCami0wfGyUhCaYlsw0N%2Bur6nSdNWgmopk6VaWzs%3D)
 
## Excercise-3: Verify Your Auto Scaling Group 

Now that you have created your Auto Scaling group, you are ready to verify that the group has launched an EC2 instance.

### Task: 1 To verify Auto Scaling group has launched an EC2 instance

1.	On the **Auto Scaling Groups** page, select the Auto Scaling group that you just created.

2.	The **Details** tab provides information about the Auto Scaling group.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/37.png?st=2019-11-25T12%3A06%3A17Z&se=2025-11-26T12%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pIgBKPKdDU2G%2BLzZKEPXXRaPEOcN6aslljnBBNIEAFk%3D)
 
3.	On the **Activity History** tab, the **Status** column shows the current status of your instance. While your instance is launching, the status column shows **In progress**. The status changes to Successful after the instance is launched. You can also use the refresh button to see the current status of your instance.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/38.png?st=2019-11-25T12%3A06%3A37Z&se=2025-11-26T12%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TfKBl%2FHsnuwIlRsJjSLBaG08LcDFcM3IYTIabkJs9n0%3D)
 
4.	On the **Instances** tab, the **Lifecycle** column shows the state of your instance. You can see that your Auto Scaling group has launched your EC2 instance, and that it is in the **InService** lifecycle state. The **Health Status** column shows the result of the EC2 instance health check on your instance.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/39.png?st=2019-11-25T12%3A06%3A57Z&se=2026-11-26T12%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dyBf8uZJPTzk0a3ZnbPVxMNemfbS%2FCBimK2ZZeSPduI%3D)

### Task2: Terminate an Instance in Your Auto Scaling Group

The minimum size for your Auto Scaling group is one instance. Therefore, if you terminate the running instance, Amazon EC2 Auto Scaling must launch a new instance to replace it.

1.	On the Instances tab, select the **ID of the instance**. This shows you the instance on the Instances page.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/40.png?st=2019-11-25T12%3A07%3A18Z&se=2025-11-26T12%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bT3VqA%2B%2Bw3CUFZVg14m3H%2BdSYgylq6ar35If6UslolU%3D)

2.	Choose **Actions**, Instance State, **Terminate**. When prompted for confirmation, choose **Yes, Terminate**.
 
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/41.png?st=2019-11-25T12%3A07%3A37Z&se=2026-11-26T12%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7du3EQ%2F9bhujS3SFxyCsQqZVBaxajRS4wmOnfBrGOJo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/42.png?st=2019-11-25T12%3A10%3A24Z&se=2026-11-26T12%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=V2E0JaCyv8aRR523h2w9h7Zc%2BBA36pz9WoUzhcoXBB8%3D)

3.	On the navigation pane, choose **Auto Scaling Groups**. Select your Auto Scaling group and choose the **Activity History** tab. The default cooldown for the Auto Scaling group is 300 seconds (5 minutes), so it takes about 5 minutes until you see the scaling activity. Refersh the aws console to see the changes.

4.	When the **scaling activity** starts, you see an entry for the termination of the first instance and an entry for the launch of a new instance. The **Instances** tab shows the new instance only.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/43.png?st=2019-11-25T12%3A10%3A48Z&se=2025-11-26T12%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iQu6lqAzJwp%2FfVyC81oylSjQLx1vMAPUGd4znkro7Xs%3D)
 
5.	On the navigation pane, choose **Instances**. This page shows both the **terminated** instance and the **running** instance.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/44.png?st=2019-11-25T12%3A11%3A05Z&se=2025-11-26T12%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9ULlUVtOqlWx40LEOWbIia3JKu8ACFgwY%2BT1nNldd5o%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Ec2%20Autoscaling/45.png?st=2019-11-25T12%3A11%3A23Z&se=2025-11-26T12%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Rm254oNk05442XWWLjqQbD2BpU7fTJqQR8QvUyKX4LY%3D)

> **Result:** After completing this lab, you would be able to create a launch template, create a autoscaling group and associate it with your VPC. You can also do the auto scale of your Ec2 instance when it is terminated.
