# Create Service Bus using Azure Portal and Service Bus High Availability

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1:Create Service Bus using Azure Portal](#excercise-1-create-service-bus-using-azure-portal)

[Excercise-2:Routing data from IoT Hub to Service bus Queue](#excercise-2-routing-data-from-iot-hub-to-service-bus-queue)

[Excercise-3:Message routing](#excercise-3-message-routing)

[Excercise-4:Service Bus High Availability (Geo-Disaster recovery)](#excercise-3-service-bus-high-availability (Geo-Disaster recovery))

## Overview 

The aim of this lab is to create and configure Azure Service and High availability to Azure Service bus.

## Introduction to Azure Service Bus

**Azure Service Bus**

Azure Service Bus is a messaging service hosted on the Azure platform that allows exchanging messages between various applications in a loosely coupled fashion. The service offers guaranteed message delivery and supports a range of standard protocols (e.g. REST, AMQP, WS*) and APIs such as native pub/sub, delayed delivery, and more. Messages are in a binary format, which can contain JSON, XML or just text.

**Namespaces:**

A namespace in Service Bus is a way of scoping your service bus entities so that similar or related services can be grouped together.  Within a Service Bus Namespace, you can create several different types of entities: queues, topics, relays and notification hubs.

**Queues:**

Messages are sent to and received from queues. Queues enable you to store messages until the receiving application is available to receive and process them.
Messages in queues are ordered and timestamped on arrival. Once accepted, the message is held safely in redundant storage. Messages are delivered in pull mode, which delivers messages on request.

**Topics:**

You can also use topics to send and receive messages. While a queue is often used for point-to-point communication, topics are useful in publish/subscribe scenarios.
Topics can have multiple, independent subscriptions. A subscriber to a topic can receive a copy of each message sent to that topic. Subscriptions are named entities, which are durably created but can optionally expire or auto-delete.

## Pre-Requisites

*   Azure portal Access.
*   Familiar with Azure portal.

**Note**: Azure Portal access is provided as part of the Lab environment

## Create Service Bus using Azure Portal

1.Using the Chrome browser, login into Azure portal with the below details.
**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal1.png?sv=2019-10-10&st=2020-10-20T05%3A34%3A03Z&se=2023-10-21T05%3A34%3A00Z&sr=c&sp=rl&sig=6nBiiism12QCIjGbAHN1IK3XQ9%2FQXIF9DVdgOXdwxQM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal2.png?sv=2019-10-10&st=2020-10-20T05%3A34%3A03Z&se=2023-10-21T05%3A34%3A00Z&sr=c&sp=rl&sig=6nBiiism12QCIjGbAHN1IK3XQ9%2FQXIF9DVdgOXdwxQM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal3.png?sv=2019-10-10&st=2020-10-20T05%3A34%3A03Z&se=2023-10-21T05%3A34%3A00Z&sr=c&sp=rl&sig=6nBiiism12QCIjGbAHN1IK3XQ9%2FQXIF9DVdgOXdwxQM%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal4.png?sv=2019-10-10&st=2020-10-20T05%3A34%3A03Z&se=2023-10-21T05%3A34%3A00Z&sr=c&sp=rl&sig=6nBiiism12QCIjGbAHN1IK3XQ9%2FQXIF9DVdgOXdwxQM%3D)

Go to **Azure Portal**, click on **+Create a Resource**, Search for **Service Bus** then select the Service Bus from the drop down.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/1.png?st=2019-10-25T11%3A40%3A27Z&se=2022-10-26T11%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=YHFGZbnEb1XiUKUYmx0LuUeW%2B9c38S95P%2BBzdSS3tAA%3D)

Click on **Create** and continue to next steps of creating Service Bus.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/2.png?st=2019-10-25T11%3A40%3A55Z&se=2022-10-26T11%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QqHJJiarC%2BCYrBxBeGupEl8Um8Oa%2BFJ9Etl7LqeQCgk%3D)

On the next section **Create Namespace**, fill in the fields as instructed below.

```
Name: Enter a unique name for the namespace.

Pricing tier: Select the pricing tier (Basic, Standard, or Premium) for the namespace. If you want to use topics and subscriptions, choose either Standard or Premium as topics/subscriptions are not supported in the Basic pricing tier.

Messaging units: Specify the number of messaging units.

```
`Subscription`: select the default subscription.

`Resource group`: {{resource-group-name}}

`Location`: {{location}}

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/3.png?st=2019-10-25T11%3A41%3A25Z&se=2022-10-26T11%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xx9%2BwfaWUU3QEcy6vjh%2Fd4as3ExAIpbuO2%2BdtxkpKzw%3D)

