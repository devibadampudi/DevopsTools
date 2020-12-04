# Lab: Create Event Hub using Azure Portal and Event Hub High availability

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Exercise 1: Create Event Hub using Azure Portal](#exercise-1-create-event-hub-using-azure-portal)

[Exercise 2: Connecting IoT Devices to Event Hub](#exercise-2-connecting-iot-devices-to-event-hub)

[Exercise 3: Event Hub High Availability](#exercise-3-event-hub-high-availability)

## Overview

The main aim of this lab is Create Event Hub using Azure Portal and Connecting IoT devices to event huband perform Event Hub High availability.

Event Hubs is a data streaming platform and a service which ingests events. Per second several events are received and processed. Using any real-time analytics provider or storage adapters event hubs data are transformed and stored. We can use Event hubs in some scenarios like logging of application, while Transaction processing, telemetry streaming of device or telemetry processing of user. Azure Event Hubs automatically enables the capture the streaming data in event hubs through azure blob storage or azure data lake storage

### Scenario and Objective

In this Lab you will Learn

1. Create Event Hub using Azure Portal

2. Connecting IoT Devices to Event Hub

3. Event Hub High availability

## Pre-Requisites

* Azure Portal

## Exercise 1: Create Event Hub using Azure Portal

Using the Chrome browser, login to Azure Portal with the below details:

```
Azure Username : {{ Portal Useremail }}

Azure Password : {{ Portal Password }}
```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/1.png?st=2019-10-04T09%3A14%3A35Z&se=2026-10-05T09%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZynltR8TK3RK1n73ZHnz6tYsINk9LNoN3B9NYmc6P94%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/2.png?st=2019-10-04T09%3A15%3A03Z&se=2025-10-05T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QAjNBj6fBdNfzcfbl7ttiIutx04%2B1tSNswvdcaVVEb4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/3.png?st=2019-10-04T09%3A15%3A21Z&se=2025-10-05T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=3EKcJorbRTBUI5fsWXsVRwVUac3OYRMI4toX0iSYm5Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/4.png?st=2019-10-04T09%3A15%3A52Z&se=2025-10-05T09%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XoJ1BkkgWvK1dbyGsRfhf5IsaWzz%2F2hjUIw%2BlVmZRwo%3D)

Now you can **click** on **+Create a resource** in azure portal.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e1.png?st=2019-10-04T09%3A28%3A29Z&se=2026-10-05T09%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xUQ%2BZ88xbPmC5KcgyvVvbtGaQHZPghOXTawsvGN6jvU%3D)

Then **search** for **Event hub** in search box and Click Event Hubs Service in the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e2.png?st=2019-10-04T09%3A29%3A18Z&se=2026-10-05T09%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q9yenAbUT7xiGgGoR3DywsI7uh5Ukz8goMoLxyJOV2A%3D)

Then click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e3.png?st=2019-10-04T09%3A29%3A42Z&se=2027-10-05T09%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Oq%2BEYDVcPzcT%2BBpOM7zyvUjTbt8EriUyrhL6OvgozdI%3D)

Then you can see the first screen for creating Event Hub

Fill all the below fields to create Event hub namespace

```

Name: give a unique name to your Event Hub namespace, on availability of Event Hub namespace it will show the green check mark

Pricing tier: Standard

Subscription: {{ subscriptionId }}

Resource group: : {{ ResourceGroup }}

location : {{ location }}

```

Mark the check box for enabling the auto inflate mode, which will increase the number of throughputs automatically when your traffic exceeds. This will work only for standard pricing tier.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e4.png?st=2019-10-04T09%3A34%3A36Z&se=2025-10-05T09%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LaBV%2FKbajgSmAez84rLo7R%2BSftgarobMYgYmp3YGdXo%3D)

**Click** on **Create**. Creating the Event hub namespace will take a few minutes.

Click the notification button to monitor creation progress of Event Hub namespace. Once it’s successfully deployed, then click on resource group name for redirecting to the Event Hub namespace.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e5.png?st=2019-10-04T09%3A35%3A16Z&se=2025-10-05T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=w8SMjQ4p0OvR%2FNPr3JJ3v6sGYl%2FsoMaLt2FdK7E4MBw%3D)

### Create Event Hub in Event hub Namespace

In this section we are creating event hub in event hub namespace.

Go to the **Resource group**, where the event hub namespace got deployed in azure portal.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e6.png?st=2019-10-04T09%3A35%3A34Z&se=2026-10-05T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WQAmGLfxbrqlg%2FenlHJ%2BGTwmW0ymYmAxHogPyqaW4EE%3D)

