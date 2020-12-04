# Advanced IoT Labs

## Table of Contents

- [Practice-1: Azure Service Bus](#practice-1-azure-service-bus)

     - [Lab-1: Create Service Bus using Azure Portal and Service Bus High Availability](#lab-1:-create-service-bus-using-azure-portal-and-service-bus-high-availability)

- [Practice-2: Azure Time Series Insights](#practice-1-azure-time-series-insights)

     - [Lab-2: Create Time Series Insights using Azure Portal and Visualize the data in Time Series Insights Explorer](#lab-2:-create-time-series-insights-using-azure-portal-and-visualize-the-data-in-time-series-insights-explorer)

- [Practice-3: Azure Data lake store](#practice-3-azure-data-lake-store)

     - [Lab-3: Create Data Lake store using Azure Portal and send data from IoT hub to Data lake store using Stream analytics](#lab-3:-create-data-lake-store-using-azure-portal-and-send-data-from-iot-hub-to-data-lake-store-using-stream-analytics)
    

## Lab-1: Create Service Bus using Azure Portal and Service Bus High Availability 

### Introduction to Azure Service Bus

**What is Azure Service Bus?**

Azure Service Bus is a messaging service hosted on the Azure platform that allows exchanging messages between various applications in a loosely coupled fashion. The service offers guaranteed message delivery and supports a range of standard protocols (e.g. REST, AMQP, WS*) and APIs such as native pub/sub, delayed delivery, and more. Messages are in a binary format, which can contain JSON, XML or just text.

**Namespaces:**

A namespace in Service Bus is a way of scoping your service bus entities so that similar or related services can be grouped together.  Within a Service Bus Namespace, you can create several different types of entities: queues, topics, relays and notification hubs.

**Queues:**

Messages are sent to and received from queues. Queues enable you to store messages until the receiving application is available to receive and process them.
Messages in queues are ordered and timestamped on arrival. Once accepted, the message is held safely in redundant storage. Messages are delivered in pull mode, which delivers messages on request.

**Topics:**

You can also use topics to send and receive messages. While a queue is often used for point-to-point communication, topics are useful in publish/subscribe scenarios.
Topics can have multiple, independent subscriptions. A subscriber to a topic can receive a copy of each message sent to that topic. Subscriptions are named entities, which are durably created but can optionally expire or auto-delete.

### Create Service Bus using Azure Portal

Go to **Azure Portal**, click on **+Create a Resource**, Search for **Service Bus** then select the Service Bus from the drop down.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h1.png)

Click on **Create** and continue to next steps of creating Service Bus.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h2.png)

On the next section **Create Namespace**, fill in the fields as instructed below.

**Name:** Enter a unique name for the namespace.

**Pricing tier:** Select the pricing tier (Basic, Standard, or Premium) for the namespace. If you want to use topics and subscriptions, choose either Standard or Premium as topics/subscriptions are not supported in the Basic pricing tier.

**Messaging units:** Specify the number of messaging units.

**Subscription:** Choose an Azure subscription in which you want to create the Namespace.

**Resource group:** choose an existing resource group or create a new one.

**Location:** Choose the region in which you’ll deploy your namespace.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h3.png)

You’ll receive a notification on a successful deployment as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h4.png)

**Create Queue**

Go to **Resource group** and select your **service bus namespace**.

Click on **Queues** under Entities section on the navigation pane and select **+ Queue**

Enter a Name for the queue and proceed to **create**, leaving all the other fields to their defaults.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h5.png)

### Routing data from IoT Hub to Service bus Queue

**Pre-requisites**

1. **Create an IoT Hub using Azure Portal**

Login to the **Azure Portal**.

Click on **+Create a resource**, search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

Click on **Create**.

Fill in the fields on next step as instructed below.

* **Subscription:** Select the subscription in which you want to create your IoT hub.

* **Resource Group:** Select a resource group in which you wish to create the environment from the drop-down (If already exists) or you can create a new Resource group by clicking on “Create New”.

* **Region:** Select the location you want to deploy the Environment and be advised to choose a geographically close region to avoid latencies.

* **IoT Hub Name:** Enter globally unique name for your IoT Hub. If the name you provided is available, then a green check mark will appear. Enter a unique name for your IoT Hub. (The name of the IoT Hub must be unique, globally).

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h6.png)

