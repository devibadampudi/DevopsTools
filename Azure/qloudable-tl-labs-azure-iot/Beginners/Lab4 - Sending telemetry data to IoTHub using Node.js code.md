# Sending telemetry data to IoTHub using Node.js code

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Excercise-1: Create IoT Hub using Azure Portal](#excercise-1-create-iot-hub-using-azure-portal)

[Excercise-2: Create a device in IoT Hub](#Excercise-2-create-a-device-in-iot-hub)

[Excercise-3: Listen for direct method calls from IoT Hub](#Excercise-3-listen-for-direct-method-calls-from-iot-hub)


## Overview 

IoT Hub is an Azure service which allows to intake high volume of telemetry to cloud for storage or processing from IoT Devices. The direct method is used to control a simulated device and remotely change the behavior of a device connected to IoT Hub.

Here we use two node.js applications.

* Simulated device application

* Back-end device application

* The calls made from a back-end application through a direct method, will in turn be responded by a simulated device application. This application connects to a device-specific endpoint on IoT Hub for receiving the direct method calls.

* The direct method call is made by back-end application on the simulated device. The back-end application connects to service-side endpoint on IoT Hub for calling the direct method on a simulated device.

**Scenario and Objective**

*   Create a device in IoT Hub

*   Listen for direct method calls from IoT Hub

*   Call the direct method from device

## Pre-Requisites

*   Azure Portal access

>   **Note**: Azure Portal access is provided as part of the Lab environment

The two applications which we are using in the lab are written using Node.js, for which Node.js v4.x.x or later version is to be there on development machine.

## Excercise-1: Create IoT Hub using Azure Portal

### Task 1: IoT Hub Creation

1.	Go to the **Azure Portal** and provide your credentials for login.

From Lab computer, start Chrome, browse to http://portal.azure.com and, if prompted, sign in by using the Microsoft account that is the Service Administrator of your Azure subscription.

Using the Chrome browser, login into Azure portal with the below details.

```
Azure Username: {{azure-login-id}}

Azure Password: {{azure-login-password}}

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/1.png?st=2019-10-25T11%3A28%3A05Z&se=2025-10-26T11%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cPyCAyklG08j7DtzwO99bDMwvKYfFPETxcdIDQkK1Y4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/2.png?st=2019-10-25T11%3A27%3A38Z&se=2025-10-26T11%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=yB5Cr4CPPVjSnJn8EfjaBne%2Bt0teOWUXCsDUWw%2B7K%2F4%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/3.png?st=2019-10-25T11%3A28%3A29Z&se=2026-10-26T11%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Xs1JDxmyIVIASV9V9Lb%2BexkQ5v5tpVU76gBqjgQzFRQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/4.png?st=2019-10-25T11%3A28%3A48Z&se=2026-10-26T11%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0n2QjxNmULUAOeq%2BEh8wI%2F3uWvG6rz6plDU%2BXS6WeyU%3D)

2.	Click **+Create a resource**, then search for IoT Hub in search box of Marketplace and select the **IoT Hub** from the list.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/5.png?st=2019-10-25T11%3A29%3A05Z&se=2025-10-26T11%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ryIa2t3tHDJi0kghdh8%2F%2F62MuqCH7vJ1TojmIlpYI%2F0%3D)

Click **Create**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/6.png?st=2019-10-25T11%3A29%3A56Z&se=2025-10-26T11%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TjGhUVn0dTPaUY%2BoFEsa8GICvFBZJ6msC%2BDhefBiquo%3D)

Then you will see the below screen, fill all the required fields.

```
Subscription: Select the default

Resource Group: {{resource-group-name}}

Region: {{location}}

IoTHub Name :Enter globally unique name for your IoT Hub. If the name you provided is available, then a green check mark will appear.

Click Next: Size and scale to proceed further with creating IoT hub.

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/7.png?st=2019-10-25T11%3A30%3A15Z&se=2026-10-26T11%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4Ov7FOtUlxB4Ym4aqS83YPqBXc64%2Fvg8FwfIxCvhfVs%3D)

You can take the defaults by just clicking **Review + create** at the bottom.

**Pricing and scale tier:** You can select from different tiers depending on the features and messages you want to send through your solution per day. You can use free tier for testing and evaluation, which allows 500 devices to be connected to the IoT hub with the limit of 8,000 messages per day. For each Azure Subscription we can have only one free tier.

*Basic and Standard Tier:*

For IoT solution which require only Uni-directional communication from devices to the cloud, then you can use Basic Tier. Standard tier implements all the features, and it is for IoT solution which require bi-directional communication. Both tiers offer the same security and authentication features.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/8.png?st=2019-10-25T11%3A30%3A40Z&se=2026-10-26T11%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=n16D8d0KS4ASMBnVUtgthvCTPlFjhHNNaPVPxdbqEao%3D)

Make sure to disable the **Azure security centre** option.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/AZiotlabs-lab1/iothub2.png?sv=2019-10-10&st=2020-10-08T15%3A48%3A32Z&se=2023-10-09T15%3A48%3A00Z&sr=b&sp=r&sig=pP%2FEOnWT6cMAt8si0eKoeEWIUPfPUenkSbvSmyzzyOo%3D)

