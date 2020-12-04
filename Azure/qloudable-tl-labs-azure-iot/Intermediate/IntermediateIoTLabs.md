# Intermediate Labs

## Table of Contents

- [Practice-1: Azure Cosmos DB](#practice-1-azure-cosmos-db)

     - [Lab-1: Create Cosmos DB using Azure Portal and Cosmos DB High Availability](#lab-1:-create-cosmos-db-using-azure-portal-and-cosmos-db-high-availability)
    
- [Practice-2: Azure Stream Analytics](#practice-2-azure-stream-analytics)

     - [Lab-2: Create Stream Analytics using Azure Portal and Streaming data from IoT Hub to Cosmos DB using Stream Analytics](#lab-2:-create-stream-analytics-using-azure-portal-and-streaming-data-from-iot-hub-to-cosmos-db-using-stream-analytics)
    
- [Practice-3: Event hub](#practice-3-Event-hub)

     - [Lab-3: Create Event Hub using Azure Portal and Event Hub High availability](#lab-9:-create-event-hub-using-azure-portal-and-event-hub-high-availability)

- [Practice-4: Notification Hub](#practice-3-notification-hub)

     - [Lab-4: Create Notification Hub using Azure Portal](#lab-4:-create-notification-hub-using-azure-portal)


## Lab-1: Create Cosmos DB using Azure Portal and Cosmos DB High Availability

### Introduction to Cosmos DB

Azure Cosmos DB becomes very important these days for the applications to be maintained at extremely responsive and available almost all the time round the clock. As a best practice, the companies are getting to host their applications on multiple and globally near to their user base to brace impact during the peak hours, minimize response time taken for any massive changes, store increasing volumes of storage and keep the latency to minimum.

Azure CosmosDB is Microsoft Azure’s multi model database service, which allows distribution and elastic scaling globally to provide comprehensive service level agreements for throughput, latency, accessibility, and consistency guarantees. The elastic scaling of the service allows you to scale throughput and storage to benefit quick, single digit milli-second access to any API including SQL, MongoDB, Cassandra, Tables or Gremlin.

#### Features of Cosmos DB

Cosmos DB service feature many capabilities, you can find in the section listed below.

**Global distribution:** Cosmos DB can replicate globally wherever your application has a userbase, resulting quick responses as the user gets to interact with a replica that is closest to them and hence promoting you to build highly responsive and highly available applications.

**Always On:** Cosmos DB guarantees 99.999% availability for both read and write operations by the transparent multi-master replication and deep integration with infrastructure. You can also be assured that your application is failover capable in cases of any regional disaster with the ability to invoke the regional failover of your Cosmos account.

**No Schema or index management:** Keeping database schema and indexes in-sync with an application’s schema can be painful on a day to day basis. You can just leave that to cosmos DB as it is fully schema-agnostic and automatically indexes all data, never worry about schema or index management and application downtime during the schema migration. 

**Secure by default:** Cosmos DB, by default encrypts all the data and provides row level authorization to compile with strict security standards. Cosmos DB is also certified for multiple compliance standards.

**Elastic scalability:** Designed with transparent horizontal partitioning and multi-master replication, Cosmos DB offers incredible elastic scalability for all reads and writes globally. A single API call can invoke scalability up to millions of requests per second to deal with unanticipated spikes by avoiding need to over-provision.

**Significant TCO savings:** Azure Cosmos DB can significantly help you operate at lower costs, by ruling out the costs for support, licensing or operations to provision excessively for peak hours on workloads. Being a fully managed service, it retains cost of operating complex multi datacenter deployments and upgrades.

**In this Lab you will Learn**

 **Step-1:** Creating Cosmos DB using Azure Portal

 **Step-2:** Cosmos DB High Availability

### Step-1: Creating Cosmos DB using Azure Portal

Firstly, **Login** to the **Azure Portal** with your credentials.

**Click** on **+Create a resource**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c1.png)

**Search** for **Azure Cosmos DB** in search box and **Click** Azure **Cosmos DB Service** in the list.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c2.png)

Then click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c3.png)

Upon navigating to the **create page**, fill in the fields to create Cosmos DB instance.

1. **Select** the specific **subscription** you want to deploy the Device Provisioning Service.

2. Give a **unique name** to your cosmos DB account.

3. You can **create** a **new resource group** or **select** an **existing resource group** in your portal. To create a new resource group, click on Create new and assign the name you want to use for the resource group, to use an existing resource group, click Use existing and select the resource group from the dropdown. 

4. **Choose** the **API and data model** to use with this account from dropdown.

5. **Select** the **region** from dropdown list, in which location you want to deploy the device provisioning service.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c4.png)

Then click on **Review + create**, after making sure you add any tags you wish to. 

Then click on **Create**. It may take a few minutes to provision your Cosmos DB instance.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c5.png)

You can monitor the deployment process by clicking on the deployment notification. Once the Cosmos DB is successfully deployed, **click** on **Go to resource**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c6.png)

#### Creating Database, Containers in Cosmos DB

In this section you’ll see how to provision throughput on a database in azure Cosmos DB through azure portal. You can also do the same using azure cosmos DB SDKs. You can also, provision the throughput in database and share that throughput among the containers within the database.

**Note:** You can create databases and collections, manually or through any SDK API calls, by navigating to data explorer under Cosmos DB overview.

1. Navigate to the **Resource group**, where you created the Cosmos DB and **click** on **Cosmos DB**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c7.png)

2. Under Cosmos DB **overview** options, **click** on the **Data Explorer** and **click** on the **New Container** drop down to select **New Database** to create a database.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c8.png)

