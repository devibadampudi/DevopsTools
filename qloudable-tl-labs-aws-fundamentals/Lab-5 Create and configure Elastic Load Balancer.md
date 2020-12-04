# Create and Configure Elastic Load Balancer

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Create a Classic Load Balancer](#exercise-2-create-a-classic-load-balancer)

[Exercise 3: Create a Application Load Balancer](#exercise-3-create-a-application-load-balancer)

## Overview

The aim of this lab is to create and Configure Classic and Application Load Balancer.

**Elastic Load balancer:**

Elastic Load Balancing distributes incoming application or network traffic across multiple targets, such as Amazon EC2 instances, containers, and IP addresses, in multiple Availability Zones.

**Elastic Load Balancing supports three types of load balancers:**

1.	Classic Load Balancers.
2.	Application Load Balancers
3.	Network Load Balancers

**Classic Load balancer:**

A load balancer distributes incoming application traffic across multiple EC2 instances in multiple Availability Zones. This increases the fault tolerance of your applications. Elastic Load Balancing detects unhealthy instances and routes traffic only to healthy instances.

**Application Load Balancer:**

An Application Load Balancer functions at the application layer, the seventh layer of the Open Systems Interconnection (OSI) model. After the load balancer receives a request, it evaluates the listener rules in priority order to determine which rule to apply, and then selects a target from the target group for the rule action. You can configure listener rules to route requests to different target groups based on the content of the application traffic. Routing is performed independently for each target group, even when a target is registered with multiple target groups.

**Listener:** A listener checks for connection requests from clients, using the protocol and port that you configure.

**Target Group:** Each target group routes requests to one or more registered targets, such as EC2 instances, using the protocol and port number that you specify. You can register a target with multiple target groups. You can configure health checks on a per target group basis.

**Listner Rule:**

The rules that you define for your listener determine how the load balancer routes requests to the targets in one or more target groups.


### Scenario and Objectives

1. Create a Classic Load Balancer

2. Create a Application load Balancer

## Pre-Requisites

* 4 EC2 instances

## Exercise 1: Login to AWS Console

1. Navigate to **chrome** on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select AWS Management console.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Use below credentials to login to AWS console.

 **Account ID:** {{Account ID}} <br>
 **IAM username:** {{username}} <br>
 **Password:** {{password}} <br>
 **Region:** {{region}}

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Enter **Account ID** from the above information, then click on Next.

5. Enter **IAM username** and **Password** from the above information and click on Sign In.

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. In the navigation bar, on the top-right region dropdown, select below region.

 * Region: {{region}}

## Exercise 2: Create a Classic Load Balancer

1.	On the navigation pane, under **LOAD BALANCING**, choose **Load Balancers**.

2.	Choose **Create Load Balancer**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/1.png?st=2019-11-26T07%3A11%3A53Z&se=2022-11-27T07%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2Mtuxiq2g23WW85M5wJt%2FYg0ql%2BVBPFuIgUlVJyhqis%3D)

3. For **Classic Load Balancer**, choose **Create**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/2.png?st=2019-11-26T07%3A12%3A31Z&se=2022-11-27T07%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y1ftuyy17u7ItuWXniAZEEEOiowBLacZ%2Btu99lzPLbM%3D)

4.	Define the below following details

```

    Load Balancer name:  Type a name for your load balancer.
    
    Create LB inside: Select the Existing VPC
    
    Listener configuration: Leave the default listener configuration.
```

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/3.png?st=2019-11-26T07%3A12%3A56Z&se=2022-11-27T07%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PD1pwMpuYV8DPRrOvHTqyXWkzRumsvuqjelIFUBHyuY%3D)

5.	For Available subnets, select available public subnet using its **add icon**. The subnet is moved under Selected subnets.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/4.png?st=2019-11-26T07%3A13%3A21Z&se=2022-11-27T07%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mcmhIYsNK%2FaYRoHRxujtUmnvkIOTgqj3yau%2FPkd%2BmnE%3D)

6.	Choose **Next: Assign Security Groups**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/5.png?st=2019-11-26T07%3A13%3A47Z&se=2022-11-27T07%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EZFRg53FQ%2Fso4DGB46zULGOMuHQF3ri3xVmKwiN1NAQ%3D)

7.	Define the below following details.

```
    Assign a security group:  Select Create a new security group.
    Security group name: Type a name for your Security group.
    Description: Type a name for your Description.
    
 ```

8.	Choose **Next: Configure Security Settings.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/6.png?st=2019-11-26T07%3A14%3A24Z&se=2022-11-27T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iYmAlKoIXduuVqU7kh9XiYNjSPyKhnP6tdq%2FSBau%2Fjs%3D)

9.	Choose **Next: Configure Health Check.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/7.png?st=2019-11-26T07%3A14%3A46Z&se=2022-11-27T07%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gp1aldf37bnub2HRsSOPo9jL9htwRWh%2FMSfjXPFBL6g%3D)

10.	Define the below following details

```
    Ping Protocol: HTTP
    Ping Port: 80
    Ping Path: /
    
 ```