**Click** on the **Event hub namespace**, then you will be navigated to overview blade. Click on Event Hubs blade, and for creating Event Hub click on **+Event Hub**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e7.png?st=2019-10-04T09%3A35%3A57Z&se=2025-10-05T09%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=nawZrpUCHCwiqDajdpSxIPzhHGyS4MxINQceegm8m0Y%3D)

You will get below screen, under the **Name** field give a unique name. On availability of Event Hub name green check mark will appear.

Depending on project requirement the partition count, message retention can be increased, once done click on **Create** Button.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e8.png?st=2019-10-04T09%3A36%3A13Z&se=2025-10-05T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qZeE%2BEtcSCTIwqB10pYN%2FdrKsoiCM6Sra%2Bm88NuCE98%3D)

Once the deployment is done you will get the notification like below and the created event hub will be listed under Event hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e9.png?st=2019-10-04T09%3A36%3A32Z&se=2026-10-05T09%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=lke72djyWh7Mm%2F8ggWqul6okqsvKX9N0v6QevO7pUjQ%3D)

### Create access policies for Event Hub

In this section we are creating access policies for Event Hub.

**Click** on the **Event hub**, you will be navigated to overview blade like below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e10.png?st=2019-10-04T09%3A37%3A41Z&se=2025-10-05T09%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=C9PapKF0wbYkSrQRqF6sL9oAA8ZTxObMcUwttSUl4%2BY%3D)

Under **settings** menu from left side, select **Shared access policies** and click on **+Add**.

Provide any name to the policy, mark the checkboxes **Manage, Send, Listen** and then click on **Create** button.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e11.png?st=2019-10-04T09%3A38%3A00Z&se=2025-10-05T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XJZhBPLNueAUS4%2BkkAzXP0oi2%2F1OX%2B5cxBXTBxwIeMA%3D)

Once the policy is created, it will get listed like below by clicking on policy you will get Event hub keys and connections strings. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e12.png?st=2019-10-04T09%3A38%3A17Z&se=2025-10-05T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GVPWeB0N%2BiC2nfEZvtcmAvT74OO4ov%2Fp%2FrydryrqRCY%3D)

## Exercise 2: Connecting IoT Devices to Event Hub

In this lab we are connecting the IoT device to EventHub. whatever the data send to IoT hub also received by Event hub by doing the message routing in IoT Hub.

Initially you must create one IoT Hub and device in azure portal.

### Create Azure IoT hub using Azure Portal

Go to the Azure Portal and provide your credentials for login.

Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the IoT Hub from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e13.png?st=2019-10-04T09%3A38%3A43Z&se=2027-02-05T09%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jsfEtl1gWksOBZ%2BsxAfLbDUh6pAN13zS%2BmY1t5SUagU%3D)

Click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e14.png?st=2019-10-04T09%3A39%3A24Z&se=2026-10-05T09%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=76%2BaoEtN1JbWlhzpskJl4ik9McdZ780RdSO5spMmyro%3D)

You will see the below screen, fill all the required fields.

```

Subscription: {{ subscriptionId }}

Resource group: : {{ ResourceGroup }}

location : {{ location }}

IoT Hub Name: Provide a unique name to your IoT Hub, on availability of IoT Hub name it will show the green check mark.

```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e15.png?st=2019-10-04T09%3A39%3A45Z&se=2025-10-05T09%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CtDOM1JMLk4uwNn8h7Zg7geBA9X1Agxne%2F24E6dgo6c%3D)

Click **Next: Size and scale**.

Take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

**Basic and Standard Tier:** For IoT solution which require only uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e16.png?st=2019-10-04T09%3A40%3A02Z&se=2025-10-05T09%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=31SkBZ2RqOEgIEhqjs2qeTWAunHSeqDChofYnOs9k%2FM%3D)

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e17.png?st=2019-10-04T09%3A40%3A23Z&se=2025-10-05T09%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NlwHoUm5H649WHAxpJjMvrKMNctJScq5SDlssiIeDPA%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e18.png?st=2019-10-04T09%3A40%3A39Z&se=2025-10-05T09%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RQWYs5xWY2eunXW0TeUVMkM3AYUY9%2FisHSg2HzzlP4k%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e19.png?st=2019-10-04T09%3A40%3A57Z&se=2024-10-05T09%3A40%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QKfMDVia8pGxiQLLBXqMgbVu%2B%2BpeKwIBA80285iz0Gw%3D)

