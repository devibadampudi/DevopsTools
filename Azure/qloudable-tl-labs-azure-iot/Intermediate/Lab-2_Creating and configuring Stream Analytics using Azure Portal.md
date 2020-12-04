# Lab-2: Creating and configuring Stream Analytics using Azure Portal

## Table of Contents

[Overview](#Overview)

[Pre-requisites](#pre-requisites)

[Excercise-1: Creation of IoTHub using Azure Portal](#excercise-1-creation-of-iothub-using-azure-portal)

[Excercise-2: Creation of CosmosDB using Azure Portal](#excercise-2-creation-of-cosmosdb-using-azure-portal)

[Excercise-3: Create Stream Analytics job using Azure Portal](#excercise-3-create-stream-analytics-job-using-azure-portal)

[Excercise-4: Configure Stream Analytics to receive data from IoT Hub](#excercise-4-configure-stream-analytics-to-receive-data-from-iot-hub)

[Excercise-5: Configuring Stream Analytics to send data to Cosmos DB](#excercise-5-configuring-stream-analytics-to-send-data-to-cosmos-db)

##  Overview

The aim of this lab is to creating Azure Stream Analytics using Azure Portal.Configuring Azure Stream Analytics to reveive data from IoTHub and send data to CosmosDB.

#### Introduction to Stream Analytics job

Azure Stream Analytics is an event processing engine, which can process large amounts of data from a live stream. The input sources can be anything from devices, sensors, websites, live feeds and applications. The data collected from these devices can be used to derive relationships and patterns to trigger other defined actions like alerts, reports and data storage. The Stream analytics job has two components.

* Input source

* Output source

**Input source:** The input source is the source of your streaming data. You can select any from IoT Hub, Event hub and Blob storage.

We’ll choose IoT Hub as an input source for this demo purpose.

**Output source:** The output source can be any output configuration to store or present the transformed data. Any of the following can be your output source.

SQL Data base, Blob Storage, table storage, Service bus topic, Service bus queue, Cosmos Db, Power BI, Azure data lake store and Azure functions.

Here I am taking the output source as Cosmos DB.

For this demo purpose, we’ll here be using Cosmos DB as our output source.

##  Pre-requisites

*   Azure portal Access.
*   Familiar with Azure portal.

**Note**: Azure Portal access is provided as part of the Lab environment

##  Excercise-1: Creation of IoTHub using Azure Portal

1.Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal1.png?sv=2019-10-10&st=2020-10-08T12%3A27%3A55Z&se=2023-10-09T12%3A27%3A00Z&sr=c&sp=rl&sig=w7H%2BoHxSPy70CyboWV%2BDdGUK88Ec2vm459DXq3%2B80NI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal2.png?sv=2019-10-10&st=2020-10-08T12%3A27%3A55Z&se=2023-10-09T12%3A27%3A00Z&sr=c&sp=rl&sig=w7H%2BoHxSPy70CyboWV%2BDdGUK88Ec2vm459DXq3%2B80NI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal3.png?sv=2019-10-10&st=2020-10-08T12%3A27%3A55Z&se=2023-10-09T12%3A27%3A00Z&sr=c&sp=rl&sig=w7H%2BoHxSPy70CyboWV%2BDdGUK88Ec2vm459DXq3%2B80NI%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal4.png?sv=2019-10-10&st=2020-10-08T12%3A27%3A55Z&se=2023-10-09T12%3A27%3A00Z&sr=c&sp=rl&sig=w7H%2BoHxSPy70CyboWV%2BDdGUK88Ec2vm459DXq3%2B80NI%3D)


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

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/7.png?st=2019-09-11T11%3A53%3A47Z&se=2021-09-12T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i%2B4Vi1zo%2FSk6oDgqzYWAk%2FbyYzhvgxLmafVe83Bnotg%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/8.png?st=2019-09-11T11%3A54%3A06Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xmqw4ouj6WGdhHayZFKu8Bh44pGbkq%2B1QC4J%2BnlNQR0%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/9.png?st=2019-09-11T11%3A54%3A26Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7fr6vmehaTkBOslBH3rEYh3jW8BFVLDnhn0l28IPas8%3D)

### Creating devices on Azure IoT Hub

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

### Sending data to IoT Hub using online PI simulator

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

##  Excercise-2: Creation of CosmosDB using Azure Portal 

1.  In the Azure portal **Click** on **+Create a resource**.

2.  **Search** for **Azure Cosmos DB** in search box and **Click** Azure **Cosmos DB Service** in the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/21.png?st=2019-10-18T06%3A28%3A42Z&se=2022-10-19T06%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=XerurQQsStXG2zNhxUiZWJukjwp6uPkOApMJIwV9aKA%3D)

3.  Then click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/22.png?st=2019-10-18T06%3A30%3A24Z&se=2022-10-19T06%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=1p5DK2yT0pMnkCwbtv1k31tBtcy3wULQ6BGTEOQUj1M%3D)

Upon navigating to the **create page**, fill in the fields to create Cosmos DB instance.

`subscription`: select the default subscription

`Name` :Provide a unique name to your cosmos DB account.

`Resource group`: {{resource-group-name}}

Choose the API and data model to use with this account from dropdown.

`Region` : {{location}}


![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/23.png?st=2019-10-18T06%3A30%3A50Z&se=2022-10-19T06%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=xLiXkXKwimxlLKFNde92WlD3YqGO8Aum%2FDe%2BokEzpZc%3D)

Then click on **Review + create**, after making sure you add any tags you wish to. 

Then click on **Create**. It may take a few minutes to provision your Cosmos DB instance.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/24.png?st=2019-10-18T06%3A31%3A43Z&se=2022-10-19T06%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qyfCE35bqfvSsvA8s7jm%2BewX6BJfUh%2BqSMGK73302%2Bg%3D)

You can monitor the deployment process by clicking on the deployment notification. Once the Cosmos DB is successfully deployed, **click** on **Go to resource**.

#### Creating Database, Containers in Cosmos DB

In this section you’ll see how to provision throughput on a database in azure Cosmos DB through azure portal. You can also do the same using azure cosmos DB SDKs. You can also, provision the throughput in database and share that throughput among the containers within the database.

**Note:** You can create databases and collections, manually or through any SDK API calls, by navigating to data explorer under Cosmos DB overview.

1. Navigate to the **Resource group**, where you created the Cosmos DB and **click** on **Cosmos DB**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c7.png?st=2019-10-18T07%3A06%3A02Z&se=2022-10-19T07%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jjrwZDAUNwTGKy5PXtuIB2T0BdcvB4TKcS33BYkp4bc%3D)

2. Under Cosmos DB **overview** options, **click** on the **Data Explorer** and **click** on the **New Container** drop down to select **New Database** to create a database.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c8.png?st=2019-10-18T07%3A06%3A23Z&se=2022-10-19T07%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=E8w8h%2BQMaSjgZwT0VUy3YbjAYqeXEgPhlDb18An77sY%3D)