11. For **Advanced Details**, leave the default values. and choose **Next: Add EC2 Instances**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/8.png?st=2019-11-26T07%3A15%3A04Z&se=2022-11-27T07%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FmR0JkxECDfXFGE2Opfb65SIM2C0DgSFtsxuk46Hi1c%3D)

12. On the **Add EC2 Instances page,** select the instances to register with your load balancer.

13. Choose **Next: Add Tags.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/9.png?st=2019-11-26T07%3A15%3A26Z&se=2022-11-27T07%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DTOSzzcFEMug7bTHKmGcb7%2B3mR24RC%2FCiCqJMw81IJk%3D)

14. On the **Add Tags page**, specify a key and a value for the tag. Choose **Review and Create.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/10.png?st=2019-11-26T07%3A15%3A48Z&se=2022-11-27T07%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SqWzAQvkfBpDgsIWVyOn0a6euxDCQMB2QJeyRFVRyxQ%3D)

15.	On the **Review** page, choose **Create.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/11.png?st=2019-11-26T07%3A16%3A06Z&se=2022-11-27T07%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZqHf2SZQxJqBEeDoSeUPNxGg4lRewNb9vJ%2F8%2B31ScEg%3D)

16.	Choose **Close.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/12.png?st=2019-11-26T07%3A16%3A27Z&se=2022-11-27T07%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=j0oHFP%2BLIIfCXtKuZFcAz1z3lzbl0U5nh56phCxnxmg%3D)

17.	Select your new load balancer and Copy the DNS Name.

18.	Paste it in Browser.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/13.png?st=2019-11-26T07%3A16%3A46Z&se=2022-11-27T07%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=IEOYoMg8VfgwFLLxDrpAO9SM8cxbmD3coj81FPhn1ZU%3D)

19.	You can able to see the Application running in your EC2 instance

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/14.png?st=2019-11-26T07%3A17%3A05Z&se=2022-11-27T07%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fhMbRK0AjmbjEiNixFwxWYB0oWFrNOfwQ1GQ3%2Fef2yc%3D)

## Exercise 3: Create a Application Load Balancer

1. On the navigation pane, under **LOAD BALANCING**, choose **Target Groups**.

2. Choose **Create Target group.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/15.png?st=2019-11-26T07%3A17%3A27Z&se=2022-11-27T07%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AXdP1uJ5pP1jNpnebIb7JVZ0k88ldlfaB5BZMGFIJsg%3D)

3. Give the below following details.

```
Target group name: Type a name for the target group(Bank-TG).
Target Type: Instance
Protocol: HTTP
Port: 80
VPC: Select the Existing VPC

Health Check Settings:
Protocol: HTTP
Path: /

```

4. Click on **Create.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/16.png?st=2019-11-26T07%3A17%3A44Z&se=2022-11-27T07%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=c9SpoDrM6py0HpL8%2FeC8nUnrlEdty47HbXRyA2QCXJQ%3D)


5. Click on **Close.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/17.png?st=2019-11-26T07%3A18%3A02Z&se=2022-11-27T07%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=d5hw1ScmYdnYwGX76UW0sdFnqkTVt%2FuMAv2yOcwxszw%3D)

6.	**Bank-TG** Created Successfully.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/18.png?st=2019-11-26T07%3A18%3A27Z&se=2022-11-27T07%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eIexXx30WqmufAl7sb7hVL2fFRu2j5o7ENQLw44tHf0%3D)

7.	Choose **Create Target group.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/19.png?st=2019-11-26T07%3A18%3A47Z&se=2022-11-27T07%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7xmTG3tUNcHSwv7p2UmpownmPO7O4z33jnddDLMFDNc%3D)

1. Give the below following details

```
Target group name: Type a name for the target group (Loan-TG).
Target Type: Instance
Protocol: HTTP
Port: 80
VPC: Select the Existing VPC

Health Check Settings:
Protocol: HTTP
Path: /

```

9. Click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/20.png?st=2019-11-26T07%3A19%3A08Z&se=2022-11-27T07%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mQAOvBFmc0nkEaWpeezgYgp2yvhg59kuG3%2FtJ8FnKqM%3D)

10.	Click on **Close**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/21.png?st=2019-11-26T07%3A19%3A29Z&se=2022-11-27T07%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xaq98dKU0udCCwic%2BB8TtRKH%2BAK%2FnQx4%2Fsnn%2FcKZMzo%3D)

11.	**Loan-TG** Created Successfully.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/22.png?st=2019-11-26T07%3A19%3A49Z&se=2022-11-27T07%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hecLb3zwLYSmjuLMhxWEO3zPUUavCm72DBWy9zHV1dA%3D)

12.	Select the **Bank-TG**, under that click on the **Targets** then choose **Edit**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/23.png?st=2019-11-26T07%3A20%3A11Z&se=2022-11-27T07%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i3ukm251%2BsddJC7uk6NW%2Fq0%2FFbKvYEboCVfCBcIgeaw%3D)


13.	Select 2 Instances from **Same Availability Zone** (us-east-2a)

14.	Click on **Add to registered.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/24.png?st=2019-11-26T07%3A20%3A29Z&se=2022-11-27T07%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Bn2aCKoVThXDGDErdpdBUPUmaI56VTE7NZPXobCF8zs%3D)