### Create a device in Azure IoT Hub

In this lab, we create a device in existing IoT Hub. A device cannot connect to IoT Hub unless it has an entry in the identity registry.

In IoT Hub navigation menu, open **IoT Devices**, then select **Add** to register a new device in your IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e20.png?st=2019-10-04T09%3A41%3A25Z&se=2025-10-05T09%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bWdbUfpz4W0IHJwgKwdnz1uxPgoxqXtVRk1XsvRWeZw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e21.png?st=2019-10-04T09%3A41%3A45Z&se=2025-10-05T09%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QPcfA8buBcYB%2FOxWuitGE%2F4OxIMQWbtkWueS0ijtduo%3D)

Provide any user defined name for new device, such as **device-1**, and select **Save**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e22.png?st=2019-10-04T09%3A42%3A05Z&se=2025-10-05T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=S9pxXYOk61g8235hrDJFOyDgZYzWcSA%2BcZFumN3uF08%3D)

This will create a new device identity in IoT hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e23.png?st=2019-10-04T09%3A42%3A23Z&se=2025-10-05T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aXBq7rAWiqNBITDUtsnX94uCa6W%2BP2VfLQNn7XSxlJU%3D)

After the device is created, open the device from the list in the IoT devices pane.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e24.png?st=2019-10-04T09%3A42%3A49Z&se=2025-10-05T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tiFuRAuUsx8t%2BpTYboJegZoOMCyM2ZDqJOxCiO8cMbE%3D)

**Copy** the **Connection string---primary key** and **save** it somewhere, this will be used later.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e25.png?st=2019-10-04T09%3A43%3A09Z&se=2025-10-05T09%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=q6HCg%2FgbzV%2Bv9kyfRanXpztD1wdmVZRxlJgg%2FFqDo%2Fk%3D)

### Message routing using Event Hub

To add the message routing to IoT hub using Event Hub follow the below steps.

Go to the IoT Hub **resource group** in Azure portal then click on **IoT Hub**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e26.png?st=2019-10-04T09%3A43%3A28Z&se=2025-10-05T09%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yKlhQ2lDd4YlCeur8w35zsZwOUcKk5mxN92HJpzilsk%3D)

In IoT Hub under **Messaging** blade menu which will appear on left side of window, go to **Message Routing** you see the **Routes** and **Custom endpoints** menu as shown below. For creating customs endpoints, click on Custom endpoints menu then you can create routes.

**Click** on **+Add** to add Event Hubs as custom endpoints select Event Hubs.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e27.png?st=2019-10-04T09%3A44%3A32Z&se=2025-10-05T09%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2Yv7YKCgF7uCELjWhOWlI%2FGH5Z83%2BlwdnmMmvbA8F2U%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e28.png?st=2019-10-04T09%3A43%3A49Z&se=2026-10-05T09%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=M3qe7oILGYk5iMLovpdzJBdkjkfLdPNmkDkECXrdIa8%3D)

Once selected Add an event hub endpoint screen will be appeared, fill all the required fields. In **Endpoint name** give a unique name and choose the Event Hub namespace from dropdown which you created before. In Event Hub Instance select created EventHub in dropdown, then click on Create.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e29.png?st=2019-10-04T09%3A49%3A36Z&se=2026-10-05T09%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=av8CJNz%2BwNFQ1fxipRg1kRPipBeB01F83rRMxySqSzY%3D)

Now the custom endpoint is added with the provided name.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e30.png?st=2019-10-04T09%3A49%3A16Z&se=2025-10-05T09%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DvdDv3KGant%2FYLlNKwKyjD0%2BkleQxf0OYKBi%2BxQmqfg%3D)

Initially the custom endpoint state is **Unknown**, once the data is sent it will change **Healthy**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e31.png?st=2019-10-04T09%3A49%3A54Z&se=2025-10-05T09%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PXXUpf9d6%2FJ1%2F5LulkaFmjRVKK4%2FddkpRUfXfGC9cLA%3D)

Now select the **Routes** and click on **+ Add** to add route.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e32.png?st=2019-10-04T09%3A50%3A12Z&se=2026-10-05T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dWYgdFOHHGpUU%2FQF394kEDkNLv4aeQLaa8%2F21zF6x3s%3D)