3. Proceed to enter desired database name in **Database id** field and **check** the **provision throughput** check box to set the throughput, then **click** on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c9.png?st=2019-10-18T07%3A06%3A38Z&se=2022-10-19T07%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ImuCk6PKG6odht2m9y0WruxwhtzZH%2FFSQYHfPi1hZk0%3D)

4. Now you can see the database is created under the Cosmos DB.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c10.png?st=2019-10-18T07%3A06%3A54Z&se=2022-10-19T07%3A06%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tFEQAoTDnbFBJLgaWii9Xp65N8V%2BKviqYnMHcSohNDw%3D)

5. **Click** on the database drop down to create a container, select **New Container**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c11.png?st=2019-10-18T07%3A07%3A10Z&se=2019-10-19T07%3A07%3A10Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BaRninZSb9QqyTGcj9nXot%2BaF1Vq4jR%2FBDMb0SxPxwA%3D)

6. As shown in the screenshot below, enter the **container id** to have a unique name, and **partition key** to look like **/<containerid>**. **Select** the **provision dedicated throughput** and set it to desired value and click on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c12.png?st=2019-10-18T09%3A42%3A50Z&se=2022-10-19T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vzA1dDNY393KuEqTcBasXltxk8AlW9xdZwcfBcRubxQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c13.png?st=2019-10-18T09%3A43%3A07Z&se=2022-10-19T09%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oX12M5hMpebkkNHYjjoyBuXZbjcGMLZ6Y9IcV4o6%2BZQ%3D)