3. Proceed to enter desired database name in **Database id** field and **check** the **provision throughput** check box to set the throughput, then **click** on **OK**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c9.png)

4. Now you can see the database is created under the Cosmos DB.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c10.png)

5. **Click** on the database drop down to create a container, select **New Container**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c11.png)

6. As shown in the screenshot below, enter the **container id** to have a unique name, and **partition key** to look like **/<containerid>**. **Select** the **provision dedicated throughput** and set it to desired value and click on **OK**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c12.png)
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c13.png)

7. You can see your container just created in the database as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c14.png)

### Step-2: Cosmos DB High Availability

Azure cosmos DB ensures that your data is always highly available in due to their high availability features. Multi master feature of cosmos DB can be used to distribute your data in multiple regions and add multiple read and write regions.

You’ll need to perform no action in cases of any regional failover occurrences.

We can configure high availability for cosmos DB in two ways. One being manual fail over and other one is automatic fail over. You’ll first need to select the regions, before you perform any fail over.

#### Configure Azure Regions

Go to the **Resource group**, you deployed the cosmos DB and **click** on the **Cosmos DB** instance to see the overview options.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c15.png)

On the overview options, **click** on the **Replicate data globally** option to configure high availability for the cosmos DB.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c16.png)

You can add multiple Read and Write regions by clicking on **+Add Region** to your Cosmos DB instance.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c17.png)

**Select** the specific **region** you’d wish to make additional read region, from drop down list and click on **OK**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c18.png)

**Save** the changes to add selected region, to the read regions list.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c19.png)

It will take few minutes to configure the regions and the changes to be updated in the read regions list.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c20.png)

Upon the success notification, you can now see the added regions on your Cosmos DB home by **refreshing** the page. You can also scale the number up and down in the same way.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c21.png)

#### Manual Failover

Manual failover is a feature of the cosmos DB, that allows users to failover cosmos DB operations from a write region to the selected Azure read region. Manual failover can be useful in situations like any regional disaster.

1. **Click** on **Manual Failover** option, then you can make the read region as write region and write region as read region by following the steps below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c22.png)

2. **Select** a **read region**, which one you want to switch to a write region and click on **OK**. We have selected East US for this demo. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c23.png)

3. It will take a few minutes to complete the manual fail over operation.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c24.png)

4. You’ll receive a notification as in below screenshot after the operation is successful.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c25.png)

5. You can now **refresh** the page to see the Read/Write regions are switched.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c26.png)

#### Automatic Failover

You can use automatic failover option to failover the impact region to another region. 

This is set to happen automatically depending on health of infrastructure in the respective region.

1. **Click** on the **Automatic Failover** as shown in the screenshot below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c27.png)

2. **Toggle** the **ON/OFF** button to switch on the automatic failover.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c28.png)

3. Set the priority levels for any failover occurrences.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c29.png)

4. Allow it a few minutes to enable the automatic failover.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c30.png)

5. You’ll receive a notification on completion.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/c31.png)

## Lab-2: Create Stream Analytics using Azure Portal and Streaming data from IoT Hub to Cosmos DB using Stream Analytics

### Introduction to Stream Analytics job

Azure Stream Analytics is an event processing engine, which can process large amounts of data from a live stream. The input sources can be anything from devices, sensors, websites, live feeds and applications. The data collected from these devices can be used to derive relationships and patterns to trigger other defined actions like alerts, reports and data storage. The Stream analytics job has two components.

