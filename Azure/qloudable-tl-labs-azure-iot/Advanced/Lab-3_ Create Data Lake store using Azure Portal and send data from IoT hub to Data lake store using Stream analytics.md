# Lab-3: Create Data Lake store using Azure Portal and send data from IoT hub to Data lake store using Stream analytics

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Creating IoT Hub using Azure Portal](#excercise-1-creating-iot-hub-using-azure-portal)

[Excercise-2: Create data lake store using Azure Portal](#excercise-2-create-data-lake-store-using-azure-portal)

[Excercise-3: Configure Stream Analytics to receive data from IoT Hub](#excercise-3-configure-stream-analytics-to-receive-data-from-iot-hub)

[Excercise-4: Configuring Stream Analytics to send data to Data Lake storage](#excercise-4-configuring-stream-analytics-to-send-data-to-data-lake-storage)

[Excercise-5: Exercise-5: Run the Stream Analytics job](#excercise-5-run-the-stream-analytics-job)]

## Overview

### Scenario and Objective

* Create an Azure Time Series Insights environment

* Create an IoT hub by using the Azure portal and create a device in IoT Hub

* Send data to IoT Hub using online PI simulator

## Pre-Requisites


## Excercise-1: Creating IoT Hub using Azure Portal

1.Using the Chrome browser, login into Azure portal with the below details.

```
Azure Username: {{ Portal Username }}

Azure Password: {{ Portal Password }}

```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

2.	Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/3.png?st=2019-09-11T11%3A50%3A06Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v6dBYoq%2F7vlT4UjRqk38%2BnvSS5FUaJ7LpWPDyoJAq8I%3D)

Click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/4.png?st=2019-09-11T11%3A50%3A24Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jlF%2B4t0e1zjqOg1fXINUx68qXhwGEdTZzm3mz9NYltc%3D)

Then you will see the below screen, fill all the required fields.

```
Subscription: Select the default

Resource Group: {{ ResourceGroup }}

Region: {{ Location }}

IoTHub Name :Enter globally unique name for your IoT Hub. If the name you provided is available, then a green check mark will appear.

Click Next: Size and scale to proceed further with creating IoT hub.

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/5.png?st=2019-09-11T11%3A50%3A47Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xkk3I83%2Fa9hDOvKNnuWPo3QTreMLONNQ95AFKKBOze4%3D)

You can take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

*Basic and Standard Tier:*

For IoT solution which require only Uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/6.png?st=2019-09-11T11%3A51%3A12Z&se=2021-09-12T11%3A51%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=iFjwxYBtJ2L3ElhodF1s8mZgMdXnw3mu6UjxMF0c5sE%3D)

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/7.png?st=2019-09-11T11%3A53%3A47Z&se=2021-09-12T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i%2B4Vi1zo%2FSk6oDgqzYWAk%2FbyYzhvgxLmafVe83Bnotg%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/8.png?st=2019-09-11T11%3A54%3A06Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xmqw4ouj6WGdhHayZFKu8Bh44pGbkq%2B1QC4J%2BnlNQR0%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/9.png?st=2019-09-11T11%3A54%3A26Z&se=2021-09-12T11%3A54%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7fr6vmehaTkBOslBH3rEYh3jW8BFVLDnhn0l28IPas8%3D)


## Excercise-2: Create data lake store using Azure Portal

**Data Lake**

Azure Data Lake Storage, Gen2 is now available for GA. Data Lake Storage Gen2 is the result of converging the capabilities of two existing storage services: Azure Blob Storage and Azure Data Lake Storage Gen1. Features from Azure Data Lake Storage Gen1, such as file system semantics, file-level security and scale are combined with low-cost, tiered storage, high availability/disaster recovery capabilities from Azure Blob Storage.

Azure Data Lake enables you to capture data of any size, type, and ingestion speed in one single place for operational and exploratory analytics. Data Lake Storage Gen1 can be accessed from Hadoop (available with HDInsight cluster) using the WebHDFS-compatible REST APIs. It's designed to enable analytics on the stored data and is finetuned for performance of data analytics scenarios. Data Lake Storage Gen1 includes all enterprise-grade capabilities like security, manageability, scalability, reliability, and availability.

Open the **Azure Portal**, click **+Create a resource** and search for Data Lake Storage and select **Data Lake Storage Gen1**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l1.png?sv=2019-10-10&st=2020-10-21T11%3A38%3A31Z&se=2023-10-22T11%3A38%3A00Z&sr=b&sp=r&sig=grfWq7BZbNAOvn1zQE5MbghX1pFqstfpS2FfoSTCG8U%3D)

Click on **Create** to create a Data Lake Storage  (Gen1).

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l2.png?sv=2019-10-10&st=2020-10-21T11%3A39%3A13Z&se=2023-10-22T11%3A39%3A00Z&sr=b&sp=r&sig=7%2FH70FhqL1xdN3OUgnu%2FLP8jAZxR3syLAlnqo%2B47Suk%3D)

Fill in the fields as shown below with required values.

```
Name: Give a name for Data Lake Storage. 

Subscription: select the default subscription.

Resource group: {{ ResourceGroup }}

Location: {{ Location }}

Pricing package: Basic

```

Click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l3.png?sv=2019-10-10&st=2020-10-21T11%3A39%3A41Z&se=2023-10-22T11%3A39%3A00Z&sr=b&sp=r&sig=ubUsU4AG1qHTTsCHrGnXgoRRteuzH%2FzAtLGUDpBpk1c%3D)

After a successful deployment, you’ll receive a notification stating that your deployment was successful as shown in the below screenshot.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l4.png?sv=2019-10-10&st=2020-10-21T11%3A40%3A17Z&se=2023-10-22T11%3A40%3A00Z&sr=b&sp=r&sig=4E5HaCba1vY1zKp7Vhzq0BUHQbtx85KeGwsNl6eSa8Y%3D)

## Excercise-3: Configure Stream Analytics to receive data from IoT Hub

Go to **Resource group** and click on **stream analytics job**. The overview section under the Stream analytics shows the Inputs, Outputs and Query options.

You need to set the **Inputs**, **Outputs** and then you will proceed to writing a **query** which can take in the inputs and send the values to the configured output. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l5.png?sv=2019-10-10&st=2020-10-21T11%3A40%3A59Z&se=2023-10-22T11%3A40%3A00Z&sr=b&sp=r&sig=lpUYMa7f29CgG24fviZy3QjclEEmR87PNL1TZjN7nLc%3D)

Click **Inputs** under job topology from the navigation pane on the left and click on Add **stream input** and then you can select any option from the **IoT Hub/ Event hub/Blob storage**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l6.png?sv=2019-10-10&st=2020-10-21T11%3A41%3A31Z&se=2023-10-22T11%3A41%3A00Z&sr=b&sp=r&sig=LnPQpjQCrShd%2Bb9oK2a4vuYPsEARK2WB7%2FAGXtuz%2F50%3D)

Click on the **Inputs** label and click on **Add stream input** and then select the **IoT Hub**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l7.png?sv=2019-10-10&st=2020-10-21T11%3A42%3A15Z&se=2023-10-22T11%3A42%3A00Z&sr=b&sp=r&sig=hOgaXhyEA89MAtbqzIGp2t3H9JO94B9dZjxCftPGGzg%3D)

On the next step, you will have options to either select the existing IoT hub or to create a new IoT Hub. As we already have IoT hub created, we’ll proceed to selecting the existing one. 

**Note:** *Refer section 4.2 for Creating IoT Hub.*

Fill in the fields on **IoT Hub for new Input** section with the values as instructed below:

```

Input alias: Enter a name to identify the job’s input.

Subscription: Select the Azure subscription that has the storage account you created.

IoT Hub: Enter the name of the IoT Hub you created in the previous section.

```

Leave other fields to defaults, click on **Save** to save the settings.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l8.png?sv=2019-10-10&st=2020-10-21T11%3A42%3A48Z&se=2023-10-22T11%3A42%3A00Z&sr=b&sp=r&sig=N%2F3PpVXWcO%2Fn9hRQEwpgOc4LlPk1%2FGi1qk7fMCodDY0%3D)

Now you have successfully configured the input. You can see the configured Input under Inputs as shown in the below screenshot.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l9.png?sv=2019-10-10&st=2020-10-21T11%3A44%3A25Z&se=2023-10-22T11%3A44%3A00Z&sr=b&sp=r&sig=ct%2BsmyBY6%2F42%2FZP%2B%2BgvyrGrOihBRkEjjARLF%2FrFJtGk%3D)

## Excercise-4: Configuring Stream Analytics to send data to Data Lake storage

Go to the **Outputs** under Job topology section and click **Add** and then select any one of the options from below output options list to store the received data from input source.	

Click on **Outputs** -> **Add** -> Select **Data Lake Storage Gen1**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l10.png?sv=2019-10-10&st=2020-10-21T11%3A44%3A55Z&se=2023-10-22T11%3A44%3A00Z&sr=b&sp=r&sig=Ld8d2npgmlFBtvHczMZZCtqVoMgw21gByys9ixS50dI%3D)

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

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l11.png?sv=2019-10-10&st=2020-10-21T11%3A45%3A20Z&se=2023-10-22T11%3A45%3A00Z&sr=b&sp=r&sig=w4n%2BoZynjhvaOQA2tAS9d9wKL4svzlLUJuCecd4s2tk%3D)

* **Authentication mode**: Select “User Token”.

* You will be prompted to authorize access to the Data Lake Storage Gen1 account. Click on **Authorize**.

* For Delimiter, select tab.

Click on **Save**, which will now add the output and tests the connection to it.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l12.png?sv=2019-10-10&st=2020-10-21T11%3A45%3A45Z&se=2023-10-22T11%3A45%3A00Z&sr=b&sp=r&sig=dCCdAZAHOxf23RdJ6WbsOK1RW3VcAG5LdUGDR1UrmuE%3D)

## Excercise-5: Run the Stream Analytics job

To run a Stream Analytics job, you must run a query from the **Query** tab. You can run the sample query by replacing the placeholders with the job input and output aliases, as shown in the screen capture below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l13.png?sv=2019-10-10&st=2020-10-21T11%3A46%3A10Z&se=2023-10-22T11%3A46%3A00Z&sr=b&sp=r&sig=rWOB0RqfZ%2Fy5zHVGTs8VCNUIC1OMYiRjCPCAPzsB6Ek%3D)

From the Overview tab, click on **Start**. From the dialog box, select **Now** for **Job output start time**, and then click on **Start**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l14.png?sv=2019-10-10&st=2020-10-21T11%3A46%3A54Z&se=2023-10-22T11%3A46%3A00Z&sr=b&sp=r&sig=mzLI7q4rgsCQn71aBc3V%2FcVbo9byfpetpZYaTo2QR7E%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l15.png?sv=2019-10-10&st=2020-10-21T11%3A47%3A19Z&se=2023-10-22T11%3A47%3A00Z&sr=b&sp=r&sig=%2B6wVj23%2BYw8j0XBBRg8656GP6ZIN8jED2NFcqY%2F3C4s%3D)

It can take up to a couple minutes to start the job.

You can verify that the job output data is available in the **Data Lake Storage Gen1 account**.

In the **Data Explorer** pane, notice that the **output** is written to a folder path as specified in the Data Lake Storage Gen1’s output settings (streamanalytics/job/output/{date}/{time}).

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l16.png?sv=2019-10-10&st=2020-10-21T11%3A47%3A45Z&se=2023-10-22T11%3A47%3A00Z&sr=b&sp=r&sig=vX8%2FaH1gUGLKBV%2BJZZcWV5BD1yvKIev1A8cbf8z1Bj4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l17.png?sv=2019-10-10&st=2020-10-21T11%3A48%3A14Z&se=2023-10-22T11%3A48%3A00Z&sr=b&sp=r&sig=sfqwi3JV6AnrOqeSfDYihOq%2F%2FgUAqXPdloVZ4%2FTIDH8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/l18.png?sv=2019-10-10&st=2020-10-21T11%3A48%3A43Z&se=2023-10-22T11%3A48%3A00Z&sr=b&sp=r&sig=Raa8Rtda4%2FB3lvgef41GnX0gCyQfpzp7aE1OhRJkWPo%3D)
