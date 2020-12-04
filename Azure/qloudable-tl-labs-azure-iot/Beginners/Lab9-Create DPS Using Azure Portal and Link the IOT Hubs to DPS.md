# Lab 9: Create DPS Using Azure Portal and Link the IOT Hubs to DPS

## Table of Content

[Overview](#overview)

[Pre-requisites](#pre-requisites)

[Exercise 1: Creating IoT Hub using Azure Portal](#exercise-1-creating-iot-hub-using-azure-portal)

[Exercise 2: Create DPS using Azure Portal](#exercise-2-create-dps-using-azure-portal)

[Exercise 3: Link the IoT hubs to DPS](#exercise-3-link-the-iot-hubs-to-dps)

## Overview

The main aim of this lab is creating IoT Hub and DPS using Azure Portal, then link the IoT hub to DPS.
 
### Scenario and Objectives

* Create DPS using Azure Portal

* Link the IoT hubs to DPS

**Note:** Before you create the device provisioning service first you have to create the IoT Hub, For Creating IoT Hub refer the Lab-1 to Create Azure IoT Hub Using Azure Portal and Create a device in IoT Hub

## Pre-requisites

* Azure Portal

## Exercise 1: Creating IoT Hub using Azure Portal

1.Using the Chrome browser, login into Azure portal with the below details.

```
Azure Portal Email: {{azure-login-id}}

Azure Password: {{azure-login-password}}

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/portal1.png?st=2019-09-27T09%3A32%3A17Z&se=2022-09-28T09%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PWmM%2F8bi7gbtkrfNXJk4GSFYorxRMHdIQg6e23mwAVg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/portal2.png?st=2019-09-27T09%3A32%3A38Z&se=2022-09-28T09%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BgwjgjR%2BpX3aeDEULWSb%2FjO1C8aDjOJJmX8gUKu7eOw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/portal3.png?st=2019-09-27T09%3A32%3A57Z&se=2022-09-28T09%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0qcdI7S3kKTWANgG1B0B22hG%2B2jiBhhnPmLNqcuYhAw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/portal4.png?st=2019-09-27T09%3A33%3A21Z&se=2022-09-28T09%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Amdxnn%2Fx9VsOvqoMc0eQ5HWz13CtdgIG%2FUIvXmiRbsg%3D)


2.	Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/3.png?st=2019-09-11T11%3A50%3A06Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v6dBYoq%2F7vlT4UjRqk38%2BnvSS5FUaJ7LpWPDyoJAq8I%3D)

Click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/4.png?st=2019-09-11T11%3A50%3A24Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jlF%2B4t0e1zjqOg1fXINUx68qXhwGEdTZzm3mz9NYltc%3D)

Then you will see the below screen, fill all the required fields.

```
Subscription: Select the default

Resource Group: {{resource-group-name}}

Region: {{location}}

IoTHub Name :Enter globally unique name for your IoT Hub. If the name you provided is available, then a green check mark will appear.

Click Next: Size and scale to proceed further with creating IoT hub.

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/5.png?st=2019-09-11T11%3A50%3A47Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xkk3I83%2Fa9hDOvKNnuWPo3QTreMLONNQ95AFKKBOze4%3D)

You can take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

*Basic and Standard Tier:*

For IoT solution which require only Uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

```
S1: Standard tier
```
Here we are selecting sku size of **Standard:S1** and **Disabling** the **Azure Security Centre** option.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/iothub2.png?st=2020-02-20T06%3A50%3A31Z&se=2022-02-21T06%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Wnd6d4KIOwsnFxc2aXZYxXvf3US6ywhvlvktD3U2V4k%3D)

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/7.png?st=2019-09-11T11%3A53%3A47Z&se=2021-09-12T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i%2B4Vi1zo%2FSk6oDgqzYWAk%2FbyYzhvgxLmafVe83Bnotg%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/8.png?st=2019-09-11T11%3A54%3A06Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xmqw4ouj6WGdhHayZFKu8Bh44pGbkq%2B1QC4J%2BnlNQR0%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/9.png?st=2019-09-11T11%3A54%3A26Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7fr6vmehaTkBOslBH3rEYh3jW8BFVLDnhn0l28IPas8%3D)

## Exercise 2: Create DPS using Azure Portal

Using the Chrome browser, login into Azure portal with the below details.

In This step we are creating the IoT hub device provisioning service using the Azure Portal. 

1. First you have to login to the azure portal with your credentials.

2. Click on +Create a resource in azure portal, then search for IoT Hub device provisioning service in search box and Click IoT Hub Device Provisioning Service in the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/d2.png?st=2019-09-27T09%3A35%3A23Z&se=2022-09-28T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BnLYaMuehcfdlUaU5HNaBCRbRacXDjdojuhhLiqGozQ%3D)

Then click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/d3.png?st=2019-09-27T09%3A36%3A19Z&se=2022-09-28T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8xwBKSYVO223goWi%2F%2B15ovaVRHKhaYQTg6LV%2FZgOMQE%3D)