* Input source

* Output source

**Input source:** The input source is the source of your streaming data. You can select any from IoT Hub, Event hub and Blob storage.

We’ll choose IoT Hub as an input source for this demo purpose.

**Output source:** The output source can be any output configuration to store or present the transformed data. Any of the following can be your output source.

SQL Data base, Blob Storage, table storage, Service bus topic, Service bus queue, Cosmos Db, Power BI, Azure data lake store and Azure functions.

Here I am taking the output source as Cosmos DB.

For this demo purpose, we’ll here be using Cosmos DB as our output source.

**Pre-requisites:**

1. Create IoT Hub Using Azure Portal and register or create a device in IoT Hub.

***Refer Lab-1 of Begginners guide*** for Creating IoT Hub Using Azure Portal and registering or creating a device in IoT Hub

2. Send the data to IoT Hub using online PI Simulator.

***Refer Lab-1 of Begginners guide*** to send data to IoT Hub using Online PI Simulator

3. Create Cosmos DB using Azure Portal and Create collection in Cosmos DB.

***Refer Lab-1 of Intermediate Lab*** for creating Cosmos DB and collections (Containers) in Cosmos DB using Azure Portal.

### Create Stream Analytics job using Azure Portal

Open the **Azure Portal**, click **+Create a resource** and search for Stream analytics. Select **Stream Analytics job**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s1.png)

Click **Create** to create Stream Analytics.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s2.png)

Fill in the fields as shown below with required values.

**Job name:** Give name for the Stream Analytics. 

**Subscription:** Select the subscription in which you want to deploy your Stream Analytics job.

**Resource group:** Click **Create new** to create new resource group or if you want to use already created Resource group in that subscription you can select the Resource group from the dropdown list.

**Location:** Select the Location nearest to your region from the list of available locations.

Then click **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s3.png)

After a successful deployment, you’ll receive a notification stating your deployment was successful as shown in the below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s4.png)

Go to **Resource group** and **click** on **Stream Analytics job**, you just created. Overview section under the Stream analytics shows the Inputs, Outputs and Query options.

You need to set the Inputs, Outputs and then you will proceed to writing a query which can take in the inputs and send the values to the configured output. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s5.png)

### Configure Stream Analytics to receive data from IoT Hub

In the left side menu, click **Inputs** under job topology and click on **Add stream input** and then you can select any option from the **IoT Hub/ Event hub/Blob storage**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s6.png)

**Click** on the **Inputs** label and navigate to **Add stream input** and then select the IoT Hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s7.png)

On the next step, you will have options to select the existing IoT hub and to create a new IoT Hub. As we already have IoT hub created, we’ll proceed to selecting the existing one. 

**Note:** *Refer section 4.2 for Creating IoT Hub.*

Fill in the fields on IoT Hub page with the following values:

**Input alias:** Enter a name to identify the job’s input.

**Subscription:** Select the Azure subscription that has the storage account you created.

**IoT Hub:** Enter the name of the IoT Hub you created in the previous section.

Leave other fields to defaults, click in Save to save the settings.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s8.png)

Now you have successfully configured the input. You can see the configured Input under Inputs as shown in the below screenshot.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s9.png)

### Configuring Stream Analytics to send data to Cosmos DB 

Click on the **Outputs** under Job topology section and click **Add** and then select any one of the options from below output options list to store the received data from input source.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s10.png)

Click on **Outputs** -> **Add**-> Select **Cosmos DB**

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s11.png)

After selecting Cosmos DB as output to stream analytics job, fill in the fields on next page as in the instructions below. 

**Output alias:** Name of your output source

**Subscription:** Choose your subscription

**Account ID:** The name or endpoint URI of the Azure Cosmos DB account

**Account key:** The shared access key for the Azure Cosmos DB account

**Database:** The Azure Cosmos DB database name. You can either create a new database or select the one you had already created. In this section I am using existing database.

**Collection name pattern:** The collection name for the collection to be used. 

**Document ID:** Optional. The column name in output events used as the unique key on which insert, or update operations must be based. If left empty, all events will be inserted, with no update option.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s12.png)

Now that you have configured both the input and output source, click on Edit query, where you can write your queries.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s13.png)

We will be using a simple SQL Query to send data from IoT Hub to Cosmos DB.

**Query:**

`SELECT * INTO [YourOutputAlias] FROM [YourInputAlias]`

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s14.png)

**Note:** *Before streaming data from IoT Hub to Cosmos DB, you need to send data to IoT Hub using Online PI Simulator.*