7. You can see your container just created in the database as shown in the screenshot below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/c14.png?st=2019-10-18T09%3A43%3A32Z&se=2022-10-19T09%3A43%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kaH%2FDK9Wjxc6gBdEfGgqaNLQU2vV5LyeKDMn37QGjIo%3D)

##  Excercise-3: Create Stream Analytics job using Azure Portal

Open the **Azure Portal**, click **+Create a resource** and search for Stream analytics. Select **Stream Analytics job**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/26.png?st=2019-10-18T06%3A33%3A28Z&se=2022-10-19T06%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4SpeSdBnlXzRVQOqxH97BYSPb14vZJC6lQFHX402Yls%3D)

Click **Create** to create Stream Analytics.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/27.png?st=2019-10-18T06%3A33%3A45Z&se=2022-10-19T06%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FwofuTfHzYMBCiuKLvYwCQJgekVhofasyjvBO%2F%2F7bHM%3D)

Fill in the fields as shown below with required values.

`Job name`: Give name for the Stream Analytics. 

`Subscription`: Select the default subscription .

`Resource group`: {{resource-group-name}}

`Location`: {{location}}.

Then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/28.png?st=2019-10-18T06%3A34%3A03Z&se=2022-10-19T06%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=SH9CvVWVUs3z%2BhV73KFwOWeqr1O1SDnk%2B%2BR2NMdQijg%3D)

After a successful deployment, you’ll receive a notification stating your deployment was successful as shown in the below screenshot.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/29.png?st=2019-10-18T06%3A34%3A22Z&se=2022-10-19T06%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EMUj8aw6Xou0EaOPUX9xHNOWHoFZy6n0im5zCy7GEEo%3D)

Go to **Resource group** and **click** on **Stream Analytics job**, you just created. Overview section under the Stream analytics shows the Inputs, Outputs and Query options.

You need to set the Inputs, Outputs and then you will proceed to writing a query which can take in the inputs and send the values to the configured output. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/30.png?st=2019-10-18T06%3A35%3A14Z&se=2022-10-19T06%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HEXOH1INkQOOzql9pylwO%2Fw7cnlxiHH2bgP4l7BI4PA%3D)

##  Excercise-4: Configure Stream Analytics to receive data from IoT Hub

In the left side menu, click **Inputs** under job topology and click on **Add stream input** and then you can select any option from the **IoT Hub/ Event hub/Blob storage**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/31.png?st=2019-10-18T06%3A35%3A44Z&se=2022-10-19T06%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gWNYdomAnt7gOAwXFuMLackbpg1eUJC3JyDYzsrJ6io%3D)

**Click** on the **Inputs** label and navigate to **Add stream input** and then select the IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/32.png?st=2019-10-18T06%3A49%3A13Z&se=2022-10-19T06%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2BAS3EQD%2FHis%2FuDdLcytPSjNuers8hs5iqhhcNhX4iOc%3D)

On the next step, you will have options to select the existing IoT hub and to create a new IoT Hub. As we already have IoT hub created, we’ll proceed to selecting the existing one. 

Fill in the fields on IoT Hub page with the following values:

