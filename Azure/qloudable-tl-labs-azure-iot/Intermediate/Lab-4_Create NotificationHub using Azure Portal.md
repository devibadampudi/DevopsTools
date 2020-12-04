# Lab-4: Create Notification Hub using Azure Portal

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Exercise 1: Create Notification Hub using Azure Portal](#exercise-1-create-notification-hub-using-azure-portal)

## Overview

Notification Hub is an entity that we can provision inside of windows azure account. It basically pushes notifications to any platform (iOS, Android, Windows, Kindle, Baidu, etc.) from any backend (cloud or on-premises). They work with any back end, cloud or local and are compatible with .NET, PHP, Java and Node.js.

Azure Notification Hubs allow developers to take advantage of push notifications without having to deal with the back-end complexities of enabling push on their own.

**Common uses for using Azure Notification Hub:** 

* Alerting smartphone users about breaking news or any dangerous conditions.

* Sending location-based coupons to opt-in subscribers.

* Pushing alerts in Safari to website subscribers about new site content.

### Scenario and Objective

In this Lab you will Learn

1. Creating the Notification Hub using Azure Portal

## Pre-Requisites

* Azure Portal

**Note:** Azure Portal is a part of the Lab.

## Exercise 1: Create Notification Hub using Azure Portal

Using the Chrome browser, login to Azure Portal with the below details:

```
Azure Username : {{ Portal Useremail }}

Azure Password : {{ Portal Password }}
```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/1.png?st=2019-10-25T11%3A01%3A16Z&se=2022-10-26T11%3A01%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=L2IKMBaONKG4AYDW4YMxznKJU%2BHtE%2FOhG0daUn4%2B6z8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/2.png?st=2019-10-25T11%3A02%3A09Z&se=2022-10-26T11%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zwTHTTxRzRZGaycsgii4eeJT25t5rQ%2FO21AJMdFG76g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/3.png?st=2019-10-25T11%3A02%3A32Z&se=2022-10-26T11%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kJT0FZ6Re8b1O2D2NqKQXD3UG0zhdquWSRYEN9wul1U%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/4.png?st=2019-10-25T11%3A02%3A58Z&se=2022-10-26T11%3A02%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=9Z8ToWJDzFKNyp9B4l257Wgk9DGP03eHNP1HUvnjNEk%3D)

Click **+Create a resource** and search for Notification Hub in Search box then select Notification Hub from the drop down.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/5.png?st=2019-10-25T11%3A03%3A22Z&se=2022-10-26T11%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FEgMAABa1ucwblqtnNvyG9UfUCv5hIp1Y4dCgJCvRPU%3D)

Now  click **Create** to continue creating Notification Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/6.png?st=2019-10-25T11%3A03%3A55Z&se=2022-10-26T11%3A03%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PtBr0cCcBAj7L5Ubpn0tqfYt6Uv9SH0oDj6P9YU78SI%3D)

On the Notification Hub page, do the following Steps:

```
Notification Hub: Specify a name for the notification hub.

Create a namespace: Specify a name for the namespace. A namespace contains one or more hubs.

Location: {{ Location }}

Resource Group: {{ ResourceGroup }}

Subscription: Select the Subscription from the dropdown

Pricing tier: Basic tier

```

Then click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/7.png?st=2019-10-25T11%3A04%3A20Z&se=2022-10-26T11%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=00Fequ47FOZxVla75dGus82nugbVyd3N%2BN7EY3R6k7g%3D)

After successful deployment you can see the Deployment succeeded message in Notifications.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/8.png?st=2019-10-25T11%3A04%3A44Z&se=2022-10-26T11%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=j%2FPfkyDWKon8rbnTWAiI45XK0ZpK3%2BM5CACH7FrjN2I%3D)

Go to **Resource groups** -> Click on **ResourceGroup** -->  **Overview** -> click on created **Notification Hub**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/9.png?st=2019-10-25T11%3A05%3A06Z&se=2022-10-26T11%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=owZFsI31GqA4srnDyOmzKQAnxLr8ia2dNMBi5XUeZcs%3D)

Click  **Access Policies** -> Copy the **Listen connection string** to use later.

> **Note:** *Do not use the DefaultFullSharedAccessSignature in your application. This is meant to be used in your back-end only.*

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/NotificationHub%20images/10.png?st=2019-10-25T11%3A05%3A32Z&se=2022-10-26T11%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=goL7E3%2BSHQTJ9DyV%2FvNI7MIDpcjNAVFeJyDqycwS1o4%3D)