Here, you’ll have two options to push data to stream analytics input source (IoT Hub): You can upload data from sample data file or take the data from input.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s15.png)

Choose Start time and duration then click **OK**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s16.png)

You’ll see a notification like in below screenshot on successful integration.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s17.png)

Then click **test** and observe the data in Stream Analytics input source (IoT Hub). Now you should be able to see the output as below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s18.png)

Now click on **Start** to stream the data from IoT Hub to Cosmos DB.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s19.png)

Select Job output start time and then click on **Start**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s20.png)

You could see the message **Streaming job started successfully** on the notification bar.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s21.png)

You can see the status of Job change to **running** after a while.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/s22.png)

## Lab-3: Create Event Hub using Azure Portal and Event Hub High availability

### Introduction to Event Hub	

Event Hubs is a data streaming platform and a service which ingests events. Per second several events are received and processed. Using any real-time analytics provider or storage adapters event hubs data are transformed and stored. We can use Event hubs in some scenarios like logging of application, while Transaction processing, telemetry streaming of device or telemetry processing of user. Azure Event Hubs automatically enables the capture the streaming data in event hubs through azure blob storage or azure data lake storage. 

Event hubs have the below key components.

* Event producers

* Partitions

* Consumer group

* Throughput units

* Event receivers 

**Event producers:** Any entity that sends data to an event hub. Event publishers can publish events using HTTPS or AMQP 1.0 or Apache Kafka.

**Partitions:** In the message stream each consumer only reads a specific subset, or partition.

**Consumer groups:** A view i.e., state, position or offset of an entire event hub. Consumer groups enable consuming applications to each have a separate view of the event stream, which will read the stream independently at their own pace and with their own offsets.

**Throughput units:** The throughput capacity of event hubs can be controlled by pre-purchased units of capacity.

**Event receivers:** Any entity that reads event data from an event hub. All Event Hubs consumers connect via the AMQP 1.0 session. The Event Hubs service delivers events through a session as they become available. All Kafka consumers connect via the Kafka protocol 1.0 and later.

### Create Event Hub using Azure Portal

In this section we are creating the Event Hub using the azure portal.

First you have to **Login** to the **Azure Portal** using your credentials.

Now you can **click** on **+Create a resource** in azure portal.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e1.png)

Then **search** for **Event hub** in search box and Click Event Hubs Service in the list.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e2.png)

Then click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e3.png)

Then you can see the first screen for creating Event Hub

Fill all the below fields to create Event hub namespace

In the **Name** field give a unique name to your Event Hub namespace, on availability of Event Hub namespace it will show the green check mark.

Select **Pricing tier** for event hub namespace from the dropdown list.

Select the specific **Subscription** you want to deploy the event hub namespace.

You can **create a new resource group** or use an **existing resource group** in your portal. For new resource group, click on “Create new” and assign the name of your choice, on availability it will show green check mark and for existing resource group, click “Use existing” and select it from the dropdown menu.

Select the region from dropdown list, where you want to deploy the Event hub namespace.

Mark the check box for enabling the auto inflate mode, which will increase the number of throughputs automatically when your traffic exceeds. This will work only for standard pricing tier.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e4.png)

**Click** on **Create**. Creating the Event hub namespace will take a few minutes.

Click the notification button to monitor creation progress of Event Hub namespace. Once it’s successfully deployed, then click on resource group name for redirecting to the Event Hub namespace.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e5.png)

#### Create Event Hub in Event hub Namespace

In this section we are creating event hub in event hub namespace.

Go to the **Resource group**, where the event hub namespace got deployed in azure portal.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e6.png)

**Click** on the **Event hub namespace**, then you will be navigated to overview blade. Click on Event Hubs blade, and for creating Event Hub click on **+Event Hub**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e7.png)

You will get below screen, under the **Name** field give a unique name. On availability of Event Hub name green check mark will appear.

Depending on project requirement the partition count, message retention can be increased, once done click on **Create** Button.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e8.png)

Once the deployment is done you will get the notification like below and the created event hub will be listed under Event hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e9.png)

#### Create access policies for Event Hub

In this section we are creating access policies for Event Hub.

**Click** on the **Event hub**, you will be navigated to overview blade like below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e10.png)

Under **settings** menu from left side, select **Shared access policies** and click on **+Add**.

Provide any name to the policy, mark the checkboxes **Manage, Send, Listen** and then click on **Create** button.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e11.png)

Once the policy is created, it will get listed like below by clicking on policy you will get Event hub keys and connections strings. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e12.png)

