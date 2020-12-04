# Creating IoT Hub Using Azure Portal 

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Creating IoT Hub using Azure Portal](#excercise-1-creating-iot-hub-using-azure-portal)

[Excercise-2: Creating devices on Azure IoT Hub](#excercise-2-creating-devices-on-azure-iot-hub)

[Excercise-3: Sending data to IoT Hub using online PI simulator](#excercise-3-sending-data-to-iot-hub-using-online-pi-simulator)

## Overview 

The aim of this lab is to create and configure an Azure IoTHub from Azure portal and send data to IoTHub using PI Simulator

#### Introduction to Azure IoT Hub

Azure IoT Hub is a managed service that enables millions of IoT devices and solutions to have bidirectional communication between them in the most scalable, reliable and secure manner. It is Cloud-based Platform as a service that allows multiple users to access single server.

IoT Hub supports communications both ways i.e., device to the cloud and cloud to the device. IoT Hub monitoring helps maintaining the health of the solution by tracking events like device creation, device failures, and device connections.

Azure IoT Hub is known for the most reliable and secure bi-communication between device-to-cloud and cloud-to-device.

1. IoT Hub maintains Device twins on each device connected using which one can store, synchronize, and query the device’s metadata and state information.

2. Per-device authentication is provided on each device by creating a security key in a common place called IoT Hub identity registry

3. IoT Hub defines message routes to send device-to-cloud messages.

**Scenario and Objectives**

*   Creating IoT Hub using Azure Portal

*   Creating devices on Azure IoT Hub

*   Sending data to IoT Hub using online PI simulator


## Pre-Requisites

*   Azure Portal access

*   knwledge on Azure IoT Hub

>   **Note**: Azure Portal access is provided as part of the Lab environment

## Excercise-1: Creating IoT Hub using Azure Portal

1.Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal1.png?sv=2019-10-10&st=2020-10-22T04%3A19%3A33Z&se=2023-10-23T04%3A19%3A00Z&sr=c&sp=rl&sig=brt7QE%2FCYc27KFQ0TiMUL2Yt5nkWUKiDPGfUixEAFxE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal2.png?sv=2019-10-10&st=2020-10-22T04%3A19%3A33Z&se=2023-10-23T04%3A19%3A00Z&sr=c&sp=rl&sig=brt7QE%2FCYc27KFQ0TiMUL2Yt5nkWUKiDPGfUixEAFxE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal3.png?sv=2019-10-10&st=2020-10-22T04%3A19%3A33Z&se=2023-10-23T04%3A19%3A00Z&sr=c&sp=rl&sig=brt7QE%2FCYc27KFQ0TiMUL2Yt5nkWUKiDPGfUixEAFxE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal4.png?sv=2019-10-10&st=2020-10-22T04%3A19%3A33Z&se=2023-10-23T04%3A19%3A00Z&sr=c&sp=rl&sig=brt7QE%2FCYc27KFQ0TiMUL2Yt5nkWUKiDPGfUixEAFxE%3D)


2.	Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/3.png?st=2019-09-11T11%3A50%3A06Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v6dBYoq%2F7vlT4UjRqk38%2BnvSS5FUaJ7LpWPDyoJAq8I%3D)

Click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/4.png?st=2019-09-11T11%3A50%3A24Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jlF%2B4t0e1zjqOg1fXINUx68qXhwGEdTZzm3mz9NYltc%3D)

Then you will see the below screen, fill all the required fields.

`Subscription`: Select the default

`Resource Group`: {{resource-group-name}}

`Region`: {{location}}

`IoTHub Name` :Enter globally unique name for your IoT Hub. If the name you provided is available, then a green check mark will appear.

`Click Next`: Size and scale to proceed further with creating IoT hub.


![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/5.png?st=2019-09-11T11%3A50%3A47Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xkk3I83%2Fa9hDOvKNnuWPo3QTreMLONNQ95AFKKBOze4%3D)

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

*Basic and Standard Tier:*

For IoT solution which require only Uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

