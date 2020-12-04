# Lab-1 : Create Cosmos DB using Azure Portal and Cosmos DB High Availability

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Exercise 1: Create Cosmos DB using Azure Portal](#exercise-1-create-cosmos-db-using-azure-portal)

[Exercise 2: Cosmos DB High Availability](#exercise-2-cosmos-db-high-availability)


## Overview

The main aim of this lab is creating CosmosDB using Azure portal and Cosmos DB High Availability.

### Scenario and Objective

In this Lab you will Learn

1. Create Cosmos DB using Azure Portal

2. Cosmos DB High Availability

## Pre-Requisites

* Azure Portal

## Exercise 1: Create Cosmos DB using Azure Portal

Using the Chrome browser, login to Azure Portal with the below details:

```
Azure Username : {{ Portal Useremail }}

Azure Password : {{ Portal Password }}
```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/l1.png?st=2019-09-30T05%3A13%3A03Z&se=2026-10-01T05%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=bNpC5%2F4qLbuCQVqWkzFxYt96%2BryV%2BTeQXj9CHQCtd9g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/l2.png?st=2019-09-30T05%3A15%3A19Z&se=2026-10-01T05%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4TWKhhkh20iSQVb%2Bhq%2Fdqjb%2BGW3lBBGMFpsRpSk4LiU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/l3.png?st=2019-09-30T05%3A15%3A46Z&se=2027-10-01T05%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wNKk%2FyqG93NN0NKbAyego27XMoV2kOmPG0qNeep1FuQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/l4.png?st=2019-09-30T05%3A16%3A08Z&se=2025-10-01T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QqgNVoEFpJGz4HZT6uRcrrUxeBt1HOyMKi46vA9IvV0%3D)


**Click** on **+Create a resource**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c1.png?st=2019-09-30T05%3A16%3A35Z&se=2025-10-01T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=77g0J72fT7ISTZAVWKEzfFcVgFZ%2BSfzR1gAPR7Vvt3c%3D)

**Search** for **Azure Cosmos DB** in search box and **Click** Azure **Cosmos DB Service** in the list.
bnj
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c2.png?st=2019-09-30T05%3A16%3A54Z&se=2025-10-01T05%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uGz8QUnUuYNaMyHQQaXFoc%2BkL32kpd5D0%2B2%2B3nXbxTQ%3D)

Then click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c3.png?st=2019-09-30T05%3A17%3A15Z&se=2025-10-01T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2YA77qODRpx0M9QvG4nzQEIGYAVdbz2qPyYHtUabDow%3D)

Upon navigating to the **create page**, fill in the fields to create Cosmos DB instance.

1. **Select** the specific **subscription** you want to deploy the Device Provisioning Service.

2. Give a **unique name** to your cosmos DB account.

3. You can **create** a **new resource group** or **select** an **existing resource group** in your portal. To create a new resource group, click on Create new and assign the name you want to use for the resource group, to use an existing resource group, click Use existing and select the resource group from the 

dropdown. 

4. **Choose** the **API and data model** to use with this account from dropdown.

5. **Select** the **region** from dropdown list, in which location you want to deploy the device provisioning service.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c4.png?st=2019-09-30T05%3A17%3A34Z&se=2025-10-01T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=OM812dqE8oxXcSg0lsrgD%2Bc3Yv31Sr4%2B%2FGBx3Ver1Ss%3D)

Then click on **Review + create**, after making sure you add any tags you wish to. 

Then click on **Create**. It may take a few minutes to provision your Cosmos DB instance.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c5.png?st=2019-09-30T05%3A17%3A58Z&se=2025-10-01T05%3A17%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DqBVl%2FUmPQVd8ssoiytPgV5SvIJSaWTNZ%2FQHltnfpCU%3D)

You can monitor the deployment process by clicking on the deployment notification. Once the Cosmos DB is successfully deployed, **click** on **Go to resource**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c6.png?st=2019-09-30T05%3A18%3A15Z&se=2025-10-01T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sKhiMIj35RXGlv67NumZzVH%2FOTtcjOUnqj6BH5nTB0M%3D)

#### Creating Database, Containers in Cosmos DB

In this section you’ll see how to provision throughput on a database in azure Cosmos DB through azure portal. You can also do the same using azure cosmos DB SDKs. You can also, provision the throughput in database and share that throughput among the containers within the database.

