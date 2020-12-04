# Lab-6: IoT Hub Manual Failover

## Table of Contents

[Overview](#overview)

[Pre-requisites](#pre-requisites)

[Excercise-1: Create an IoT hub using Azure Portal](#excercise-1-create-an-iot-hub-using-azure-portal)

[Excercise-2: Perform a manual failover](#excercise-2-perform-a-manual-failover)

[Excercize-3: Status of Hub running in the secondary location](#excercize-3-status-of-hub-running-in-the-secondary-location)

## Overview

Manual failover is a feature of an IoT Hub service which helps for business continuity and disaster recovery if experiencing any downtime or region failover by performing failover of an IoT Hub operations from a primary region to the corresponding Azure geo-paired region. 

Below are the steps to perform manual failover of an Azure IoT Hub.

*   Create an IoT hub using Azure portal in the right, supported region.

*   Perform IoT Hub failover.

*   Check the status of the hub running in the secondary location.

#### Scenario and Objective

*   Perform a IoT Hub manual failover

*   Status of Hub running in the secondary location

##  Pre-requisites

*   Azure portal Access

*   Familiar with Azure Portal.

**Note** : Azure portal access is provided as part of the lab environment.

##  Excercise-1: Create an IoT hub using Azure Portal

1.Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal1.png?sv=2019-10-10&st=2020-10-08T16%3A04%3A52Z&se=2023-10-09T16%3A04%3A00Z&sr=c&sp=rl&sig=CSZmGurKxCI9d28hGETqGZQvMdP5jyAASwTceW6usWk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal2.png?sv=2019-10-10&st=2020-10-08T16%3A04%3A52Z&se=2023-10-09T16%3A04%3A00Z&sr=c&sp=rl&sig=CSZmGurKxCI9d28hGETqGZQvMdP5jyAASwTceW6usWk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal3.png?sv=2019-10-10&st=2020-10-08T16%3A04%3A52Z&se=2023-10-09T16%3A04%3A00Z&sr=c&sp=rl&sig=CSZmGurKxCI9d28hGETqGZQvMdP5jyAASwTceW6usWk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal4.png?sv=2019-10-10&st=2020-10-08T16%3A04%3A52Z&se=2023-10-09T16%3A04%3A00Z&sr=c&sp=rl&sig=CSZmGurKxCI9d28hGETqGZQvMdP5jyAASwTceW6usWk%3D)


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

You can take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

*Basic and Standard Tier:*

For IoT solution which require only Uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

Here we are selecting sku size of **Standard:S1** and **Disabling** the **Azure Security Centre** option.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/6.png?st=2019-09-11T11%3A51%3A12Z&se=2021-09-12T11%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iFjwxYBtJ2L3ElhodF1s8mZgMdXnw3mu6UjxMF0c5sE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/iothub2.png?sv=2019-10-10&st=2020-10-08T16%3A11%3A18Z&se=2023-10-09T16%3A11%3A00Z&sr=b&sp=r&sig=SHVsWVuVe51Fy3LIg2wmivojYowhMKb7UcYLWvM6NzU%3D)

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/7.png?st=2019-09-11T11%3A53%3A47Z&se=2021-09-12T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i%2B4Vi1zo%2FSk6oDgqzYWAk%2FbyYzhvgxLmafVe83Bnotg%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/8.png?st=2019-09-11T11%3A54%3A06Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xmqw4ouj6WGdhHayZFKu8Bh44pGbkq%2B1QC4J%2BnlNQR0%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/9.png?st=2019-09-11T11%3A54%3A26Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7fr6vmehaTkBOslBH3rEYh3jW8BFVLDnhn0l28IPas8%3D)

##  Excercise-2: Perform a manual failover

Note that for an IoT Hub, there is a limit of two failovers and two failbacks per day.

Navigate to **Azure Portal >Resource group > select your IoT Hub >** click **failover**. If the IoT Hub is not set up in a valid region, the manual failover option will be disabled.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/im1.png?st=2019-09-26T11%3A04%3A59Z&se=2022-09-27T08%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QyP5S%2F7Ck9bSzoradll4d8VB%2B08Vzo6Bl4e01PrAiE0%3D)

On the same page, we can notice the **IoT Hub Primary Location** and the **IoT Hub Secondary Location.** The primary location is set to the location you specified when you created the IoT hub, and the secondary location is the Azure geo-paired region that is paired to the primary location. You cannot change the geo-paired region values. For example, the primary location is **westus2** and the geo-paired region of the secondary location is **West Central US**.

Click on **Initiate failover**. You see the **Confirm manual failover** pane. Fill in the name of your IoT hub to confirm the manual failover once you see the Confirm manual failover pane. Click on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/im2.png?st=2019-09-26T11%3A05%3A58Z&se=2022-09-27T11%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uVQ1rOfA8TdXnkv16MU7bshK2SWTScj%2BUH6c95722Vc%3D)

View the progress status of manual failover when clicked **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/im3.png?st=2019-09-26T11%3A06%3A39Z&se=2022-09-27T11%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AXySXPWKFmvfEUW%2Fget30%2Fn7WiGy2c9iE%2BTxd5viWTI%3D)

##  Excercize-3: Status of Hub running in the secondary location

Once the failover is done, the primary and secondary regions on the Manual Failover page are changed and the Hub is active again. 

In this example, the primary location is now West Central US and the secondary location is westus2.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/im5.png?st=2019-09-26T11%3A07%3A00Z&se=2022-09-27T11%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WjzGfGYFgrvERhTzaSoCAmzllQS2tFXfQOcIXUUyn9o%3D)