Fill all the fields, under name field provide unique name for route. Endpoint field value should.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e33.png?st=2019-10-04T09%3A50%3A29Z&se=2025-10-05T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=w%2FOAi46rSgT9Ndd9EncSkuDxDF%2B32PVeRSh%2BcWJ4koo%3D)

In **Data source** field select which one you want from drop down. If you already have any routing query use that or else keep the routing query as true and **click** on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e34.png?st=2019-10-04T09%3A50%3A50Z&se=2025-10-05T09%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sKLgYcefKnUH7eExPN1N0QI0W7HBqKe0K4PVpMx%2BRoo%3D)

Now the notification Route added, in **Routes** the route is added with the provided name.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e35.png?st=2019-10-04T09%3A51%3A08Z&se=2026-10-05T09%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OuWN%2BbOV9iHIUGJDnGkd19aYEFrddBDqnapSbnuWCHg%3D)

The added route will be appeared as shown below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e36.png?st=2019-10-04T09%3A51%3A25Z&se=2026-10-05T09%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JtKuaB%2BjkpbmhkKWi3g0TlMYEkCjerCZo2fPnR1GlYg%3D)

### Sending data to IoT Hub using online PI simulator

In this lab, we learn the basics of working with Raspberry Pi online simulator and how to seamlessly connect the Pi simulator to the cloud by using Azure IoT Hub.

**Click** on **below link** to launch Raspberry Pi online simulator.

https://azure-samples.github.io/raspberry-pi-web-simulator/#GetStarted

In code editor window, make sure you are working on the default sample application. Remove the placeholder and update the Azure IoT Hub connection string value of **connectionString** variable.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e37.png?st=2019-10-04T09%3A51%3A49Z&se=2025-10-05T09%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GQud0MDWsWjy0w0nPMAiXyLd7h7FQI7Ek5D2RdijOOg%3D)

Select **Run** or type **npm start** to run the application.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e38.png?st=2019-10-04T09%3A52%3A11Z&se=2025-10-05T09%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=G%2FmS5Y5LQrYg%2FLiQ9lMVQ403Vq0PTWqPfq5ZrfchyLg%3D)

Once the Simulator start running, it shows below output of the sensor data and the messages that are sent to connected IoT Hub. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e39.png?st=2019-10-04T09%3A52%3A33Z&se=2026-10-05T09%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xTGj2Xq9DcnMAYPP3gkH8cic97KVA6OspORFjYwZlB0%3D)

Messages will start flowing into connected IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e40.png?st=2019-10-04T09%3A52%3A51Z&se=2025-10-05T09%3A52%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kJ0eWXxg8R2ZDRRI0N1DMi6ivmfRG2sIcgGUnIgevS4%3D)

Go to the event hub namespace and click on event hubs **overview**, we can view the Incoming requests, successful requests in graphs like shown below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e41.png?st=2019-10-04T09%3A53%3A07Z&se=2025-10-05T09%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LO0MLYUBLBIEYHxUHFmI3yribzGD1M8WKyyp1TcGFVI%3D)

Now check the custom endpoints in IoT Hub, Event hub endpoint status is turned in to Healthy from Unknown after sending data to IoT Hub. As the routing is enabled so the same data will sent to Event Hubs.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e42.png?st=2019-10-04T09%3A53%3A25Z&se=2025-10-05T09%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=T3uhGI3x9VCoRxkWvXOPwd6RejocVdmArCL9dD%2B%2B6jg%3D)

## Exercise 3: Event Hub High Availability

We can do the high availability for event hubs using geo recovery feature at event hub namespace level. If any event hub is temporary unavailable, it will affect the components of service. Once the issue is fixed the event hub is available. We loss data from event hubs while any disaster happens, so if we do geo recovery there is no data loss and messages can be recovered once the data center is back up.

Geo recovery option is available for only Standard SKU Event Hubs.

In this Lab we will learn how to do the geo recovery for EventHub.

### Initiate Pairing

1. Navigate to the deployed or already exist EventHub Namespace’s resource group and click on it.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e43.png?st=2019-10-04T09%3A53%3A45Z&se=2025-10-05T09%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XpFOTT7HJtBIld1hz8OdIFqBotouMbTtxoVFL8k2FNE%3D)

2. Under **Settings** menu select **Geo-Recovery** blade, click on **Initiate pairing** option.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e44.png?st=2019-10-04T09%3A58%3A41Z&se=2026-10-05T09%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8oD12eWubSHvsVNvYfHAN%2B9cgSXssT2rUn9h5tcl6fg%3D)