```

Input alias: Enter a name to identify the job’s input.

Subscription: Select the default subscription.

IoT Hub: Enter the name of the IoT Hub you created in the previous section.

Leave other fields to defaults, click in Save to save the settings.

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/33.png?st=2019-10-18T06%3A49%3A56Z&se=2022-10-19T06%3A49%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yhCG%2FRPUgRxRoPw7lX6WsD%2FNiARb4qO1LiPRUMp98xQ%3D)

Now you have successfully configured the input. You can see the configured Input under Inputs as shown in the below screenshot.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/34.png?st=2019-10-18T06%3A50%3A20Z&se=2022-10-19T06%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wE9v6%2B9kOEuGZ5zPAxf9xpO%2FqzCKHVvZGPEVcCceEcg%3D)

##  Excercise-5: Configuring Stream Analytics to send data to Cosmos DB 

Click on the **Outputs** under Job topology section and click **Add** and then select any one of the options from below output options list to store the received data from input source.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/35.png?st=2019-10-18T06%3A57%3A02Z&se=2022-10-19T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=KSMdpRibGnwJXf5ooX8u%2ByoYrQDfWfe2Iw0GPl7OaVo%3D)

Click on **Outputs** -> **Add**-> Select **Cosmos DB**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/36.png?st=2019-10-18T06%3A57%3A19Z&se=2022-10-19T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=RghZMwkeg45goHqzolORwxxkC%2F6AbvpF4JsQkbk0yZ4%3D)

After selecting Cosmos DB as output to stream analytics job, fill in the fields on next page as in the instructions below. 

```
Output alias: Name of your output source

Subscription: select the default subscription

Account ID: The name or endpoint URI of the Azure Cosmos DB account

Account key: The shared access key for the Azure Cosmos DB account

Database: The Azure Cosmos DB database name. You can create a new database .

Collection name pattern: The collection name for the collection to be used. 

Document ID: Optional. The column name in output events used as the unique key on which insert, or update operations must be based. If left empty, all events will be inserted, with no update option.

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/37.png?st=2019-10-18T06%3A57%3A48Z&se=2022-10-19T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DA5%2FyBJGUyrGFNwiHzEIjdVrhsmDb%2FZCZLRYV%2BX%2FJB8%3D)

Now that you have configured both the input and output source, click on Edit query, where you can write your queries.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/38.png?st=2019-10-18T06%3A58%3A10Z&se=2022-10-19T06%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ajlvElPcaH2mWH9sjY5N1yiz7%2FvwBjXITFPh%2FgI7Tm4%3D)

We will be using a simple SQL Query to send data from IoT Hub to Cosmos DB.

**Query:**

```

`SELECT * INTO [YourOutputAlias] FROM [YourInputAlias]`

```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/39.png?st=2019-10-18T06%3A58%3A28Z&se=2022-10-19T06%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pSuAseTwIZDSRMVy2toJ0G%2FNCwBSuscjcQZSLN1pfjc%3D)

**Note:** *Before streaming data from IoT Hub to Cosmos DB, you need to send data to IoT Hub using Online PI Simulator.*

Now click on **Start** to stream the data from IoT Hub to Cosmos DB.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/40.png?st=2019-10-18T06%3A58%3A48Z&se=2022-10-19T06%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=BhxHYcLBtKuhf%2B%2FRHDlQEphh83AYG0Aqigp2tZnKkaE%3D)

Select Job output start time and then click on **Start**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/41.png?st=2019-10-18T06%3A59%3A02Z&se=2022-10-19T06%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gfEXzPK4qdj3LQW6aem7b8SkTAoBxr35G4VBG2%2BWDMo%3D)

You could see the message **Streaming job started successfully** on the notification bar.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/42.png?st=2019-10-18T06%3A59%3A22Z&se=2022-10-19T06%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=HNytdC75Vk%2B9aloPOIDWBW%2BS9Pg6lTxrfNmotL9n348%3D)

You can see the status of Job change to **running** after a while.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Intermediate-Lab2-creating%20and%20configuring%20Azure%20stream%20analytics/43.png?st=2019-10-18T06%3A59%3A37Z&se=2022-10-19T06%3A59%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2B7XAertzhWrxAZYdaPCgBiujZwelw4Ak46FSwOMwZgQ%3D)
