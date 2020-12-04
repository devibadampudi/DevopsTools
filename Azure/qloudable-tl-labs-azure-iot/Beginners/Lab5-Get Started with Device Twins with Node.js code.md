# Get Started with Device Twins with Node.js code

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Exercise 1: Create the Service App](#exercise-1-create-the-service-app)

[Exercise 2: Create the Device App](#exercise-2-create-the-device-app)

[Exercise 3: Run the Device App](#exercise-3-run-the-device-app)

## Overview

The Device Twin is a JSON formatted document that describes the metadata, properties of any device created within IoT Hub. It describes the individual device specific information. It stores the device state information including metadata, configurations and conditions.

**Benefits:**

* Device Twins are used to store device metadata in the cloud.

* The current state information like available capabilities and conditions is reported from device application.

* In long-running workflows Device-Twin is used to synchronize the state between device application and back-end application.

* Device Twin used for querying device meta data, configuration or state.

### Scenario and Objective

In this Lab you will Learn: 

1. Creating the Service App

2. Creating the Device App

3. Running the Device App

## Pre-Requisites

* Azure Portal

* Windows PowerShell

**Note:** Azure Portal and PowerShell is a part of the Lab.

## Exercise 1: Create the Service App

### Task-1: Creating IoT Hub using Azure Portal

1. Using the Chrome browser, login to Azure portal with the below details.

 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal1.png?sv=2019-10-10&st=2020-10-06T07%3A15%3A27Z&se=2023-10-07T07%3A15%3A00Z&sr=c&sp=rl&sig=NfRZ%2F8R9FdmQk5T0f3SuH785IAgI2zDlwAhHmt10CQE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal2.png?sv=2019-10-10&st=2020-10-06T07%3A15%3A27Z&se=2023-10-07T07%3A15%3A00Z&sr=c&sp=rl&sig=NfRZ%2F8R9FdmQk5T0f3SuH785IAgI2zDlwAhHmt10CQE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal3.png?sv=2019-10-10&st=2020-10-06T07%3A15%3A27Z&se=2023-10-07T07%3A15%3A00Z&sr=c&sp=rl&sig=NfRZ%2F8R9FdmQk5T0f3SuH785IAgI2zDlwAhHmt10CQE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/Lab4-Web%20Apps%20and%20cloud%20services/portal4.png?sv=2019-10-10&st=2020-10-06T07%3A15%3A27Z&se=2023-10-07T07%3A15%3A00Z&sr=c&sp=rl&sig=NfRZ%2F8R9FdmQk5T0f3SuH785IAgI2zDlwAhHmt10CQE%3D)

2. Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/3.png?st=2019-09-11T11%3A50%3A06Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=v6dBYoq%2F7vlT4UjRqk38%2BnvSS5FUaJ7LpWPDyoJAq8I%3D)

3. Click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/4.png?st=2019-09-11T11%3A50%3A24Z&se=2021-09-12T11%3A50%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=jlF%2B4t0e1zjqOg1fXINUx68qXhwGEdTZzm3mz9NYltc%3D)

4. Then you will see the below screen, fill all the required fields.

* **Subscription:** select as default from the dropdown <br>
* **Resource Group:** {{resource-group-name}} <br>
* **Region:** {{location}} <br>
* **IoT Hub Name:** enter globally unique name for your IoT Hub. 

5. Click **Next: Size and scale** to proceed further with creating IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/1.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

6. Select **B1: Basic tier** from the dropdown.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/6.png?sv=2019-10-10&st=2020-10-06T09%3A33%3A03Z&se=2023-10-07T09%3A33%3A00Z&sr=b&sp=r&sig=exlgKEa6SuJyGyO%2BynnnYMqGqvoRFJsuPk9Bk7xRzzI%3D)

7. Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/7.png?st=2019-09-11T11%3A53%3A47Z&se=2021-09-12T11%3A53%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=i%2B4Vi1zo%2FSk6oDgqzYWAk%2FbyYzhvgxLmafVe83Bnotg%3D)

8. Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/2.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

9. After successful deployment you can see the Deployment succeeded notification as shown like below screen. Click on **Go to resource**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/3.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

10. Click on **Shared access policies** -> **iothubowner** -> copy the IoT Hub **Connection string - primary key** to use later.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/9.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

### Task-2: Creating device in Azure IoT Hub

1. This task describes how to create a device in existing IoT Hub. A device cannot connect to IoT Hub unless it has an entry in the identity registry.

2. In IoT Hub navigation menu, open **IoT Devices**, then select **New** to register a new device in your IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/4.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/5.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

3. Provide any user defined name for new device, such as **device-1**, and select **Save**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/6.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

4. This will create a new device identity in IoT Hub.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/13.png?st=2019-09-11T11%3A55%3A48Z&se=2021-09-12T11%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pSR%2F3F4jfuIcsEI5XpS8z05cmTN8NIN9pWTy9prYNPY%3D)

5. After the device is created, open the device from the list in the **IoT devices** pane. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/7.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

6. Copy the **Connection string---primary key** and save it in Notepad, this will be used later.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/8.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

### Task-3: Create Service App

1. In this Task, we create a Node.js console application that adds location metadata to the Device Twin associated with device id (device-1). The Device Twins of the IoT Hub selecting the devices located in the same region and the one that is reporting a cellular connection is queried by this console application.

2. Open PowerShell from the top of the lab menu, as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/10.png?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

3. Run the below command to check the node version.

 ```
 node --version
 ```

4. Run the below command to change the root directory.

 ```
 cd ../../

 cd .\Users\PhtonUser\Downloads
 ```
5. Create a new empty folder called **addtagsandqueryapp** by using below command.

 ```
 mkdir addtagsandqueryapp
 ```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/11.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

6. In that created folder run the below command to create a new package.json file.

 ```
 cd addtagsandqueryapp

 npm init
 ```

7. Accept all the defaults by pressing enter.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/12.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

8. To install the **azure-iothub** package, execute the below command under addtagsandueryapp folder in the command prompt.

```
npm install azure-iothub --save
```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/13.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

9. Open Visual Studio Code from the Lab catlog as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/14.png?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

10. Click on **File** -> **New File** in Visual Studio Code.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/15.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

11. **Copy** and **Paste** the below code to the new file and replace the **{iot hub connection string}** with the IoT Hub connection string we copied earlier and **myDeviceId** with the device name you have created earlier. 

```
'use strict';
     var iothub = require('azure-iothub');
     var connectionString = '{iot hub connection string}';
     var registry = iothub.Registry.fromConnectionString(connectionString);

     registry.getTwin('myDeviceId', function(err, twin){
         if (err) {
             console.error(err.constructor.name + ': ' + err.message);
         } else {
             var patch = {
                 tags: {
                     location: {
                         region: 'US',
                         plant: 'Redmond43'
                   }
                 }
             };

             twin.update(patch, function(err) {
               if (err) {
                 console.error('Could not update twin: ' + err.constructor.name + ': ' + err.message);
               } else {
                 console.log(twin.deviceId + ' twin updated successfully');
                 queryTwins();
               }
             });
         }
     });

 var queryTwins = function() {
         var query = registry.createQuery("SELECT * FROM devices WHERE tags.location.plant = 'Redmond43'", 100);
         query.nextAsTwin(function(err, results) {
             if (err) {
                 console.error('Failed to fetch the results: ' + err.message);
             } else {
                 console.log("Devices in Redmond43: " + results.map(function(twin) {return twin.deviceId}).join(','));
             }
         });

         query = registry.createQuery("SELECT * FROM devices WHERE tags.location.plant = 'Redmond43' AND properties.reported.connectivity.type = 'cellular'", 100);
         query.nextAsTwin(function(err, results) {
             if (err) {
                 console.error('Failed to fetch the results: ' + err.message);
             } else {
                 console.log("Devices in Redmond43 using cellular network: " + results.map(function(twin) {return twin.deviceId}).join(','));
             }
         });
     };
```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/16.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/17.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