**Note:** You can create databases and collections, manually or through any SDK API calls, by navigating to data explorer under Cosmos DB overview.

1. Navigate to the **Resource group**, where you created the Cosmos DB and **click** on **Cosmos DB**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c7.png?st=2019-09-30T05%3A18%3A34Z&se=2025-10-01T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yMChp6aqCZ3xpF0cfjReEnwY6GCq9IFaMOKJ7OWryD0%3D)

2. Under Cosmos DB **overview** options, **click** on the **Data Explorer** and **click** on the **New Container** drop down to select **New Database** to create a database.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c8.png?st=2019-09-30T05%3A18%3A54Z&se=2026-10-01T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=M7l%2FPLefk%2BSzyp4UnMvk8w00uLyGTbI3ZCCp7Fd2v2w%3D)

3. Proceed to enter desired database name in **Database id** field and **check** the **provision throughput** check box to set the throughput, then **click** on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c9.png?st=2019-09-30T05%3A19%3A14Z&se=2026-10-01T05%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TOSHt4LUjyQXuLKjQuH%2B1%2F%2F2kGn1Ghu3O1104Jv5lWI%3D)

4. Now you can see the database is created under the Cosmos DB.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c10.png?st=2019-09-30T05%3A19%3A38Z&se=2026-10-01T05%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jc80KJjvRtTGnhdPXTlCp9tfkIV4JIY0Irkj%2BJe9ypM%3D)

5. **Click** on the database drop down to create a container, select **New Container**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c11.png?st=2019-09-30T05%3A19%3A55Z&se=2025-10-01T05%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=J2RPtMRYFIIxJpV6UXrqeV%2Fkbrkn9y23fm1fpU2oeew%3D)

6. As shown in the screenshot below, enter the **container id** to have a unique name, and **partition key** to look like **/<containerid>**. **Select** the **provision dedicated throughput** and set it to desired value and click on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c12.png?st=2019-09-30T05%3A20%3A12Z&se=2025-10-01T05%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Nttz9vPHwzHN1R8GE7P8%2BP4Xs2%2B2eLv%2BtniPJHiiYeg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c13.png?st=2019-09-30T05%3A20%3A32Z&se=2025-10-01T05%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=seGPGgwdogUmqmsRZSfF3ae9lMVqgnAXw24j7d9YH4U%3D)

7. You can see your container just created in the database as shown in the screenshot below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c14.png?st=2019-09-30T05%3A20%3A51Z&se=2025-10-01T05%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gBDleT0Zk8YbLZCmUlppizGir%2Fm1RMh7%2Bz7nbGg1K3k%3D)

## Exercise 2: Cosmos DB High Availability

Azure cosmos DB ensures that your data is always highly available in due to their high availability features. Multi master feature of cosmos DB can be used to distribute your data in multiple regions and add multiple read and write regions.

You’ll need to perform no action in cases of any regional failover occurrences.

We can configure high availability for cosmos DB in two ways. One being manual fail over and other one is automatic fail over. You’ll first need to select the regions, before you perform any fail over.

### Configure Azure Regions

Go to the **Resource group**, you deployed the cosmos DB and **click** on the **Cosmos DB** instance to see the overview options.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c15.png?st=2019-09-30T05%3A21%3A33Z&se=2025-10-01T05%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5THqkCxwjakAMYpuFhUN1Kxd1SoqX6I58sQvDi0bga8%3D)

On the overview options, **click** on the **Replicate data globally** option to configure high availability for the cosmos DB.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c16.png?st=2019-09-30T05%3A21%3A52Z&se=2026-10-01T05%3A21%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QvxXcLMIn3QGjRmNLetk6BWtBBNfbabrciCWoDP8Y9I%3D)

You can add multiple Read and Write regions by clicking on **+Add Region** to your Cosmos DB instance.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c17.png?st=2019-09-30T05%3A22%3A12Z&se=2025-10-01T05%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=N3G%2BOy%2BrHA78KpGWaG3TDFe6DDJwVL7Gf9doLI2g7IQ%3D)

**Select** the specific **region** you’d wish to make additional read region, from drop down list and click on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c18.png?st=2019-09-30T05%3A22%3A34Z&se=2025-10-01T05%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ze7LkR2Igr0aEuXV%2FUjd8enhWJPG1usicHJA3NJxU08%3D)