15.	Click on **Save.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/25.png?st=2019-11-26T07%3A20%3A50Z&se=2022-11-27T07%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wxZJ7ayRlXXZpPJ%2BtubsqEJGImMuFTD9rVpfNorNoRg%3D)

16.	The 2 instances are added in **Bank-TG** Successfully.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/26.png?st=2019-11-26T07%3A21%3A09Z&se=2022-11-27T07%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=URqURqk0YIIAIXzJMFM50vJLjLeVeLCYtX%2F3vKnLZiQ%3D)


17.	Select the **Loan-TG,** under that click on the **Targets** then choose **Edit.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/27.png?st=2019-11-26T07%3A21%3A26Z&se=2022-11-27T07%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3lLPXvM17NYcayDs8xxBucPfx94vvIzOWWZwuABukVI%3D)


18.	Select 2 Instances from **Same Availability Zone** (us-east-2b)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/28.png?st=2019-11-26T07%3A21%3A48Z&se=2022-11-27T07%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uZzMIGCC4nFo53yJ7%2FtLLAPER4piNVIF%2B7YFLrfDM6Y%3D)

19.	Click on **Add to registered** and **Save.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/29.png?st=2019-11-26T07%3A22%3A05Z&se=2022-11-27T07%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wu%2F7mRpSX976K5vR4RZMRr046EoU7%2BZXYPuF51uAYEY%3D)


20.	The 2 instances are added in **Loan-TG** Successfully.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/30.png?st=2019-11-26T07%3A22%3A24Z&se=2022-11-27T07%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1x4KzA%2BSwt8ePZaVG%2FGhcawevnhpbOuM%2BRKnzXPU6BU%3D)

21.	On the navigation pane, under **LOAD BALANCING**, choose **Load Balancers**.

22.	Choose **Create Load Balancer.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/31.png?st=2019-11-26T07%3A22%3A42Z&se=2022-11-27T07%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HXyLvNfWRWErvVEgCOi6wVcArKf%2Bw72vGNyYpmwVWXA%3D)

23.	For **Application Load Balancer**, choose **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/32.png?st=2019-11-26T07%3A22%3A58Z&se=2022-11-27T07%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Bls3V92hAhNuxqZ0qJU5Oq%2B9zt5hOI8DUskbNU5ZarI%3D)

24.	Define the below following details

```
Load Balancer name: Type a name for your load balancer
Create LB inside: Select Existing VPC

```
![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/33.png?st=2019-11-26T07%3A23%3A16Z&se=2022-11-27T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ISXwKjrbtOQ0KJLrI2w4ciz63NkxIio22KUucBjnYk0%3D)

25.	Select two Availability Zones from your VPC and Choose **Next: Configure Security Settings**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/34.png?st=2019-11-26T07%3A23%3A58Z&se=2022-11-27T07%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=V7472Is2A2e9I6aGGYCIlWhrTMYFfi2qKGw2S7vu1a0%3D)


26.	Choose **Next: Configure Security Groups.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/35.png?st=2019-11-26T07%3A24%3A21Z&se=2022-11-27T07%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B5wa%2FtuOdfy730183IP1JJbQ1HfDDDxwl0X%2FGSgC34Y%3D)


27.	Choose **Create a new security group**.

```

Security group name: Type your security group name
Description: Description for the security group

```

28.	Choose **Next: Configure Routing.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/36.png?st=2019-11-26T07%3A24%3A42Z&se=2022-11-27T08%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y5QlDWVNP1dWIp7dM38PtDWNv11tRDion%2Bf1WOzo%2FiI%3D)

29.	Define below following details.

```
Target Group
Target group: Existing target group
Name: Select Created Target group
Target type: Instance
Protocol: HTTP
Port: 80

Health Checks:
Protocol: HTTP
Path: /

```

30.	Choose **Next: Register Targets.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/37.png?st=2019-11-26T07%3A25%3A13Z&se=2022-11-27T07%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vz1Daq3c99bgjgniUgYz0SRy5%2BU0ZNzcpdcir6j%2F3K8%3D)

31.	Choose **Next: Review.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/38.png?st=2019-11-26T07%3A25%3A34Z&se=2022-11-27T07%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=U8cbhBzMvVUSeBywxW8z2c3AXz1ywT36lF5BZatVifY%3D)

32.	On the **Review page**, choose **Create.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/39.png?st=2019-11-26T07%3A26%3A04Z&se=2022-11-27T07%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vAuolKPAL90oOFZ5R5IJnmBYST8gk4KGpl6ptAHbGJk%3D)

33.	After the load balancer is created, choose **Close.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/40.png?st=2019-11-26T07%3A26%3A22Z&se=2022-11-27T07%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fN4YvOr7f2C9ecwue%2B%2BhvSJ7xyuWwx9HH50OX1HEPrU%3D)


34.	Load Balancer is created Successfully.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/ELB/41.png?st=2019-11-26T07%3A40%3A10Z&se=2022-11-27T07%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AuT1Avgsclbn4ge4awKra8FRty04ygqzEVFZPUnmsww%3D)