Here we are selecting sku size of **Basic:B1** and **Disabling** the **Azure Security Centre** option.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Lab2/28.PNG?st=2019-10-22T09%3A45%3A30Z&se=2022-10-23T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=FGnsVkizYvdjNm%2Bhy4Ewuyfrtdsga7OJT06BDSwHe1M%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Lab2/29.PNG?st=2019-10-22T09%3A45%3A30Z&se=2022-10-23T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=FGnsVkizYvdjNm%2Bhy4Ewuyfrtdsga7OJT06BDSwHe1M%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen. Click on **Go to resource**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Advanced/Lab2/30.PNG?st=2019-10-22T09%3A45%3A30Z&se=2022-10-23T09%3A45%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=FGnsVkizYvdjNm%2Bhy4Ewuyfrtdsga7OJT06BDSwHe1M%3D)



## Excercise-2: Creating devices on Azure IoT Hub

This Step describes how to create a device in existing IoT Hub. A device cannot connect to IoT Hub unless it has an entry in the identity registry.

In IoT Hub navigation menu, open **IoT Devices**, then select **Add** to register a new device in your IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/10.png?st=2019-09-11T11%3A54%3A47Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NFWgIn8izq6uFuwBkZXjnVrnFC1%2FV5WZPzJiNFhxoGg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/11.png?st=2019-09-11T11%3A55%3A09Z&se=2021-09-12T11%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fXeKD86XpVtUmR%2FE5gNp7V2tEJhQS4veXIp6Fp2UcgI%3D)

Provide any user defined name for new device, such as **device-1**, and select **Save**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/12.png?st=2019-09-11T11%3A55%3A31Z&se=2021-09-12T11%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1aBjlXs51ILjiJ27J7YdL1J5bOQPPfE%2BKlCkWXKXI5Q%3D)

This will create a new device identity in IoT hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/13.png?st=2019-09-11T11%3A55%3A48Z&se=2021-09-12T11%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pSR%2F3F4jfuIcsEI5XpS8z05cmTN8NIN9pWTy9prYNPY%3D)

After the device is created, open the device from the list in the **IoT devices** pane. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/14.png?st=2019-09-11T11%3A56%3A09Z&se=2021-09-12T11%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gBicN8U9m5rGQHWPj6fTrRN8TKqnlcrJaObjcdJFb%2FI%3D)

Copy the **Connection string---primary key** and save it somewhere, this will be used later.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/15.png?st=2019-09-11T11%3A57%3A34Z&se=2021-09-12T11%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eanaShQV%2B9imnFVVYJynWX2T%2B7jp4wwxOyOz9WInzeY%3D)

## Excercise-3: Sending data to IoT Hub using online PI simulator

This step describes how to send data to IoT Hub using online PI simulator and learn the basics of working with Raspberry Pi online simulator and then how to seamlessly connect the Pi simulator to the cloud by using Azure IoT Hub.

Copy and paste the below link on to the chrome's new browserto launch Raspberry Pi online simulator.

https://azure-samples.github.io/raspberry-pi-web-simulator/#GetStarted

In code editor window, make sure you are working on the default sample application. Remove the placeholder and update the Azure IoT Hub connection string value of “connectionString” variable.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/16.png?st=2019-09-11T11%3A57%3A57Z&se=2021-09-12T11%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=y8XSg3F610hu2lRJJXY8yXNGAF9sS%2Fl8hqsKPkoJCms%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/17.png?st=2019-09-11T11%3A58%3A17Z&se=2021-09-12T11%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=K%2B3XYmqm%2FFh7uwoFQTXRjzR%2F8y002525FPn%2FwAyNZOQ%3D)

Select **Run** or type “npm start” to run the application.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/18.png?st=2019-09-11T11%3A59%3A02Z&se=2021-09-12T11%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TaPZ8CBbz%2Bhhfoer9qTLT8j45IDHY69J2I420XzGh5Q%3D)

Once the Simulator start running, it shows below output of the sensor data and the messages that are sent to connected IoT Hub. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/19.png?st=2019-09-11T11%3A59%3A21Z&se=2021-09-12T11%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vRmMipG%2FpV9R3j3wpSInExkhSN1FH%2B7avPEAqqOBelw%3D)

Messages will start flowing into IoT Hub, now check the messages in IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/20.png?st=2019-09-11T11%3A59%3A40Z&se=2021-09-12T11%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GdtyqmKhr2cble0CSK33PgSrfS1yYkrNQYO5XfMVa7s%3D)