You’ll receive a notification on a successful deployment as shown in the screenshot below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/4.png?st=2019-10-25T11%3A41%3A54Z&se=2022-10-26T11%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PJgnu110xzmBFxZ4gbbZS5SdWU2jgq5heuWHVgqgQOQ%3D)

**Create Queue**

Go to **Resource group** and select your **service bus namespace**.

Click on **Queues** under Entities section on the navigation pane and select **+ Queue**

Enter a Name for the queue and proceed to **create**, leaving all the other fields to their defaults.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/5.png?st=2019-10-25T11%3A42%3A16Z&se=2022-10-26T11%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0ujpbCQj8Bj2s5FwmJjNq1usyeU%2F6ovzjwEaRN014zY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/6.png?st=2019-10-25T11%3A43%3A37Z&se=2022-10-26T11%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pCymJcul6HiGGWNg3%2BYwzkL7E%2FxnEeoCYueCWt7%2Fz1g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/7.png?st=2019-10-25T11%3A44%3A03Z&se=2022-10-26T11%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v89OIpN3YVIJqPeI3WIjSgkgBxlL5gEl7zrBk25QSZA%3D)


## Routing data from IoT Hub to Service bus Queue

1. **Create an IoT Hub using Azure Portal**

Login to the **Azure Portal**.

Click on **+Create a resource**, search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/8.png?st=2019-10-25T11%3A44%3A45Z&se=2022-10-26T11%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ewH5IIRm%2FiUxHkqXp1u6inbby%2B2UcjYARRg8%2B7fca8g%3D)

Click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/9.png?st=2019-10-25T11%3A45%3A10Z&se=2022-10-26T11%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FygGljDZCeDQqBiU%2B8LLq9kfU80JeePDIk%2FIDqCV%2Fxw%3D)

Fill in the fields on next step as instructed below.

`Subscription`: Select the default subscription.

`Resource Group`: {{resource-group-name}}

`Region`: {{location}}

`IoT Hub Name`: The name of the IoT Hub must be unique, globally.

Click on **Next: Size and scale** to proceed on to next steps of creating IoT Hub.

Proceed to **Review + Create**, leaving all the fields to their defaults.

* **Pricing and scale tier:** You can choose from different pricing tiers available, depending on the features and number of messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. You can only deploy one solution per subscription on the free tier.

**Basic and Standard Tier:** You can use the basic tier for IoT solutions which require only uni-directional communication from the devices to Cloud and standard tier implementation for the solutions which require bi-directional communications. Apart from the working specifications, both the offerings possess same security and authentication features. 

Click **Next: Size and scale** to proceed further with creating IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/10.png?st=2019-10-25T11%3A45%3A29Z&se=2022-10-26T11%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qyKIpsC9pjkASiWeNSgSRfjUvELAmw50oiJIfuxo%2Fao%3D)
 
```
Pricing and scale tier: B1:Basic tier

```

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Lab2/28.PNG?st=2019-10-22T09%3A45%3A30Z&se=2022-10-23T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=FGnsVkizYvdjNm%2Bhy4Ewuyfrtdsga7OJT06BDSwHe1M%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Lab2/29.PNG?st=2019-10-22T09%3A45%3A30Z&se=2022-10-23T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=FGnsVkizYvdjNm%2Bhy4Ewuyfrtdsga7OJT06BDSwHe1M%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen. Click on **Go to resource**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Lab2/30.PNG?st=2019-10-22T09%3A45%3A30Z&se=2022-10-23T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=FGnsVkizYvdjNm%2Bhy4Ewuyfrtdsga7OJT06BDSwHe1M%3D)


2. **Create a device in IoT Hub:**

Go to **Resource group** -> Select the **IoT Hub** you just created.

Navigate to the IoT Devices from the menu and click on **Add** to register a new device.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/12.png?st=2019-10-25T11%3A46%3A58Z&se=2022-10-26T11%3A46%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xMVPws7aoWnOEEs82aBQLiYunkvmOm1m3zFEHQMMtV0%3D)

Enter the device name (Ex: device-1) and click on **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/13.png?st=2019-10-25T11%3A47%3A23Z&se=2022-10-26T11%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZV9v3xd%2BRMbkEA8lmtBitllAk8qsEDMLN9eJVJpOeFY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/h12.png?sv=2019-10-10&st=2020-10-20T09%3A09%3A59Z&se=2023-10-21T09%3A09%3A00Z&sr=b&sp=r&sig=ndqB3MitOimp55KWNau3SNldD5phU3jUbl62ooQrwqs%3D)