Click on **Next: Size and scale** to proceed on to next steps of creating IoT Hub.

Proceed to **Review + Create**, leaving all the fields to their defaults.

* **Pricing and scale tier:** You can choose from different pricing tiers available, depending on the features and number of messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. You can only deploy one solution per subscription on the free tier.

**Basic and Standard Tier:** You can use the basic tier for IoT solutions which require only uni-directional communication from the devices to Cloud and standard tier implementation for the solutions which require bi-directional communications. Apart from the working specifications, both the offerings possess same security and authentication features. 

Click on **Review + create**. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h7.png)

Click on **Create**, once you have verified all the details. Allow a few minutes for the creation of IoT.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h8.png)

You’ll receive a notification on a successful deployment, as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h9.png)

2. **Create a device in IoT Hub:**

Go to **Resource group** -> Select the **IoT Hub** you just created.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h10.png)

Navigate to the IoT Devices from the menu and click on **Add** to register a new device.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h11.png)

Enter the device name (Ex: device-1) and click on **Save**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h12.png)

This will create a new device identity in IoT hub.

After the device is created, open the device from the list in the IoT devices pane. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h13.png)

**Copy** the **Connection string (primary key)** and **save** them for later use.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h14.png)

3. **Sending data to IoT Hub using online PI simulator:** 

Launch the Raspberry Pi online simulator, clicking on the below link.

https://azure-samples.github.io/raspberry-pi-web-simulator/#GetStarted

In code editor window, make sure you are working on the default sample application. Remove the placeholder and update the Azure IoT Hub connection string value of **connectionString** variable.

Click on **Run** or type **npm start** to run the application.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h15.png)

Once the simulator is up and running, you can see the output of the sensor data and the messages, sent to connected IoT Hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h16.png)

4. **Check the data in IoT Hub:**

You can now see the messages started flowing into the IoT Hub from the Overview blade.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h17.png)

### Message routing

Go to **IoT Hub** -> Select **Message routing** -> Click on **Add** to add a route.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h18.png)

**Name:** Enter a name for the route.

**Endpoint:** On the **Add a Route** section, click on **+Add** button, next to the Endpoint field to view the supported endpoints, as displayed in the below screenshot.

Select the **Service bus queue** from the drop-down, from which you’ll be redirected to another section, **Add a service bus endpoint**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h19.png)

Enter a name for the endpoint.

Select the existing Service bus namespace and Service bus queue from the dropdown.

Now click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h20.png)

Now that you’re **back to** the **Add a route** section, make sure the Endpoint field is set to the name of Endpoint you just created and click on **Save**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h21.png)

You can now verify the route added under the Routes tab.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h22.png)

#### Check the routed data in Service Bus Queue:

You can now see the activity of routed data in the Service Bus Queue.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h23.png)

### Service Bus High Availability (Geo-Disaster recovery)

Geo-Disaster recovery currently only ensures that the metadata (Queues, Topics, Subscriptions, Filters) are copied over from the primary namespace to secondary namespace, when paired.

When entire Azure region or datacenter (if no availability zones are used) experience downtime, it is critical for data processing to continue to operate in a different region or datacenter. Azure Service Bus supports geo-disaster recovery at the namespace level.

**Note:** *The Geo-disaster recovery feature is globally available for the Service Bus Premium SKU.*

Create a **Primary** Service Bus Premium Namespace.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h24.png)

Create a **Secondary** Service Bus Premium Namespace in a different region from where the primary namespace is created. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h25.png)