Click **Review + create**. 

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/9.png?st=2019-10-25T11%3A31%3A02Z&se=2026-10-26T11%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CHbMN%2F2QLOcy71kXBuTzjc1nK1MmsCyiFZlKMJSWeZ0%3D)

Click **Create**, which will take few minutes for IoT Hub creation.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/10.png?st=2019-10-25T11%3A31%3A22Z&se=2026-10-26T11%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=8GOuasMI%2FIVzbFateCJl3BWQpDNUx%2FBo08CPaA0jtmw%3D)

After successful deployment you can see the Deployment succeeded notification as shown like below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/11.png?st=2019-10-25T11%3A31%3A50Z&se=2026-10-26T11%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LBmo6ngscC8UI14fQIT7W23KrTemxws7FpPYTd2uRG8%3D)


### Task 2: Open Cloud Shell

1. At the top of the portal, click the **Cloud Shell** icon to open a new shell instance.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/12.png?st=2019-10-25T11%3A32%3A04Z&se=2026-10-26T11%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JdCuUJBFqa99mqYCuF2MqVpAoTBnIphPlVYJqfWGAIU%3D)

 > **Note**: The **Cloud Shell** icon is a symbol that is constructed of the combination of the *greater than* and *underscore* characters.

2. If this is your first time opening the **Cloud Shell** using your subscription, you will see a wizard to configure **Cloud Shell** for first-time usage. When prompted, in the **Welcome to Azure Cloud Shell** pane, click **Bash (Linux)**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/13.png?st=2019-10-25T11%3A32%3A22Z&se=2025-10-26T11%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sB1%2BBR%2FPsv5aZL0o8BDoHWAwBYeawujhxfZCgnBzrHk%3D)

   > **Note**: If you do not see the configuration options for **Cloud Shell**, this is most likely because you are using an existing subscription with this course's labs. If so, proceed directly to the next task. 

3. In the **You have no storage mounted** pane, click **Show advanced settings**, perform the following tasks:

    - Leave the **Subscription** drop-down list entry set to its default value.

    - In the **Cloud Shell region** drop-down list, select the Azure region matching or near thelocationwhere you deployed resources in this lab.

    - In the **Resource group** section, select the **Use existing** option and then, in the drop-down list, select {{resource-group-name}}.

    - In the **Storage account** section, ensure that the **Create new** option is selected and then, in the text box below, type a unique name consisting of a combination of between 3 and 24 characters and digits. 

    - In the **File share** section, ensure that the **Create new** option is selected and then, in the text box below, type **cloudshell**.

    - Click the **Create storage** button.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/14.png?st=2019-10-25T11%3A32%3A41Z&se=2025-10-26T11%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=473BHeYoW2YEd9CyuaKbvgO9XjlheNEyou49Sf%2FApeU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/15.png?st=2019-10-25T11%3A32%3A57Z&se=2026-10-26T11%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=VIVm059FW51BDGojfBMCGH5XMU2DgOnXoVUWXf8yUMk%3D)

To verify the current version of Node.js, execute the below command by typing.

***Command:*** `node –-version`

!![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/16.png?st=2019-10-25T11%3A33%3A19Z&se=2025-10-26T11%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ImcDlQ0EL71xjbJQI6rO3VQlxNos05ztnj8s4Mvxwi0%3D)

