# Creating an IoT Edge device in Azure IoT Hub

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Exercise 1: Creating an IoT Hub](#exercise-1-creating-an-iot-hub)

[Exercise 2: Registering an IoT Edge device in your IoT Hub](#exercise-2-registering-an-iot-edge-device-in-your-iot-hub)

[Exercise 3: Deploying a Linux Machine and make it an Edge device](#exercise-3-deploying-a-linux-machine-and-make-it-an-edge-device)

[Exercise 4: Deploying Modules and learn how to Create Routes](#exercise-4-deploying-modules-and-learn-how-to-create-routes)

## Overview

Azure IoT Edge is a service meant to work on Azure IoT Hub for deploying the workloads on cloud, services. Furthermore, IoT Edge can also be used in running data analytics on the device, rather on cloud to share a part of the workload across and therefore less traffic transmission to the cloud, resulting in better response time for all status changes on the devices.

### Scenario and Objective

After completing this lab, you will be able to:

* Create an IoT Hub

* Register an IoT Edge device in your IoT hub

* Deploying a Linux Machine and make it an edge device

* Deploying Modules and learn how to Create Routes

## Pre-Requisites

1. Azure Portal

2. Familiar with Azure cloud shell

## Exercise 1: Creating an IoT Hub

1. Using the Chrome browser, Login to Azure Portal with the below details:

 **Azure login_ID:** {{azure-login-id}} <br>
 **Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/Lab4%20-%20Configure%20Azure%20DNS/portal1.png?st=2019-09-05T09%3A42%3A02Z&se=2022-09-06T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=igNCmxkgy8jEIHJZ6PyjEF9C7%2F%2BIhh1f4y6NOSGhtXM%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/Lab4%20-%20Configure%20Azure%20DNS/portal2.png?st=2019-09-05T09%3A42%3A23Z&se=2022-09-06T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ZZUZvHB8wU%2B4qcb5%2FEgwvsWym5BZwrxY0ra%2B8RRjfcg%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/Lab4%20-%20Configure%20Azure%20DNS/portal3.png?st=2019-09-05T09%3A42%3A40Z&se=2022-09-06T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wFt6UDhop3gbP%2BwBKG2NA%2FD3u22gYcMYduh8uPmXVZ4%3D) 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/Lab4%20-%20Configure%20Azure%20DNS/portal4.png?st=2019-09-05T09%3A42%3A55Z&se=2022-09-06T09%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=gq%2F0iEKqyyV%2F%2FkE%2Fm4OcKfQ4hBKHYowLNbrIUVdSqak%3D)

2. Choose **+Create a resource**, then search for IoT Hub in search box and Select **IoT Hub**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/1.png?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

3. Click on **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/2.png?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

4. Fill in all the fields with required data on the form for creating the IoT Hub.


* **Subscription:** Select as default from the dropdown <br>
* **Region:** {{location}} <br>
* **Resource Group:** {{resource-group-name}} <br>
* **IoT Hub Name:** The name of the IoT Hub must be globally unique

5. Click on **Next** to proceed to **Size and scale** options.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/3.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

```
Pricing and scale tier: S1:Standard tier

```

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/4.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

7. Click on **Review + Create** button at the bottom.

8. Click on **Create** to create your new IoT hub. The process takes a few minutes.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/5.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

## Exercise 2: Registering an IoT Edge device in your IoT Hub

The IoT Edge device requires a device entity to establish connection to the IoT Hub. The identity of the device lives on the cloud and a unique device connection string can be used to associate a physical device. You can create one by following the steps below.

1. Go to **Resource group** -> {{resource-group-name}}

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/6.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

2. Select **IoT Hub**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/7.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

3. Click on **IoT Edge** -> **Add an IoT Edge device**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/8.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

2. Enter value for the **Device name** and click on **Save**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/9.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

3. The created device will be displayed as shown in the screenshot below. Proceed to click on the created device.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/10.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

4. **Copy** the **Connection string** (primary key which will be used to configure the IoT Edge runtime).

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/11.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

## Exercise 3: Deploying a Linux Machine and make it an Edge device

### Deploy Ubuntu VM using Azure Portal

1. Click on **+ Create a resource** on the upper left corner of your Azure portal and search for **Ubuntu**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/12.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/13.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

2. On the **Basics** tab, under the **Project details**, make sure the correct subscription is selected and then click on **Create new**.

3. On the next step, enter a value for name of VM, choose appropriate ones for available dropdown’s and click on **OK**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/14.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

4. Select **VM size**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/15.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

5. Then Select authentication type as Password and give username and Password for VM to login then click on **Next:Disks**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/Lab7/16.PNG?st=2019-10-01T05%3A18%3A47Z&se=2022-10-02T05%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=SPj%2BCWhBr4T7o1L8%2FCSP%2Fejew5pu4G7UbKSbdwlFwkc%3D)

6. Choose **OS disk type**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/96.png)

