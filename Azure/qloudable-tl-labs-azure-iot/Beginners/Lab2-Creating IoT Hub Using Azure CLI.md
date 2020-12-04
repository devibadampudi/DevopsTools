# Creating IoT Hub Using Azure CLI

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Exercise 1: Creating IoT Hub using Azure CLI](#exercise-1-creating-iot-hub-using-azure-cli)

[Exercise 2: Register or Create a new Azure IoT device with Azure CLI](#exercise-2-register-or-create-a-new-azure-iot-device-with-azure-cli)

## Overview

The main Aim of this lab is about creating an IoT Hub using Azure CLI and Register a new IoT device in IoT Hub.

### Scenario and Objective

In this Lab you will Learn:

1. Creating IoT Hub using Azure CLI

2. Register or Create a new Azure IoT device with Azure CLI

## Pre-Requisites

* Azure Portal

* Azure Cloud Shell

> **Note:** 1. Azure Cloud Shell is a part of Azure Portal.

## Exercise 1: Creating IoT Hub using Azure CLI

Using the Chrome browser, login to Azure Portal with the below details:

 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/1.png?st=2019-09-11T12%3A12%3A25Z&se=2022-09-12T12%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aH0lpF2UUWb5kr1u0%2FHQbifyN%2Fl9yeoRa3D7kfO%2Bjpk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/2.png?st=2019-09-11T12%3A12%3A46Z&se=2022-09-12T12%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=NXAHK%2BPkNcRfbgIMOa%2FgBh6k2hjls37bA4dOLTf9%2B4Q%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/3.png?st=2019-09-11T12%3A13%3A01Z&se=2022-09-12T12%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Z4MUjukhMn5hktG5i61HpZQ0k7bvuUl0DIvsB6Ylbgw%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/4.png?st=2019-09-11T12%3A13%3A15Z&se=2022-09-12T12%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0r%2BMreXZvceSKLZ1i4ToljUl%2BZ%2FsPEpxSM8dATxj2Y4%3D)

Click on the **Cloud Shell** button on the menu in the upper-right corner of the Azure portal.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/5.PNG?st=2019-09-11T12%3A13%3A31Z&se=2022-09-12T12%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=PAKiJvImfae1VMbkOYogMLvam7jHMxAfPaLyjUJGlcc%3D)

Start the **Bash shell** in Azure Cloud Shell.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/6.PNG?st=2019-09-11T12%3A13%3A50Z&se=2022-09-12T12%3A13%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=R2JWWz9A7vFFc8C%2FYdrYOGUf7q1QO2BUp3CdltYmCEc%3D)

If you are presented with you have **no storage mounted** message, configure storage using the following settings:

> **Settings**:

* **Subscription:** Select as default from the dropdown <br>
* **Cloud Shell region:** {{location}} <br>
* **Resource Group:** {{resource-group-name}} <br>
* **Storage account:** a name of a new storage account <br>
* **File share:** a name of a new file share
 
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/7.PNG?st=2019-09-11T12%3A14%3A09Z&se=2022-09-12T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4qfHD9WPbbZ3xjCI6GPAOBo6%2FkRXq637%2Bkr6%2FvicRHk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/8.PNG?st=2019-09-11T12%3A14%3A25Z&se=2022-09-12T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AY%2Bm8zCUilgUj1Qxuq%2B25eo3o0adp%2F7tOOgKe0iiLX4%3D)

Then just type **az** to use Azure CLI.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/9.png?st=2019-09-11T12%3A14%3A47Z&se=2022-09-12T12%3A14%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fQlOmA6bY7QmlKEsFAd6ild830cLTQC%2Bq8FavPh5h14%3D)

Run the below command to create an IoT Hub in the existing Resource Group.

> **Note:** Replace the placeholder **<YourIoTHubName>** with unique name

 `az iot hub create --name <YourIoTHubName> --resource-group {{resource-group-name}} --sku B1`

**Ex:: az iot hub create --name abtesthub13 --resource-group tl-<unique string> --sku B1**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/10.PNG?st=2019-09-11T12%3A15%3A14Z&se=2022-09-12T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=oW0XTJ0wuQLMYBhnscmUwOB6MOoS02MJ%2BZazlRjzVNA%3D)

## Exercise 2: Register or Create a new Azure IoT device with Azure CLI

> ***Note:*** Run below command before creating device to add az extension.

 `az extension add --name azure-cli-iot-ext`

Use the below command to create a new device identity in the IoT Hub.

> **Note:** Replace the placeholder **<YourIoTHubName>** and **<YourdeviceName>** with two different names.

 `az iot hub device-identity create --hub-name <YourIoTHubName> --device-id <YourdeviceName>`

**Ex:az iot hub device-identity create --hub-name abtesthub13 --device-id device-1**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/11.PNG?st=2019-09-11T12%3A15%3A29Z&se=2022-09-12T12%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5zGFqdGWbCGjASy%2BrO4MPG%2BRc9EaWI%2FgTktKsvNdMI8%3D)

Use the below command to retrieve the connection string for the created device.

 `az iot hub device-identity show-connection-string --device-id <YourdeviceName> --hub-name <YourIoTHubName>`

**Ex:**: az iot hub device-identity show-connection-string --device-id device-1 --hub-name abtesthub13

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab2/12.PNG?st=2019-09-27T05%3A41%3A48Z&se=2022-09-28T05%3A41%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2Fhnb7IVHb0G5cj36e1t60gCbf4mRpWOp24%2BuMERnCks%3D)

> **Result:** After completing this lab, you have deployed IoT Hub using Azure CLI and registered a device in it.