This will create a new device identity in IoT hub.

After the device is created, open the device from the list in the IoT devices pane. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/h13.png?sv=2019-10-10&st=2020-10-20T09%3A10%3A29Z&se=2023-10-21T09%3A10%3A00Z&sr=b&sp=r&sig=93pDMfmrCvF1A1W1T4PKr8nnQ2SlfQ8BY6Pw36Kfi5M%3D)

**Copy** the **Connection string (primary key)** and **save** them for later use.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/h14.png?sv=2019-10-10&st=2020-10-20T09%3A11%3A12Z&se=2023-10-21T09%3A11%3A00Z&sr=b&sp=r&sig=GxxxD%2BhFnRk4VKwwzcglA1ATl4v7RzKu8Ewjz9byLtw%3D)

3. **Sending data to IoT Hub using online PI simulator:** 

Launch the Raspberry Pi online simulator, clicking on the below link.

https://azure-samples.github.io/raspberry-pi-web-simulator/#GetStarted

In code editor window, make sure you are working on the default sample application. Remove the placeholder and update the Azure IoT Hub connection string value of **connectionString** variable.

Click on **Run** or type **npm start** to run the application.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/14.png?st=2019-10-25T11%3A47%3A42Z&se=2022-10-26T11%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=m08qodv5J0PcakGgCcffoQ2IUqNKQCKDZhKL4xwSuAI%3D)

Once the simulator is up and running, you can see the output of the sensor data and the messages, sent to connected IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/15.png?st=2019-10-25T11%3A47%3A58Z&se=2022-10-26T11%3A47%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3NLTSRDy458HVZcw2xylKprKJhK8EqmgPxOnaZkdbvc%3D)

4. **Check the data in IoT Hub:**

You can now see the messages started flowing into the IoT Hub from the Overview blade.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/16.png?st=2019-10-25T12%3A02%3A59Z&se=2022-10-26T12%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=geczXY0alfRz3UFHHD%2FrUBLoKAZF9FrlwMOEn%2FmE29Q%3D)

## Message routing

Go to **IoT Hub** -> Select **Message routing** -> Click on **Add** to add a route.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/17.png?st=2019-10-25T12%3A03%3A24Z&se=2022-10-26T12%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vLKN3kzD9MIXKNzhYnmsggueMZPdnO55gjopqoEy58k%3D)

**Name:** Enter a name for the route.

**Endpoint:** On the **Add a Route** section, click on **+Add** button, next to the Endpoint field to view the supported endpoints, as displayed in the below screenshot.

Select the **Service bus queue** from the drop-down, from which you’ll be redirected to another section, **Add a service bus endpoint**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/18.png?st=2019-10-25T12%3A04%3A16Z&se=2022-10-26T12%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3S%2BWbGY1iCC%2BNUNFCt9oO8FdBG8S8ZalQ4UIqOIa4kc%3D)

Enter a name for the endpoint.

Select the existing Service bus namespace and Service bus queue from the dropdown.

Now click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/19.png?st=2019-10-25T12%3A05%3A17Z&se=2022-10-26T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wgvoVp6GrIVfEMsH16fpQNZBuEGySUxwlwZzUhMpvcY%3D)

Now that you’re **back to** the **Add a route** section, make sure the Endpoint field is set to the name of Endpoint you just created and click on **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/20.png?st=2019-10-25T12%3A05%3A43Z&se=2022-10-26T12%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2F6StXfyiWZyMCmk13yqGM4%2Bqbq3GcX5h%2FGWFs4OXSfM%3D)

You can now verify the route added under the Routes tab.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/20.0.png?st=2019-10-25T12%3A08%3A55Z&se=2022-10-26T12%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZoJrYFzO%2F%2Fo7dExPwq57rnKTg5%2F%2Fm%2FNSyOHD%2BUr6Ia4%3D)

#### Check the routed data in Service Bus Queue:

You can now see the activity of routed data in the Service Bus Queue.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/21.1.png?st=2019-10-25T12%3A10%3A24Z&se=2022-10-26T12%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=W0ZUAB9TD6xjzYsHYGnl7V4yU9GX6zI%2BAW6U4dsOzQo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/21.png?st=2019-10-25T12%3A10%3A53Z&se=2022-10-26T12%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gs1PRpIHQjVepVPC2j1iFvlyHRFE7WCH1TPB5JB5mVk%3D)

## Service Bus High Availability (Geo-Disaster recovery)

Geo-Disaster recovery currently only ensures that the metadata (Queues, Topics, Subscriptions, Filters) are copied over from the primary namespace to secondary namespace, when paired.

