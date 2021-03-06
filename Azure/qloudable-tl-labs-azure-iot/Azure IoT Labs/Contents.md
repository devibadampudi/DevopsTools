# Qloudable TL 

## Azure IoT Labs

### Table of Contents 

 - [1 Introduction to IoT](#1-introduction-to-iot)  
 - [2 Introduction to Azure IoT](#2-introduction-to-azure-iot)
 - [3 Azure IoT Services](#3-azure-iot-services)
 - [4 Azure IoT Hub](#4-azure-iot-hub)
     - [4.1 Introduction to Azure IoT Hub](#41-introduction-to-azure-iot-hub)
     - [4.2 Create Azure IoT Hub Using Azure Portal](#42-create-azure-iot-hub-using-azure-portal)
     - [4.3 Create a device in IoT Hub](#43-create-a-device-in-iot-hub)
     - [4.4 Create Azure IoT Hub from Azure CLI](#44-create-aAzure-iot-hub-from-azure-cli)
     - [4.5 Sending data to IoT Hub using online PI Simulator](#45-sending-data-to-iot-hub-using-online-pi-simulator)
     - [4.6 Send and receive device to cloud messages using C# code](#46-send-and-receive-device-to-cloud-messages-using-C#-code)
     - [4.7 Control a device connected to an IoT hub with (Node.js) code](#47-control-a-device-connected-to-an-iot-hub-with-(Node.js)-code)
     - [4.8 Get Started with Device Twins with (Node.js) code](#48-get-started-with-device-twins-with-(node.js)-code)
     - [4.9 IoT Hub Manual Failover](#49-iot-hub-manual-failover)
 - [5 Azure IoT Edge](#5-azure-iot-edge)  
     - [5.1 Introduction to Azure IoT Edge](#51-introduction-to-azure-iot-egde)
     - [5.2 Create IoT Edge device in Azure IoT Hub](#52-create-iot-edge-device-in-azure-iot-hub)
     - [5.3 Deploy a Linux machine and make it an edge device](#53-deploy-a-linux-machine-and-make-it-an-edge-device)
         - [5.3.1 Deploy Ubuntu VM using Azure Portal](#531-deploy-ubuntu-vm-using-azure-portal)
         - [5.3.2 Configure created IoT Edge device](#532-configure-created-iot-edge-device)
         - [5.3.3 Login to Ubuntu VM](#533-login-to-ubuntu-vm)
         - [5.3.4 Install Azure IoT Edge runtime on Linux Machine](#534-install-the-azure-iot-edge-runtime-on-linux-machine)
     - [5.4 Deploy a module](#54-deploy-a-module)
 - [6 IoT Hub DPS](#6-iot-hub-dps)
     - [6.1 Introduction to DPS](#61-introduction-to-dps)
     - [6.2 Create DPS Using Azure Portal](#62-create-dps-using-azure-Portal)
     - [6.3 Link the IOT Hubs to DPS](#63-link-the-iot-hubs-to-dps)
 - [7 Azure Cosmos DB](#7-azure-cosmos-db)
     - [7.1 Introduction to Cosmos DB](#71-introduction-to-azure-cosmos-db)
     - [7.2 Create Cosmos DB using Azure Portal](#72-create-cosmos-db-using-azure-portal)
     - [7.3 Cosmos DB High Availability](#73-cosmos-db-high-availability)
 - [8 Azure Stream Analytics](#8-azure-stream-analytics)
     - [8.1 Introduction to Azure Stream Analytics](#81-introduction-to-azure-stream-analytics)
     - [8.2 Create Stream Analytics using Azure Portal](#82-create-stream-analytics-using-azure-portal)
     - [8.3 Configuring stream analytics to receive data from IoT Hub](#83-configuring-stream-analytics-to-receive-data-from-iot-hub)
     - [8.4 Streaming the data from stream analytics to Cosmos DB](#84-streaming-the-data-from-stream-analytics-to-cosmos-db)
 - [9 Event hub](#9-event-hub)
     - [9.1 Introduction to Event Hub](#91-introduction-to-event-hub)
     - [9.2 Create Event Hub using Azure Portal](#92-create-event-hub-using-azure-portal)
     - [9.3 Connecting IoT Devices to Event Hub](#93-connecting-iot-devices-to-event-hub)
     - [9.4 Event Hub High availabilty](#94-event-hub-high-availability)
 - [10 Notification Hub](#10-notification-hub)
     - [10.1 Introduction to Notification Hub](#101-introduction-to-notification-hub)
     - [10.2 Create Notification Hub using Azure Portal](#102-create-notification-hub-using-azure-portal)
 - [11 Azure Service bus](#11-azure-service-bus)
     - [11.1 Introduction to Azure Service bus](#111-introduction-to-azure-service-bus)
     - [11.2 Create Service bus using Azure Portal](#112-create-service-bus-using-azure-portal)
     - [11.3 Routing data from IoT Hub to Service bus Queue](#113-routing-data-from-iot-hub-to-service-bus-queue)
     - [11.4 Service Bus High Availability](#114-service-bus-high-availability)
 - [12 Time Series](#12-time-series)
     - [12.1 Introduction to Time Series Insights](#121-introduction-to-time-series-insights)
     - [12.2 Create Time Series Insights using Azure Portal](#122-create-time-series-insights-using-azure-portal)
     - [12.3 Plan your environment](#123-plan-your-environment)
     - [12.4 Visualize data in Explorer](#124-visualize-data-in-explorer)
 - [13 Azure Data Lake Store](#13-azure-data-lake-store)
     - [13.1 Introduction to Azure Data Lake Store](#131-introduction-to-azure-data-lake-store)
     - [13.2 Create Data Lake Store using Azure Portal](#132-create-data-lake-store-using-azure-portal)
     - [13.3 Streaming data from IoT hub to Data Lake Store](#133-streaming-data-from-iot-hub-to-data-lake-store)
 - [14 SQL DB & Web app](#14-sql-db-&-web-app)
     - [14.1 Introduction to SQL DB & Web app](#141-introduction-to-sql-db-&-Web-app)
     - [14.2 Create SQL DB using Azure Portal](#142-create-sql-db-using-azure-portal)
     - [14.2 Create Web app using Azure Portal](#142-create-web-app-using-azure-portal)
     - [14.3 Streaming data from stream analytics to SQL DB](#143-streaming-data-from-stream-analytics-to-sql-db)