7. Leave rest of all fields to their defaults and then click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/97.png)

8. Navigate to the **Resource groups** and select the VM, you just created. Click on the **Connect** to get **ssh** command to connect to the VM.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/98.png)

9. **Copy** the **SSH** command.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/99.png)

10. Click on **Cloud shell** in the portal.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/100.png)

11. Make sure you select **Bash shell**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/101.png)

### Configure the IoT Edge device

Start the Azure IoT Edge runtime on your IoT Edge device.

You’ll be required to provide a device connection string in the process of configuring Runtime on the device. Use the string retrieved from the Azure CLI, which associates your physical device with IoT Edge device identity on Azure.

**Set the connection string on the IoT Edge device**

If you're using the Azure IoT Edge on Ubuntu virtual machine as described in the prerequisites, then your device already has the IoT Edge runtime installed. You will just need to configure your device with the device connection string that you retrieved in the previous section.

Run the following command, replacing **VM name** and **{device_connection_string}** with the string retrieved.

```
az vm run-command invoke -g {{resource-group-name}} -n <VM name> --command-id RunShellScript --script "/etc/iotedge/configedge.sh '<device_connection_string>'

```

***Ex:*** 

```
az vm run-command invoke -g Az-IoTedge-Rg -n Edgevm --command-id RunShellScript --script "/etc/iotedge/configedge.sh 'HostName=edgehub30.azure-devices.net;DeviceId=device-1;SharedAccessKey=8L6UKj9xhSPby1MCs1Rk1bnfBrhub4vnltJnebzFo14='
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/102.png)

> ***Note:*** If you're running IoT Edge on your local machine, you will need to install the IoT Edge runtime and its prerequisites on your device.

### Login to Ubuntu VM

Go back to Cloud Shell and paste the copied ssh command to login to Ubuntu VM.

Enter the password you used to create the VM, when prompted and hit on **Enter**.

On a successful authentication, you’ll be logged in on to your VM.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/103.png)

### Install the Azure IoT Edge runtime on Linux Machine

Follow the steps below to install the Azure IoT Edge runtime on your Ubuntu Linux x64 (Intel/AMD) IoT Edge device. 

**Register Microsoft key and software repository feed**

```
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > ./microsoft-prod.list

```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/104.png)

```
sudo cp ./microsoft-prod.list /etc/apt/sources.list.d/

```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/105.png)

```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg

```

```
sudo cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/106.png)

**Container runtime Installation**

```
sudo apt-get update
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/107.png)

```
sudo apt-get install moby-engine

```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/108.png)

```
sudo apt-get install moby-cli
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/109.png)

**Installation of Azure IoT Edge Security Daemon**:

```
sudo apt-get update
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/110.png)

```
sudo apt-get install iotedge
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/111.png)

**Azure IoT Edge Security Daemon Configuration**

```
sudo nano /etc/iotedge/config.yaml
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/112.png)

Update the device connection string in config.yaml file.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/113.png)

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/114.png)

```
sudo systemctl restart iotedge
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/115.png)

**Verify successful installation**

```
systemctl status iotedge
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/116.png)

```
sudo iotedge list
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/117.png)

## Exercise 4: Deploying Modules and learn how to Create Routes

You can manage your Azure IoT Edge device from the cloud portal, to deploy a module that will send telemetry data to IoT Hub. 

Go to **“Azure portal”**, search for the **“Simulated Temperature Sensor”** and click on the Market place result for the same.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/118.png)

Select an IoT Edge device to receive this module. On the **“Target Devices for IoT Edge Module”** page, provide the following information:

```

Subscription: Select as default from the dropdown

IoT Hub: Select the name of the IoT Hub.

IoT Edge Device Name: Select Find Device to choose from a list of IoT Edge devices in your IoT Hub.

```

Click on **Create**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/119.png)

Click on **Next**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/120.png)

Click on **Next**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/121.png)

Click on **Submit**.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/122.png)

Go to the device details page and scroll down to find the **Modules** section which contains, **$edgeAgent**, **$edgeHub**, and **SimulatedTemperatureSensor**. 

> **Note:** If one or more of the modules are listed as specified in deployment, but not reported by the device, your IoT Edge device is still starting them. Wait for few moments and click on Refresh at the top of the page.

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/123.png)

You can check the status of **IoT Edge modules** in edge VM, using below command.

```
sudo iotedge list
```

![alt text](https://github.com/sysgain/qloudable-tl-labs/raw/Azure-IoT-Labs/Beginners/images/124.png)

> **Result**: After completing this Lab, you have created an IoT Hub and registered an IoT Edge device in IoT Hub. Deployed a Ubuntu VM and make it as Edge VM.