Create **pairing** between the Primary namespace and Secondary namespace to obtain the alias.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h26.png)

#### Failover

Failover on the Azure service bus is deactivating the primary namespace and activating the secondary namespace, to act as primary. This, in the case of any downtime in primary namespace, the secondary namespace takes over the responsibility of the primary namespace.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h27.png)

Click on **failover** and enter the alias in the prompted field and initiate the failover.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h28.png)

Failover may take a few minutes and you’ll receive a notification on a successful failover as in the below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h29.png)

You can now see that the secondary namespace has takenover the primary namespace.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h30.png)

Proceed to create a route in IoT Hub to send data from IoT Hub to Secondary Premium Service Bus Queue.

**Note:** *We’ll use the same alias we created before to connect primary and secondary service bus, as queue now.*

#### Check the data in Secondary Service Bus Queue:

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/h31.png)

## Lab-2: Create Time Series Insights using Azure Portal and Visualize the data in Time Series Insights Explorer

### Introduction to Time Series Insights (TSI)

Azure Time Series Insights is a fully managed cloud service with Analytics, Storage and Visualization components that makes it simple to explore, store, ingest and analyze billions of IoT events generated by IoT devices simultaneously.

Azure Time Series Insights captures and stores every new event as a row, and change is efficiently measured over time. It is device agnostic requires no coding.

When dealing with more of IoT devices, it is difficult to monitor them all at once. However, using the new technology from Microsoft, Azure Time Series Insights. It allows you to validate your IOT solution and analyze them in a relatively simple way by organizing your data. It can help you find device issues early and enable features like predictive maintenance. 

### Create Time Series Insights using Azure Portal

Login to the **Azure portal**.

Select the **+Create resource** button and search for Time Series Insights and click on **Time Series Insights** from the drop down as shown like below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t1.png)

Then click on **Create** to continue creating Time Series Insights.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t2.png)

Fill in the required fields, following the instructions below:

**Environment name:** Enter a unique name for your Time Series Insights environment. (The name of the Time Series Environment must be unique, globally.)

**Subscription:** Select the subscription in which you want to create your Time Series Insights Environment.

**Resource group:** Select a resource group in which you wish to create the environment from the drop-down (If already exists) or you can create a new Resource group by clicking on “Create New”.

**Location:** Select the location you want to deploy the Environment. Be advised to select the location in which your source data resides, to avoid intra-region data and bandwidth costs.

**Pricing tier:** Choose the throughput needed. For purposes of this demo and keeping the cost low, select S1.

**Capacity:** Capacity is the multiplier applies to the ingress rate, storage capacity, and cost associated with the selected SKU. You can change capacity of an environment after creation. For lowest costs, select a capacity of 1.

Click on **Next**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t3.png)

Toggle the button to **No** for Create an Event source and click on **Review + Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t4.png)

Click on **Create**, on the next step, which will take a few minutes to create Time Series Insights. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t5.png)

You’ll receive a notification on a successful deployment, as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t6.png)

Go to **Resource group** -> select your **time Series Insights** -> Overview -> Click **Go to Environment**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t7.png)

Then you will be redirected to your Time Series Insights Explorer.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t8.png)

### Grant data access

Follow the below steps to grant data access for a user.

Try logging in to Time Series Insights Explorer with new user. It should throw an error as in the screenshot below, as you do not have access.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t9.png)

Select **Data Access Policies**, and then click on **+Add**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t10.png)

Click on the **Select user** blade, search for the user name or email address to locate the user you want to add and click on **Select** to confirm the selection.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t11.png)

Navigate to the **Select role** blade and select the appropriate access role for the user:

* Select Contributor if you want to allow the user to change reference data and share saved queries and perspectives with other users of the environment.

* Otherwise, select Reader to allow the user to query data in the environment and save personal, not shared, queries in the environment.

Click on **OK** to confirm the role choice.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t12.png)

