# Send and receive data to IoTHub using C# code

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercize-1: Create or Register a Device in IoT Hub](#Excercize-1-create-or-register-a-device-in-iot-hub)

[Excercize-2: Send simulated Data to IoTHub](#Excercize-2-send-simulated-data-to-iothub)

[Excercize-3: Read Simulated Data from IoT Hub](#Excercize-3-read-simulated-data-from-iot-hub)


## Overview

The aim of this lab is to send and recieve data to and from IoTHub using C# code.

IoT Hub is an Azure service that allows to ingest high volumes of telemetry data from connected IoT devices into the cloud for storage or processing. We send telemetry data from a simulated device application via IoT Hub to a back-end application for processing.

Here we use two pre-written C# applications, one to send the telemetry data and another to read the telemetry from the IoT Hub. We need to create an IoT hub and register a device with the hub before running the applications.

#### Scenario and Objective

*   Create or Register a Device in IoT Hub

*   Send simulated Data to IoTHub using C# code

*   Read Simulated Data from IoT Hub using C# code

## Pre-Requisites

*   Azure Portal access

*   Azure Cloud Shell

>   **Note**: Azure Portal access is provided as part of the Lab environment

## Excercize-1: Create or Register a Device in IoT Hub

1.	Go to the **Azure Portal** and provide your credentials for login.

From Lab computer, start Chrome, browse to http://portal.azure.com and, if prompted, sign in by using the Microsoft account that is the Service Administrator of your Azure subscription.

Using the Chrome browser, login into Azure portal with the below details.

```
Azure Username: {{ Azure Portal Username }}

Azure Password: {{ Azure Portal Password }}

```
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal1.png?st=2019-08-22T11%3A08%3A20Z&se=2020-08-23T11%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=fm%2BDTeOkr2f0%2BS344uOTMlPzHxDsCisvhsf4Jo1LzmY%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal2.png?st=2019-08-22T11%3A09%3A36Z&se=2020-08-23T11%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ONwSsJE%2B5ENkff6wqI098VfdvzB77ezY7PxjamtqBgQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal3.png?st=2019-08-22T11%3A09%3A59Z&se=2020-08-23T11%3A09%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=5JhMvyxOF4PJSrB3u4M9KLit%2B9IqG6MrVjUObzyLaGg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal4.png?st=2019-08-22T11%3A10%3A23Z&se=2020-08-23T11%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QKaTSjnXbhdQ1wkIajvEAwwAJvuUfoQn7NBkmBQa2C4%3D)

The two sample applications are written using C#, for which .NET Core SDK 2.1.0 or greater on development machine is needed.

Verify the current version of C# on development machine using the below command.

***Command:*** `dotnet --version`

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/31.png)

Execute the below command for adding the Microsoft Azure IoT Extension from Azure CLI to Cloud Shell instance. The IoT Extension adds IoT Hub, IoT Edge, and IoT Device Provisioning Service (DPS) specific commands to Azure CLI.

```
Syntax: `az extension add --name <name of IoT Extension>`

Ex: `az extension add --name azure-cli-iot-ext`

```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/32.png)

Copy and paste the below link on Chrome's browser to download the sample C# project and extract the ZIP archive.

URL : https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/AppCode/azure-iot-samples-csharp-master.zip

We should register a device on IoT Hub before it can be connected. Azure Cloud Shell can be used to create a simulated device.

1. Execute the below command in Azure Cloud Shell to create the device identity.

```
Syntax: `az iot hub device-identity create --hub-name <IoTHubName> --device-id <DotnetDeviceName>`

Ex: `az iot hub device-identity create --hub-name aziothubt1 --device-id device1`
```

>   ***Note:*** *if you want to change the device name(device1) then you also need to change in the sample application before you run it.*

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/33.png)

device connection string for the device you to get the just created in IoT Hub, execute the below command.

