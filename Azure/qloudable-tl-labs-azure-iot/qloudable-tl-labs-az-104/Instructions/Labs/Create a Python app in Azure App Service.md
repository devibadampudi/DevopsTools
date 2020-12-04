# Create a Python app in Azure App Service on Linux

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites) 

[Set up your initial environment](#set-up-your-initial-environment)

[Clone the sample code](#clone-the-sample-code)

[Run the sample code](#run-the-sample-code)

[Deploy the sample code](#deploy-the-sample-code)

[Browse to the app](#browse-to-the-app)

[Redeploy updates and Stream logs](#redeploy-updates-and-stream-logs)

[Manage the Azure app](#manage-the-azure-app)
  
## Overview

The aim of this lab is to deploy a Python web app to App Service on Linux, Azure's highly scalable, self-patching web hosting service.

**Scenario & Objectives**

You need to evaluate Azure functionality that would provide insight into performance and configuration of Azure resources, focusing in particular on Azure Web app. To accomplish this, you intend to examine the capabilities of Azure Monitor.

In this lab, you will learn:

1. Set up your initial environment

2. Clone the sample code

3. Run the sample code

4. Deploy the sample code

5. Browse to the app

6. Redeploy updates and Stream logs

7. Manage the Azure app

**Some Key points:**

1. We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

2. All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

3. Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

4. Do NOT use any data from screen shots.Only use data provided in the content section of the lab

5. Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the AWS Console.

## Pre-Requisites

* Azure fundamentals

## Set up your initial environment

In this task, you will deploy a virtual machine that will be used to test monitoring scenarios.

1.  Using the Chrome browser, login into Azure portal with the below details.

**Azure login_ID:** {{azure-login-id}}

**Azure login_Password:** {{azure-login-password}}

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/1.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)
 
![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/2.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/3.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az900/lab6%20-%20Configure%20Azure%20Storage/4.png?st=2020-08-25T12%3A20%3A09Z&se=2023-08-26T12%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=pbk1%2BobUdQvMezv7bkK8D5GA8%2BIxV5X3KO5EmQGhbbk%3D)


2. Open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

3. If prompted to select either **Bash** or **PowerShell**, select **Bash**. 

    > **Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/18.png?st=2019-09-16T06%3A56%3A43Z&se=2022-09-17T06%3A56%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=847NFTW3Z2mlgo%2FGqyWi%2BuRhShvBLUrO95HPTorQ7QA%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/19.png?st=2019-09-16T06%3A57%3A14Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=UoWgW4qVa8tZZBz7ss%2FwqcJnLZDsX0ANpXF0WS6yEvc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a40.png?st=2019-09-18T04%3A55%3A48Z&se=2022-09-19T04%3A55%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=ptbWzZ%2F1V4AzJ0Nc%2FNLNEahWl6fqV%2BMblYXJo7vE9NY%3D)

python3 --version
* **Resource group:** `{{resource-group-name}}` <br>

* **Storage Account Name:** `Create new Storage` <br>

* **File Share Name:** `Create new file share`


![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/a41.PNG?st=2019-09-18T04%3A58%3A12Z&se=2022-09-19T04%3A58%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=zQJmfYNONwPRTvZ3mdfA6ZtkxKIjh%2FCTdGu9oNPOe%2FE%3D)

![alt text](https://qloudableassets.blob.core.windows.net/microsoft-learning/Az103/lab1/21.png?st=2019-09-16T06%3A57%3A56Z&se=2022-09-17T06%3A57%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=JMFKFtYFry1nNVFUWtQOewXhh1ZDMSXBuR%2BXc4szLxk%3D)

In Cloud shell run below command to check your Python version is 3.6 or higher.

`python3 --version`

![alt text]()

## Clone and the sample code

Clone the sample repository using the following command and navigate into the sample folder.

`git clone https://github.com/Azure-Samples/python-docs-hello-world`

Then navigate into that folder

`cd python-docs-hello-world`

The sample contains framework-specific code that Azure App Service recognizes when starting the app.

## Run the sample code

Make sure you're in the python-docs-hello-world folder.

Create a virtual environment and install dependencies

`python3 -m venv .venv`

`source .venv/bin/activate`

`pip install -r requirements.txt`

> **Note:** If you encounter "No such file or directory: 'requirements.txt'.", make sure you're in the python-docs-hello-world folder.

Run the development server.

`flask run`

By default, the server assumes that the app's entry module is in app.py, as used in the sample.

Open a web browser and go to the sample app at http://localhost:5000/. The app displays the message Hello, World!.

![alt text]()

In your terminal window, press Ctrl+C to exit the development server.

## Deploy the sample

Deploy the code in your local folder (python-docs-hello-world) using the az webapp up command:

`az webapp up --sku F1 --name <app-name> --location <location-name> 