12. At the bottom of the Visual Studio Code click on **PlainText** then search for **javascript** and select it as shown like below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/18.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

13. Save the file with **AddTagsAndQuery.js** name in the addtagsandqueryapp folder.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/19.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/20.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/21.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/22.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

> **Note:** The **Registry** object exposes all the methods required to interact with Device Twins from the service. The previous code first initializes the **Registry** object, then retrieves the device twin for **device-1**, and finally updates its tags with the desired location information. After updating the tags, it calls the **queryTwins** function.

14. Switch back to PowerShell and run the application with below command.

 ```
 node .\AddTagsAndQuery.js

 ```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/27.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/23.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

## Exercise 2: Create the Device App

1. In this Exercise, you also create a Node.js console app that connects to your hub as device-1 and then updates its device twin's reported properties to contain the information that it is connected using a cellular network.

2. Run the below commands to create a new empty folder called **reportconnectivity**. In the **reportconnectivity**folder, create a new package.json file using the npm init command in your PowerShell as shown like below. 

 ```
 cd ..

 mkdir reportconnectivity

 cd reportconnectivity

 npm init
 ```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/24.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

3. Accept all the defaults.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/25.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

4. In your PowerShell in the **reportconnectivity** folder, run the below command to install the **azure-iot-device**, and **azure-iot-device-mqtt** package

 ```
 npm install azure-iot-device azure-iot-device-mqtt --save
 ```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/26.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

5. Switch to Visual Studio Code, create a new **ReportConnectivity.js** file in the **reportconnectivity** folder as shwon like below.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/27.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

6. Click on **File** -> **New File** in Visual Studio Code.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/15.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

7. Copy and Paste the following code into the new file and replace the **{device connection string}** placeholder with the device connection string you copied when you created the **device-1** device identity.

```
'use strict';
    var Client = require('azure-iot-device').Client;
    var Protocol = require('azure-iot-device-mqtt').Mqtt;

    var connectionString = '{device connection string}';
    var client = Client.fromConnectionString(connectionString, Protocol);

    client.open(function(err) {
    if (err) {
        console.error('could not open IotHub client');
    }  else {
        console.log('client opened');

        client.getTwin(function(err, twin) {
        if (err) {
            console.error('could not get twin');
        } else {
            var patch = {
                connectivity: {
                    type: 'cellular'
                }
            };

            twin.properties.reported.update(patch, function(err) {
                if (err) {
                    console.error('could not update twin');
                } else {
                    console.log('twin state reported');
                    process.exit();
                }
            });
        }
        });
    }
    });
```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/28.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/29.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/30.0.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/30.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/31.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/32.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

## Exercise 3: Run the Device App

1. Switch back to PowerShell and run the below command to run the device app.

 ```
 node ReportConnectivity.js
 ```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/33.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

2. You should see the message **twin state reported**.

3. Now that the device reported its connectivity information, it should appear in both queries. Go back in the **addtagsandqueryapp** folder and run the queries again

 ```
 cd ..

 cd addtagsandqueryapp

 node AddTagsAndQuery.js

 ```

4. This time device-1 should appear in both query results.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZIoT100-Lab5/34.PNG?st=2019-10-29T09%3A16%3A58Z&se=2022-10-30T09%3A16%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=vGMv3gzKTm6pfH1CVCUPfz2cmhXNOsd9rdwwiwVrWvc%3D)

> **Result**: After completing this lab, you have created a Node.js console application that adds location metadata to the device twin associated with device id (device-1) and also create a Node.js console app that connects to your hub as device-1 and then updates its device twin's reported properties to contain the information that it is connected using a cellular network.