```
Syntax: `az iot hub device-identity show-connection-string –hub-name <IoTHubName> --device-id <DotNetDeviceName> --output table`

Ex: `az iot hub device-identity show-connection-string --hub-name aziothub2504 --device-id device1 --output table`
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/34.png)

>   ***Note:*** *Copy the device connection string and save it to use later.*

2. To enable back-end application for connecting and retrieving the messages to the created IoT Hub, we required the following.

  * Event Hubs-compatible endpoint

  *	Event Hubs-compatible path

  * IoTHubowner primary key

By using below commands, we can retrieve these values from the created IoT hub.

Update the IoT Hub name aziothub2504 with your IoT Hub name

```

Syntax:

`az iot hub show --query properties.eventHubEndpoints.events.endpoint --name <IoTHubName>` 

`az iot hub show --query properties.eventHubEndpoints.events.path --name <IoTHubName>`

`az iot hub policy show --name iothubowner --query primaryKey --hub-name <IoTHubName>` 

Ex:

`az iot hub show --query properties.eventHubEndpoints.events.endpoint --name aziothub2504`

`az iot hub show --query properties.eventHubEndpoints.events.path --name aziothub2504`

`az iot hub policy show --name iothubowner --query primaryKey --hub-name aziothub2504`

```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/35.png)

>   ***Note:*** *Save these three values, which we will use later.*

If you use any special device name instead of device1 you have to do the below changes in application code.

1. In your local system, navigate to the root folder of the sample C# application which you downloaded and extract before.Go to that extract C# application folder then navigate to the iot-hub\Quickstarts\back-end-application.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/36.png)

2. Click on that folder and open the BackEndApplication.cs file from text editor update the device1 with your device name in that file and save.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/37.png)

## Excercize-2: Send simulated Data to IoTHub

The simulated device application should be connected to a device-specific endpoint on your IoT hub and sends simulated temperature and humidity telemetry.

1.	In your local system, navigate to the root folder of the sample C# application whisch you downloaded and extract before.Go to that extract C# application folder then navigate to the iot-hub\Quickstarts\simulated-device folder.

2.	Click on simulated-device folder and open the SimulatedDevice.js file in any text editor.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/38.png)

3. Update the value of the connectionstring variable with the device connection string you made a note before then save the SimulatedDevice.js file

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/39.png)

4.	In the local command prompt go to the path of C# application code folder “azure-iot-samples-csharp-master\azure-iot-samples-csharp-master\iot-hub\Quickstarts\simulated-device” and run the below commands to install the required libraries and run the simulated device application.

```
Command: `dotnet restore`
```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/40.png)

5.	Then enter the below command to build and run the simulated device application

```
Command: `dotnet run`

```
The below screen shows the output as the simulated device application sends telemetry to IoT hub.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/41.png)

Don’t stop the sending data to simulated-device, simultaneously we must read the simulated data.

## Excercize-3: Read Simulated Data from IoT Hub

The server-side Events end point is getting connected by the back-end application of created IoT Hub. The simulated device sends the device-to-cloud messages to the application. The device-to-cloud messages are received and processed by IoT Hub back-end application which usually run in the cloud.

1. In local terminal, open the root folder of the sample C# project and then navigate to the iot-hub\Quickstarts folder.

2. Click on the read-d2c-messages folder and open the ReadDeviceToCloudMessages.cs file in any text editor.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/42.png)

3. Update the s_eventHubsCompatibleEndpoint, s_eventHubsCompatiblePath, s_iotHubSasKey variable values with the values which you note before while run the commands in cloud shell and save the changes to the file.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/43.png)

4. Navigate to the path of C# application code “azure-iot-samples-csharp-master\azure-iot-samples-csharp-master\iot-hub\Quickstarts\read-d2c-messages”, execute the below command to install the required libraries for the back-end application.

```
Command: `dotnet restore`
```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/44.png)

5. Execute the below command to build and run the back-end application.

```
Command: `dotnet run`
```
![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/45.png)

The simulated device sends telemetry data to the back-end application to the hub as shown in the below output screen.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/46.png)

