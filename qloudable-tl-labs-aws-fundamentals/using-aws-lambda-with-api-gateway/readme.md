# Using AWS Lambda with API Gateway

# Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Login to AWS Console](#login-to-aws-console)

[Create AWS Lambda function](#create-aws-lambda-function)

[Test the function](#test-the-function)

[Create and Configure API Gateway connecting to AWS Lambda](#create-and-configure-api-gateway-connecting-to-aws-lambda)

[Deploy API gateway and get function endpoint](#deploy-api-gateway-and-get-function-endpoint)

## Overview

What is AWS Lambda?

Amazon Web Services (AWS) Lambda is an on-demand compute service that lets you run code in response to events or HTTP requests.

You can run scripts and apps without having to provision or manage servers in a seemingly infinitely-scalable environment where you pay only for usage. This is "serverless" computing in a nut shell. For our purposes, AWS Lambda is a perfect solution for running user-supplied code quickly, securely, and cheaply.

By the end of this lab you will be able to…

* Create AWS Lambda function through AWS Console
* Test the function
* Create and Configure API Gateway connecting to AWS Lambda
* Trigger an AWS Lambda function from API Gateway

## Pre-Requisites

* you have some knowledge of basic Lambda operations and the Lambda console.
* Basic knowledge on API Gateway 

## Login to AWS Console

1. Navigate to chrome on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select **AWS Management console**.

3. Use below credentials to login to AWS console.

    - Account ID: {{Account ID}}
    - IAM username: {{user name}}
    - Password: {{password}}
    - Region: {{region}}
 

4. Enter **Account ID** from the above information, then click on **Next**.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/1.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Enter **IAM username** and **Password** from the above information and click on **Sign In**

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/2.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Once you provide all that information correctly you will see the AWS-management console dashboard.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/3.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. In the navigation bar, on the top-right region dropdown, select below region.

    * Region: {{region}}

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/4.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Create AWS Lambda function

1. Click on **Services**, Click on Lambda under compute section.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/5.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Click on **Create function**

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/6.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Select **Use a blueprint**, search for **hello-world** and select **hello-world-python** from search results.

4. Click on **Configure**

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/7.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Fill the details as below
   * Function name: hello-world-python
   * Execution role: select **Use an existing role**
   * Existing role: {{iam-role}} (Role is to give permission for lambda to access required resources)
   
![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/8.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

   Then click on **Create function** at bottom of page.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/9.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. After Creation of function you are navigated to your lambda function, here you can see properties of function like Designer, Function code and others.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/10.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

   This lambda function taking three input values as input and returns value1 out of these three values

   On next section we will test the function manually.

## Test the function

To test the Lambda function manually, we need to create a event and click test on console. Follow the below steps to test the function.

1. Click on **select a test event** dropdown box (at Top-Right of console) and select**Configure test events** 

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/11.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Configure the test evet with below details 
   * Event name: TestFunctionEvent
   * On code block, leave defaults. These value1,value2 and value3 are passing as input parameters.
   
   Then Click on **Create**

   ![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/12.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Now, Hit **Test** button, It runs the function through test event, You can see **Execution result** on top of page. 

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/13.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Click on details, here you can see the result returned by your function execution. 

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/14.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

## Create and Configure API Gateway connecting to AWS Lambda

We are done with creating Lambda Function but how to invoke the function from external world? We need an endpoint, right? Here comes Amazon API Gateway. The gateway is also fully managed service which acts as "front door" for applications sitting behind on Lambda, EC2. It abstracts traffic management, authorization and access control, monitoring, and API version management providing a https gateway URL that make it easy to serve applications in few minutes.

In this section we are going to create and configure API Gateway and connecting to existing AWS Lambda.

1. Click on Services (at Top-left of console), Search for **API gateway** and select API gateway from the options.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/15.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Click on **Get Started**  if no gateway present on console, other wise Click on create API gateway. Press **ok** for any popup window when click on **Get started.**

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/16.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3.  select **New API** 

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/17.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4. Fill the below details 

   * **API name:** testLambda
   * **Description** API gateway for hello-world lambda function
   * **Endpoint Type**  Regional. 

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/18.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

   Then Click on **Create API**. After Creating API you will be navigated to created API gateway. here you are going to create a resource and Post method to trigger the lambda function from API manually.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/19.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. On the **Actions** dropdown, Click **Create Resource**. 

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/20.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Fill **Resource Name as testLamdba**  and then click **Create Resource**.  Next create a Post method under the created resource

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/21.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7.  On the **Actions** dropdown, Click **Create Method** and then Select **Post** From the dropdown list and click **Right Tik mark**

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/22.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

8. Enter lambda function name which you created earliar in the **Lambda function** text box and click save. Click ok for **Add Permission to Lambda Function** popup.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/23.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

9. Click on **TEST** to trigger lambda function from API.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/24.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

10. On **Request Body** box past below code and click **test**. It will trigger the lambda function.

```
{
  "key1": "value1",
  "key2": "value2",
  "key3": "value3"
}
```

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/25.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

11. On Right side of the page you can see the result of triggered function.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/26.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

On Next section we will deploy the API gateway and through curl command we will access the lambda function.

## Deploy API gateway and get function endpoint

To get API gateway endpoint, We need to deploy the API. 

1. On the **Actions** dropdown, click on **Deploy API** under API Actions.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/27.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

2. Fill in the new pop with below details 
   
   * Deployment stage: select **New stage**
   * Stage name : **test**

leave remaining fields empty or fill with appropriate description

   Click **Deploy** then Click **Save Changes**
   
![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/28.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)   

3. Exand test and click on **POST**(Ingnore warning). API gateway will generate a random subdomain for the API endpoint URL, and the stage name will be added to the end of the URL. You should now be able to make POST requests to a similar URL:  : https://kqfz1lukm0.execute-api.us-west-2.amazonaws.com/test/testlambda

4. copy the **Invoke URL** Test this via cURL

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/29.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

5. Click on **Apps Icon** and open **Git bash**

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/30.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

6. Run below command to sends the POST request to the API Gateway endpoint. In below command, replace ```<Invoke URL>``` with copied URL 

    ```curl -s -X POST -d "{ \"key1\": \"Value1\", \"key2\": \"value2\", \"key3\": \"value3\" }"  <Invoke URL>```

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/31.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

7. The abouve Command will trigger the Lambda function and gives the result as shown bleow.

![](https://qloudableassets.blob.core.windows.net/aws-fundamentals/using-aws-lambda-with-api-gateway/images/32.PNG?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)