### Connecting IoT Devices to Event Hub

In this lab we are connecting the IoT device to EventHub. whatever the data send to IoT hub also received by Event hub by doing the message routing in IoT Hub.

Initially you must create one IoT Hub and device in azure portal.

#### Create Azure IoT hub using Azure Portal

Go to the Azure Portal and provide your credentials for login.

Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the IoT Hub from the list.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e13.png)

Click **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e14.png)

You will see the below screen, fill all the required fields.

* Subscription

* Resource Group

* Region

* IoT Hub Name

**Subscription:** Select the subscription in which you want to create your IoT hub.

**Resource Group:** Here you can create a new resource group or use an existing resource group in your portal. For new resource group, click on “Create new” and assign the name of your choice, on availability it will show green check mark and for existing resource group, click “Use existing” and select it from the dropdown menu. 

**Region:** Select the region from dropdown list, where you want to deploy the IoT Hub.

**IoT Hub Name:** Provide a unique name to your IoT Hub, on availability of IoT Hub name it will show the green check mark.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e15.png)

Click **Next: Size and scale**.

Take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

**Basic and Standard Tier:** For IoT solution which require only uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e16.png)

Click **Review + create**. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e17.png)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e18.png)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e19.png)

#### Create a device in Azure IoT Hub

In this lab, we create a device in existing IoT Hub. A device cannot connect to IoT Hub unless it has an entry in the identity registry.

In IoT Hub navigation menu, open **IoT Devices**, then select **Add** to register a new device in your IoT Hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e20.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e21.png)

Provide any user defined name for new device, such as **device-1**, and select **Save**. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e22.png)

This will create a new device identity in IoT hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e23.png)

After the device is created, open the device from the list in the IoT devices pane.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e24.png)

**Copy** the **Connection string---primary key** and **save** it somewhere, this will be used later.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e25.png)

#### Message routing using Event Hub

To add the message routing to IoT hub using Event Hub follow the below steps.

Go to the IoT Hub **resource group** in Azure portal then click on **IoT Hub**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e26.png)

In IoT Hub under **Messaging** blade menu which will appear on left side of window, go to **Message Routing** you see the **Routes** and **Custom endpoints** menu as shown below. For creating customs endpoints, click on Custom endpoints menu then you can create routes.

**Click** on **+Add** to add Event Hubs as custom endpoints select Event Hubs.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e27.png)
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e28.png)

Once selected Add an event hub endpoint screen will be appeared, fill all the required fields. In **Endpoint name** give a unique name and choose the Event Hub namespace from dropdown which you created before. In Event Hub Instance select created EventHub in dropdown, then click on Create.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e29.png)

Now the custom endpoint is added with the provided name.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e30.png)

Initially the custom endpoint state is **Unknown**, once the data is sent it will change **Healthy**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e31.png)

Now select the **Routes** and click on **+ Add** to add route.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e32.png)

Fill all the fields, under name field provide unique name for route. Endpoint field value should.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e33.png)

In **Data source** field select which one you want from drop down. If you already have any routing query use that or else keep the routing query as true and **click** on **OK**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e34.png)

Now the notification Route added, in **Routes** the route is added with the provided name.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e35.png)

The added route will be appeared as shown below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e36.png)

#### Sending data to IoT Hub using online PI simulator

In this lab, we learn the basics of working with Raspberry Pi online simulator and how to seamlessly connect the Pi simulator to the cloud by using Azure IoT Hub.

**Click** on **below link** to launch Raspberry Pi online simulator.

https://azure-samples.github.io/raspberry-pi-web-simulator/#GetStarted

In code editor window, make sure you are working on the default sample application. Remove the placeholder and update the Azure IoT Hub connection string value of **connectionString** variable.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e37.png)

Select **Run** or type **npm start** to run the application.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e38.png)

Once the Simulator start running, it shows below output of the sensor data and the messages that are sent to connected IoT Hub. 

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e39.png)

Messages will start flowing into connected IoT Hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e40.png)

Go to the event hub namespace and click on event hubs **overview**, we can view the Incoming requests, successful requests in graphs like shown below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e41.png)

Now check the custom endpoints in IoT Hub, Event hub endpoint status is turned in to Healthy from Unknown after sending data to IoT Hub. As the routing is enabled so the same data will sent to Event Hubs.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e42.png)

### Event Hub High Availability