Click **OK** on the Select User Role page.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t13.png)

Confirm that the **Data Access Policies page** lists the users and the roles for each user.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t14.png)

Now, try logging in with the user on which you have grant permissions and you must be able to access a page like in the below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t15.png)

### Add an IoT hub event source to your Time Series Insights environment

**Prerequisites:**

***1. Create an Azure Time Series Insights environment.***

***2. Create an IoT hub by using the Azure portal and create a device in IoT Hub.***

***3. Send data to IoT Hub using online PI simulator***

#### Add a consumer group to your IoT hub

Find and open your IoT Hub on the Azure portal.

In the menu under the **Settings**, select **Built-in Endpoints**, and then click on the **Events** endpoint.

Under **Consumer groups**, enter a unique name for the consumer group. Use the same name as in your Time Series Insights environment when you create a new event source.

Proceed to **Save**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t16.png)

#### Add a new event source

Go to **Resource group** -> select your **Time Series Insights** environment.

Navigate to the Event Sources under the Environment Topology and then click on **Add**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t17.png)

In the New event source pane, for Event source name, enter a name that's unique to this Time Series Insights environment.

For Source, select the IoT Hub.

Select a value for Import option:

* If you already have an IoT hub in one of your subscriptions, select Use IoT Hub from available subscriptions. This option is the easiest approach.

* If the IoT hub is external to your subscriptions, or if you want to choose advanced options, select Provide IoT Hub settings manually.

Add the dedicated Time Series Insights consumer group name, that you added to your IoT hub.

Click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t18.png)
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t19.png)

You can see the added event source, under the Event Sources as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t20.png)

### Visualize the data in Time Series Insights Explorer

Go to **Resource group** -> Select created **Time Series Insights** -> **Overview** -> **Go to Environment**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t21.png)

In Time Series Insights Explorer, you can see the Messages average and sum by *Message ID*, *temperature*, *humidity*, *events* separately as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t22.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t23.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t24.png)

You can also split the message by *device id*, *Event source* name as in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t25.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t26.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t27.png)

You can also visualize the data in Time Series Insights as *CHART*, *HEATMAP* and *TABLE*. 

Below screenshots shows the **HEATMAP** view.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t28.png)

Below screen shows the **CHART** view.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/t29.png)

## Lab-3: Create Data Lake store using Azure Portal and send data from IoT hub to Data lake store using Stream analytics

### Introduction to Data Lake store

Azure Data Lake Storage, Gen2 is now available for GA. Data Lake Storage Gen2 is the result of converging the capabilities of two existing storage services: Azure Blob Storage and Azure Data Lake Storage Gen1. Features from Azure Data Lake Storage Gen1, such as file system semantics, file-level security and scale are combined with low-cost, tiered storage, high availability/disaster recovery capabilities from Azure Blob Storage.

Azure Data Lake enables you to capture data of any size, type, and ingestion speed in one single place for operational and exploratory analytics. Data Lake Storage Gen1 can be accessed from Hadoop (available with HDInsight cluster) using the WebHDFS-compatible REST APIs. It's designed to enable analytics on the stored data and is finetuned for performance of data analytics scenarios. Data Lake Storage Gen1 includes all enterprise-grade capabilities like security, manageability, scalability, reliability, and availability.

**Prerequisites:**

***1. Create an Azure Time Series Insights environment.***

***2. Create an IoT hub by using the Azure portal and create a device in IoT Hub.***

***3. Send data to IoT Hub using online PI simulator***

### Create data lake store using Azure Portal

Open the **Azure Portal**, click **+Create a resource** and search for Data Lake Storage and select **Data Lake Storage Gen1**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l1.png)

Click on **Create** to create a Data Lake Storage (Gen1).

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l2.png)

Fill in the fields as shown below with required values.

**Name:** Give a name for Data Lake Storage. 