3. Below fields need to be filled to proceed further.

 * In **subscription** field select the existing subscription where we deployed Primary namespace.

 * In **resource group** field select existing resource group.

 * Select the **location** from dropdown list. 

 * In Secondary namespace field to create new namespace select **create new** option, for the existing one select **Use existing** option. 

 * In Alias give any unique name, click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e45.png?st=2019-10-04T09%3A59%3A04Z&se=2025-10-05T09%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dYa9bMj76tzf5bW27SoNZrjAhw%2F%2FRLPCl6ZkcmVGMLo%3D)

4. We can see the status of deployment in the Notifications which will take few minutes to complete.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e46.png?st=2019-10-04T09%3A59%3A31Z&se=2025-10-05T09%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vGukJQl%2BC5JmuVxhku7A7I2ljC8Z3l8VYfTAN3S%2FYio%3D)

5. Once the deployments get completed, the pairing is happened from primary namespace region to secondary namespace region as shown below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e47.png?st=2019-10-04T09%3A59%3A50Z&se=2027-10-05T09%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hn1F2iLPVK8t0B5B2NiG8THbJgrTli7QahmnAWU99bA%3D)

6. The namespaces related information can be seen by scrolling down.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e48.png?st=2019-10-04T10%3A00%3A14Z&se=2025-10-05T10%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NgKOgOtYLyhQH%2BQLpUuOIBB7EZUAzlxTtw93JdMVYd8%3D)

7. If Existing resource group selected then go back to the resource group, if Create new resource for secondary namespace is selected then navigate to that resource group, we can see secondary namespace deployed in different region.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e49.png?st=2019-10-04T10%3A00%3A36Z&se=2025-10-05T10%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OTrxE33pRVs3LNX%2FofC83jFFErtgpU3Vc2QzOXySOIg%3D)

8. **Click** on **secondary EventHub Namespace**, from the left side menu Under **Entities** menu select **Event Hubs** we can find the same Event Hubs present in secondary namespace as of primary namespace, it got replicated after doing the initiate paring.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e50.png?st=2019-10-04T10%3A00%3A55Z&se=2025-10-05T10%3A00%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DyASba%2FjeVuZgHJF8HbMFr6RO9eF%2Fv8HL1uwDPyNsig%3D)

9. Now **click** on that **event hub** and go to **shared access policies**, here we can see the **alias connection string** is added in keys.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e51.png?st=2019-10-04T10%3A01%3A21Z&se=2025-10-05T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=o0SxnkKJQ9hZEuRMkX1AIGTAuvEuRXcDosz%2FD6ER%2FII%3D)

10. Similarly, go to the **primary namespace** - > **Event Hub** and click on **shared access policies** we find here as well the alias connection string is added in keys. Both the namespace’s alias connection strings are same, if alias connection strings are used then there is no need to change the connection strings.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e52.png?st=2019-10-04T10%3A01%3A41Z&se=2025-10-05T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bJBc48bi7dMX9Lp%2FBLMrDKNZfcPHR1sWM6eXCBzUc5o%3D)

### Failover

To do a Failover, we are removing (deactivating) the Primary namespace and activating the Secondary namespace as primary. It means if we lost the primary namespace also the secondary namespace will work as same as primary namespace.

1. **Click** on **failover** then provide the **alias name** to do failover and click on **failover** button.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e53.png?st=2019-10-04T10%3A01%3A59Z&se=2026-10-05T10%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FK2DCK92Osmem3Va9MD5R6VysPruii4eFtxHY5SDRc8%3D)

2. It will take few minutes to deploy, once done it will show the completed notification as shown below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e54.png?st=2019-10-04T10%3A02%3A18Z&se=2025-10-05T10%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8%2B72RedSC5SuoH6MA8FlGQA7FNLuTqnSmv9KgAPn3Y8%3D)

3. After the failover the secondary namespace will become the Primary namespace.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e55.png?st=2019-10-04T10%3A02%3A56Z&se=2025-10-05T10%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TvmdaPV4%2FPF9t88yiTGMfwiwJXpKAtm%2F3dbQbaxGMPs%3D)

4. If you scroll down you can see the namespace information primary namespace is disapper afer failover and secondary namespace only presented.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/eventhub/e56.png?st=2019-10-04T10%3A03%3A17Z&se=2025-10-05T10%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TbZJE7rBdz8vgHQCLVV4gz9NrGwCF1aZxNobI24WXvQ%3D)