We can do the high availability for event hubs using geo recovery feature at event hub namespace level. If any event hub is temporary unavailable, it will affect the components of service. Once the issue is fixed the event hub is available. We loss data from event hubs while any disaster happens, so if we do geo recovery there is no data loss and messages can be recovered once the data center is back up.

Geo recovery option is available for only Standard SKU Event Hubs.

In this Lab we will learn how to do the geo recovery for EventHub.

#### Initiate Pairing

1. Navigate to the deployed or already exist EventHub Namespace’s resource group and click on it.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e43.png)

2. Under **Settings** menu select **Geo-Recovery** blade, click on **Initiate pairing** option.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e44.png)

3. Below fields need to be filled to proceed further.

 * In **subscription** field select the existing subscription where we deployed Primary namespace.

 * In **resource group** field select existing resource group.

 * Select the **location** from dropdown list. 

 * In Secondary namespace field to create new namespace select **create new** option, for the existing one select **Use existing** option. 

 * In Alias give any unique name, click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e45.png)

4. We can see the status of deployment in the Notifications which will take few minutes to complete.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e46.png)

5. Once the deployments get completed, the pairing is happened from primary namespace region to secondary namespace region as shown below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e47.png)

6. The namespaces related information can be seen by scrolling down.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e48.png)

7. If Existing resource group selected then go back to the resource group, if Create new resource for secondary namespace is selected then navigate to that resource group, we can see secondary namespace deployed in different region.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e49.png)

8. **Click** on **secondary EventHub Namespace**, from the left side menu Under **Entities** menu select **Event Hubs** we can find the same Event Hubs present in secondary namespace as of primary namespace, it got replicated after doing the initiate paring.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e50.png)

9. Now **click** on that **event hub** and go to **shared access policies**, here we can see the **alias connection string** is added in keys.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e51.png)

10. Similarly, go to the **primary namespace** - > **Event Hub** and click on **shared access policies** we find here as well the alias connection string is added in keys. Both the namespace’s alias connection strings are same, if alias connection strings are used then there is no need to change the connection strings.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e52.png)

#### Failover

To do a Failover, we are removing (deactivating) the Primary namespace and activating the Secondary namespace as primary. It means if we lost the primary namespace also the secondary namespace will work as same as primary namespace.

1. **Click** on **failover** then provide the **alias name** to do failover and click on **failover** button.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e53.png)

2. It will take few minutes to deploy, once done it will show the completed notification as shown below.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e54.png)

3. After the failover the secondary namespace will become the Primary namespace.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e55.png)

4. If you scroll down you can see the namespace information primary namespace is disapper afer failover and secondary namespace only presented.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/e56.png)

## Lab-4: Create Notification Hub using Azure Portal

### Introduction to Azure Notification Hub

Notification Hub is an entity that we can provision inside of windows azure account. It basically pushes notifications to any platform (iOS, Android, Windows, Kindle, Baidu, etc.) from any backend (cloud or on-premises). They work with any back end, cloud or local and are compatible with .NET, PHP, Java and Node.js.

Azure Notification Hubs allow developers to take advantage of push notifications without having to deal with the back-end complexities of enabling push on their own.

**Common uses for using Azure Notification Hub:** 

* Alerting smartphone users about breaking news or any dangerous conditions.

* Sending location-based coupons to opt-in subscribers.

* Pushing alerts in Safari to website subscribers about new site content.

### Create Notification Hub using Azure Portal

**Log in** to **Azure Portal**, click **+Create a resource** and search for Notification Hub in Search box then select Notification Hub from the drop down.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/n1.png)

Now  click **Create** to continue creating Notification Hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/n2.png)

On the Notification Hub page, do the following Steps:

**Notification Hub:** Specify a name for the notification hub.

**Create a namespace:** Specify a name for the namespace. A namespace contains one or more hubs.

**Location:** Select a location in which you want to create the notification hub.

**Resource Group:** Select an existing resource group or enter a name for the new resource group.

**Subscription:** Select the Subscription in which you want to create Notification Hub.

**Pricing tier:** Notification Hub is offered in three tiers—free, basic and standard. Base charge and quotas are applied at the namespace level. Pushes exceeding included amounts are aggregated at the subscription level for each tier.

Then click **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/n3.png)

After successful deployment you can see the Deployment succeeded message in Notifications.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/n4.png)

Go to **Resource group** -> **Overview** -> *click on created Notification Hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/n5.png)

Click **Access Policies** -> Copy the **Listen connection string** to use later.

**Note:** *Do not use the DefaultFullSharedAccessSignature in your application. This is meant to be used in your back-end only.*

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Intermediate/Images/n6.png)