**Subscription:** Select the subscription in which you want to deploy your Data Lake Storage.

**Resource group:** Click **Create new** to create new resource group or select the resource group you have, in which you intend to deploy your new resource, from the dropdown. 

**Location:** Select the Location nearest to your region, from the list of available locations.

**Pricing package:** Select Your pricing package as of your requirement. For the demo purposes, we’ll select Pay-as-You-Go.

Click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l3.png)

After a successful deployment, you’ll receive a notification stating that your deployment was successful as shown in the below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l4.png)

### Configure Stream Analytics to receive data from IoT Hub

Go to **Resource group** and click on **stream analytics job**. The overview section under the Stream analytics shows the Inputs, Outputs and Query options.

You need to set the **Inputs**, **Outputs** and then you will proceed to writing a **query** which can take in the inputs and send the values to the configured output. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l5.png)

Click **Inputs** under job topology from the navigation pane on the left and click on Add **stream input** and then you can select any option from the **IoT Hub/ Event hub/Blob storage**. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l6.png)

Click on the **Inputs** label and click on **Add stream input** and then select the **IoT Hub**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l7.png)

On the next step, you will have options to either select the existing IoT hub or to create a new IoT Hub. As we already have IoT hub created, we’ll proceed to selecting the existing one. 

**Note:** *Refer section 4.2 for Creating IoT Hub.*

Fill in the fields on **IoT Hub for new Input** section with the values as instructed below:

**Input alias:** Enter a name to identify the job’s input.

**Subscription:** Select the Azure subscription that has the storage account you created.

**IoT Hub:** Enter the name of the IoT Hub you created in the previous section.

Leave other fields to defaults, click on **Save** to save the settings.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l8.png)

Now you have successfully configured the input. You can see the configured Input under Inputs as shown in the below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l9.png)

### Configuring Stream Analytics to send data to Data Lake storage

Go to the **Outputs** under Job topology section and click **Add** and then select any one of the options from below output options list to store the received data from input source.	

Click on **Outputs** -> **Add** -> Select **Data Lake Storage Gen1**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l10.png)

After selecting Data Lake Storage Gen1 as output to stream analytics job, fill in the fields on next section as in the instructions below. 

* For **Output alias**, enter a unique name for the job output. This is a friendly name used in queries to direct the query output to this Data Lake Storage Gen1 account.

* **Subscription:** Select the Azure subscription used to create the storage account.

* For **Account name**, select the Data Lake Storage Gen1 account you already created, where you want the job output to be sent to.

* For **Path prefix** pattern, enter a file path used to write your files, within the specified Data Lake Storage Gen1 account.

        o	Ex: cluster1/logs/{date}/{time}

* For **Date format**, if you used a date token in the prefix path, you can select the date format in which your files are organized.

* For **Time format**, if you used a time token in the prefix path, specify the time format in which your files are organized.

* For **Event serialization format**, select JSON.

* For **Encoding**, select UTF-8.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l11.png)

* **Authentication mode**: Select “User Token”.

* You will be prompted to authorize access to the Data Lake Storage Gen1 account. Click on **Authorize**.

* For Delimiter, select tab.

Click on **Save**, which will now add the output and tests the connection to it.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l12.png)

### Run the Stream Analytics job

To run a Stream Analytics job, you must run a query from the **Query** tab. You can run the sample query by replacing the placeholders with the job input and output aliases, as shown in the screen capture below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l13.png)

From the Overview tab, click on **Start**. From the dialog box, select **Now** for **Job output start time**, and then click on **Start**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l14.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l15.png)

It can take up to a couple minutes to start the job.

You can verify that the job output data is available in the **Data Lake Storage Gen1 account**.

In the **Data Explorer** pane, notice that the **output** is written to a folder path as specified in the Data Lake Storage Gen1’s output settings (streamanalytics/job/output/{date}/{time}).

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l16.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l17.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Advanced/Images/l8.png)