When entire Azure region or datacenter (if no availability zones are used) experience downtime, it is critical for data processing to continue to operate in a different region or datacenter. Azure Service Bus supports geo-disaster recovery at the namespace level.

**Note:** *The Geo-disaster recovery feature is globally available for the Service Bus Premium SKU.*

Create a **Secondary** Service Bus Premium Namespace in a different region from where the primary namespace is created. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/22.png?st=2019-10-25T12%3A13%3A49Z&se=2022-10-26T12%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jSQZ2cKrwlYfU7tvTC15GScazNZcUnz0KvgwhSHH3Do%3D)

Create **pairing** between the Primary namespace and Secondary namespace to obtain the alias.

follow the below steps to create and pair the secondary namespace with the primary one.

  > Make sure to choose the Geo-paired region of your primary namespace location.

```
EX: eastus -- westus
    eastus2 -- central us
```
Refer the below link for Azure geo-paired regions.

https://docs.microsoft.com/en-us/azure/best-practices-availability-paired-regions

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/23.png?st=2019-10-25T12%3A14%3A09Z&se=2022-10-26T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5Yjud%2BreVE74TI6XhYyUgKPA5u%2FLGilVUTaSen4kbVs%3D)


![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/24.png?st=2019-10-25T12%3A14%3A31Z&se=2022-10-26T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jil3HODFw%2FHCp8QojZ5VjOaSxfQn0H2FvqLnEI8Sir8%3D)


![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/25.png?st=2019-10-25T12%3A14%3A46Z&se=2022-10-26T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hb6pWHmMFRa6fA4NcMlwZY3n%2B0TnOzDDx78yO3yXgyI%3D)


![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/26.png?st=2019-10-25T12%3A15%3A00Z&se=2022-10-26T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=53tTN9sn5XmEhgTz%2Fs%2BVND041XOXX2Y18cCiE0JiPJg%3D)

#### Failover

Failover on the Azure service bus is deactivating the primary namespace and activating the secondary namespace, to act as primary. This, in the case of any downtime in primary namespace, the secondary namespace takes over the responsibility of the primary namespace.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/28.png?st=2019-10-25T12%3A15%3A55Z&se=2022-10-26T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hmJzCZ7FixRUg9y9xT%2Fod%2B6WkUOQ%2BKTKr0X0X56ZGiw%3D)

Click on **failover** and enter the alias in the prompted field and initiate the failover.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/29.png?st=2019-10-25T12%3A16%3A12Z&se=2022-10-26T12%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=mL%2BNq5S%2FrmlMo9llisDHb4xrEiXLD6Spi1N1YP4%2Bah0%3D)

Failover may take a few minutes and you’ll receive a notification on a successful failover as in the below screenshot.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/30.png?st=2019-10-25T12%3A16%3A29Z&se=2022-10-26T12%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4uUM2xuf9Oyx51Ez7RnUnTjcugJgqeG7EMlvVWWlJZo%3D)

You can now see that the secondary namespace has takenover the primary namespace.

Adding the Secondary namespace **endpoint** into the **iothub** using the below steps to send data to **secondary namespace queue** after the failover.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/31.png?st=2019-10-25T12%3A16%3A52Z&se=2022-10-26T12%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Y18V2HZsocT2%2B%2BWTg%2BOnLJxm8L%2BDInyaHTJaUBot6Uk%3D)

Proceed to create a route in IoT Hub to send data from IoT Hub to Secondary Premium Service Bus Queue.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/32.png?st=2019-10-25T12%3A17%3A12Z&se=2022-10-26T12%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BLfz1oiwmNWWFkWuErF%2BLo90bZNQ%2Ba8tKhgR9gf0iF0%3D)


![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/33.png?st=2019-10-25T12%3A17%3A31Z&se=2022-10-26T12%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zpTurhbhMgraObFzavlZ%2BGDacXTQecuWvcxcIzou1TU%3D)

#### Check the data in Secondary Service Bus Queue:

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/34.png?st=2019-10-25T12%3A17%3A44Z&se=2022-10-26T12%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QBt%2BNxvrPf%2F%2F7mw3WqyxdYNeO5WDHNMbObwBKCt%2Bipg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Create%20Service%20Bus%20using%20Azure%20Portal%20and%20Service%20Bus%20High%20Availability/35.png?st=2019-10-25T12%3A17%3A57Z&se=2022-10-26T12%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=53jS4Tiq5dkuwhtpEZ14IudmsuyG6z2ufJ3Mzr81ftA%3D)