Microsoft Azure IoT Extension can be added to Azure CLI by executing the below command in the cloud Shell instance, which will add IoT Hub, IoT Edge, and IoT Device Provisioning Service specific commands to it.Type the command in shell command line

***Command:*** `az extension add --name azure-cli-iot-ext`

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/17.png?st=2019-10-25T11%3A33%3A39Z&se=2026-10-26T11%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Uj2Pmsd1c38%2BwUYVjT8OhX0c2DyoKDBKMn5i7hcFyNs%3D)


## Excercise-2: Create a device in IoT Hub

A device should be registered along with your IoT hub before it will connect. during this lab, you employ the Azure Cloud Shell to create a simulated device.

Run the below command in Azure Cloud Shell to create the device identity in your IoT Hub.

Replace IoT Hub in the below commands with the name you used for your IoT hub.

The name of the device you're creating in IoT Hub. Use device1 as given in the commands. If you decide on a special name for your device, you would like to use that name throughout the lab.

```
Syntax: `az iot hub device-identity create --hub-name <IoTHubName> --device-id <DotnetDeviceName>`

Ex: `az iot hub device-identity create --hub-name aziothub2504 --device-id device1`

```
>   ***Note:*** `if you want to change the device name(device1) then you also need to change in the sample application before you run it.`

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/18.png?st=2019-10-25T11%3A33%3A57Z&se=2025-10-26T11%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pYvbfdycbAHm89SSwkEZ8Lh%2FGTUxyUM8kPoPQid3hpU%3D)

Run the below commands in Azure Cloud Shell to get the device connection string for the device you just created in IoT Hub.

```
Syntax: `az iot hub device-identity show-connection-string –hub-name <IoTHubName> --device-id <DotNetDeviceName> --output table`

Ex: `az iot hub device-identity show-connection-string --hub-name aziothub2504 --device-id device1 --output table`

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/19.png?st=2019-10-25T11%3A34%3A14Z&se=2025-10-26T11%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0zO%2Fy5XYW571Gtf6MHc0a09Xo%2FlMYTo6ghTONMdcFxo%3D)

Note down the device connection string in notepad we will use it later.

you also want IoT Hub connection string to modify the back-end application to attach to your IoT hub and retrieve the messages. the subsequent command retrieves the connection string for your IoT hub.

```
Syntax: `az iot hub show-connection-string --name <IoTHubName> --output table`

Ex: `az iot hub show-connection-string --name aziothub2504 --output table`