**Save** the changes to add selected region, to the read regions list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c19.png?st=2019-09-30T05%3A22%3A52Z&se=2025-10-01T05%3A22%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tLfMU%2FonDzSH2sHhBMW0ABX3yseGk%2BjwVeN8HBwt8ag%3D)

It will take few minutes to configure the regions and the changes to be updated in the read regions list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c20.png?st=2019-09-30T05%3A23%3A09Z&se=2025-10-01T05%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Hr6iCwBlpz9rIEjrHhwvlerQB2nzIAUKlhk%2B6IUbET0%3D)

Upon the success notification, you can now see the added regions on your Cosmos DB home by **refreshing** the page. You can also scale the number up and down in the same way.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c21.png?st=2019-09-30T05%3A23%3A30Z&se=2025-10-01T05%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=2k4UCHG6xytecYinlL0xCyPsk0FHj8WeZXr9XgfFcDM%3D)

### Manual Failover

Manual failover is a feature of the cosmos DB, that allows users to failover cosmos DB operations from a write region to the selected Azure read region. Manual failover can be useful in situations like any regional disaster.

1. **Click** on **Manual Failover** option, then you can make the read region as write region and write region as read region by following the steps below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c22.png?st=2019-09-30T05%3A23%3A56Z&se=2025-10-01T05%3A23%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kJgq0Q3fOk0V%2F3m02miKUJsr9rakqIIGUmCBAQvaK%2FQ%3D)

2. **Select** a **read region**, which one you want to switch to a write region and click on **OK**. We have selected East US for this demo. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c23.png?st=2019-09-30T05%3A24%3A14Z&se=2025-10-01T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JrmOabZupaSci%2FHo8z46kBBcKsyvWsTzizfZV7zYZGE%3D)

3. It will take a few minutes to complete the manual fail over operation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c24.png?st=2019-09-30T05%3A24%3A35Z&se=2025-10-01T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sqrITiTc0ODLtm%2BZWFn14mKMJasL9n%2FAHRuJsBUS%2Fvo%3D)

4. You’ll receive a notification as in below screenshot after the operation is successful.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c25.png?st=2019-09-30T05%3A24%3A54Z&se=2025-10-01T05%3A24%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=tg1JnZcvqPAoaqNUHK9Qy%2FKJClAErU5f9vwImE7IVik%3D)

5. You can now **refresh** the page to see the Read/Write regions are switched.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c26.png?st=2019-09-30T05%3A25%3A18Z&se=2025-10-01T05%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dEzYx5xPm5K5Pu%2BdHGpKTocARcT89fIPpyFsez0S0q0%3D)

### Automatic Failover

You can use automatic failover option to failover the impact region to another region. 

This is set to happen automatically depending on health of infrastructure in the respective region.

1. **Click** on the **Automatic Failover** as shown in the screenshot below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c27.png?st=2019-09-30T05%3A25%3A41Z&se=2025-10-01T05%3A25%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fp5aTVP44%2BchAd9pkkRdFCO3f%2FCzTwgG2Erwdb4L4Mw%3D)

2. **Toggle** the **ON/OFF** button to switch on the automatic failover.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c28.png?st=2019-09-30T05%3A26%3A10Z&se=2025-10-01T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=US1cJ07ZtwZOnKBvSY44Ku1snIdg1Pdp%2FZNIPdgstQw%3D)

3. Set the priority levels for any failover occurrences.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c29.png?st=2019-09-30T05%3A26%3A26Z&se=2025-10-01T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AsBWYsG3sqImfs0kVHsGbxcFU4ijCs2n8i%2BNC2C9zVE%3D)

4. Allow it a few minutes to enable the automatic failover.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c30.png?st=2019-09-30T05%3A26%3A48Z&se=2025-10-01T05%3A26%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=WplbrG4yiVPTszEesQqXd5CEOrnX2mv5gmiCIQK8vx8%3D)

5. You’ll receive a notification on completion.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/cosmosdblab/c31.png?st=2019-09-30T05%3A27%3A40Z&se=2025-10-01T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NuTUkAwp9hdOsk9k%2BfMSWWtz%2F6%2BEuAN57FwYcwmkW2o%3D)