Then we can see the first screen for creating an IoT hub device provisioning service

Fill all the fields to create DPS.

1. In the Name field give a unique name to your device provisioning service, If the name is available it will show the green check mark.

2. Select the specific subscription you want to deploy the Device Provisioning Service

3. You can create a new resource group or use an existing resource group in your portal. To create a new resource group, click on Create new and assign the name you want to use for the resource group, To use an existing resource group, click Use existing and select the resource group from the dropdown. 

4. Select the region from dropdown list, in which location you want to deploy the device provisioning service.

Then click on **Create**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/d4.png?st=2019-09-27T09%3A36%3A45Z&se=2022-09-28T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iKYi05ygKWw5jvf8uelJBQz8CfuWex1BXpVIABHnjIk%3D)

Click the notification button to monitor the creation of the DPS service. After the device provisioning service is successfully deployed, then click on Go to resource so that you can redirect to the DPS resource group.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/d5.png?st=2019-09-27T09%3A37%3A07Z&se=2022-09-28T09%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ubXPAe8xAp8wtXm96CCmeCjESUPB492f5bUcYpV2yNA%3D)

## Exercise 3: Link the IoT hubs to DPS

**DPS(Device Provisioning Service):**

For all your IoT Solutions needs, Microsoft Azure provides a rich set of integrated public cloud services. The IoT Hub Device Provisioning Service (DPS) is a helper service for IoT Hub that enables customers to provision/facilitate millions of devices in a secure and scalable manner without need of human intervention.

You will add a configuration to the DPS instance, which will set the IoT hub for which devices will be provisioned.

1. Click on the resource groups button from the left-hand menu of the Azure portal. Select the resource group which you deployed the device provisioning service in the earlier section.

2. Click on the DPS service and go to overview, select Linked IoT hubs. Click on the + Add button to add the IoT hub to Device provisioning service.

3. Then it will display the below screen of the Add link to IoT hub, provide the following information to link new DPS instance to an IoT hub. 

  * Select the subscription of the IoT hub that you want to link with DPS.

  * Select the IoT hub name from the dropdown to link with the deployed Device Provisioning service.

  * In access policy, select “iothubowner” in dropdown for establishing the link between the IoT hub and Device provisioning service 

Then click on **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/d6.png?st=2019-09-27T09%3A37%3A28Z&se=2022-09-28T09%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ymlVxPZXG6Q%2FTYOx66Q7BpyYL8pIbOVitA%2FnB7sNQ0w%3D)

Once you click on **Refresh** button to show Linked IoT hubs.

Now you can see the selected IoT hub, when you click on Linked IoT hubs. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab9/d7.png?st=2019-09-27T09%3A37%3A45Z&se=2022-09-28T09%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CzaJrVvrSt%2F8w0NCITxDoon97pSx4dHLFuOpqbU1MM0%3D)