```
![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/20.png?st=2019-10-25T11%3A34%3A36Z&se=2025-10-26T11%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=aCz%2BOlRjGjgkpL3R4Hurj7sm6zcq9IVSLg8UlvEkNx8%3D)

Note down the IoT Hub connection string, the IoT Hub connection string is totally different from the device connection string.

The sample Node.js applications code can be downloaded by copy and paste the below link in google chrome new window.

URL:https://qloudableassets.blob.core.windows.net/az-iot-labs/azure-iot-samples-node-master.zip?st=2019-10-25T04%3A35%3A08Z&se=2026-10-26T04%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2Bs6NdiQqoOY%2BzikBmEHwd4E1dC2NQifbO8RPmiUbtYY%3D

click on **save**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/29.png?st=2019-10-25T11%3A35%3A41Z&se=2026-10-26T11%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=cHdP6F9FQthygRTwRDXi2iivNwpbIuG24%2BjxIpGKIdc%3D)

in Chroome click on the downloaded file right click on it click on **show in folder**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/30.png?st=2019-10-25T11%3A36%3A07Z&se=2026-10-26T11%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=r52WUFGDYlyFBuxYRiMOvYeViFwtnlq3Wl4uydgEawA%3D)

Then right click on that folder select **Extract All**

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/31.png?st=2019-10-25T11%3A36%3A24Z&se=2026-10-26T11%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QJJ9OmCEqrY8I08lOV4VHYCYT%2B%2BSQjU1XfEFiaFKxhE%3D)

Then it will show the below page click on **Extract**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/32.png?st=2019-10-25T11%3A36%3A38Z&se=2026-10-26T11%3A36%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=m6UEgogyqqMy2%2BTnDvHg6qvoMSVyPSjxGbX7jG1BO60%3D)

If you click on that folder it will show the extracted files like below

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/33.PNG?st=2019-10-25T11%3A37%3A00Z&se=2026-10-26T11%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vmMUfv9HvXHLiFDgrOfQ%2BgnRj%2BHMa5AunbfX9IG0sAA%3D)

If you use any special device name instead of device1 you have to do the below changes in application code otherwise go to the next step.

navigate to the **iot-hub\Quickstarts\back-end-application**.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/39.png?st=2019-10-25T11%3A39%3A41Z&se=2026-10-26T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=wSXMTjtuNl13amm7mlPkMX1uJ5e21O138nz2RZP8YSU%3D)

Click on that folder and open the BackEndApplication.cs file from visual studio code update the device1 with your device name in that file and save.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/40.png?st=2019-10-25T11%3A39%3A23Z&se=2025-10-26T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DuUis7sd6F%2BRk%2BCx%2F61YEn0nOF8seAOphxvGRo59O48%3D)

minimize the visual studion code after saved the file.

## Excercise-3: Listen for direct method calls from IoT Hub

The device-specific endpoint on IoT hub is connected by simulated device application, which sends simulated measuring and listens for direct method calls. The interval at which telemetry is sent by simulated device, can be changed by the direct method call from the IoT Hub and the simulated device responds back with an acknowledgement to IoT Hub once the direct method is executed.

 go to the root folder of the sample Node.js project, which we downloaded earlier. 

Now go to IoT Hub -> QuickStarts->simulated-device-2 folder.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/34.PNG?st=2019-10-25T11%3A37%3A23Z&se=2026-10-26T11%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=EXgWjkZYc7xdw%2BQl%2F7AFvaRcpA1wSk16GbDzDovrfMo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/35.png?st=2019-10-25T11%3A37%3A39Z&se=2026-10-26T11%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=vFWsxg5qUd6aAnF%2F%2FkRVMItfnBErAwDL20lRXZwBei0%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/36.PNG?st=2019-10-25T11%3A37%3A57Z&se=2025-10-26T11%3A37%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=LyvveRd%2F014MNXnUvaUtdYBrkAIOPYF5OPD%2BVjMdCqs%3D)

Open “SimulatedDevice.js” file in visual studio from “simulated-device-2”

The **connectionString** variable value need to be changed with the device connection string, which we saved earlier and save the SimulatedDevice.js file.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/37.png?st=2019-10-25T11%3A38%3A28Z&se=2025-10-26T11%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=AZViLu0HieMyte81TjbLQX4G%2FV6BQFhp1O3YSZArrgU%3D)

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/38.png?st=2019-10-25T11%3A38%3A45Z&se=2026-10-26T11%3A38%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DlkMbAAfgdT340sfcSO5ax50NbULYKQA4F8k3hOyUEo%3D)

Minimize the visual studio code after saved the file.

In powershell command prompt, navigate to the path of node.js application code 
“azure-iot-samples-node-master\azure-iot-samples-node-master\iot-hub\Quickstarts\simulated-device-2”. 

Open the powershell command line from console.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/21.PNG?st=2019-10-25T11%3A35%3A19Z&se=2025-10-26T11%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=qKBs0rYBpSZCZ09yBXY4g4I%2FYlFjWDbaXt7aitOfwII%3D)

Go to the application path by entering the below commands.

```

cd \

cd D:\PhotonUser\Downloads\azure-iot-samples-node-master\azure-iot-samples-node-master\azure-iot-samples-node-master\iot-hub\Quickstarts\simulated-device-2

```

Execute the below commands to install the needed libraries and run the simulated device application.

```

Command: `npm install`

```
Run the below command to send the data.

```

Command: `node SimulatedDevice.js`

```
The simulated device application sends telemetry to IoT Hub as shown in below screen.

![alt text](https://qloudableassets.blob.core.windows.net/az-iot-labs/nodejsiotlab/41.PNG?st=2019-10-25T11%3A39%3A03Z&se=2027-10-26T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Cyo5GKIuYAVwT9mjrg%2BNzufRSfKLhSg2QlQhymjCPvg%3D)

